Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272325AbSISSiI>; Thu, 19 Sep 2002 14:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272328AbSISSiI>; Thu, 19 Sep 2002 14:38:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:25618 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S272325AbSISSiH>; Thu, 19 Sep 2002 14:38:07 -0400
Date: Thu, 19 Sep 2002 19:43:09 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Dan Christian <dchristian@mail.arc.nasa.gov>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 serial drops characters with 16654
Message-ID: <20020919194309.D11763@flint.arm.linux.org.uk>
References: <11E89240C407D311958800A0C9ACF7D13A7992@EXCHANGE> <200209191027.46127.dchristian@mail.arc.nasa.gov> <1032457132.27721.45.camel@irongate.swansea.linux.org.uk> <200209191124.24964.dchristian@mail.arc.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200209191124.24964.dchristian@mail.arc.nasa.gov>; from dchristian@mail.arc.nasa.gov on Thu, Sep 19, 2002 at 11:24:24AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 11:24:24AM -0700, Dan Christian wrote:
> This still isn't getting at the core problem.  I'm sending data out the 
> port and dropping characters.  The receive works fine.
> 
> It can't be a problem with the receiving device being over-run, since 
> the 16550 works (even though it sends several bytes after CTS drops), 
> and the 16654 doesn't (it stops after the current byte).
> 
> I think that data must be lost when the receiving device drops CTS.  
> Either this is a hardware flaw (and data is lost from the transmit 
> FIFO), or there is some kind of race condition between the CTS drop and 
> re-loading the FIFO.

Ok, it doesn't sound like FIFO underrun, but FIFO overrun.  In theory,
this should never ever happen on the transmit side, however you appear
to be seeing exactly this.

The first thing I'll ask is that you check that the port is being
recognised as a ST16654 and not 16650V2.  The former has 64 bytes of
FIFO, the latter has 256 bytes.

Secondly, how many characters on average do you seem to be dropping in
one go?  I'm not expecting an exact figure, just a rough idea will
probably do.

Thirdly, there is a possibility here that could be causing this, and
it surrounds the following code in transmit_chars() in serial.c:

        count = info->xmit_fifo_size;
        do {
                serial_out(info, UART_TX, info->xmit.buf[info->xmit.tail]);
                info->xmit.tail = (info->xmit.tail + 1) & (SERIAL_XMIT_SIZE-1);
                info->state->icount.tx++;
                if (info->xmit.head == info->xmit.tail)
                        break;
        } while (--count > 0);

We always load a full FIFO-size chunk of data into the UART whenever
it says "hey, my transmit holding register is empty" since the FIFO
should be empty.  I'm wondering if the ST16654 is giving an early
indication.

Could you try changing the first line in drivers/char/serial.c to:

        count = info->xmit_fifo_size / 2;

to find out whether that improves the situation?  Don't worry, I don't
intend this as a fix.  Its more to (dis-)prove the point.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

