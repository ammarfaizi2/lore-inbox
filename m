Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268295AbUJSB00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268295AbUJSB00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 21:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268293AbUJSB0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 21:26:25 -0400
Received: from eth2613.sa.adsl.internode.on.net ([150.101.239.52]:41934 "EHLO
	foghorn2.internal") by vger.kernel.org with ESMTP id S268228AbUJSBVM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 21:21:12 -0400
Date: Tue, 19 Oct 2004 10:51:03 +0930
From: John Pearson <jpearson@sa.pracom.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Message-ID: <20041019012103.GA1990@sa.pracom.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5.8
X-Spam-Report: Spam detection software, running on the system "foghorn2.internal", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  This has probably been said before, but just in case I
	missed it; there are many viewpoints in this thread, but the two main
	camps appear to be arguing at cross-purposes. As far as I can see: -
	YES, Linux select 'lies' and violates POSIX wrt checksums: a call to
	recvmsg() might well have blocked when select() said data was ready, as
	a result of a currupt UDP packet; [...] 
	Content analysis details:   (-5.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.1 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This has probably been said before, but just in case I missed
it; there are many viewpoints in this thread, but the two main camps
appear to be arguing at cross-purposes.

As far as I can see:

  - YES, Linux select 'lies' and violates POSIX wrt checksums:
    a call to recvmsg() might well have blocked when select()
    said data was ready, as a result of a currupt UDP packet;

  - NO, 'fixing' select() won't guarantee that recvmsg()
    will not block/return EAGAIN, because select() only
    guarantees that a call to recvmsg() would not have blocked
    at that time - as others have observed, it cannot guarantee
    that 'valid' data won't subsequently be discarded; any
    subsequent call to recvmsg() is only 'immediate' in a fuzzy,
    imprecise and inadequate sense.

Can we get back to arguing about something less repetitive
(or at least, make the circle larger and more scenic)?



John.


On Sun, Oct 17, 2004 at 07:22:44PM +0200, Lars Marowsky-Bree wrote
> On 2004-10-17T16:17:06, Buddy Lucas <buddy.lucas@gmail.com> wrote:
> 
> > > The SuV spec is actually quite detailed about the options here:
> > > 
> > >         A descriptor shall be considered ready for reading when a call
> > >         to an input function with O_NONBLOCK clear would not block,
> > >         whether or not the function would transfer data successfully.
> > >         (The function might return data, an end-of-file indication, or
> > >         an error other than one indicating that it is blocked, and in
> > >         each of these cases the descriptor shall be considered ready for
> > >         reading.)
> > But it says nowhere that the select()/recvmsg() operation is atomic, right?
> 
> See, Buddy, the point here is that Linux _does_ violate the
> specification. You can try weaseling out of it, but it's not going to
> work.
> 
> This isn't per se the same as saying that it's not a sensible violation,
> but very clearly the specs disagree with the current Linux behaviour.
> 
> It's impossible to claim that you are allowed by the spec to block on a
> recvmsg directly following a successful select. You are not. You could
> claim that, but you'd be wrong.
> 
> If the packet has been dropped in between, which _could_ have happened
> because UDP is allowed to be dropped basically anywhere, EIO may be
> returned. But blocking or returning EAGAIN/EWOULDBLOCK is verboten. The
> spec is very clearly on that.
> 
> (Now I'd claim that returning EIO after a succesful select is also
> slightly suboptimal - the performance optimizations should be turned off
> for blocking sockets, IMHO, and the data which caused the select() to
> return should be considered comitted - but it would be allowed.)
> 
> I'm not so sure what's so hard to accept about that. It may be well that
> Linux is following the de-facto industry standard (or even setting it)
> here, and I'd agree that if you don't want blocking use O_NONBLOCK, but
> in no way can Linux claim POSIX/SuV spec compliance for this behaviour.
> 
> I'm not getting why people argue so much to try and weasel the words so
> that it comes out as compliant. It's not. It may make sense due to
> practical reasons, but it's not compliant.
> 
> 
> Sincerely,
>     Lars Marowsky-Brée <lmb@suse.de>
> 
> -- 
> High Availability & Clustering
> SUSE Labs, Research and Development
> SUSE LINUX AG - A Novell company
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> --__--__--

-- 
Voice: +61 8 8202 9040
Email: jpearson@sa.pracom.com.au

Pracom Ltd
288 Glen Osmond Road
Fullarton, South Australia 5063

Ph: + 61 8 82029000
Fax: +61 8 82029001

CAUTION: This email and any attachments may contain information that is
confidential and subject to copyright. If you are not the
intended recipient, you must not read, use, disseminate, distribute or
copy this email or any attachments. If you have received this
email in error, please notify the sender immediately by reply email and
erase this email and any attachments.

DISCLAIMER: Pracom uses virus-scanning technology but accepts no
responsibility for loss or damage arising from the use of the
information transmitted by this email including damage from virus.

