Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261283AbSJYGWD>; Fri, 25 Oct 2002 02:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261290AbSJYGWD>; Fri, 25 Oct 2002 02:22:03 -0400
Received: from hazard.jcu.cz ([160.217.1.6]:22672 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id <S261283AbSJYGWC>;
	Fri, 25 Oct 2002 02:22:02 -0400
Date: Fri, 25 Oct 2002 08:28:09 +0200
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [miniPATCH][RFC] Compilation fixes in the 2.5.44
Message-ID: <20021025062809.GA7522@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo l-k,

I'm beginner in the kernel hacking (or fixing ;-))).

I have small patch, which is fixing some compilation errors (I'm using
gcc-2.95.4-17 from Debian sid).

The first chunk fixed this warning:

arch/i386/kernel/irq.c: In function `do_IRQ':
arch/i386/kernel/irq.c:331: warning: unused variable `esp'

I move declaration of variable esp to the #ifdef blok, where it is
using...

The second chunk fixed this warning:

In file included from arch/i386/kernel/timers/timer_pit.c:15:
arch/i386/mach-generic/do_timer.h: In function `do_timer_interrupt_hook':
arch/i386/mach-generic/do_timer.h:26: warning: implicit declaration of
function `smp_local_timer_interrupt'

I've found, that declaration of function do_timer_interrupt_hook is in
the header asm/apic.h and it is as:

extern void do_timer_interrupt_hook...

Then I add #include of asm/apic.h

The third chunk fixed this error:

net/ipv4/raw.c: In function `raw_send_hdrinc':
net/ipv4/raw.c:297: `NF_IP_LOCAL_OUT' undeclared (first use in this
function)
net/ipv4/raw.c:297: (Each undeclared identifier is reported only once
net/ipv4/raw.c:297: for each function it appears in.)

In this case was missing #include of netfilter_ipv4.h...


Any comments and sugestion is welcome...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080

--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fixes.patch"

diff -urN linux-2.5.44/arch/i386/kernel/irq.c linux-2.5.44-new/arch/i386/kernel/irq.c
--- linux-2.5.44/arch/i386/kernel/irq.c	2002-10-19 06:01:09.000000000 +0200
+++ linux-2.5.44-new/arch/i386/kernel/irq.c	2002-10-24 19:54:19.000000000 +0200
@@ -328,12 +328,12 @@
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
 	unsigned int status;
-	long esp;
 
 	irq_enter();
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
 	/* Debugging check for stack overflow: is there less than 1KB free? */
+	long esp;
 	__asm__ __volatile__("andl %%esp,%0" : "=r" (esp) : "0" (8191));
 	if (unlikely(esp < (sizeof(struct task_struct) + 1024))) {
 		extern void show_stack(unsigned long *);
diff -urN linux-2.5.44/arch/i386/mach-generic/do_timer.h linux-2.5.44-new/arch/i386/mach-generic/do_timer.h
--- linux-2.5.44/arch/i386/mach-generic/do_timer.h	2002-10-19 06:02:30.000000000 +0200
+++ linux-2.5.44-new/arch/i386/mach-generic/do_timer.h	2002-10-24 20:09:31.000000000 +0200
@@ -1,5 +1,7 @@
 /* defines for inline arch setup functions */
 
+#include <asm/apic.h>
+
 /**
  * do_timer_interrupt_hook - hook into timer tick
  * @regs:	standard registers from interrupt
diff -urN linux-2.5.44/net/ipv4/raw.c linux-2.5.44-new/net/ipv4/raw.c
--- linux-2.5.44/net/ipv4/raw.c	2002-10-19 06:01:07.000000000 +0200
+++ linux-2.5.44-new/net/ipv4/raw.c	2002-10-24 20:24:17.000000000 +0200
@@ -65,6 +65,7 @@
 #include <net/inet_common.h>
 #include <net/checksum.h>
 #include <linux/netfilter.h>
+#include <linux/netfilter_ipv4.h>
 
 struct sock *raw_v4_htable[RAWV4_HTABLE_SIZE];
 rwlock_t raw_v4_lock = RW_LOCK_UNLOCKED;

--J2SCkAp4GZ/dPZZf--
