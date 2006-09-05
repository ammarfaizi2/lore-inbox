Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbWIEQM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWIEQM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 12:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbWIEQM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 12:12:56 -0400
Received: from pat.uio.no ([129.240.10.4]:63715 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S965154AbWIEQMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 12:12:54 -0400
Subject: Re: [NFS] [PATCH 016 of 19] knfsd: match GRANTED_RES replies
	using	cookies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Olaf Kirch <okir@suse.de>
Cc: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20060904090939.GC28400@suse.de>
References: <20060901141639.27206.patches@notabene>
	 <1060901043932.27641@suse.de> <1157126618.5632.52.camel@localhost>
	 <20060904090939.GC28400@suse.de>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 12:12:30 -0400
Message-Id: <1157472751.8238.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.2, required 12,
	autolearn=disabled, AWL 1.80, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-04 at 11:09 +0200, Olaf Kirch wrote:
> On Fri, Sep 01, 2006 at 12:03:38PM -0400, Trond Myklebust wrote:
> > Vetoed. The reason why we need the client's IP address as an argument
> > for nlmsvc_find_block() is 'cos the cookie value is unique to the
> > _client_ only.
> 
> In NLM, a cookie can be used to identify the asynchronous reply to the
> original request. Previously, there was a hack in the code that
> sends GRANT replies to reuse the original cookie from the client's
> LOCK request. The protocol spec explicitly says you must not rely
> on this behavior; the only reason I added this kludge was that some
> HPUX and SunOS versions did just that.
> 
> The down side of that kludge is that we are using a client-provided cookie
> in one of our calls - which means we keep our fingers crossed it doesn't
> collide with the cookie we generate ourselves. And to reduce the risk,
> we also check the client IP when searching the nlm_blocked list. But it
> is incorrect, and a kludge, and the longer I look at this code the
> more I'm amazed it hasn't blown up.
> 
> This patch changes the code so that the only cookies we ever use
> to look up something are those we generate ourselves, so they
> are globally unique. As a consequence, we can stop using the client's
> IP when searching the list.
> 
> > IOW: when we go searching a global list of blocks for a given cookie
> > value that was sent to us by a given client, then we want to know that
> > we're only searching through that particular client's blocks.
> 
> This is no longer true after applying this change.

Sorry, I missed that change. I see your point now.

> > A better way, BTW, would be to get rid of the global list nlm_blocked,
> > and just move the list of blocks into a field in the nlm_host for each
> > client.
> 
> Given an incoming NLM_GRANTED_RES, how can you look up the nlm_host
> and the pending NLM_GRANTED_MSG?
> The reply may not come from any IP address you know of. The whole
> reason for introducing this cookie nonsense in the NLM specification
> was that the RPC layer doesn't always give you enough clues to
> match a callback to the original message.

Right. The question is how many clients out there do still rely on the
current behaviour?

Looking at Brent's 'NFS Illustrated', I see that he notes that for
NLM_GRANTED, the cookie is "An opaque value that is normally the same as
the client sent in the LOCK request, though the client cannot depend on
it". Which sounds like weasel words for "some clients still do depend on
it".

Cheers
  Trond

