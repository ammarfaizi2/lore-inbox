Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269016AbTGOPac (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 11:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268966AbTGOP24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 11:28:56 -0400
Received: from firewall.mdc-dayton.com ([12.161.103.180]:18352 "EHLO
	firewall.mdc-dayton.com") by vger.kernel.org with ESMTP
	id S268932AbTGOP1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 11:27:36 -0400
From: "Kathy Frazier" <kfrazier@mdc-dayton.com>
To: <root@chaos.analogic.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Interrupt doesn't make it to the 8259 on a ASUS P4PE mobo
Date: Tue, 15 Jul 2003 11:52:54 -0500
Message-ID: <PMEMILJKPKGMMELCJCIGAELACCAA.kfrazier@mdc-dayton.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.53.0307141833190.4354@chaos>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>There is a possibility that you are trying to use a shared interrupt,
>but the IRQ is set up for edge. You can only share level interrupts.

I checked it out.  The Edge/Level Triggered Register (ELCR) of Intel's 82801
ICH4 PIC register shows that our IRQ is setup for edge.

>Also, in the keyboard ISR, there is code that will spin <forever>
>if the bit that was supposed to be true when the interrupt occurred,
>remains false. This means that, if the timing was screwed up on some
>feature-board bus interface state-machine, it could corrupt what
>other devices see on the bus. The result could be a "hang forever"
>condition.

Hmmm, this is good information.  Exactly what bit are you referring too?  Is
this in /drivers/char/keyboard.c?  I took a quick look through, but didn't
see anything.  With the symptoms I am experiencing, I thought it might be
due to a piece of software spinning in a loop after it issued a cli.
However, I should at least see any pending interrupts in the IRR of the
8259!  The cli would just prevent the CPU from being notified of the pending
interrupt.

>The 8259 is such an old device that all its bugs are known and
>work-arounds have been in-place for ages. It is unlikely that your
>problem has anything to do with either in 8259 or existing kernel
>code. My bet's on with a level/edge problem or bus corruption due
>to bus-contention (timing issues).

I tend to agree with you - the 8259 has been around forever.  The snooping
I've done with my debug indicates that that the IRQ never gets through from
the hardware.  The CPU is still running software and apparantly other things
are getting scheduled.  But no other IRQs are getting through!  Something is
corrupted on the bus.  This posting was a final sanity check to insure I
wasn't totally out in left field with respect to the driver software.  I
know there are issues of race conditions when using the sleep_on/wake_up
mechanisms.  However, from what I've read, wait_event_interruptible() method
will avoid this . . .  Any thoughts on that?

Thanks for your input!

Kathy

