Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269332AbUI3QSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269332AbUI3QSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 12:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269330AbUI3QSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 12:18:13 -0400
Received: from ns.visionsystems.de ([62.145.30.242]:36075 "EHLO
	hhlx01.visionsystems.de") by vger.kernel.org with ESMTP
	id S269327AbUI3QRI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 12:17:08 -0400
From: Roland =?utf-8?q?Ca=C3=9Febohm?= 
	<roland.cassebohm@VisionSystems.de>
Organization: Vision Systems GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: Serial driver hangs
Date: Thu, 30 Sep 2004 18:16:44 +0200
User-Agent: KMail/1.6.2
Cc: Paul Fulghum <paulkf@microgate.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
References: <200409281734.38781.roland.cassebohm@visionsystems.de> <200409291607.07493.roland.cassebohm@visionsystems.de> <1096467951.1964.22.camel@deimos.microgate.com>
In-Reply-To: <1096467951.1964.22.camel@deimos.microgate.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409301816.44649.roland.cassebohm@visionsystems.de>
X-OriginalArrivalTime: 30 Sep 2004 16:16:46.0069 (UTC) FILETIME=[E1A83250:01C4A708]
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.27.0.12; VDF 6.27.0.82
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 29. September 2004 16:25 schrieb Paul Fulghum:
> On Wed, 2004-09-29 at 09:07, Roland Caßebohm wrote:
> > I have added a routine to "struct tty_driver" for
> > restarting the RX interrupt after TTY_DONT_FLIP bit is
> > cleared in read_chan().
>
> If you are using RTS/CTS flow control,
> your scheme might prevent data loss if you also
> drop RTS (like driver throttle method) when disabling
> the rx IRQ and reasserting RTS (unthrottle) when
> reenabling the IRQ. Unfortunately, this may interfere
> with the line discipline's use of throttle/unthrottle.

Maybe I can use the functions rs_throttle() and 
rs_unthrottle(). In rs_unthrottle I could reenable the RX 
interrupt. So I don't need to add a function in "struct 
tty_driver". I only need to set the flag TTY_THROTTLED if I 
disable the interrupt.

>
> > It seems to take to long time in read_chan(). Do you now
> > what is the exact reason of locking the filp buffer with
> > the TTY_DONT_FLIP flag? For a short look I would say the
> > buffers are safe locked by the spinlock tty->read_lock.
>
> I can't identify the reason.
> If you feel brave, remove the setting/clearing
> of TTY_DONT_FLIP and see what happens.

I've just commented out all places where TTY_DONT_FLIP would 
be set and left everything else original. It seems to work 
without problems.

My system is sending and receiving on two ports with 921600 
baud with CPU load of 85%. Some bytes get still lost, but 
less then before. The test is working for 2h now and I have 
forced sometimes some more activity to have a CPU load of 
100%, but it is still working. 

Maybe TTY_DONT_FLIP is really don't needed anymore.
I think to be save and fast maybe one way could be, if the 
flip buffer is full it should be flipped but not processed 
with tty->ldisc.receive_buf() in the interrupt routine. 
flush_to_ldisc() has then always to look at both flip buffers 
and process them.
If the second flip buffer is still not clean, if the interrupt 
routine needs to flip it, it has to stop the flow and disable 
the receive interrupt.
unthrottle() could then reenable the interrupt.

Maybe my thinking is to simple, what do you think?

Roland
-- 
___________________________________________________

VS Vision Systems GmbH, Industrial Image Processing
Dipl.-Ing. Roland Caßebohm
Aspelohe 27A, D-22848 Norderstedt, Germany
Mail: roland.cassebohm@visionsystems.de
http://www.visionsystems.de
___________________________________________________
