Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262561AbTCRTYF>; Tue, 18 Mar 2003 14:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262560AbTCRTYF>; Tue, 18 Mar 2003 14:24:05 -0500
Received: from mail-7.tiscali.it ([195.130.225.153]:45116 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S262561AbTCRTYC>;
	Tue, 18 Mar 2003 14:24:02 -0500
Date: Tue, 18 Mar 2003 20:34:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, ak@suse.de
Subject: Re: 2.4 delayed acks don't work, fixed
Message-ID: <20030318193458.GY30541@dualathlon.random>
References: <20030317082553.GA1324@dualathlon.random> <200303181834.VAA04953@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303181834.VAA04953@sex.inr.ac.ru>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 09:34:50PM +0300, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > Apparently linux only waits 0.2 at max,
> 
> This is not true, the maximum is 0.5 in your case.

what is the point of this:

#define TCP_DELACK_MAX	((unsigned)(HZ/5))	/* maximal time to delay before sending an ACK */

if the above means the maximal time to delay before sending an ack in
0.5 and not 0.2?

> > 1) the delayed ack timer destroy the ato value resetting it to the min
> >    value (40msec) and the quickack mode is activated (pingpong = 0)
> 
> This is not true, delack timer inflates ato. pingpong=0 is not quickack
> mode, it means that the session is unidirectional stream, which
> is correct in your case.

pingpong is set to 0 only by "tcp_enter_quickack_mode" and later by:

			/* RFC2581. 4.2. SHOULD send immediate ACK, when
					 ^^^^^^^^^^^^^^^^^^^^^^^^^^
			 * gap in queue is filled.
			 */
			if (skb_queue_len(&tp->out_of_order_queue) == 0)
				tp->ack.pingpong = 0;

and finally by the delack timer (if it was set to 1):

	if (tcp_ack_scheduled(tp)) {
		if (!tp->ack.pingpong) {
			/* Delayed ACK missed: inflate ATO. */
			tp->ack.ato = min(tp->ack.ato << 1, tp->rto);
		} else {
			/* Delayed ACK missed: leave pingpong mode and
			 * deflate ATO.
			 */
			tp->ack.pingpong = 0;
			^^^^^^^^^^^^^^^^^^^^
			tp->ack.ato = TCP_ATO_MIN;
		}

tcp_enter_quickack_mode is called every time we have to disable delayed
acks like when we send duplicate acks or when there's packet reordering
or whatever similar error.

how can 'pingpong' relate to the direction of the stream? I see no
relation at all. That means quickack mode according to the code.
'pingpong' has no clue of what I'm sending, it only knows if I'm
receiving fine and in turn if I can delay the ack.

since it's never re-activated, the tcp stack assumes I'm not receiving
fine, right after the first error, and forever until I close the socket.

> > 2) the pingpong is never re-activated,
> 
> It MUST NOT. It is activated on transactional sessions only.

And according to tcp_in_quickack_mode this means you'll have a chance to
send a delayed ack only after "tp->ack.quick" have been sent out, after
an error of some sort (because whatever error triggers a
tcp_incr_quickack, tcp_enter_quickack_mode calls tcp_incr_quickack
infact).

> > 3) the ato averaging logic during the packet reception will not inflate
> >    the ato if "m > ato" which is obviously the case after a delack timer
> >    triggered and in turn after the ato is been deflated to its min value
> 
> When m > ato, the sample is invalid, apparently it is triggered by
> a random delay at sender. When real ato increases, increase
> is made in delack timer, not through estimator.

this is only true if pingpong was just 0. but if pingpong is 0 it won't
send delayed acks in the first place because quick will very rarely get
down to 0. The streamer delays the next packet of something longer than
ato once in a while, but for all other packets delayed acks could work
perfectly. Only once in a while the delack timer will trigger.

> > 4) the logic that bounds the delayed ack to the srtt >> 3 looks also
> >    risky, using the rto looks much safer to me there, to be sure
> >    those delacks aren't going to trigger too early
> 
> It is necessary to provide more or less sane behaviour on interactive
> session when ato > 100msec. Clamping by rto just does not make any sense.

ok.

> > 5) I suspect the current delack algorithm can wait more than 2 packets,
> 
> Yes, when window is not opening, it is not required. Delack is send
> when window is advanced.

The RFC 1122 says:


	    [..] in a stream of full-sized
            segments there SHOULD be an ACK for at least every second
            segment.

unless you can point me to a more recent RFC where the above text is
been obsoleted, you're wrong. After the second packet the delack must be
sent _always_ according to rfc 1122 (at least if they're full-sized like
in my workload). No matter if this generated a window advance or not.
2.2 did it right. Maybe I'm reading obsolete specifications? Could you
point me to the RFC that speaks about the pingpong directional stream as
well?

I also wonder if this is correct:

			if (eaten) {
				if (tcp_in_quickack_mode(tp)) {
					tcp_send_ack(sk);
				} else {
					tcp_send_delayed_ack(sk);
				}

it's not checking if more than one segment arrived.

> Shortly, I still do not understand what kind of pathalogy happens in your
> case (particularly, difference in adevrtised window before and after
> applying your patch is confusing _a_ _lot_, I really would like

ok, the window updates doesn't matter much, they're a separate issue and
what I did of delaying the window update if a delack is probably not RFC
compliant either even if I liked it, I should have sent two separate
patches for clarity.

> to look at larger tcpdump, covering beggining of the sssion),
> but all the 5 items are surely wrong.

ok, I need to recompile the kernel and reboot my desktop for generating
it, I will try to send a full trace shortly, but it will be exactly like
the one that I posted but replicated forever. the start of the trace
will be different, and in the start of the trace the delayed acks will
work correctly, after they get disabled (or as you say the stream gets
detected as ""unidirectional"" [i.e. quickack forever IMHO]) the delayed
acks stops working completely forever and my machine sends the double
number of packets than it was really necessary if delacks would work as
I expect by reading the RFC like in the start of the trace.

I'm not aware if there's a more uptodate draft defining new behaviour of
delayed acks different from rfc 1122, let me know if that's the case of
course.

> Unnumbered 6th one may be right, the heuristic with expansion twice
> have no explanation, I think it can be relaxed even more.

Ok fine. I guess it matters more in my case because the window was
small, so when changing from 1460 to 2920 was just triggering a windows
update for just 1 packet read in userspace, while excluding the == case,
the window update is sent only when at least two packets are read in
userspace that better fits the delayed ack behavior and removes lots of
spurious window updates.

Andrea
