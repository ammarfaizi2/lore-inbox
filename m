Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272132AbSISR4I>; Thu, 19 Sep 2002 13:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272134AbSISR4I>; Thu, 19 Sep 2002 13:56:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58129 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S272132AbSISR4G>; Thu, 19 Sep 2002 13:56:06 -0400
Date: Thu, 19 Sep 2002 19:01:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dchristian@mail.arc.nasa.gov, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 serial drops characters with 16654
Message-ID: <20020919190107.C11763@flint.arm.linux.org.uk>
References: <11E89240C407D311958800A0C9ACF7D13A7992@EXCHANGE> <3D7FCDE0.200@domdv.de> <1031818855.2994.47.camel@irongate.swansea.linux.org.uk> <200209191027.46127.dchristian@mail.arc.nasa.gov> <1032457132.27721.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1032457132.27721.45.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Sep 19, 2002 at 06:38:52PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 06:38:52PM +0100, Alan Cox wrote:
> Actually you can do it in hardware on the 16550 depending how its wired.
> Take a look at the usenet-2 serial port design some day. The software
> mode we do does in theory mean heavy delay to the bh handling might
> delay the assertion excessively. That I think may be the real
> explanation here.
> 
> Its
>          buffer full
>          bh handler delayed by bh load (tasklet nowdays I guess I mean)
>          overrun
>          overrun
>          ...
>          ksoftirqd
>          Oh look I should do carrier
> 
> Russell - does that sound reasonable.

Hmm, looking at the tty stuff, I'd say its a distinct possibility.  Even
more so since the flip buffer handler is put on tq_timer, which is subject
to ksoftirqd.

However, at the point when we hand data to the tty layer, we should have
2048 bytes left in the flip buffer before we really start soft overrunning
(vs hardware overrunning.)  I notice that we don't make any attempt to
report such an event to user space, even when user space wants to know
about overruns.

Christian - what baud rate are you running these uarts at?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

