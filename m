Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263668AbTJCRZj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 13:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263692AbTJCRZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 13:25:39 -0400
Received: from chaos.analogic.com ([204.178.40.224]:640 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263668AbTJCRZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 13:25:38 -0400
Date: Fri, 3 Oct 2003 13:25:30 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: FDC motor left on
Message-ID: <Pine.LNX.4.53.0310031322430.499@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux-2.4.22 and earlier, if there is no FDC driver installed,
the FDC motor may continue to run after boot if the motor was
started as part of the BIOS boot sequence.
This patch turns OFF the motor once Linux gets control.


--- linux-2.4.22/arch/i386/boot/setup.S.orig	Fri Aug  2 20:39:42 2002
+++ linux-2.4.22/arch/i386/boot/setup.S	Fri Oct  3 11:50:43 2003
@@ -59,6 +59,8 @@
 #define SIG1	0xAA55
 #define SIG2	0x5A5A

+FDC_MOTOR = 0x3f2
+FDC_MOTON = 0x10
 INITSEG  = DEF_INITSEG		# 0x9000, we move boot here, out of the way
 SYSSEG   = DEF_SYSSEG		# 0x1000, system loaded at 0x10000 (65536).
 SETUPSEG = DEF_SETUPSEG		# 0x9020, this is the current segment
@@ -776,6 +778,12 @@

 	movb	$0xFB, %al			# mask all irq's but irq2 which
 	outb	%al, $0x21			# is cascaded
+
+	movl	$FDC_MOTOR, %edx		# FDC motor control
+	inb	%dx, %al			# Get what's there
+	andb	$~FDC_MOTON, %al		# Reset motor bit
+	outb	%al, %dx			# Turn OFF motor
+

 # Well, that certainly wasn't fun :-(. Hopefully it works, and we don't
 # need no steenking BIOS anyway (except for the initial loading :-).



Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


