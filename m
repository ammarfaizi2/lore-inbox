Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271692AbRHQQwc>; Fri, 17 Aug 2001 12:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271693AbRHQQwV>; Fri, 17 Aug 2001 12:52:21 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:36358 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S271692AbRHQQwP>;
	Fri, 17 Aug 2001 12:52:15 -0400
Message-Id: <200108162306.DAA00420@mops.inr.ac.ru>
Subject: Re: Kernel 2.4.6 and 2.4.7 networking performance: Seeing serious delays
To: nivedita@us.ibm.COM (Nivedita Singhvi)
Date: Fri, 17 Aug 2001 03:06:14 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OF643DA24A.2BEBB0B0-ON88256AA9.0059AF34@boulder.ibm.com> from "Nivedita Singhvi" at Aug 15, 1 09:45:14 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I'm still wondering why the next ack isnt delayed as well, though.

Because out tcp is enough clever to understand that it made
a shit delaying ACK for previous packet. But not enough psychic
to foresee future and to avoid delay. :-)


> I dont believe we should still be in quickack mode, 

However, we are there. :-)


 4 0.000061 .100 .101 41359 > 4180 [PSH, ACK] Seq=4186558035 Ack=124141119 Win=5
840 Len=8
 5 0.000061 .101 .100 4180 > 41359 [ACK] Seq=124141119 Ack=4186558043 Win=5792 L
en=0

.101 quickacks

 6 0.002295 .101 .100 4180 > 41359 [PSH, ACK] Seq=124141119 Ack=4186558043 Win=5
792 Len=8

.101 leaves quickacks setting pingpong


 7 0.000098 .100 .101 41359 > 4180 [ACK] Seq=4186558043 Ack=124141127 Win=5840 L
en=0

.100 quickacks

 8 0.000111 .100 .101 41359 > 4180 [PSH, ACK] Seq=4186558043 Ack=124141127 Win=5
840 Len=8

.100 leaves quickacks setting pingpong


 9 0.000062 .101 .100 4180 > 41359 [PSH, ACK] Seq=124141127 Ack=4186558051 Win=5
792 Len=8
10 0.036399 .100 .101 41359 > 4180 [ACK] Seq=4186558051 Ack=124141135 Win=5840 L
en=0  <- DELAY

.100 experiences delack timeout, which is considered as an error.
It is really error. So, tcp clears pingpong and returns to quickack.

11 0.000074 .101 .100 4180 > 41359 [PSH, ACK] Seq=124141135 Ack=4186558051 Win=5
792 Len=1447
12 0.000362 .100 .101 41359 > 4180 [ACK] Seq=4186558051 Ack=124142582 Win=8682 L
en=0  

.100 quickacks

This loop would repeat infinitely, if connection were not closed.
Kernel sees that user replies fastly, switches to canonical BSD mode
to allow ack piggibacking and tries to delay ack, but silly user does
not want to reply more. So, we have reduced amount of timeouts twice,
but this is not a big win in this case.

I am writing this mostly because it is the best demonstration
why TCP_QUICKACK:=0 is invalidated. :-)


What's about advice to use TCP_NODELAY in this case, it is _absolutely_
wrong and in fact presents violation of protocol, this app sends silly
spagetti of pakets which must be coalesced. It is exactly the situation
when TCP_NODELAY is straight bug. This app should use TCP_CORK or,
even better from the viewpoint of performance, to coalesce writes at user user
level not abusing tcp.

Alexey
