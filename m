Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265290AbUFOFXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265290AbUFOFXJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 01:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbUFOFXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 01:23:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:29380 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265290AbUFOFXE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 01:23:04 -0400
Date: Mon, 14 Jun 2004 22:16:55 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] apic.c init section references
Message-Id: <20040614221655.33c15636.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix init/initdata and static uses in arch/i386/kernel/apic.c

Error: ./arch/i386/kernel/apic.o .data refers to 0000009c R_386_32          .init.text

arch/i386/kernel/apic.c
void (*wait_timer_tick)(void) = wait_8254_wraparound;
wait_8254_wraparound is __init.  wait_timer_tick should be __initdata,
which flows onto several other functions.

Also, __setup_APIC_LVTT() can be static since it is only called
from within this source file.

Error no longer reported by reference_init.pl.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>


diffstat:=
 arch/i386/kernel/apic.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -Naurp ./arch/i386/kernel/apic.c~apic_init ./arch/i386/kernel/apic.c
--- ./arch/i386/kernel/apic.c~apic_init	2004-05-09 19:33:21.000000000 -0700
+++ ./arch/i386/kernel/apic.c	2004-06-14 21:49:20.000000000 -0700
@@ -811,7 +811,7 @@ static void __init wait_8254_wraparound(
  * Default initialization for 8254 timers. If we use other timers like HPET,
  * we override this later
  */
-void (*wait_timer_tick)(void) = wait_8254_wraparound;
+void (*wait_timer_tick)(void) __initdata = wait_8254_wraparound;
 
 /*
  * This function sets up the local APIC timer, with a timeout of
@@ -826,7 +826,7 @@ void (*wait_timer_tick)(void) = wait_825
 
 #define APIC_DIVISOR 16
 
-void __setup_APIC_LVTT(unsigned int clocks)
+static void __setup_APIC_LVTT(unsigned int clocks)
 {
 	unsigned int lvtt_value, tmp_value, ver;
 
@@ -847,7 +847,7 @@ void __setup_APIC_LVTT(unsigned int cloc
 	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
 }
 
-static void setup_APIC_timer(unsigned int clocks)
+static void __init setup_APIC_timer(unsigned int clocks)
 {
 	unsigned long flags;
 


--
~Randy
