Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273334AbTG3TTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 15:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273336AbTG3TTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 15:19:53 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:50105 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S273334AbTG3TTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 15:19:51 -0400
Date: Wed, 30 Jul 2003 21:18:54 +0200 (MEST)
Message-Id: <200307301918.h6UJIskn020572@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: Re: [PATCH] NMI watchdog documentation
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, torvalds@osdl.org,
       vherva@niksula.hut.fi
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003 18:06:30 +0200, Andi Kleen wrote:
>Right, 1 and 2 need to be exchanged. Anyways local apic mode does not seem
>to work, the kernel always reportss "NMI stuck" at bootup.
>IO APIC mode for is default.

That's strange. I've tested perfctr-generated interrupts through
the local APIC on Opteron, and they work with the perfctr driver.

Two things you might want to test:
- In case the unofficial event 0x76 really doesn't work in your
  version of the chip, try this event specifier instead: it
  creates a clock-like event using an inverted threshold approach.
  I've tested this on K8 and P6 with the perfctr driver. The event
  code (0xC0) is immaterial, 0x00 and 0xFF work equally well.

--- linux-2.6.0-test2/arch/x86_64/kernel/nmi.c.~1~	2003-07-03 12:32:44.000000000 +0200
+++ linux-2.6.0-test2/arch/x86_64/kernel/nmi.c	2003-07-30 20:46:21.412657728 +0200
@@ -51,7 +51,7 @@
 #define K7_EVNTSEL_OS		(1 << 17)
 #define K7_EVNTSEL_USR		(1 << 16)
 #define K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING	0x76
-#define K7_NMI_EVENT		K7_EVENT_CYCLES_PROCESSOR_IS_RUNNING
+#define K7_NMI_EVENT		(0xC0 | (1<<23) | (0xFF << 24))
 
 #define P6_EVNTSEL0_ENABLE	(1 << 22)
 #define P6_EVNTSEL_INT		(1 << 20)

- My perfctr driver routes interrupts through LVTPC programmed for
  Fixed delivery mode. Maybe the NMI delivery mode is broken. You
  could try changing the NMI watchdog to use a new vector and Fixed
  delivery mode, just to see if the watchdog starts ticking.

/Mikael
