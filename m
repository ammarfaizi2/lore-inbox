Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbULIN7R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbULIN7R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 08:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbULIN7Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 08:59:16 -0500
Received: from av1.karneval.cz ([81.27.192.107]:45112 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S261335AbULIN6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 08:58:44 -0500
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: VM86 interrupt emulation breakage and FIXes for 2.6.x kernel series
Date: Thu, 9 Dec 2004 14:59:51 +0100
User-Agent: KMail/1.7.1
Cc: Linus Torvalds <torvalds@osdl.org>, trivial@rustcorp.com.au,
       Pavel Pisa <pisa@cmp.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412091459.51583.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

because there is no maintainer specified for VM86 subsystem, I bother you all.

There is is problem in VM86 emulation code. It returns IRQ_NONE for each
handler invocation. This results in missdetection of interrupt as uncared
and it is disabled after 100000 invocations. Next patch solves this problem.
It still returns IRQ_NONE, if the interrupt servicing by userspace
is lacking/broken or if interrupt is stuck and could freeze kernel.

The original code could not work with level invocated interrupts at all,
it would lead to the contant system freeze if IRQ_HANDLED is returned.
IRQ is didabled now in the handler and reenabled in get_and_reset_irq()
by VM86_GET_AND_RESET_IRQ IOCTL.

The FIX has been tested on 2.6.4 kernel, but I have not noticed any
change solving problem of VM86 IRQ in 2.6 BitKeeper repository
till yesterday.

We are using this VM86 feature for education purposes. Students
can write and debug their code controlling some IRC with IRQ
equipped DC motor from userspace first.
Than code could be moved to RT-Linux threads or Linux driver module.
This will be part of next run of Computer for Control curse
at our department
   http://dce.felk.cvut.cz/por/

I have used this setup even for testing and development of real drivers.
I have macros and simple adaptation code, that low level parts of
real driver code can be run in userspace, attaching interrupts through
VM86, IO/MEM through ioperm and mmap. If somebody is interrested
in this approach, I can send my sources.

Best wishes

                Pavel Pisa
        e-mail: pisa@cmp.felk.cvut.cz
        www:    http://cmp.felk.cvut.cz/~pisa
        work:   http://www.pikron.com


Name: VM86 interrupt emulation FIX for 2.6.x
Status: Trivial
Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>

Fixes faulty IRQ_NONE value returning by VM86 irq_handler().
The IRQ source is blocked as well until userspace confirms processing.
This should enable to use VM86 code even for level triggered
interrupt sources.

--- linux-2.6.4/arch/i386/kernel/vm86.c.orig 2004-03-11 03:55:22.000000000 
+0100
+++ linux-2.6.4/arch/i386/kernel/vm86.c 2004-12-08 11:25:08.000000000 +0100
@@ -718,6 +718,10 @@ static irqreturn_t irq_handler(int intno
  if (vm86_irqs[intno].sig)
   send_sig(vm86_irqs[intno].sig, vm86_irqs[intno].tsk, 1);
  /* else user will poll for IRQs */
+ spin_unlock_irqrestore(&irqbits_lock, flags); 
+ /* Next line would be required to handle correctly level activated 
interrupts */
+ disable_irq(intno);
+ return IRQ_HANDLED;
 out:
  spin_unlock_irqrestore(&irqbits_lock, flags); 
  return IRQ_NONE;

