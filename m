Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263065AbRE1O0M>; Mon, 28 May 2001 10:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263066AbRE1O0B>; Mon, 28 May 2001 10:26:01 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:48011 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S263065AbRE1OZz>; Mon, 28 May 2001 10:25:55 -0400
Message-ID: <3B125E62.1DD4712E@uow.edu.au>
Date: Tue, 29 May 2001 00:19:14 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Steve Kieu <haiquy@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.5-ac2 OOPs when run pppd ?
In-Reply-To: <20010528084855.10604.qmail@web10402.mail.yahoo.com> from "=?iso-8859-1?q?Steve=20Kieu?=" at May 28, 2001 06:48:55 PM <E154NQp-000386-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Yeas it is stil the same as 2.4.5-ac1, but did not
> > happen with 2.4.5; You can try running pppd in the
> > console (tty1) without any argument.
> 
> Looks like an interaction with the newer console locking code. The BUG() is
> caused when the ppp code tries to write to the console from inside an
> interrupt handler [now not allowed]

I wondered if there were more cases.

In the (as-yet-unsent) Linus patch I've added an

	if (in_interrupt()) {
		shout_loudly();
		return;
	}

in three places to catch this possibility.   I'll prepare
a -ac diff.


This is a fundamental problem.

- The console is a tty device
- tty devices are callable from interrupts
- the console is very stateful and needs locking
- the locking must be interrupt-safe (irqsave)
- the console is very slow.

net result: we block interrupts for ages.  It's
an exceptional situation.  I hope Linus buys this
line of reasoning :)

-
