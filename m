Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133013AbRDRQoL>; Wed, 18 Apr 2001 12:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132960AbRDRQoC>; Wed, 18 Apr 2001 12:44:02 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:14094 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S133013AbRDRQnu>; Wed, 18 Apr 2001 12:43:50 -0400
Message-ID: <3ADDC425.CE865BC3@computer.org>
Date: Wed, 18 Apr 2001 18:43:17 +0200
From: k.lichtenwalder@computer.org
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: patch: llseek for raw devices
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
this is my try for implementing the llseek operation on raw devices. The
reason is that lseek does a check on the limits of the undlying
filesystem and thus tends to err where the real device lies. Lseek check
takes the /dev/raw/rawX filesystem as limiting factor, not the device
that is bound to rawX. In my case I'm using a reiserfs (the old one)
with 4G limits and thus can't do an llseek on DVD, resulting in an error
half way through the film.
This lseek was rigged together from the lseek from the memory device and
from limit checkings from the rw_raw_dev function.
I couldn't find any maintainer, so it's going to the list. (Alan, if
you're going to add it to the -ac patches, it's against plain 2.4.3
raw.c. But this patch should apply without problems)
(please watch the on long line below, will most probably get broken in
transit)

Klaus

--- raw.c.orig	Mon Oct  2 05:35:15 2000
+++ raw.c	Wed Apr 18 18:28:55 2001
@@ -28,12 +28,14 @@
 
 ssize_t	raw_read(struct file *, char *, size_t, loff_t *);
 ssize_t	raw_write(struct file *, const char *, size_t, loff_t *);
+loff_t  raw_lseek(struct file * , loff_t, int);
 int	raw_open(struct inode *, struct file *);
 int	raw_release(struct inode *, struct file *);
 int	raw_ctl_ioctl(struct inode *, struct file *, unsigned int, unsigned
long);
 
 
 static struct file_operations raw_fops = {
+	llseek:		raw_lseek,
 	read:		raw_read,
 	write:		raw_write,
 	open:		raw_open,
@@ -341,4 +342,46 @@
 	}
 	
 	return err;
+}
+
+
+loff_t raw_lseek(struct file * file, loff_t offset, int orig)
+{
+	int		minor;
+	kdev_t		dev;
+	unsigned long	limit;
+
+	int		sector_size, sector_bits, sector_mask;
+	int		max_sectors;
+	loff_t		fpos;
+
+	switch (orig) {
+		case 0:
+			fpos = offset;
+			break;
+		case 1:
+			fpos = file->f_pos + offset;
+			break;
+		default:
+			return -EINVAL;
+	}
+
+	minor = MINOR(file->f_dentry->d_inode->i_rdev);
+	dev = to_kdev_t(raw_device_bindings[minor]->bd_dev);
+	sector_size = raw_device_sector_size[minor];
+	sector_bits = raw_device_sector_bits[minor];
+	sector_mask = sector_size- 1;
+	max_sectors = KIO_MAX_SECTORS >> (sector_bits - 9);
+	
+	if (blk_size[MAJOR(dev)])
+		limit = (((loff_t) blk_size[MAJOR(dev)][MINOR(dev)]) <<
BLOCK_SIZE_BITS) >> sector_bits;
+	else
+		limit = INT_MAX;
+	if ((fpos & sector_mask))
+		return -EINVAL;
+	if ((fpos >> sector_bits) >= limit) {
+		return -EINVAL;
+	}
+	file->f_pos = fpos;
+	return fpos;
 }


------------------------------------------------------------------------ 
 Klaus Lichtenwalder, Dipl. Inform.,       http://www.webforum.de/Klaus/
 Fax +49-(0)89-91072699                            Lichtenwalder@ACM.org
 NIC: KL2100, KL76-RIPE                     K.Lichtenwalder@Computer.org
 PGP Key fingerprint = 2658 EA97 E1A1 2680 5ECA  0036 80F5 F250 3CF8
C2C7
