Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293408AbSCFJUF>; Wed, 6 Mar 2002 04:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293410AbSCFJT4>; Wed, 6 Mar 2002 04:19:56 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:58521 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S293408AbSCFJTo> convert rfc822-to-8bit; Wed, 6 Mar 2002 04:19:44 -0500
Importance: Normal
Subject: Re: s390 is totally broken in 2.4.18
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OFDEDB80A6.8491BBDE-ONC1256B74.0031662E@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Wed, 6 Mar 2002 10:17:26 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 06/03/2002 10:22:26
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Pete,

>Certainly, I do. I worked around the partitions part with "obvious"
>fixup:
>
>-       if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo);
>+       if (ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo))
>-       data = read_dev_sector(bdev, inode->label_block*blocksize, &sect);
>+       data = read_dev_sector(bdev, info->label_block*blocksize, &sect);
>
>But that code did not look too good, in particular it was
>not checking return codes. So, it was on my TODO list to
>clean it up.

This won't work. The trouble we have is that a partition detection can be
done in two completely different situations. First the "normal" detection
with a builtin dasd driver. ibm_partition is called with no locks held and
with a non-open block device. Second the detection can be done as part of
a block device open with an automated module load. In this case the
get_blkfops functions requests the module which in turn calls the partition
detection. That is done with the bd_sem semaphore of the block device held.
The call to ioctl_by_bdev with the builtin dasd driver fails because the
block device is not open. So we would need to add an open to the partition
detection but we can't do that because then the automated module load
would dead-lock.
Your hack to get it running only works by chance. The first ioctl_by_bdev
that is supposed to get the block number of the label block will fail as
well. So normally you'll end up loading the wrong block. The hack we are
currently using looks like this:

diff -urN linux-2.4.18/fs/block_dev.c linux-2.4.18-s390/fs/block_dev.c
--- linux-2.4.18/fs/block_dev.c Mon Feb 25 20:38:08 2002
+++ linux-2.4.18-s390/fs/block_dev.c    Fri Mar  1 15:47:25 2002
@@ -530,11 +530,18 @@
 {
        int res;
        mm_segment_t old_fs = get_fs();
+       struct block_device_operations *bd_op;

-       if (!bdev->bd_op->ioctl)
+       bd_op = bdev->bd_op;
+       if (bd_op == NULL) {
+               bd_op = blkdevs[MAJOR(to_kdev_t(bdev->bd_dev))].bdops;
+               if (bd_op == NULL)
+                       return -EINVAL;
+       }
+       if (!bd_op->ioctl)
                return -EINVAL;
        set_fs(KERNEL_DS);
-       res = bdev->bd_op->ioctl(bdev->bd_inode, NULL, cmd, arg);
+       res = bd_op->ioctl(bdev->bd_inode, NULL, cmd, arg);
        set_fs(old_fs);
        return res;
 }

The idea is to get ioctl_by_bdev to work for non-open devices. But it is
a hack because I do not safe-guard against module unloading.

blue skies,
   Martin

P.S. I will sent you the patches I sent Marcelo in a private mail.

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


