Return-Path: <linux-kernel-owner+w=401wt.eu-S1030399AbWLTW2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030399AbWLTW2x (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030400AbWLTW2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:28:53 -0500
Received: from odyssey.analogic.com ([204.178.40.5]:2725 "EHLO
	odyssey.analogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030399AbWLTW2w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:28:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 20 Dec 2006 22:28:50.0628 (UTC) FILETIME=[3924D040:01C72486]
Content-class: urn:content-classes:message
Subject: Re: locking issue (hardirq+softirq+user)
Date: Wed, 20 Dec 2006 17:28:49 -0500
Message-ID: <Pine.LNX.4.61.0612201715300.24083@chaos.analogic.com>
In-Reply-To: <45893C1C.60305@gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: locking issue (hardirq+softirq+user)
thread-index: AcckhjkwqGwNBiaWSjmX0WfIV1tYwQ==
References: <45893C1C.60305@gmail.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Jiri Slaby" <jirislaby@gmail.com>
Cc: "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Dec 2006, Jiri Slaby wrote:

> Hi!
>
> an user still gets NMI watchdog warning, that the machine deadlocked.
>
> The code is something like this:
>
> DEFINE_SPINLOCK(lock);
>
> isr() /* i.e. hardirq context */
> {
> spin_lock(&lock);
> ...
> spin_unlock(&lock);
> }
>
> timer() /* i.e. softirq context */
> {
> unsigned int f;
> spin_lock_irqsave(&lock, f) /* stack shows, that it locks here */
> ...
> spin_unlock_irqrestore(&lock, f)
> ...
> mod_timer();
> }
>
> tty_open_or_whatever() /* i.e. user context */
> {
> unsigned int f;
> spin_lock_irqsave(&lock, f)
> ...
> spin_unlock_irqrestore(&lock, f)
> }
>
> init()
> {
> mod_timer();
> request_irq();
> register_that_open_with_something();
> }
>
> What's the correct locking approach in this situation? Is that correct (I tried
> to go through Rusty Russel's guide to locking, but I didn't get it in this
> case)? There were many spin_lock recursions in the driver
> (drivers/char/isicom.c), which I removed, but it still deadlocks on SMP.
>
> thanks,
> -- 
> http://www.fi.muni.cz/~xslaby/            Jiri Slaby
> faculty of informatics, masaryk university, brno, cz
> e-mail: jirislaby gmail com, gpg pubkey fingerprint:
> B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E

Well the locking is okay. The lock in the ISR, which doesn't require saving
and restoring flags, will prevent any other spin-lock from being entered
by another CPU when an interrupt is being handled. The spin-locks within
the timer will not clash as long as you are truly accessing the same lock 
variable.

The watchdog (NMI) hang detector runs when a CPU instruction-pointer seems
to be in the same place for too long. It could be that your ISR does not
return the correct 'done' flag or that you have some do-forever loop in your
code.

Note that if you start your timer from within the ISR, the timer (on another
CPU) may start instantly. This is usually not a problem, but you need
to make sure this doesn't create a wait-forever loop as well. Nevertheless
the basic spin-locking that you have shown is correct.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.24 on an i686 machine (5592.72 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
