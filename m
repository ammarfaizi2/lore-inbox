Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVD0RTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVD0RTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261810AbVD0RTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:19:13 -0400
Received: from mail.kroah.org ([69.55.234.183]:28358 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261824AbVD0RRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:17:45 -0400
Date: Wed, 27 Apr 2005 10:16:27 -0700
From: Greg KH <gregkh@suse.de>
To: erik@debian.franken.de, Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [04/07] partitions/msdos.c fix
Message-ID: <20050427171627.GE3195@kroah.com>
References: <20050427171446.GA3195@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427171446.GA3195@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

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
