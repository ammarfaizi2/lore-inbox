Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262606AbTCRWIU>; Tue, 18 Mar 2003 17:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262607AbTCRWIU>; Tue, 18 Mar 2003 17:08:20 -0500
Received: from mail-2.tiscali.it ([195.130.225.148]:63906 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id <S262606AbTCRWIQ>;
	Tue, 18 Mar 2003 17:08:16 -0500
Date: Tue, 18 Mar 2003 23:19:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: linux-kernel@vger.kernel.org, davem@redhat.com, ak@suse.de
Subject: Re: 2.4 delayed acks don't work, fixed
Message-ID: <20030318221906.GA30541@dualathlon.random>
References: <20030318193458.GY30541@dualathlon.random> <200303182013.XAA05239@sex.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303182013.XAA05239@sex.inr.ac.ru>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2003 at 11:13:42PM +0300, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > what is the point of this:
> > 
> > #define TCP_DELACK_MAX	((unsigned)(HZ/5))	/* maximal time to delay before sending an ACK */
> 
> It is maximal delack for generic (transactional) traffic. It is not used
> in stream mode. Big clamp of 500msec is hardwired to tcp_send_delayed_ack,
> I simply was not able to invent name for it.
> 
> > and finally by the delack timer (if it was set to 1):
> 
> It is the place. Session stops to be tranasaction, when we
> experience the first delack timeout.

In a normal internet connection you will always get packet loss or
timeouts in the middle of any big transfer.

however as far as the delacks can be reactivated w/o waiting dozen of
packets it's ok.

> > tcp_enter_quickack_mode is called every time we have to disable delayed
> > acks like when we send duplicate acks or when there's packet reordering
> > or whatever similar error.
> 
> Also correct. Delacks are disabled while recovery periods.

sure, delacks must be disabled until the ofo queue is empty again.

> > how can 'pingpong' relate to the direction of the stream? I see no
> > relation at all.
> 
> It is set, when we see traffic in both directions. It is cleared
> when we see the first delack timeout. Logically, it should be cleared
> when we do not see data flowing in opposite direction for some time,
> but as soon as we do not see delack timeouts, it does not matter.
> 
> 
> > since it's never re-activated,
> 
> If you do not see any delack timeouts, clearing pingpong does not make
> difference.

I see seldom delack timeouts during streming because the streamer simply
waits, the bandwidth of the link is higher than the streamer one

> > this is only true if pingpong was just 0. but if pingpong is 0 it won't
> > send delayed acks in the first place because quick will very rarely get
> > down to 0.
> 
> Stop here. quick quickly must become zero. In your case, when window
> is one packet, it happens exactly after the first packet.

there must be something that forbids it because I get immediate acks
instead.

> 
> I am confused. Please, check.
> 
> 
> >             segments there SHOULD be an ACK for at least every second
> >             segment.
> 
> SHOULD, not MUST. :-)
> 
> Jokes apart, it is simply wrong statement. Right one reads: "when right
> egde of window advanced by at least two segments". It is supposed to provide
> ACK clock, but when window stalled, such acks are pure abuse, they are simply
> ignored by clocking mechanism.
> 
> 
> > 			if (eaten) {
> > 				if (tcp_in_quickack_mode(tp)) {
> > 					tcp_send_ack(sk);
> > 				} else {
> > 					tcp_send_delayed_ack(sk);
> > 				}
> > 
> > it's not checking if more than one segment arrived.
> 
> "eaten" is special path, it happens when this function is subroutine
> of tcp_recvmsg(), where the same code is executed upon return
> from the function.

so is the ack sent elsewhere if this was the third packet and there's a
window advance?

Andrea
