Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318539AbSGaXOp>; Wed, 31 Jul 2002 19:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318541AbSGaXOp>; Wed, 31 Jul 2002 19:14:45 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:39421 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318539AbSGaXOo>; Wed, 31 Jul 2002 19:14:44 -0400
Subject: Re: Interrupt trouble due to IRQ router VIA?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kathy Frazier <kfrazier@daetwyler.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200207311615.15896.kfrazier@daetwyler.com>
References: <200207311615.15896.kfrazier@daetwyler.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Aug 2002 01:34:53 +0100
Message-Id: <1028162093.13008.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-31 at 21:15, Kathy Frazier wrote:
> another system.  In this system, the driver times out on the 
> interruptible_sleep_on_timeout waiting for the interrupt.  One thing that I 

There is a classic kernel programming error which goes something like
this


my_interrupt()
{
	foo->ready = 1;
	wake_up(&foo_pending);
}


foo_read()
{
	while(!foo->ready && !signal_pending(current))
		interruptible_sleep_on(&foo_pending);

}

What happens then is this

	foo->ready = 0 - true
	signal pending = 0 - ok

		INTERRUPT
			foo->ready=1
			wake up
		END INTERRUPT

	interruptible_sleep_on(&foo_pending);


Waits forever


It could be your timings have changed so such a bug now shows up

