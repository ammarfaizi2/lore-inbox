Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275784AbRJNQz5>; Sun, 14 Oct 2001 12:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275778AbRJNQzs>; Sun, 14 Oct 2001 12:55:48 -0400
Received: from cs181088.pp.htv.fi ([213.243.181.88]:18304 "EHLO
	cs181088.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S274991AbRJNQzo>; Sun, 14 Oct 2001 12:55:44 -0400
Message-ID: <3BC9C38F.5CD9C5FD@welho.com>
Date: Sun, 14 Oct 2001 19:55:43 +0300
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: Re: TCP acking too fast
In-Reply-To: <3BC94F3A.7F842182@welho.com> <20011014.020326.18308527.davem@redhat.com> <k2zo6uiney.fsf@zero.aec.at> <20011014.023948.95894368.davem@redhat.com> <20011014133004.34133@colin.muc.de> <3BC97BC5.9F341ACE@welho.com> <20011014160511.53642@colin.muc.de> <3BC9A0AD.598BB4F5@welho.com> <20011014181235.63397@colin.muc.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Sun, Oct 14, 2001 at 04:26:53PM +0200, Mika Liljeberg wrote:
> > My solution to this would be to recalculate rcv_mss once per window.
> > I.e., start new_rcv_mss from 0, keep increasing it for one window width,
> > and then copy it to rcv_mss. No funny heuristics, and it would adjust to
> > a shrunken MSS within one transmission window.
> 
> Sounds complicated. How would you implement it?

Not very hard at all. It could be done easily with a couple of extra
state variables. The following is a rough pseudo code (ignores
initialization of state variables):

if (seg.len > rcv.new_mss)
	rcv.new_mss = seg.len;
if (rcv.nxt >= rcv.mss_seq || rcv.new_mss > rcv.mss) {
	rcv.mss = max(rcv.new_mss, TCP_MIN_MSS);
	rcv.new_mss = 0;
	rcv.mss_seq = rcv.nxt + measurement_window;
}

The basic property is that you can balance the time required to detect a
decreased receive MSS against the reliability of the estimate by tuning
the measurement window. Increased receive MSS would be detected
immediately. Of course, I'm not claiming that there might not be a
better algorithim somewhere that doesn't require the two state
variables.

> > Actually, I think it would be better to simply to always ack every other
> > segment (except in quickack and fast recovery modes) and only use the
> > receive window estimation for window updates. This would guarantee
> > self-clocking in all cases.
> 
> The original "ack after 2*mss" had been carefully tuned to work with well
> slow PPP links in all case; after some bad experiences. It came
> together with the variable length delayed ack.
> 
> The rcv_mss stuff was added later to fix some performance problems
> on very big MTU links like HIPPI (where you have a MSS of 64k, but
> often stacks send smaller packets like 48k; the ack after 2*mss check
> only triggered every third packet, causing bad peroformance)
> 
> Now if nobody used slow PPP links anymore it would be probably ok
> to go back to the simpler "ack every other packet" rule; but I'm afraid
> that's not the case yet.

Why would PPP links perform badly with ack-every-other? That isn't the
case in my experience, at least.

> -Andi

Regards,

	MikaL
