Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272187AbSISST2>; Thu, 19 Sep 2002 14:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272191AbSISST2>; Thu, 19 Sep 2002 14:19:28 -0400
Received: from auscon.arc.nasa.gov ([143.232.69.76]:24448 "EHLO
	rudi.arc.nasa.gov") by vger.kernel.org with ESMTP
	id <S272187AbSISST1>; Thu, 19 Sep 2002 14:19:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dan Christian <dchristian@mail.arc.nasa.gov>
Reply-To: dchristian@mail.arc.nasa.gov
Organization: NASA Ames Research Center
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 serial drops characters with 16654
Date: Thu, 19 Sep 2002 11:24:24 -0700
User-Agent: KMail/1.4.1
References: <11E89240C407D311958800A0C9ACF7D13A7992@EXCHANGE> <200209191027.46127.dchristian@mail.arc.nasa.gov> <1032457132.27721.45.camel@irongate.swansea.linux.org.uk>
In-Reply-To: <1032457132.27721.45.camel@irongate.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209191124.24964.dchristian@mail.arc.nasa.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This still isn't getting at the core problem.  I'm sending data out the 
port and dropping characters.  The receive works fine.

It can't be a problem with the receiving device being over-run, since 
the 16550 works (even though it sends several bytes after CTS drops), 
and the 16654 doesn't (it stops after the current byte).

I think that data must be lost when the receiving device drops CTS.  
Either this is a hardware flaw (and data is lost from the transmit 
FIFO), or there is some kind of race condition between the CTS drop and 
re-loading the FIFO.

-Dan

On Thursday 19 September 2002 10:38, Alan Cox wrote:
> On Thu, 2002-09-19 at 18:27, Dan Christian wrote:
> > The problem seems to be related to the RTS/CTS flow control
> > handling. The 16654 handles flow control in hardware, but the 16550
> > does it in software (I've verified this with a digital
> > oscilloscope).  I don't currently have the equipment to compare
> > when the lines drop and which characters are lost.
>
> Actually you can do it in hardware on the 16550 depending how its
> wired. Take a look at the usenet-2 serial port design some day. The
> software mode we do does in theory mean heavy delay to the bh
> handling might delay the assertion excessively. That I think may be
> the real explanation here.
>
> Its
>          buffer full
>          bh handler delayed by bh load (tasklet nowdays I guess I
> mean) overrun
>          overrun
>          ...
>          ksoftirqd
>          Oh look I should do carrier
>
> Russell - does that sound reasonable.
>
> If so the answer yet again (as with the gige performance and some
> others) might be to make it much much harder for stuff tofall back to
> ksoftirqd.
