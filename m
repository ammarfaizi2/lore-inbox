Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319197AbSHNEbO>; Wed, 14 Aug 2002 00:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319198AbSHNEbO>; Wed, 14 Aug 2002 00:31:14 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:26361 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S319197AbSHNEbN>; Wed, 14 Aug 2002 00:31:13 -0400
Date: Wed, 14 Aug 2002 00:35:05 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Andrew Morton <akpm@zip.com.au>,
       "H. Peter Anvin" <hpa@zytor.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] printk from userspace
Message-ID: <20020814003505.A16322@redhat.com>
References: <Pine.GSO.4.21.0208140016140.3712-100000@weyl.math.psu.edu> <Pine.LNX.4.44.0208132123500.1208-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208132123500.1208-100000@home.transmeta.com>; from torvalds@transmeta.com on Tue, Aug 13, 2002 at 09:26:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 09:26:45PM -0700, Linus Torvalds wrote:
> That said, I like the notion. I've always hated the fact that all the 
> boot-time messages get lost, simply because syslogd hadn't started, and 
> as a result things like fsck ran without any sign afterwards. The kernel 
> log approach saves it all in one place.
> 
> But /dev/console just sounds potentially _too_ noisy.

/dev/kmsg was another suggestion for the name.  But please revert the 
yet-another-syscall variant -- having a duplicate way for logging that 
doesn't work with stdio just seems sick to me (sys_syslog should die).
Something like the following untested code is much better.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."


diff -urN v2.5.31/drivers/char/mem.c foo/drivers/char/mem.c
--- v2.5.31/drivers/char/mem.c	Fri Aug  2 11:41:29 2002
+++ foo/drivers/char/mem.c	Wed Aug 14 00:34:33 2002
@@ -579,6 +579,24 @@
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
@@ -608,6 +626,9 @@
 		case 9:
 			filp->f_op = &urandom_fops;
 			break;
+		case 11:
+			filp->f_op = &kmsg_fops;
+			break;
 		default:
 			return -ENXIO;
 	}
@@ -634,7 +655,8 @@
 	{5, "zero",    S_IRUGO | S_IWUGO,           &zero_fops},
 	{7, "full",    S_IRUGO | S_IWUGO,           &full_fops},
 	{8, "random",  S_IRUGO | S_IWUSR,           &random_fops},
-	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops}
+	{9, "urandom", S_IRUGO | S_IWUSR,           &urandom_fops},
+	{11,"kmsg",    S_IRUGO | S_IWUSR,           &kmsg_fops},
     };
     int i;
 
