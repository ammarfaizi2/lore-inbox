Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275719AbRJNQOf>; Sun, 14 Oct 2001 12:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275716AbRJNQOZ>; Sun, 14 Oct 2001 12:14:25 -0400
Received: from colin.muc.de ([193.149.48.1]:52749 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S275709AbRJNQLm>;
	Sun, 14 Oct 2001 12:11:42 -0400
Message-ID: <20011014181235.63397@colin.muc.de>
Date: Sun, 14 Oct 2001 18:12:35 +0200
From: Andi Kleen <ak@muc.de>
To: Mika Liljeberg <Mika.Liljeberg@welho.com>
Cc: Andi Kleen <ak@muc.de>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: TCP acking too fast
In-Reply-To: <3BC94F3A.7F842182@welho.com> <20011014.020326.18308527.davem@redhat.com> <k2zo6uiney.fsf@zero.aec.at> <20011014.023948.95894368.davem@redhat.com> <20011014133004.34133@colin.muc.de> <3BC97BC5.9F341ACE@welho.com> <20011014160511.53642@colin.muc.de> <3BC9A0AD.598BB4F5@welho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <3BC9A0AD.598BB4F5@welho.com>; from Mika Liljeberg on Sun, Oct 14, 2001 at 04:26:53PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 14, 2001 at 04:26:53PM +0200, Mika Liljeberg wrote:
> My solution to this would be to recalculate rcv_mss once per window.
> I.e., start new_rcv_mss from 0, keep increasing it for one window width,
> and then copy it to rcv_mss. No funny heuristics, and it would adjust to
> a shrunken MSS within one transmission window.

Sounds complicated. How would you implement it?

> 
> > > > On further
> > > > look the 2.4 tcp_measure_rcv_mss will never update rcv_mss for packets
> > > > which do have PSH set and in this case cause random ack behaviour depending
> > > > on the initial rcv_mss guess.
> > > > Not very nice; definitely violates the "be conservative what you accept"
> > > > rule. I'm not sure how to fix it, adding a fallback to every-two-packet-add
> > > > would pollute the fast path a bit.
> > >
> > > You're right. As far as I can see, it's not necessary to set the
> > > TCP_ACK_PUSHED flag at all (except maybe for SYN-ACK). I'm just writing
> > > a patch to clean this up.
> > 
> > Setting it for packets >= rcv_mss looks useful to me to catch mistakes.
> > Better too many acks than to few.
> 
> Maybe so, but in that case I would only set it for packets > rcv_mss.
> Otherwise, my ack-every-segment-with-PSH problem would come back.

Yes > rcv_mss. Sorry for the typo.
> 
> Actually, I think it would be better to simply to always ack every other
> segment (except in quickack and fast recovery modes) and only use the
> receive window estimation for window updates. This would guarantee
> self-clocking in all cases.

The original "ack after 2*mss" had been carefully tuned to work with well 
slow PPP links in all case; after some bad experiences. It came 
together with the variable length delayed ack.

The rcv_mss stuff was added later to fix some performance problems
on very big MTU links like HIPPI (where you have a MSS of 64k, but 
often stacks send smaller packets like 48k; the ack after 2*mss check
only triggered every third packet, causing bad peroformance) 

Now if nobody used slow PPP links anymore it would be probably ok
to go back to the simpler "ack every other packet" rule; but I'm afraid
that's not the case yet.

-Andi
