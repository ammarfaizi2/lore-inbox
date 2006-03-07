Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbWCGTi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbWCGTi3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbWCGTi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:38:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63630 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932266AbWCGTi2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:38:28 -0500
Date: Tue, 7 Mar 2006 11:36:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Martin =?ISO-8859-1?B?TU9LUkVKX18=?= 
	<mmokrejs@ribosome.natur.cuni.cz>
Cc: linux-kernel@vger.kernel.org, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: 2.6.16-rc5 huge memory detection regression
Message-Id: <20060307113631.36ac029d.akpm@osdl.org>
In-Reply-To: <440D7BB8.40106@ribosome.natur.cuni.cz>
References: <440D6581.9080000@ribosome.natur.cuni.cz>
	<20060307041532.3ef45392.akpm@osdl.org>
	<440D7BB8.40106@ribosome.natur.cuni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin MOKREJ__ <mmokrejs@ribosome.natur.cuni.cz> wrote:
>
> ...
> > 
> >> --- tmp/boot-2.6.15.txt	2006-03-07 11:45:48.015509048 +0100
> >> +++ tmp/boot-2.6.16-rc5.txt	2006-03-07 11:45:48.029506920 +0100
> >> @@ -1,4 +1,4 @@
> >> -Linux version 2.6.15 (root@phylo) (gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP Mon Mar 6 20:20:06 MET 2006
> >> +Linux version 2.6.16-rc5 (root@phylo) (gcc version 3.4.5 (Gentoo 3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 SMP Mon Mar 6 19:58:24 MET 2006
> >>  BIOS-provided physical RAM map:
> >>   BIOS-e820: 0000000000000000 - 000000000009a800 (usable)
> >>   BIOS-e820: 000000000009a800 - 00000000000a0000 (reserved)
> >> @@ -12,16 +12,16 @@
> >>   BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
> >>   BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
> >>   BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
> >> - BIOS-e820: 0000000100000000 - 0000000430000000 (usable)
> >> -16256MB HIGHMEM available.
> >> + BIOS-e820: 0000000100000000 - 0000000230000000 (usable)
> >> +8064MB HIGHMEM available.
> > 
> > 
> > These numbers are what the BIOS is telling the kernel about your machine. 
> > Was the BIOS changed?
> 
> No, it hasn't since we got the motherboard. Yes, it is 1.20 instead 
> of 1.50. The MSI web is such a crap I couldn't first of all get the 
> file at all and once found on a local reseller's page the zip file 
> contains no Changelog, so I have no clue what happened between 1.20 
> and 1.50 BIOS revision.
> 
> > 
> > If not, you might need to wiggle those DIMMs or something.
> 
> It is really something else, 16GB can be seen under 2.6.15, 
> 2.6.15-rc1 (if I remember right my previous kernel version).
> I can reproduce just by booting with "wrong" kernel version.
> Any other recommendation? Except flashing and praying?
> I haven't touched the BIOS setting either, I worked completely remotely.
> 

Are you sure that it was 2.6.15 which found the full 16G?

Because there was a change which could have affected this.  But it was
merged in late October and was present in 2.6.15.


You could try a `patch -p1 -R < this:'

diff-tree f014a556e714dfb02502e3be6146a39ca625f33c (from 750deaa4021da1cf9fdb1e20861a10c76fd7f2bc)
Author: Dave Hansen <haveblue@us.ibm.com>
Date:   Sun Oct 30 14:59:37 2005 -0800

    [PATCH] fixup bogus e820 entry with mem=
    
    This was reported because someone was getting oopses reading /proc/iomem.
    It was tracked down to a zero-sized 'struct resource' entry which was
    located right at 4GB.
    
    You need two conditions to hit this bug: a BIOS E820_RAM area starting at
    exactly the boundary where you specify mem= (to get a zero-sized entry),
    and for the legacy_init_iomem_resources() loop to skip that resource (which
    only happens at exactly 4G).
    
    I think the killing zero-sized e820 entry is the easiest way to fix this.
    
    Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/arch/i386/kernel/setup.c b/arch/i386/kernel/setup.c
index 9b8c8a1..b48ac63 100644
--- a/arch/i386/kernel/setup.c
+++ b/arch/i386/kernel/setup.c
@@ -389,14 +389,24 @@ static void __init limit_regions(unsigne
 		}
 	}
 	for (i = 0; i < e820.nr_map; i++) {
-		if (e820.map[i].type == E820_RAM) {
-			current_addr = e820.map[i].addr + e820.map[i].size;
-			if (current_addr >= size) {
-				e820.map[i].size -= current_addr-size;
-				e820.nr_map = i + 1;
-				return;
-			}
+		current_addr = e820.map[i].addr + e820.map[i].size;
+		if (current_addr < size)
+			continue;
+
+		if (e820.map[i].type != E820_RAM)
+			continue;
+
+		if (e820.map[i].addr >= size) {
+			/*
+			 * This region starts past the end of the
+			 * requested size, skip it completely.
+			 */
+			e820.nr_map = i;
+		} else {
+			e820.nr_map = i + 1;
+			e820.map[i].size -= current_addr - size;
 		}
+		return;
 	}
 }
 

