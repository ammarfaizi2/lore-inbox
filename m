Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130521AbQLUUyW>; Thu, 21 Dec 2000 15:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131228AbQLUUyN>; Thu, 21 Dec 2000 15:54:13 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:8719 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130521AbQLUUyD>; Thu, 21 Dec 2000 15:54:03 -0500
Date: Thu, 21 Dec 2000 21:23:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001221212325.A30872@athlon.random>
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu> <20001220142858.A7381@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001220142858.A7381@athlon.random>; from andrea@suse.de on Wed, Dec 20, 2000 at 02:28:58PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2000 at 02:28:58PM +0100, Andrea Arcangeli wrote:
> I was in the process of fixing this (I also just backported the thinkpad
> %edx clobber fix), but if somebody is going to work on this please let
> me know so we stay in sync.

Ok this should fix the e820 memory detection, against 2.2.19pre2:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.19pre2/e820-fix-1

While fixing the code I noticed some bug was inerith from 2.4.x so I forward
ported the fixes to 2.4.0-test13-pre3:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.0-test13-pre3/e820-fix-1

I also include them below so they're handy for Linus:

diff -urN 2.4.0-test13-pre3/arch/i386/kernel/setup.c 2.4.0-test13-pre3-e820/arch/i386/kernel/setup.c
--- 2.4.0-test13-pre3/arch/i386/kernel/setup.c	Thu Dec 14 22:33:59 2000
+++ 2.4.0-test13-pre3-e820/arch/i386/kernel/setup.c	Thu Dec 21 21:12:47 2000
@@ -477,7 +477,7 @@
 			if (start < 0x100000ULL && end > 0xA0000ULL) {
 				if (start < 0xA0000ULL)
 					add_memory_region(start, 0xA0000ULL-start, type);
-				if (end < 0x100000ULL)
+				if (end <= 0x100000ULL)
 					continue;
 				start = 0x100000ULL;
 				size = end - start;
@@ -518,7 +518,8 @@
 
 		e820.nr_map = 0;
 		add_memory_region(0, LOWMEMSIZE(), E820_RAM);
-		add_memory_region(HIGH_MEMORY, mem_size << 10, E820_RAM);
+		add_memory_region(HIGH_MEMORY, (mem_size << 10)-HIGH_MEMORY,
+				  E820_RAM);
   	}
 	printk("BIOS-provided physical RAM map:\n");
 	print_memory_map(who);


The above patches doesn't include the fix for the thinkpad from Marc Joosen,
a backport of such bugfix is separately backported here (because it's
orthogonal with the other bugfixes):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.19pre2/thinkpad-e820-mjoosen-1

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
