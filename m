Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263962AbUHVArT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263962AbUHVArT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 20:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUHVArT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 20:47:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:30142 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263962AbUHVArR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 20:47:17 -0400
Date: Sat, 21 Aug 2004 17:36:54 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: bero@arklinux.org, Thomas.Duffy.99@alumni.brown.edu
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH] 2.6.8.1 modprobe tg3 oopses
Message-Id: <20040821173654.6e5b9982.rddunlap@osdl.org>
In-Reply-To: <20040820161141.28043ee8.rddunlap@osdl.org>
References: <20040820161141.28043ee8.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


| Subject: 2.6.8.1 "modprobe tg3" oopses with gcc 3.4.1
| 
| 
| I get this when trying to modprobe tg3 on an Acer Aspire 1500 notebook (32bit 
| mode) when the kernel [tried 2.6.8.1 and 2.6.8.1-mm1] is compiled with gcc 
| 3.4.1 (3.3.4 works):

I wouldn't expect this to be compiler-dependent.  There's an obvious
problem with add_pin_to_irq().  It shouldn't be __init.  Patch below.
(I thought that I had already mailed this one time, but I don't
see it anywhere.)

| CPU:    0
| EIP:    0060:[<c03ba270>]    Not tainted VLI
| EFLAGS: 00210216   (2.6.8-1ark)
| EIP is at add_pin_to_irq+0x0/0x60     <<<<< code is gone

--

add_pin_to_irq() should not be __init; it is used after init code.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 arch/i386/kernel/io_apic.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Naurp ./arch/i386/kernel/io_apic.c~ioapic_non_init ./arch/i386/kernel/io_apic.c
--- ./arch/i386/kernel/io_apic.c~ioapic_non_init	2004-08-14 03:55:10.000000000 -0700
+++ ./arch/i386/kernel/io_apic.c	2004-08-21 17:26:52.695599728 -0700
@@ -85,7 +85,7 @@ int vector_irq[NR_VECTORS] = { [0 ... NR
  * shared ISA-space IRQs, so we have to support them. We are super
  * fast in the common case, and fast for shared ISA-space IRQs.
  */
-static void __init add_pin_to_irq(unsigned int irq, int apic, int pin)
+static void add_pin_to_irq(unsigned int irq, int apic, int pin)
 {
 	static int first_free_entry = NR_IRQS;
 	struct irq_pin_list *entry = irq_2_pin + irq;
