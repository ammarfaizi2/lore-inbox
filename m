Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262515AbTCRUCx>; Tue, 18 Mar 2003 15:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262536AbTCRUCx>; Tue, 18 Mar 2003 15:02:53 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:58845 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262515AbTCRUCw>;
	Tue, 18 Mar 2003 15:02:52 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200303182013.XAA05239@sex.inr.ac.ru>
Subject: Re: 2.4 delayed acks don't work, fixed
To: andrea@suse.de (Andrea Arcangeli)
Date: Tue, 18 Mar 2003 23:13:42 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, ak@suse.de
In-Reply-To: <20030318193458.GY30541@dualathlon.random> from "Andrea Arcangeli" at Mar 18, 3 08:34:58 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> what is the point of this:
> 
> #define TCP_DELACK_MAX	((unsigned)(HZ/5))	/* maximal time to delay before sending an ACK */

It is maximal delack for generic (transactional) traffic. It is not used
in stream mode. Big clamp of 500msec is hardwired to tcp_send_delayed_ack,
I simply was not able to invent name for it.

> and finally by the delack timer (if it was set to 1):

It is the place. Session stops to be tranasaction, when we
experience the first delack timeout.


> tcp_enter_quickack_mode is called every time we have to disable delayed
> acks like when we send duplicate acks or when there's packet reordering
> or whatever similar error.

Also correct. Delacks are disabled while recovery periods.

> how can 'pingpong' relate to the direction of the stream? I see no
> relation at all.

It is set, when we see traffic in both directions. It is cleared
when we see the first delack timeout. Logically, it should be cleared
when we do not see data flowing in opposite direction for some time,
but as soon as we do not see delack timeouts, it does not matter.


> since it's never re-activated,

If you do not see any delack timeouts, clearing pingpong does not make
difference.


> this is only true if pingpong was just 0. but if pingpong is 0 it won't
> send delayed acks in the first place because quick will very rarely get
> down to 0.

Stop here. quick quickly must become zero. In your case, when window
is one packet, it happens exactly after the first packet.

I am confused. Please, check.


>             segments there SHOULD be an ACK for at least every second
>             segment.

SHOULD, not MUST. :-)

Jokes apart, it is simply wrong statement. Right one reads: "when right
egde of window advanced by at least two segments". It is supposed to provide
ACK clock, but when window stalled, such acks are pure abuse, they are simply
ignored by clocking mechanism.


> 			if (eaten) {
> 				if (tcp_in_quickack_mode(tp)) {
> 					tcp_send_ack(sk);
> 				} else {
> 					tcp_send_delayed_ack(sk);
> 				}
> 
> it's not checking if more than one segment arrived.

"eaten" is special path, it happens when this function is subroutine
of tcp_recvmsg(), where the same code is executed upon return
from the function.

Alexey
