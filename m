Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275288AbRJNO1C>; Sun, 14 Oct 2001 10:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275289AbRJNO0m>; Sun, 14 Oct 2001 10:26:42 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:10368 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S275288AbRJNO0g>; Sun, 14 Oct 2001 10:26:36 -0400
Message-ID: <3BC9A0AD.598BB4F5@welho.com>
Date: Sun, 14 Oct 2001 17:26:53 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: Re: TCP acking too fast
In-Reply-To: <3BC94F3A.7F842182@welho.com> <20011014.020326.18308527.davem@redhat.com> <k2zo6uiney.fsf@zero.aec.at> <20011014.023948.95894368.davem@redhat.com> <20011014133004.34133@colin.muc.de> <3BC97BC5.9F341ACE@welho.com> <20011014160511.53642@colin.muc.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> It's not guaranteed by any spec; just common behaviour from BSD derived
> stacks. SWS avoidance does not say anything about PSH flags.

True enough. This is a slightly dubious heuristic at best. Besides, if
the sender sets TCP_NODELAY and sends packets that are between
TCP_MIN_MSS and true receive MSS, the estimate is probably totally
hosed.

My solution to this would be to recalculate rcv_mss once per window.
I.e., start new_rcv_mss from 0, keep increasing it for one window width,
and then copy it to rcv_mss. No funny heuristics, and it would adjust to
a shrunken MSS within one transmission window.

> > > On further
> > > look the 2.4 tcp_measure_rcv_mss will never update rcv_mss for packets
> > > which do have PSH set and in this case cause random ack behaviour depending
> > > on the initial rcv_mss guess.
> > > Not very nice; definitely violates the "be conservative what you accept"
> > > rule. I'm not sure how to fix it, adding a fallback to every-two-packet-add
> > > would pollute the fast path a bit.
> >
> > You're right. As far as I can see, it's not necessary to set the
> > TCP_ACK_PUSHED flag at all (except maybe for SYN-ACK). I'm just writing
> > a patch to clean this up.
> 
> Setting it for packets >= rcv_mss looks useful to me to catch mistakes.
> Better too many acks than to few.

Maybe so, but in that case I would only set it for packets > rcv_mss.
Otherwise, my ack-every-segment-with-PSH problem would come back.

Actually, I think it would be better to simply to always ack every other
segment (except in quickack and fast recovery modes) and only use the
receive window estimation for window updates. This would guarantee
self-clocking in all cases.

> -Andi

Regards,

	MikaL
