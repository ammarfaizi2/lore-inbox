Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288854AbSBMUTT>; Wed, 13 Feb 2002 15:19:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288855AbSBMUTI>; Wed, 13 Feb 2002 15:19:08 -0500
Received: from [208.252.96.252] ([208.252.96.252]:26716 "EHLO
	riven.plaza.ds.adp.com") by vger.kernel.org with ESMTP
	id <S288854AbSBMUSy>; Wed, 13 Feb 2002 15:18:54 -0500
Date: Wed, 13 Feb 2002 12:18:48 -0800
From: "Seth D. Alford" <setha@plaza.ds.adp.com>
To: linux-kernel@vger.kernel.org
Cc: "Seth D. Alford" <setha@plaza.ds.adp.com>
Subject: LDT_ENTRIES in ldt.h: why 8192?
Message-Id: <20020213121848.A31469@mallard.plaza.ds.adp.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting "ldt allocation failures" on one of my systems.  I know of Manfred
Spraul's patch for this for 2.4.17.  I'm using 2.4.12, though, and was
wondering about an alternate solution.  What would happen if LDT_ENTRIES was
reduced, to, say, 4096, or 512, instead of 8192?

.../include/asm-i386/ldt.h specifies:

	/* Maximum number of LDT entries supported. */
	#define LDT_ENTRIES	8192

This was set to 8192 in version 0.99.15, in December, 1993, according to what I
could find by retrieving different revisions of the kernel.

I instrumented the kernel by adding a printk to the write_ldt subroutine.
Here's what I did, in the form of a patch:

diff -Naur linux-2.4.12.orig/arch/i386/kernel/ldt.c linux-2.4.12/arch/i386/kernel/ldt.c
--- linux-2.4.12.orig/arch/i386/kernel/ldt.c	Thu Jul 26 13:29:45 2001
+++ linux-2.4.12/arch/i386/kernel/ldt.c	Fri Feb  1 16:50:19 2002
@@ -59,6 +59,8 @@
 	if (copy_from_user(&ldt_info, ptr, sizeof(ldt_info)))
 		goto out;
 
+	printk(KERN_DEBUG "write_ldt: ldt_info.entry_number: %d\n", ldt_info.entry_number);
+
 	error = -EINVAL;
 	if (ldt_info.entry_number >= LDT_ENTRIES)
 		goto out;
---end of patch----

Yes, this slows down the system, and it fills up /var.  And I would never think
about doing this on a production system.  And there's probably a more efficient
way to figure out the "high water mark" of LDT entry usage using /proc, or a
static variable.

In any case, the highest entry we got was 4.  We weren't using WINE.
It seems somewhat wasteful to have many processes allocating 64 kbyte
of memory for LDT's until no more processes can run, when each process
uses only 4*8=32 bytes of the 64 kbyte LDT.

I tried to find the answer to this in the lkml archives.  I couldn't
find an lkml archive going back to 1993.  uwsg's only goes back to 1995,
and the other lkml archives don't appear to go back even that far.

Thanks,

--Seth Alford
setha@plaza.ds.adp.com
