Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbTJWROo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 13:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTJWROo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 13:14:44 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:24793 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S263640AbTJWROl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 13:14:41 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] ide write barrier support
Date: Thu, 23 Oct 2003 19:20:39 +0200
User-Agent: KMail/1.5.3
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031013140858.GU1107@suse.de> <200310231822.36023.phillips@arcor.de> <20031023162310.GQ6461@suse.de>
In-Reply-To: <20031023162310.GQ6461@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310231920.39888.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 October 2003 18:23, Jens Axboe wrote:
> On Thu, Oct 23 2003, Daniel Phillips wrote:
> > I'm specifically interested in working out the issues related to stacked
> > virtual devices, and there are many.  Let me start with an easy one.
> >
> > Consider a multipath virtual device that is doing load balancing and
> > wants to handle write barriers efficiently, not just allow the
> > downstream queues to drain before allowing new writes.  This device
> > wants to send a write barrier to each of the downstream devices,
> > however, we have only one write request to carry the barrier bit.  How
> > do you recommend handling this situation?
>
> That needs something to hold the state in, and a bio per device. As
> they complete, mark them as such. When they all have completed, barrier
> is done.
>
> That's just an idea, I'm sure there are other ways. Depending on how
> complex it gets, it might not be a bad idea to just let the queues drain
> though. I think I'd prefer that approach.

These are essentially the same, they both rely on draining the downstream 
queues.  But if we could keep the downstream queues full, bus transfers for 
post-barrier writes will overlap the media transfers for pre-barrier writes, 
which would seem to be worth some extra effort.

To keep the downstream queues full, we must submit write barriers to all the 
downstream devices and not wait for completion.  That is, as soon as a 
barrier is issued to a given downstream device we can start passing through 
post-barrier writes to it.

Assuming this is worth doing, how do we issue N barriers to the downstream 
devices when we have only one incoming barrier write?

Regards,

Daniel

