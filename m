Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263970AbUECUf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263970AbUECUf5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 16:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbUECUf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 16:35:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58020 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263962AbUECUfR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 16:35:17 -0400
Date: Mon, 3 May 2004 21:35:13 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org, kaos@sgi.com,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fw: 2.6.6-rc3 ia64 smp_call_function() called with interrupts disabled
Message-ID: <20040503203512.GP2281@parcelfarce.linux.theplanet.co.uk>
References: <20040502214525.5ad05bed.akpm@osdl.org> <20040503122948.GI2281@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503122948.GI2281@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 01:29:48PM +0100, Matthew Wilcox wrote:
> How about the following patch?  Noet that vfree() handles a NULL argument,
> so it's not necessary to check the pointer.

That patch is crap -- it only frees the memory on the error path, not
the normal exit.  Since I got confused by this function, it struck me
as not unreasonable that somebody else might also get confused by it
and split it into two parts.

I simplified some of the code.  The old code took the lock, scanned
through looking for a free slot, dropped the lock, allocated an sdp,
grabbed the lock and checked the slot was still free, branching back
if it had raced.  This rewrite assumes that we will find a slot and
allocates an sdp in advance.

Does anybody like this patch?  It survived booting on my test box which
only has one scsi device.  More testing welcomed.

Index: drivers/scsi/sg.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/scsi/sg.c,v
retrieving revision 1.13
diff -u -p -r1.13 sg.c
--- a/drivers/scsi/sg.c	15 Apr 2004 18:04:45 -0000	1.13
+++ b/drivers/scsi/sg.c	3 May 2004 20:27:36 -0000
@@ -1333,85 +1333,44 @@ static struct class_simple * sg_sysfs_cl
 
 static int sg_sysfs_valid = 0;
 
