Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264956AbUEVLSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264956AbUEVLSj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 07:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUEVLSi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 07:18:38 -0400
Received: from elektron.ikp.physik.tu-darmstadt.de ([130.83.24.72]:15110 "EHLO
	elektron.ikp.physik.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id S264956AbUEVLSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 07:18:35 -0400
From: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16559.14090.6623.563810@hertz.ikp.physik.tu-darmstadt.de>
Date: Sat, 22 May 2004 13:18:34 +0200
To: linux-kernel@vger.kernel.org
CC: Andries.Brouwer@cwi.nl
Subject: Re: rfc: test whether a device has a partition table
X-Mailer: VM 7.07 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

around last september there was a discussion about the linux kernel
recognizing "supperfloppys" as disks with bogus partition tables.
Linux Torvalds wrote at one point in the discussion:
>On Thu, 25 Sep 2003, Andries Brouwer wrote:
>> 
>> My post implicitly suggested the minimal thing to do.
>> It will not be enough - heuristics are never enough -
>> but it probably helps in most cases.
>
>I don't mind the 0x00/0x80 "boot flag" checks - those look fairly 
> obvious and look reasonably safe to add to the partitioning code.
>
>There are other checks that can be done - verifying that the start/end
>sector values are at all sensible. We do _some_ of that, but only for
>partitions 3 and 4, for example. We could do more - like checking the
>actual sector numbers (but I think some formatters leave them as zero).
>
>Which actually makes me really nervous - it implies that we've probably 
>seen partitions 1&2 contain garbage there, and the problem is that if 
>you'r etoo careful in checking, you will make a system unusable.
>
>This is why it is so much nicer to be overly permissive ratehr than 
>being a stickler for having all the values right.
>
>And your random byte checks for power-of-2 make no sense. What are they
>based on?

The discussion seemed to fade out with no visible result, and for example my
USB stick "ID 0d7d:1420 Apacer" with a floppy as second partition gets
recognized as:
SCSI device sdc: 2880 512-byte hdwr sectors (1 MB)
sdc: Write Protect is off
 sdc: sdc1 sdc2 sdc3 sdc4

Find appended a patch that does the 0x00/0x80 "boot flag" checks. Please
discuss and consider for inclusion into the kernel.

Thanks

PS: CC me for faster reaction, as I only follow the mailing list via the
MARC mailing list archive.
-- 
Uwe Bonnes                bon@elektron.ikp.physik.tu-darmstadt.de

Institut fuer Kernphysik  Schlossgartenstrasse 9  64289 Darmstadt
--------- Tel. 06151 162516 -------- Fax. 06151 164321 ----------
--- linux-2.6.6/fs/partitions/msdos-sav.c	2004-05-10 04:32:52.000000000 +0200
+++ linux-2.6.6/fs/partitions/msdos.c	2004-05-22 12:54:45.000000000 +0200
@@ -32,6 +32,7 @@
  */
 #include <asm/unaligned.h>
 
+#define BOOT_IND(p)	(get_unaligned(&p->boot_ind))
 #define SYS_IND(p)	(get_unaligned(&p->sys_ind))
 #define NR_SECTS(p)	({ __typeof__(p->nr_sects) __a =	\
 				get_unaligned(&p->nr_sects);	\
@@ -377,6 +378,7 @@
 int msdos_partition(struct parsed_partitions *state, struct block_device *bdev)
 {
 	int sector_size = bdev_hardsect_size(bdev) / 512;
+	int nr_bootable = 0;
 	Sector sect;
 	unsigned char *data;
 	struct partition *p;
@@ -389,6 +391,22 @@
 		put_dev_sector(sect);
 		return 0;
 	}
+
+	/* 
+	   Some consistancy check for a valid partition table
+	   Boot indicator must either be 0x80 or 0x0 on all primary partitions
+	   Only one partition may be marked bootable (0x80)
+	*/
+ 	p = (struct partition *) (data + 0x1be);
+	for (slot = 1 ; slot <= 4 ; slot++, p++) {
+	  if ( (BOOT_IND(p) != 0x80) && (BOOT_IND(p) != 0x0))
+	    return 0;
+	  if (BOOT_IND(p) == 0x80) 
+	    nr_bootable++;
+	}
+	if (nr_bootable >1) 
+	  return 0;
+
 	p = (struct partition *) (data + 0x1be);
 #ifdef CONFIG_EFI_PARTITION
 	for (slot = 1 ; slot <= 4 ; slot++, p++) {
