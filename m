Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267645AbTAGUnf>; Tue, 7 Jan 2003 15:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267648AbTAGUne>; Tue, 7 Jan 2003 15:43:34 -0500
Received: from elin.scali.no ([62.70.89.10]:10510 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S267646AbTAGUm0>;
	Tue, 7 Jan 2003 15:42:26 -0500
Date: Tue, 7 Jan 2003 21:54:17 +0100 (CET)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: Robert Olsson <Robert.Olsson@data.slu.se>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: NAPI and tg3
In-Reply-To: <15899.8623.323398.889764@robur.slu.se>
Message-ID: <Pine.LNX.4.44.0301072116340.1128-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2003, Robert Olsson wrote:

> 
> Steffen Persvold writes:
>  > 
>  > I've also tried the NAPI patch for e1000 and it experience the same 
>  > performance problem with multithreaded apps. The "NAPI-HOWTO" doesn't 
>  > mention that this could be an issue at all. Does any of the NAPI authors 
>  > (Jeff ?) have any comments ?
> 
>  Well wasn't ksoftirqd the general solution to schedule softirq's to run
>  before next interrupt and by putting them under scheduler control the
>  consecutive softirq's is prevented to monopolize the CPU.
> 
>  Well you're right the doc may mention this...

True, but it doesn't say that if you have two applications loaded on 
a SMP box, one which is for example constantly receiving and sending data 
from/to the network and doing computations on the data (100 % CPU) while 
some other app is only doing computations (also 100 % CPU), the ksoftirqd 
which should receive packets and refill the TX and RX rings will be put 
last in the queue because of its low nice level (19), thus the network 
dependent application has very much lower performance than what could be 
achieved with a nice level of 0 or even running the interrupt based 
mechanism. A nice level of 0 on ksoftirqd is still a heck of a lot better 
than interrupt context isn't it ?

One simple example would be to run a network throughput application 
such as netpipe, and simultaneously start something like the McAlpin 
stream test. You would notice that with a nice level of 19 (on ksoftirqd) 
the netpipe application would get very low throughput, while the stream 
application would be as optimal as it could get. With a nice level of 0 
the netpipe application would get decent throughput and the stream 
application would still produce the same result.

Regards,
 -- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

