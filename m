Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265191AbUAAJZt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 04:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265343AbUAAJZt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 04:25:49 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:49857 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265191AbUAAJZq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 04:25:46 -0500
From: Juergen Hasch <lkml@elbonia.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1 compile error
Date: Thu, 1 Jan 2004 10:26:00 +0100
User-Agent: KMail/1.5.4
References: <200401010109.12005.harisri@bigpond.com>
In-Reply-To: <200401010109.12005.harisri@bigpond.com>
Cc: Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oe+8/PshOD+LQdV"
Message-Id: <200401011026.00520.lkml@elbonia.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:464ad01b81b0f762cd239ce6f3ab8323
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_oe+8/PshOD+LQdV
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Mittwoch, 31. Dezember 2003 15:09 schrieb Srihari Vijayaraghavan:
>
>
> Then it compiled the io_apic.c and progressed (maybe a lot). But it failed
> and showed this error message:
>   LD      .tmp_vmlinux1
>
> arch/i386/pci/built-in.o(.text+0xc6e): In function `pcibios_lookup_irq':
> : undefined reference to `can_request_irq'
>
> make: *** [.tmp_vmlinux1] Error 1
>

This is obviously due to can_request_irq is found in arch/i386/kernel/irq.c
and the x86_64 build just includes some stuff from arch/i386/pci/irq.c where
can_request_irq is used too. 

Linus introduced this function a few weeks ago. I used the patch below to move 
the function from kernel/irq.c to pci/irq.c, but he will probably fix it
himself soon.

Btw. there are a lot of other fixes for the x86_64 build from Andi Kleen which
you should apply too. However, they don't apply cleanly anymore.

...Juergen

--Boundary-00=_oe+8/PshOD+LQdV
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="can_request_irq.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="can_request_irq.diff"

--- arch/i386/kernel/irq.c.orig	2004-01-01 10:06:00.000000000 +0100
+++ arch/i386/kernel/irq.c	2003-12-31 13:13:58.000000000 +0100
@@ -511,19 +511,6 @@
 	return 1;
 }
 
-int can_request_irq(unsigned int irq, unsigned long irqflags)
-{
-	struct irqaction *action;
-
-	if (irq >= NR_IRQS)
-		return 0;
-	action = irq_desc[irq].action;
-	if (action) {
-		if (irqflags & action->flags & SA_SHIRQ)
-			action = NULL;
-	}
-	return !action;
-}
 
 /**
  *	request_irq - allocate an interrupt line
--- arch/i386/pci/irq.c.orig	2004-01-01 10:06:42.000000000 +0100
+++ arch/i386/pci/irq.c	2003-12-31 13:24:35.000000000 +0100
@@ -939,6 +939,20 @@
 	pirq_penalty[irq] += 100;
 }
 
+int can_request_irq(unsigned int irq, unsigned long irqflags)
+{
+       struct irqaction *action;
+
+       if (irq >= NR_IRQS)
+               return 0;
+       action = irq_desc[irq].action;
+       if (action) {
+               if (irqflags & action->flags & SA_SHIRQ)
+                       action = NULL;
+       }
+       return !action;
+}
+
 int pirq_enable_irq(struct pci_dev *dev)
 {
 	u8 pin;

--Boundary-00=_oe+8/PshOD+LQdV--

