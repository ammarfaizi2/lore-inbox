Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270472AbRHHMRB>; Wed, 8 Aug 2001 08:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270474AbRHHMQo>; Wed, 8 Aug 2001 08:16:44 -0400
Received: from pop.gmx.net ([194.221.183.20]:21018 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S270472AbRHHMQc>;
	Wed, 8 Aug 2001 08:16:32 -0400
Message-ID: <3B716644.1AFF4804@gmx.at>
Date: Wed, 08 Aug 2001 18:18:12 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Arjan van de Ven <arjanv@redhat.com>
Subject: ataraid: reload partitiontable
Content-Type: multipart/mixed;
 boundary="------------80C7C15B3063FC7617F32980"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------80C7C15B3063FC7617F32980
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi!

Looks like the ataraid driver does not reread the partition table
because of the ioctl call is not implemented. I cloned the code from the
ide driver. The patch is attached.
The atomic_t stuff might be a bit paranoid, but I was not sure if it is
save to use char. (Well, I use it only as a boolean busy flag...)

bye,
Wilfried
--------------80C7C15B3063FC7617F32980
Content-Type: text/plain; charset=us-ascii;
 name="ataraid-partfix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ataraid-partfix.diff"

diff -Nur linux/drivers/ide/ataraid.c linux.partfix/drivers/ide/ataraid.c
--- linux/drivers/ide/ataraid.c	Wed Aug  8 18:08:46 2001
+++ linux.partfix/drivers/ide/ataraid.c	Wed Aug  8 13:39:40 2001
@@ -44,11 +44,15 @@
 static int ataraid_open(struct inode * inode, struct file * filp);
 static int ataraid_release(struct inode * inode, struct file * filp);
 static void ataraid_split_request(request_queue_t *q, int rw, struct buffer_head * bh);
+static int ataraid_revalidate(kdev_t dev, int maxusage);
 
 
 struct gendisk ataraid_gendisk;
 static int ataraid_gendisk_sizes[256];
 static int ataraid_readahead[256];
+static atomic_t busy[16];
+static unsigned int access_count[16];
+static DECLARE_WAIT_QUEUE_HEAD(busy_wait);
 
 static struct block_device_operations ataraid_fops = {
 	open:                   ataraid_open,
@@ -70,6 +74,50 @@
 	atomic_t count;
 };
 
+/* reread the partitions table */
+static int ataraid_revalidate(kdev_t dev, int maxusage)
+{
+	int target;
+	struct gendisk * gdev;
+	int max_p;
+	int start;
+	int i;
+	long flags;
+
+	target = DEVICE_NR(dev);
+	gdev = &ataraid_gendisk;
+
+	save_flags(flags);
+	cli();
+	if (atomic_read(busy+target) || access_count[target] > maxusage) {
+		restore_flags(flags);
+		return -EBUSY;
+	}
+	atomic_set(busy+target, 1);
+	restore_flags(flags);
+
+	max_p = gdev->max_p;
+	start = target << gdev->minor_shift;
+
+	for (i=max_p - 1; i >=0 ; i--) {
+		int minor = start + i;
+		invalidate_device(MKDEV(ATAMAJOR, minor), 1);
+		gdev->part[minor].start_sect = 0;
+		gdev->part[minor].nr_sects = 0;
+	}
+
+#ifdef MAYBE_REINIT
+	MAYBE_REINIT;
+#endif
+
+	grok_partitions(gdev, target, 1<<SHIFT,
+			ataraid_gendisk_sizes[MINOR(dev)>>SHIFT]);
+
+	atomic_set(busy+target, 0);
+	wake_up(&busy_wait);
+	return 0;
+}
+
 /* stub fops functions */
 
 static int ataraid_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)  
@@ -78,28 +126,52 @@
 	minor = MINOR(inode->i_rdev)>>SHIFT;
 	
 	if ((ataraid_ops[minor])&&(ataraid_ops[minor]->ioctl))
-		return (ataraid_ops[minor]->ioctl)(inode,file,cmd,arg);
+	{
+		switch(cmd)
+		{
+			case BLKRRPART:
+				if(!capable(CAP_SYS_ADMIN))
+					return -EACCES;
+				return ataraid_revalidate(inode->i_rdev, 1);
+
+			default:
+				return (ataraid_ops[minor]->ioctl)(inode,file,cmd,arg);
+		}
+	}
 	return -EINVAL;
 }
 
 static int ataraid_open(struct inode * inode, struct file * filp)
 {
-	int minor;
+	int minor, target, rc;
 	minor = MINOR(inode->i_rdev)>>SHIFT;
+	target = DEVICE_NR(inode->i_rdev);
 
 	if ((ataraid_ops[minor])&&(ataraid_ops[minor]->open))
-		return (ataraid_ops[minor]->open)(inode,filp);
+	{
+		while (atomic_read(busy+target))
+			sleep_on(&busy_wait);
+
+		rc=(ataraid_ops[minor]->open)(inode,filp);
+		access_count[target]++;
+		return rc;
+	}
 	return -EINVAL;
 }
 
 
 static int ataraid_release(struct inode * inode, struct file * filp)
 {
-	int minor;
+	int minor, target, rc;
 	minor = MINOR(inode->i_rdev)>>SHIFT;
+	target = DEVICE_NR(inode->i_rdev);
 
 	if ((ataraid_ops[minor])&&(ataraid_ops[minor]->release))
-		return (ataraid_ops[minor]->release)(inode,filp);
+	{
+		rc=(ataraid_ops[minor]->release)(inode,filp);
+		access_count[target]--;
+		return rc;
+	}
 	return -EINVAL;
 }
 

--------------80C7C15B3063FC7617F32980--

