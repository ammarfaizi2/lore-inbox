Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132867AbRASVRF>; Fri, 19 Jan 2001 16:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136275AbRASVQz>; Fri, 19 Jan 2001 16:16:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15200 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132867AbRASVQt>; Fri, 19 Jan 2001 16:16:49 -0500
Date: Fri, 19 Jan 2001 22:13:27 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: mingo@elte.hu, torvalds@transmeta.com, raj@cup.hp.com,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010119221327.C8717@athlon.random>
In-Reply-To: <20010119162552.D3447@athlon.random> <200101191818.VAA24360@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200101191818.VAA24360@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Fri, Jan 19, 2001 at 09:18:04PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2001 at 09:18:04PM +0300, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > The "uncork" won't push the last skb on the wire if there is not acknowledged
> > data in the write_queue and the payload of the last skb in the write_queue
> > isn't large MSS. This because the `uncork' will only re-evaluate the
> > write_queue in function of the _nagle_ algorithm, quite correctly because the
> > "uncork" will move frok "cork" to "nagle" (not from "cork" to "nodelay").
> 
> At least for your own implementation of SIOCPUSH has "1" among
> arguments of push_pending_frames, so that this does not happen. 8)8)

I wasn't talking about SIOCPUSH but only about uncorking, I carefully made sure
that SIOCPUSH was interpreting the write_queue from a "nodelay" point of view
(but I didn't noticed the uncorking wasn't doing that ;).

> The second thing, which makes argument above wrong is that
> both classic Nagle and linux-2.4 Nagle (extended by Minshall),
> do not have this problem. Your argument applies to buggy flavor
> of nagling specific to 2.2.

My argument applies to 2.4. The uncork _won't_ push on the wire the last
not mss-sized fragment until it's the last one in the write queue even once
cwnd and receiver window allows that. I think if there would be no problem you
wouldn't be setting nonalge unconditionally to 1 in
2.4/include/net/tcp.h.__tcp_push_pending_frames:

		if (!tcp_skb_is_last(sk, skb))
			nonagle = 1;
		if (!tcp_snd_test(tp, skb, cur_mss, nonagle) ||
		    tcp_write_xmit(sk))
			tcp_check_probe_timer(sk, tp);

> However, SIOCPUSH really affects latency badly in some curcumstances.

Not using SIOCPUSH can only increase latency, and using it can only decrease
latency. Obviously because it allows the last little fragment to be sent before
waiting it to be the last one in the write queue so reducing the time the last
fragment is received from the other end and so in turn reducing the latency of
the reply from the other end. There are no other differences in the behaviour.

It tells to the stack one information that the stack can't know otherwise and
that only the programmer writing the application knows. Knowing that
information can only allow the stack to do a _better_ choice.

What my SIOCPUSH implementation was missing is to keep considering the
write_queue in tp->nonagle=1 mode until somebody writes to the socket (so that
as soon as one acknowledgemnt for the previous data increases the reciver
window and our send window increases as well we can send the last fragment
immediatly without waiting it to be the last one). The first write to the
socket will clear tp->push.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
