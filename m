Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbUL3XKK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbUL3XKK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 18:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbUL3XKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 18:10:10 -0500
Received: from mail.tyan.com ([66.122.195.4]:8452 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261744AbUL3XJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 18:09:55 -0500
Message-ID: <3174569B9743D511922F00A0C943142307290FE1@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, Matt_Domsch@dell.com
Subject: RE: 256 apic id for amd64
Date: Thu, 30 Dec 2004 15:19:01 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.9 has a good feature and you remove that in 2.6.10.

That is if the io apic is set to above 0xf, io_apic.c will find one below
0xf unused and update the table.

YH

-----Original Message-----
From: Andi Kleen [mailto:ak@muc.de] 
Sent: Thursday, December 30, 2004 10:45 AM
To: YhLu
Cc: linux-kernel@vger.kernel.org; discuss@x86-64.org; Matt_Domsch@dell.com
Subject: Re: 256 apic id for amd64

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

diff -u linux-2.6.10/arch/x86_64/kernel/io_apic.c-o
linux-2.6.10/arch/x86_64/kernel/io_apic.c
--- linux-2.6.10/arch/x86_64/kernel/io_apic.c-o	2004-12-24
22:34:45.000000000 +0100
+++ linux-2.6.10/arch/x86_64/kernel/io_apic.c	2004-12-30
19:41:08.000000000 +0100
@@ -1160,13 +1160,6 @@
 		
 		old_id = mp_ioapics[apic].mpc_apicid;
 
-		if (mp_ioapics[apic].mpc_apicid >= 0xf) {
-			apic_printk(APIC_QUIET,KERN_ERR "BIOS bug,
IO-APIC#%d ID is %d in the MPC table!...\n",
-				apic, mp_ioapics[apic].mpc_apicid);
-			apic_printk(APIC_QUIET,KERN_ERR "... fixing up to
%d. (tell your hw vendor)\n",
-				reg_00.bits.ID);
-			mp_ioapics[apic].mpc_apicid = reg_00.bits.ID;
-		}
 
 		printk(KERN_INFO "Using IO-APIC %d\n",
mp_ioapics[apic].mpc_apicid);
 
