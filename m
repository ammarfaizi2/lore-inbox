Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261696AbUL3Spb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261696AbUL3Spb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 13:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbUL3Spb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 13:45:31 -0500
Received: from one.firstfloor.org ([213.235.205.2]:45747 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261696AbUL3SpX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 13:45:23 -0500
To: YhLu <YhLu@tyan.com>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, Matt_Domsch@dell.com
Subject: Re: 256 apic id for amd64
References: <3174569B9743D511922F00A0C943142307290EEE@TYANWEB>
From: Andi Kleen <ak@muc.de>
Date: Thu, 30 Dec 2004 19:45:22 +0100
In-Reply-To: <3174569B9743D511922F00A0C943142307290EEE@TYANWEB> (YhLu@tyan.com's
 message of "Tue, 28 Dec 2004 20:43:47 -0800")
Message-ID: <m1d5wrlj5p.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

YhLu <YhLu@tyan.com> writes:

> Can someone who maintains the x86-64 io_apic.c look at my patch about 256
> apic id for amd64?

First in general if you want patches submitted look up the maintainer
in the MAINTAINERS file in the source tree and send it directly
to the appropiate person and mailing list.

Just curious - how many IO-APICs does your system have?

Then I don't like your patch very much, since it doesnt handle 
Intel systems. The best fix is probably to 

i386 also has a different (but Intel specific fix) - uses either
0xf or 0xff based on the APIC version. Just dropping it seems
better to me though. I suppose Matt (cc'ed) who apparently
wrote this code originally used it to work around some BIOS
bug, and at least we can hope for now that there are no 
EM64T boxes with that particular BIOS bug.

I will add this patch.

-Andi

Remove check that limited max number of IO-APIC to 8.

The original check was apparently to work around some old BIOS
bugs and we just assume x86-64 machines don't have this class of
problems.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -u linux-2.6.10/arch/x86_64/kernel/io_apic.c-o linux-2.6.10/arch/x86_64/kernel/io_apic.c
--- linux-2.6.10/arch/x86_64/kernel/io_apic.c-o	2004-12-24 22:34:45.000000000 +0100
+++ linux-2.6.10/arch/x86_64/kernel/io_apic.c	2004-12-30 19:41:08.000000000 +0100
@@ -1160,13 +1160,6 @@
 		
 		old_id = mp_ioapics[apic].mpc_apicid;
 
-		if (mp_ioapics[apic].mpc_apicid >= 0xf) {
-			apic_printk(APIC_QUIET,KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC table!...\n",
-				apic, mp_ioapics[apic].mpc_apicid);
-			apic_printk(APIC_QUIET,KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
-				reg_00.bits.ID);
-			mp_ioapics[apic].mpc_apicid = reg_00.bits.ID;
-		}
 
 		printk(KERN_INFO "Using IO-APIC %d\n", mp_ioapics[apic].mpc_apicid);
 
