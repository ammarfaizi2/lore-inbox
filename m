Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264754AbTFQNw6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 09:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264755AbTFQNw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 09:52:57 -0400
Received: from ns.suse.de ([213.95.15.193]:4113 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264754AbTFQNwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 09:52:55 -0400
Date: Tue, 17 Jun 2003 16:06:50 +0200
From: Andi Kleen <ak@suse.de>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Cc: akpm@digeo.com
Subject: [PATCH] /proc/kcore fix II - handle unmapped areas
Message-ID: <20030617140650.GB19808@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On i386 and most other ports kern_addr_valid is hardcoded to 1.

This works fine as long as only mapped areas are accessed.
When you have something partially mapped in the kclist it is possible
that start points to an unmapped address. The correct behaviour 
in this case is to zero the user space.

copy_to_user usually even checks for exceptions on both 
source and destination, but it does not zero the destination
in this case and worse results in EFAULT, which is user visible.

This patch just tries to clear_user in this case again to 
actually zero the user data and catch real user side EFAULTs.

Another way to fix this is to have kern_addr_valid do a real
page table lookup (I did that on AMD64), but having this
fallback is a bit more reliable in case there is a race somewhere.

On i386 it could happen for example if the direct space to max_low_pfn contains
something unmapped. This normally isn't the case, but e.g. the slab
debugging patches in -mm* do this so it's better to handle it.

-Andi

diff -burpN -X ../KDIFX linux/fs/proc/kcore.c linux-2.5.71-amd64/fs/proc/kcore.c
--- linux/fs/proc/kcore.c	2003-06-14 23:43:01.000000000 +0200
+++ linux/fs/proc/kcore.c	2003-06-15 16:04:30.000000000 +0200
@@ -451,8 +451,16 @@ static ssize_t read_kcore(struct file *f
 			kfree(elf_buf);
 		} else {
 			if (kern_addr_valid(start)) {
-				if (copy_to_user(buffer, (char *)start, tsz))
+				long n;
+				n = copy_to_user(buffer, (char *)start, tsz);
+				/* We cannot distingush between fault on
+				   source and fault on destination. When
+				   this happens we clear too and hope
+				   it will trigger the EFAULT again. */
+				if (n) { 
+					if (clear_user(buffer + tsz - n, tsz - n))
 					return -EFAULT;
+				}
 			} else {
 				if (clear_user(buffer, tsz))
 					return -EFAULT;
