Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293018AbSCABRa>; Thu, 28 Feb 2002 20:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310290AbSCABOL>; Thu, 28 Feb 2002 20:14:11 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:52202 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S310285AbSCABMg>;
	Thu, 28 Feb 2002 20:12:36 -0500
Date: Thu, 28 Feb 2002 17:12:28 -0800
To: Dag Brattli <dag@brattli.net>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [HELP] Failed check_irq_holder() -> ???
Message-ID: <20020228171228.A20656@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	Trying to validate IrDA with 2.5.6-pre1 (I guess, that's my
job). I got some socket OOPS in a place where everything was smooth
before.
	It seems that check_irq_holder() in include/asm/smplock.h is
failing and generate the Oops. Basically, it complain when
interruptible_sleep_on() is called with interrupts disabled (fair
enough).

	The offending code in net/irda/af_irda.c look like this :
--------------------------------------
	cli();	/* To avoid races on the sleep */
	
	/* A Connect Ack with Choke or timeout or failed routing will go to
	 * closed.  */
	while (sk->state == TCP_SYN_SENT) {
		interruptible_sleep_on(sk->sleep);
		if (signal_pending(current)) {
			sti();
			return -ERESTARTSYS;
		}
	}
	
	if (sk->state != TCP_ESTABLISHED) {
		sti();
		sock->state = SS_UNCONNECTED;
		return sock_error(sk);	/* Always set at this point */
	}
	
	sock->state = SS_CONNECTED;
	
	sti();
--------------------------------------

	Wow ! This is far beyond my usual level of evil !
	My guess is that this was a cut'n'paste of some TCP code (or
else), and while this other code was fixed/cleaned up, IrDA kept the
old version.
	So, if anybody remember having seen that and could tell me how
it was fixed, that would make my day...

	Thanks...

	Jean
