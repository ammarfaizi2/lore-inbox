Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264256AbUDSPiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 11:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264266AbUDSPiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 11:38:16 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:2434 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264256AbUDSPiJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 11:38:09 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040418232230.GA11064@mail.shareable.org>
References: <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040415185355.1674115b.akpm@osdl.org>
	 <20040416090331.GC22226@mail.shareable.org>
	 <1082130906.2581.10.camel@lade.trondhjem.org>
	 <20040416184821.GA25402@mail.shareable.org>
	 <1082142401.2581.131.camel@lade.trondhjem.org>
	 <20040416193914.GA25792@mail.shareable.org>
	 <1082241169.3930.14.camel@lade.trondhjem.org>
	 <20040418032638.GA1786@mail.shareable.org>
	 <1082271815.3619.104.camel@lade.trondhjem.org>
	 <20040418232230.GA11064@mail.shareable.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082389088.2559.34.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 11:38:08 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-04-18 at 19:22, Jamie Lokier wrote:

> I agree, but would still prefer more consistent behaviour if it is
> easy -- and I explained how to do it, it's an easy algorithm.

The reason I don't like it is that it continues to tie the major timeout
to the resend timeouts. You've convinced me that they should not be the
same thing.

The other reason is that it only improves matters for the first request.
Once we reset the RTO, all those other outstanding requests are anyway
going to see an immediate discontinuity as their basic timeout jumps
from 1ms to 700ms. So why go to all that trouble just for 1 request?

> You don't respond to the other question: the doubling stopping at
> 3.2s.  Is it intended?  It goes againt a basic principle of congestion
> control.

I can put it back in.

It was partly another "consistency" issue that initially worried me,
partly in order to avoid problems with overflow:
If you have more than one outstanding request, then those that get
scheduled after the first major timeout (when we reset the RTO
estimator) will see a "jump". If the "retries" variable is too large,
they will either jump straight over 60 seconds, and thus trigger the cap
or they will end up at zero due to 32-bit overflow.

I agree, though, that this is less of an issue.

Cheers,
  Trond
