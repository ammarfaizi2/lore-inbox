Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWHWMtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWHWMtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 08:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWHWMtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 08:49:18 -0400
Received: from arrakeen.ouaza.com ([212.85.152.62]:19840 "EHLO
	arrakeen.ouaza.com") by vger.kernel.org with ESMTP id S932446AbWHWMtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 08:49:17 -0400
Date: Wed, 23 Aug 2006 14:45:41 +0200
From: Raphael Hertzog <hertzog@debian.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Paul Fulghum <paulkf@microgate.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: How to avoid serial port buffer overruns?
Message-ID: <20060823124541.GD5137@ouaza.com>
References: <20060816104559.GF4325@ouaza.com> <1155753868.3397.41.camel@mindpipe> <44E37095.9070200@microgate.com> <1155762739.7338.18.camel@mindpipe> <1155767066.2600.19.camel@localhost.localdomain> <20060817161042.GC10818@ouaza.com> <1155929467.2924.41.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1155929467.2924.41.camel@mindpipe>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I took the time to try some of your suggestions and I managed to get rid
of the overruns.

On Fri, 18 Aug 2006, Lee Revell wrote:
> Have you tried it with HZ=100?  HZ=1000 might just be too much for that
> board.

This indeed was a major problem and a bad choice of mine at the very
beginning. It goes way better with HZ=100.

On Fri, 18 Aug 2006, Paul Fulghul wrote:
> For fun, have you tried playing with the rx FIFO trigger
> level in the 16550A entry in drivers/serial/8250.c ?
> You could try replacing UART_FCR_R_TRIG_10 (8 char trigger)
> with UART_FCR_R_TRIG_01 (4 char trigger) or even
> UART_FCR_R_TRIG_00 (1 char trigger).
> That creates more interrupts, but allows
> more time to activate the ISR before overrun.

I changed the rx FIFO trigger level to 1 byte (UART_FCR_R_TRIG_00) and it
helped a lot as well. With this combination I completely resolved the
problem of overruns at full speed (115200 bauds).

For the sake of comparison, I made a similar change to the 2.4.31 kernel I
was using (ie a kernel with low latency/preemptible kernel patches).

It helped a lot as well: most of the time I wouldn't have overruns (before
they were very frequent, like at least one overrun in 10k chars received).
However from time to time I would suffer from a single big overrun (like 30
chars lost). And using heavily the disk on module will increase the
likelihood to have a buffer overrun.

With the 2.6.17.7 kernel (CONFIG_HZ=100 and patched to trigger IRQ at
1 byte received), I have been completely unable to reproduce the buffer
overruns whatever read/write operation I've been triggering during the data
exchange.

So all in all, the 2.6 kernel behaves better than the 2.4 in this
case.

Cheers,
-- 
Raphaël Hertzog

Premier livre français sur Debian GNU/Linux :
http://www.ouaza.com/livre/admin-debian/
