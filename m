Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbTEJCoE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 22:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTEJCoE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 22:44:04 -0400
Received: from zero.aec.at ([193.170.194.10]:57358 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263632AbTEJCoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 22:44:03 -0400
Date: Sat, 10 May 2003 04:56:34 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Use correct x86 reboot vector
Message-ID: <20030510025634.GA31713@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Extensive discussion by various experts on the discuss@x86-64.org
mailing list concluded that the correct vector to restart an 286+ 
CPU is f000:fff0, not ffff:0000. Both seem to work on current systems, 
but the first is correct.

See the "DPMI on AMD64" and "Warm reboot for x86-64 linux" threads
on http://www.x86-64.org/mailing_lists/list?listname=discuss&listnum=0 
for more details.

This patch fixes the 2.5.69 i386 reboot code to use this too.

--- linux-2.5.69/arch/i386/kernel/reboot.c-o	2003-03-28 18:32:18.000000000 +0100
+++ linux-2.5.69/arch/i386/kernel/reboot.c	2003-05-10 04:51:35.000000000 +0200
@@ -123,7 +123,7 @@
 };
 static unsigned char jump_to_bios [] =
 {
-	0xea, 0x00, 0x00, 0xff, 0xff		/*    ljmp  $0xffff,$0x0000  */
+	0xea, 0xf0, 0xff, 0x00, 0xf0	/* ljmp  $0xf000:0xfff0 */
 };
 
 /*
