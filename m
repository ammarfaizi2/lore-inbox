Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267632AbUIAULC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUIAULC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUIAUKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:10:14 -0400
Received: from expredir1.cites.uiuc.edu ([128.174.5.184]:13546 "EHLO
	expredir1.cites.uiuc.edu") by vger.kernel.org with ESMTP
	id S267617AbUIAUJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:09:35 -0400
From: Paul Miller <paul-kernel@pinheiro.dyndns.org>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: interrupt lockups & segfaults / custom hardware
Date: Wed, 1 Sep 2004 15:09:32 -0500
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409011509.32098.paul-kernel@pinheiro.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made a custom board that interfaces a Philips SJA1000 CAN controller to my 
PC's PCI bus.  The device works fine until I start receiving lots of 
interrupts from received CAN messages, and the PC completely locks up.  I'm 
sending 3 messages every 10ms from a DSP.  It usually takes 10-60 seconds for 
a lockup on a 2.66GHz P4.  Here are the details:

First, the chip's interrupt line is active low and remains low until it's 
interrupt vector is read.  If Linux doesn't run my ISR immediately, the pin 
is remains low.  Is this a problem?  I'm wondering if Linux clears the PC 
interrupt and adds my ISR to a queue to be run.  If so, I would expect Linux 
to be receiving thousands on interrupts before the interrupt is actually 
cleared.  This may explain why I'm receiving thousands of interrupts that 
have a null interrupt vector (no interrupt source).  Can I make the interrupt 
edge-triggered?  I suspect I'll need to redesign my hardware.

Second, if I do not service the interrupt (return IRQ_NONE) I get a message in 
syslog that the interrupt occurred and was disabled because 'nobody cared', 
which is fine, but then a segfault appears in syslog.  I suspect this is a 
bug in the kernel.

Aug 31 14:20:18 coecsl24 kernel: irq 17: nobody cared!
Aug 31 14:20:18 coecsl24 kernel:  [__report_bad_irq+42/139] 
__report_bad_irq+0x2
a/0x8b
Aug 31 14:20:18 coecsl24 kernel:  [note_interrupt+111/159] 
note_interrupt+0x6f/0
x9f
Aug 31 14:20:18 coecsl24 kernel:  [do_IRQ+295/310] do_IRQ+0x127/0x136
Aug 31 14:20:18 coecsl24 kernel:  [common_interrupt+24/32] 
common_interrupt+0x18
/0x20
Aug 31 14:20:18 coecsl24 kernel: handlers:
Aug 31 14:20:18 coecsl24 kernel: [__crc_mii_link_ok+376944/1089141] 
(snd_intel8x
0_interrupt+0x0/0x23c [snd_intel8x0])
Aug 31 14:20:18 coecsl24 kernel: Disabling IRQ #17

2.6.x Kernels, tested with 2.6.7 and 2.6.8.1..

Thanks!
-Paul
