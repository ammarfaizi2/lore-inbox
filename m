Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268446AbUI2OIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268446AbUI2OIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268447AbUI2OIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:08:10 -0400
Received: from hhlx01.vscom.de ([62.145.30.242]:56725 "EHLO
	hhlx01.visionsystems.de") by vger.kernel.org with ESMTP
	id S268446AbUI2OHU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:07:20 -0400
From: Roland =?utf-8?q?Ca=C3=9Febohm?= 
	<roland.cassebohm@VisionSystems.de>
Organization: Vision Systems GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: Serial driver hangs
Date: Wed, 29 Sep 2004 16:07:07 +0200
User-Agent: KMail/1.6.2
Cc: Paul Fulghum <paulkf@microgate.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
References: <200409281734.38781.roland.cassebohm@visionsystems.de> <200409291509.39187.roland.cassebohm@visionsystems.de> <415AB5E1.8060406@microgate.com>
In-Reply-To: <415AB5E1.8060406@microgate.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409291607.07493.roland.cassebohm@visionsystems.de>
X-OriginalArrivalTime: 29 Sep 2004 14:07:08.0368 (UTC) FILETIME=[9B5F7500:01C4A62D]
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.27.0.12; VDF 6.27.0.80
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 29. September 2004 15:17 schrieb Paul Fulghum:
> Roland Caßebohm wrote:
> > I have made a little test, at which the receive interrupt
> > is disabled in that state. It seems to be no improvement
> > to the solution of just trow away the bytes of the FIFO.
> > In both cases characters got lost.
>
> How did you reenable the receive interrupt in your test?

I have added a routine to "struct tty_driver" for restarting 
the RX interrupt after TTY_DONT_FLIP bit is cleared in 
read_chan().

>>>>>>>>>>>>
        clear_bit(TTY_DONT_FLIP, &tty->flags);
       	if (tty->driver.restart_rx)
               tty->driver.restart_rx(tty);
>>>>>>>>>>>>

and in the interrupt routine I have disabled the RX interrupt, 
if TTY_DONT_FLIP is set.

>>>>>>>>>>>>
            if (tty->flip.count >= TTY_FLIPBUF_SIZE)
            {
                info->IER &= ~UART_IER_RDI;
                serial_outp(info, UART_IER, info->IER);
                return;     // if TTY_DONT_FLIP is set
            }
>>>>>>>>>>>>

and tty->driver.restart_rx() is:

>>>>>>>>>>>>
static void rs_restart_rx(struct tty_struct *tty)
{
    struct async_struct *info = (struct async_struct 
*)tty->driver_data;
    unsigned long flags;

    if (serial_paranoia_check(info, tty->device, 
"rs_restart_rx"))
        return;

    save_flags(flags); cli();
    if (!(info->IER & UART_IER_RDI)) {
        info->IER |= UART_IER_RDI;
        serial_out(info, UART_IER, info->IER);
    }
    restore_flags(flags);
}
>>>>>>>>>>>>

It seems to take to long time in read_chan(). Do you now what 
is the exact reason of locking the filp buffer with the 
TTY_DONT_FLIP flag? For a short look I would say the buffers 
are safe locked by the spinlock tty->read_lock.

Roland
-- 
___________________________________________________

VS Vision Systems GmbH, Industrial Image Processing
Dipl.-Ing. Roland Caßebohm
Aspelohe 27A, D-22848 Norderstedt, Germany
Mail: roland.cassebohm@visionsystems.de
http://www.visionsystems.de
___________________________________________________
