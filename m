Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271547AbRHUEjd>; Tue, 21 Aug 2001 00:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271545AbRHUEjY>; Tue, 21 Aug 2001 00:39:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:37795 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S271541AbRHUEjR>; Tue, 21 Aug 2001 00:39:17 -0400
Importance: Normal
Subject: Re: Kernel 2.4.6 and 2.4.7 networking performance: Seeing serious delays
To: "kuznet" <kuznet%ms2.inr..ac.rus@boulder.ibm.com>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF6AC1553A.5DC17765-ON88256AAF.00123D09@boulder.ibm.com>
From: "Nivedita Singhvi" <nivedita@us.ibm.com>
Date: Mon, 20 Aug 2001 21:00:19 -0700
X-MIMETrack: Serialize by Router on D03NM104/03/M/IBM(Release 5.0.8 |June 18, 2001) at
 08/20/2001 10:39:31 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alexey,

Thanks for the clarification on the pingpong behaviour!
Some more questions..

>> I'm still wondering why the next ack isnt delayed as well, though.
>
>Because out tcp is enough clever to understand that it made
>a shit delaying ACK for previous packet. But not enough psychic
>to foresee future and to avoid delay. :-)


>.100 experiences delack timeout, which is considered as an error.
>It is really error. So, tcp clears pingpong and returns to quickack.

So I understand that we're allowing pingpong to retain state of whether
it makes sense to delay right now or not, based on whats been happening,
and trying to avoid a delayed ack timer expiry..

But...

>This loop would repeat infinitely, if connection were not closed.
>Kernel sees that user replies fastly, switches to canonical BSD mode
>to allow ack piggibacking and tries to delay ack, but silly user does
>not want to reply more. So, we have reduced amount of timeouts twice,
>but this is not a big win in this case.
>
>I am writing this mostly because it is the best demonstration
>why TCP_QUICKACK:=0 is invalidated. :-)

Then whats the point of TCP_QUICKACK socket option at all? If its only
a user hint that gets erased on the first go through, that is one full system call just
 to avoid a delay on one packet. The user isnt going to write an application full of
setsockopt() calls based on his data sends, right?


>What's about advice to use TCP_NODELAY in this case, it is _absolutely_
>wrong and in fact presents violation of protocol, this app sends silly
>spagetti of pakets which must be coalesced. It is exactly the situation
>when TCP_NODELAY is straight bug. This app should use TCP_CORK or,
>even better from the viewpoint of performance, to coalesce writes at user
>user  level not abusing tcp.

True, this is an abuse of TCP :). But we should have the freedom to do so, right? :)
i.e. User may need to send small amounts of data at a time.  The user might even
want to have that data sent out immediately, and not want  the kernel to delay the send.
After all, if the application is sending down large full frames, the kernel is by default
not going to be halted by Nagle. Its really  only when you are sending small packets
at a time that youre affected by Nagle and might want to set NODELAY, especially
if that application is highly interactive?.

thanks,
Nivedita

