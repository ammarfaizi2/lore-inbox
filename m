Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292122AbSBYS5Y>; Mon, 25 Feb 2002 13:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293298AbSBYS5O>; Mon, 25 Feb 2002 13:57:14 -0500
Received: from users.ccur.com ([208.248.32.211]:55319 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S292122AbSBYS5L>;
	Mon, 25 Feb 2002 13:57:11 -0500
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200202251856.SAA11120@rudolph.ccur.com>
Subject: [RFC][PATCH] irq0 affinity broke on some i386 boxes
To: linux-kernel@vger.kernel.org
Date: Mon, 25 Feb 2002 13:56:51 -0500 (EST)
Reply-To: joe.korty@ccur.com (Joe Korty)
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
  The following patch fixes a bug that prevents a write to
/proc/irq/0/smp_affinity from actually changing the cpu affinity
of IRQ #0, on all the (Dell server) SMP machines I have access to.

Given the wide variety of IO APIC and legacy PIC usage on various SMP
motherboards, and the nascent state of my APIC understanding, it is
quite likely that this fix is not universal.

I would like expand this patch so that IRQ0 affinity assignment works
properly on as many i386 SMP motherboards as possible.  If you have
such a motherboard, please first 1) verify that assignments to
/proc/irq/0/smp_affinity NOP for you, and 2) if it does NOP, that
this patch does or does not fix the problem on your system.

To verify that your system has the problem or not:

    in one window, run `watch -n1 cat /proc/interrupts'.

    in another window, assign some affinity value to irq0.  In the
    following example, cpu #0 (in a 4-cpu system) is to no longer get
    irq0 interrupts:

	echo e >/proc/irq/0/smp_affinity

    If your system is working properly, the watch-window should no
    longer show increments for the irq0 value for cpu0.

This patch is against 2.4.18-rc4

Joe

--- linux/arch/i386/kernel/io_apic.c.orig	Tue Nov 13 20:28:41 2001
+++ linux/arch/i386/kernel/io_apic.c	Mon Feb 25 13:17:13 2002
@@ -1537,6 +1537,7 @@
 				setup_nmi();
 				check_nmi_watchdog();
 			}
+			add_pin_to_irq(0, 0, pin2);
 			return;
 		}
 		/*
