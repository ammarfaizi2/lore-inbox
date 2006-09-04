Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWIDJJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWIDJJm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 05:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWIDJJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 05:09:42 -0400
Received: from mail.suse.de ([195.135.220.2]:46017 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751211AbWIDJJk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 05:09:40 -0400
Date: Mon, 4 Sep 2006 11:09:39 +0200
From: Olaf Kirch <okir@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NeilBrown <neilb@suse.de>, Andrew Morton <akpm@osdl.org>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 016 of 19] knfsd: match GRANTED_RES replies using	cookies
Message-ID: <20060904090939.GC28400@suse.de>
References: <20060901141639.27206.patches@notabene> <1060901043932.27641@suse.de> <1157126618.5632.52.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157126618.5632.52.camel@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 12:03:38PM -0400, Trond Myklebust wrote:
> Vetoed. The reason why we need the client's IP address as an argument
> for nlmsvc_find_block() is 'cos the cookie value is unique to the
> _client_ only.

In NLM, a cookie can be used to identify the asynchronous reply to the
original request. Previously, there was a hack in the code that
sends GRANT replies to reuse the original cookie from the client's
LOCK request. The protocol spec explicitly says you must not rely
on this behavior; the only reason I added this kludge was that some
HPUX and SunOS versions did just that.

The down side of that kludge is that we are using a client-provided cookie
in one of our calls - which means we keep our fingers crossed it doesn't
collide with the cookie we generate ourselves. And to reduce the risk,
we also check the client IP when searching the nlm_blocked list. But it
is incorrect, and a kludge, and the longer I look at this code the
more I'm amazed it hasn't blown up.

This patch changes the code so that the only cookies we ever use
to look up something are those we generate ourselves, so they
are globally unique. As a consequence, we can stop using the client's
IP when searching the list.

> IOW: when we go searching a global list of blocks for a given cookie
> value that was sent to us by a given client, then we want to know that
> we're only searching through that particular client's blocks.

This is no longer true after applying this change.

> A better way, BTW, would be to get rid of the global list nlm_blocked,
> and just move the list of blocks into a field in the nlm_host for each
> client.

Given an incoming NLM_GRANTED_RES, how can you look up the nlm_host
and the pending NLM_GRANTED_MSG?
The reply may not come from any IP address you know of. The whole
reason for introducing this cookie nonsense in the NLM specification
was that the RPC layer doesn't always give you enough clues to
match a callback to the original message.

So this is really a bugfix which you *do* want to apply.

Olaf
-- 
Olaf Kirch   |  --- o --- Nous sommes du soleil we love when we play
okir@suse.de |    / | \   sol.dhoop.naytheet.ah kin.ir.samse.qurax

-- 
VGER BF report: H 0.149416
