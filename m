Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319210AbSHNEoE>; Wed, 14 Aug 2002 00:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319211AbSHNEoD>; Wed, 14 Aug 2002 00:44:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8208 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319210AbSHNEoC>;
	Wed, 14 Aug 2002 00:44:02 -0400
Message-ID: <3D59E365.B0115D78@zip.com.au>
Date: Tue, 13 Aug 2002 21:58:13 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>, "H. Peter Anvin" <hpa@zytor.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
References: <Pine.GSO.4.21.0208140016140.3712-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0208132123500.1208-100000@home.transmeta.com> <20020814003505.A16322@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> ...
> Something like the following untested code is much better.

I agree.  And it worked first time.


--- 2.5.31/drivers/char/mem.c~bcrl-printk	Tue Aug 13 21:53:24 2002
+++ 2.5.31-akpm/drivers/char/mem.c	Tue Aug 13 21:53:34 2002
@@ -579,6 +579,24 @@ static struct file_operations full_fops 
 	write:		write_full,
 };
 
+static ssize_t kmsg_write(struct file * file, const char * buf,
+			  size_t count, loff_t *ppos)
+{
+	char tmp[1025];
+
+	if (count > 1024)
+		count = 1024;
+	if (copy_from_user(tmp, buf, count))
+		return -EFAULT;
+	tmp[count] = 0;
+	printk("%s", tmp);
+	return count;
+}
+
+static struct file_operations kmsg_fops = {
+	write:		kmsg_write,
+};
+
 static int memory_open(struct inode * inode, struct file * filp)
 {
 	switch (minor(inode->i_rdev)) {
@@ -608,6 +626,9 @@ static int memory_open(struct inode * in
 		case 9:
 			filp->f_op = &urandom_fops;
 			break;
+		case 11:
+			filp->f_op = &kmsg_fops;
+			break;
 		default:
 			return -ENXIO;
 	}
@@ -634,7 +655,8 @@ void __init memory_devfs_register (void)
 	{5, "zero",    S_IRUGO | S_IWUGO,           &zero_fops},
 	{7, "full",    S_IRUGO | S_IWUGO,           &full_fops},
 	{8, "random",  S_IRUGO | S_IWUSR,           &random_fops},
-	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops}
+	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops},
+	{11,"kmsg",    S_IRUGO | S_IWUSR,           &kmsg_fops},
     };
     int i;
 

.