-static int
-sg_add(struct class_device *cl_dev)
+static int sg_alloc(struct gendisk *disk, struct scsi_device *scsidp)
 {
-	struct scsi_device *scsidp = to_scsi_device(cl_dev->dev);
-	struct gendisk *disk;
-	Sg_device *sdp = NULL;
+	Sg_device *sdp;
 	unsigned long iflags;
-	struct cdev * cdev = NULL;
+	void *old_sg_dev_arr = NULL;
 	int k, error;
 
-	disk = alloc_disk(1);
-	if (!disk)
+	sdp = vmalloc(sizeof(Sg_device));
+	if (!sdp)
 		return -ENOMEM;
 
-	cdev = cdev_alloc();
-	if (! cdev)
-		return -ENOMEM;
 	write_lock_irqsave(&sg_dev_arr_lock, iflags);
-	if (sg_nr_dev >= sg_dev_max) {	/* try to resize */
+	if (unlikely(sg_nr_dev >= sg_dev_max)) {	/* try to resize */
 		Sg_device **tmp_da;
 		int tmp_dev_max = sg_nr_dev + SG_DEV_ARR_LUMP;
-
 		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
-		tmp_da = (Sg_device **)vmalloc(
-				tmp_dev_max * sizeof(Sg_device *));
-		if (NULL == tmp_da) {
-			printk(KERN_ERR
-			       "sg_add: device array cannot be resized\n");
-			error = -ENOMEM;
-			goto out;
-		}
+
+		tmp_da = vmalloc(tmp_dev_max * sizeof(Sg_device *));
+		if (unlikely(!tmp_da))
+			goto expand_failed;
+
 		write_lock_irqsave(&sg_dev_arr_lock, iflags);
-		memset(tmp_da, 0, tmp_dev_max * sizeof (Sg_device *));
-		memcpy(tmp_da, sg_dev_arr,
-		       sg_dev_max * sizeof (Sg_device *));
-		vfree((char *) sg_dev_arr);
+		memset(tmp_da, 0, tmp_dev_max * sizeof(Sg_device *));
+		memcpy(tmp_da, sg_dev_arr, sg_dev_max * sizeof(Sg_device *));
+		old_sg_dev_arr = sg_dev_arr;
 		sg_dev_arr = tmp_da;
 		sg_dev_max = tmp_dev_max;
 	}
 
-find_empty_slot:
 	for (k = 0; k < sg_dev_max; k++)
 		if (!sg_dev_arr[k])
 			break;
-	if (k >= SG_MAX_DEVS) {
-		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
-		printk(KERN_WARNING
-		       "Unable to attach sg device <%d, %d, %d, %d>"
-		       " type=%d, minor number exceeds %d\n",
-		       scsidp->host->host_no, scsidp->channel, scsidp->id,
-		       scsidp->lun, scsidp->type, SG_MAX_DEVS - 1);
-		if (NULL != sdp)
-			vfree((char *) sdp);
-		error = -ENODEV;
-		goto out;
-	}
-	if (k < sg_dev_max) {
-		if (NULL == sdp) {
-			write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
-			sdp = (Sg_device *)vmalloc(sizeof(Sg_device));
-			write_lock_irqsave(&sg_dev_arr_lock, iflags);
-			if (!sg_dev_arr[k])
-				goto find_empty_slot;
-		}
-	} else
-		sdp = NULL;
-	if (NULL == sdp) {
-		write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
-		printk(KERN_ERR "sg_add: Sg_device cannot be allocated\n");
-		error = -ENOMEM;
-		goto out;
-	}
+	if (unlikely(k >= SG_MAX_DEVS))
+		goto overflow;
 
-	SCSI_LOG_TIMEOUT(3, printk("sg_add: dev=%d \n", k));
 	memset(sdp, 0, sizeof(*sdp));
+	SCSI_LOG_TIMEOUT(3, printk("sg_add: dev=%d \n", k));
 	sprintf(disk->disk_name, "sg%d", k);
-	cdev->owner = THIS_MODULE;
-	cdev->ops = &sg_fops;
-	disk->major = SCSI_GENERIC_MAJOR;
 	disk->first_minor = k;
 	sdp->disk = disk;
 	sdp->device = scsidp;
@@ -1421,6 +1380,55 @@ find_empty_slot:
 	sg_nr_dev++;
 	sg_dev_arr[k] = sdp;
 	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+	error = k;
+
+ out:
+	if (error < 0)
+		vfree(sdp);
+	vfree(old_sg_dev_arr);
+	return error;
+
+ expand_failed:
+	printk(KERN_ERR "sg_add: device array cannot be resized\n");
+	error = -ENOMEM;
+	goto out;
+
+ overflow:
+	write_unlock_irqrestore(&sg_dev_arr_lock, iflags);
+	printk(KERN_WARNING
+	       "Unable to attach sg device <%d, %d, %d, %d> type=%d, minor "
+	       "number exceeds %d\n", scsidp->host->host_no, scsidp->channel,
+	       scsidp->id, scsidp->lun, scsidp->type, SG_MAX_DEVS - 1);
+	error = -ENODEV;
+	goto out;
+}
+
+static int
+sg_add(struct class_device *cl_dev)
+{
+	struct scsi_device *scsidp = to_scsi_device(cl_dev->dev);
+	struct gendisk *disk;
+	Sg_device *sdp = NULL;
+	struct cdev * cdev = NULL;
+	int error, k;
+
+	disk = alloc_disk(1);
+	if (!disk)
+		return -ENOMEM;
+	disk->major = SCSI_GENERIC_MAJOR;
+
+	error = -ENOMEM;
+	cdev = cdev_alloc();
+	if (!cdev)
+		goto out;
+	cdev->owner = THIS_MODULE;
+	cdev->ops = &sg_fops;
+
+	error = sg_alloc(disk, scsidp);
+	if (error < 0)
+		goto out;
+	k = error;
+	sdp = sg_dev_arr[k];
 
 	devfs_mk_cdev(MKDEV(SCSI_GENERIC_MAJOR, k),
 			S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP,

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
