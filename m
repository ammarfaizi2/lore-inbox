Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287287AbSALSnM>; Sat, 12 Jan 2002 13:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287293AbSALSnC>; Sat, 12 Jan 2002 13:43:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:52496 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287287AbSALSms>; Sat, 12 Jan 2002 13:42:48 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
To: arjan@fenrus.demon.nl
Date: Sat, 12 Jan 2002 18:54:27 +0000 (GMT)
Cc: landley@trommello.org (Rob Landley), linux-kernel@vger.kernel.org
In-Reply-To: <m16PKqN-000OVeC@amadeus.home.nl> from "arjan@fenrus.demon.nl" at Jan 12, 2002 09:52:55 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16PTIR-0002sL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another example is in the network drivers. The 8390 core for one example
carefully disables an IRQ on the card so that it can avoid spinlocking on 
uniprocessor boxes.

So with pre-empt this happens

	driver magic
	disable_irq(dev->irq)
PRE-EMPT:
	[large periods of time running other code]
PRE-EMPT:
	We get back and we've missed 300 packets, the serial port sharing
	the IRQ has dropped our internet connection completely.

["Don't do that then" isnt a valid answer here. If I did hold a lock
 it would be for several milliseconds at a time anyway and would reliably
 trash performance this time]

There are numerous other examples in the kernel tree where the current code
knows that there is a small bounded time between two actions in kernel space
that do not have a sleep. They are not spin locked, and putting spin locks
everywhere will just trash performance. They are pure hardware interactions
so you can't automatically detect them.

That is why the pre-empt code is a much much bigger problem and task than the
low latency code.

Alan
