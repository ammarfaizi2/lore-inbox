Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271321AbRHOR11>; Wed, 15 Aug 2001 13:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271324AbRHOR1J>; Wed, 15 Aug 2001 13:27:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:53633 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S271321AbRHOR0y>; Wed, 15 Aug 2001 13:26:54 -0400
Importance: Normal
Subject: Re: Kernel 2.4.6 and 2.4.7 networking performance: Seeing serious delays
To: ron.flory@adtran.com
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF643DA24A.2BEBB0B0-ON88256AA9.0059AF34@boulder.ibm.com>
From: "Nivedita Singhvi" <nivedita@us.ibm.com>
Date: Wed, 15 Aug 2001 10:30:58 -0700
X-MIMETrack: Serialize by Router on D03NM104/03/M/IBM(Release 5.0.6 |December 14, 2000) at
 08/15/2001 11:31:01 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [1.] One line summary of the problem:
>
>  Depending upon length of TCP socket write requests, I'm seeing
> extremely long TCP delays, limiting throughput to only 25 datagrams
> per second. Data blocks above a 'magic' length have a much higher
> throughput than shorter blocks, which is counter-intuitive.

This is correct (but unfortunate) operation of TCP. Youre just
hitting a well known phenomenon: the worst case interaction of
delayed acks and Nagle at a boundary condition.

Note that in the first case, your  write is 1447 bytes, which is
1 byte less than an MSS, i.e. subject to Nagle if there is an
outstanding packet not acked.

Whats happening, we suspect, is that the ack for the 8 byte request
(Frame 10) is delayed once delayed acks kick in (no longer in quick
ack mode). Delayed ack timeout is 40ms, and youre seeing around 36ms.

Since the other side has bytes outstanding and has to send a small
packet (1447 bytes, 1 less than MSS), it will delay the send (Nagle)
until it gets the ack.

> # Time Src Dst Port Info
>  8 0.000111 .100 .101 41359 > 4180 [PSH, ACK] Seq=4186558043
>       Ack=124141127 Win=5840 Len=8
>  9 0.000062 .101 .100 4180 > 41359 [PSH, ACK] Seq=124141127
>       Ack=4186558051 Win=5792 Len=8
> 10 0.036399 .100 .101 41359 > 4180 [ACK] Seq=4186558051
>       Ack=124141135 Win=5840 Len=0 <- DELAY
> 11 0.000074 .101 .100 4180 > 41359 [PSH, ACK] Seq=124141135
>       Ack=4186558051 Win=5792 Len=1447
> 12 0.000362 .100 .101 41359 > 4180 [ACK] Seq=4186558051
>       Ack=124142582 Win=8682 Len=0
> 13 0.000279 .100 .101 41359 > 4180 [FIN, ACK] Seq=4186558051
>       Ack=124142582 Win=8682 Len=0
> 14 0.000073 .101 .100 4180 > 41359 [FIN, ACK] Seq=124142582
>       Ack=4186558052 Win=5792 Len=0

In the next session, when youre sending the 1448 bytes, (exactly MSS),
the ack is delayed, but the write isnt delayed since we have a big enough
packet to send. The other end sends the ack as soon as it receives the
1447 bytes. (Acks are delayed unless we have more than one MSS
outstanding),
so it doesnt need to wait the full delayed ack timeout.

>  # Time Src Dst Port Info
>  8 0.000122 .100 .101 41363 > 4180 [PSH, ACK] Seq=4268751138
>       Ack=189815010 Win=5840 Len=8
>  9 0.000061 .101 .100 4180 > 41363 [PSH, ACK] Seq=189815010
>       Ack=4268751146 Win=5792 Len=8
> 10 0.000034 .101 .100 4180 > 41363 [ACK] Seq=189815018
>       Ack=4268751146 Win=5792 Len=1448
> 11 0.000351 .100 .101 41363 > 4180 [ACK] Seq=4268751146
>       Ack=189816466 Win=8688 Len=0
> 12 0.000520 .100 .101 41363 > 4180 [FIN, ACK] Seq=4268751146
>       Ack=189816466 Win=8688 Len=0

> Of particular interest is line #10 of each above.
>
> For some reason, in the case of the 'short' packet, the server machine
> waits for a TCP ACK from the client machine (delaying 36 millisec),
> which does not happen if the packet is just 1-byte longer, in which
> case the server immediately follows the 8-byte block with the
> 1448-byte payload.
[ snip ]

Hope that helps. Its a consequence of sending repeated small packets.
You can turn off Nagle (delayed sends) by setting the TCP socket option
TCP_NODELAY, or alter your application sequence of writes, if possible.

I'm still wondering why the next ack isnt delayed as well, though.
I dont believe we should still be in quickack mode, and
so I would have expected subsequent acks (there's just one, the FIN comes
down as a result of the close, which might be a factor, masked by ethereal
somehow) to be delayed as well.

Thanks to Sridhar Samudrala, Dave Stevens, Shirley Ma who got interested
in the question and contributed in shedding light on whats happening..

thanks,
Nivedita
----
Nivedita Singhvi                            (503) 578-4580
Linux Technology Center           nivedita@us.ibm.com
IBM Beaverton, OR                      nivedita@sequent.com

