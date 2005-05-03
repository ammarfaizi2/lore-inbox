Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261392AbVECFQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261392AbVECFQd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 01:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVECFQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 01:16:33 -0400
Received: from fire.osdl.org ([65.172.181.4]:2011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261392AbVECFQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 01:16:18 -0400
Date: Mon, 2 May 2005 22:16:07 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Joe <joecool1029@gmail.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       greg@kroah.com
Subject: Re: Empty partition nodes not created (was device node issues with
 recent mm's and udev)
Message-Id: <20050502221607.0db797d2.rddunlap@osdl.org>
In-Reply-To: <d4757e600505022118131ec083@mail.gmail.com>
References: <d4757e6005050219514ece0c0a@mail.gmail.com>
	<20050503031421.GA528@kroah.com>
	<20050502202620.04467bbd.rddunlap@osdl.org>
	<d4757e600505022118131ec083@mail.gmail.com>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 May 2005 00:18:05 -0400 Joe wrote:

| On 5/2/05, Randy.Dunlap <rddunlap@osdl.org> wrote:
| > Could this 2.6.11.8 -stable patch fix it?
| > Subject: [04/07] partitions/msdos.c fix
| > 
| > Joe, can you test 2.6.11.8, please?
| > 
| > ---
| > ~Randy
| > 
| 
| Randy, Can't run vanilla at the moment on this setup, any way you can
| get the patch seperate?  I also don't think that will fix it because
| this is an empty, not a msdos partition.

Yeah, I could be way off on this.  Anyway, the patch is below.

---
~Randy



------------------

Erik reports this fixes an oops on boot for him.

From: Andries Brouwer <Andries.Brouwer@cwi.nl>

A well-known kernel bug is that it guesses at the partition type and the
partitions on any disk it encounters.  This is bad because needless I/O is
done, slowing down the boot, sometimes quite a lot, especially when I/O
errors occur.  And it is bad because sometimes we guess wrong.

In other words, we need the user space command `partition', where
"partition -t dos /dev/sda" reads a DOS-type partition table.  (And
"partition /dev/sda" tries all known heuristics to decide what type of
partitioning might be present.) The two variants are: (i) partition tells
the kernel to do the partition table reading, and (ii) partition uses partx
to read the partition table and tells the kernel one-by-one about the
partitions found this way.

Since this is a fundamental change, a long transition period is needed, and
that period could start with a kernel boot parameter telling the kernel not
to do partition table parsing on a particular disk, or a particular type of
disks, or all disks.

This could have been the intro to a patch doing that, but is not.  (It is
just an RFC.)

The tiny patch below prompted the above - it was suggested by Uwe Bonnes
who encountered USB devices without partition table where our present
heuristics did not suffice to stop partition table parsing.  It causes the
kernel to ignore partitions of type 0.  A band-aid.

I think nobody uses such partitions seriously, but nevertheless this should
probably live in -mm for a while to see if anybody complains.

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

===== fs/partitions/msdos.c 1.26 vs 1.27 =====
--- 1.26/fs/partitions/msdos.c	2004-11-09 12:43:17 -08:00
+++ 1.27/fs/partitions/msdos.c	2005-03-07 20:41:42 -08:00
@@ -114,6 +114,9 @@ parse_extended(struct parsed_partitions 
 		 */
 		for (i=0; i<4; i++, p++) {
 			u32 offs, size, next;
+
+			if (SYS_IND(p) == 0)
+				continue;
 			if (!NR_SECTS(p) || is_extended_partition(p))
 				continue;
 
@@ -430,6 +433,8 @@ int msdos_partition(struct parsed_partit
 	for (slot = 1 ; slot <= 4 ; slot++, p++) {
 		u32 start = START_SECT(p)*sector_size;
 		u32 size = NR_SECTS(p)*sector_size;
+		if (SYS_IND(p) == 0)
+			continue;
 		if (!size)
 			continue;
 		if (is_extended_partition(p)) {
-
