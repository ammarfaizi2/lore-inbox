Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWJCCNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWJCCNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 22:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030248AbWJCCNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 22:13:10 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43407 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1030247AbWJCCNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 22:13:08 -0400
Date: Mon, 2 Oct 2006 22:13:04 -0400
To: Neil Brown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Banks <gnb@melbourne.sgi.com>
Subject: Re: [NFS] [PATCH 008 of 11] knfsd: Prepare knfsd for support of	rsize/wsize of up to 1MB, over TCP.
Message-ID: <20061003021304.GB12867@fieldses.org>
References: <20060824162917.3600.patches@notabene> <1060824063711.5008@suse.de> <20060925154316.GA17465@fieldses.org> <17697.48800.933642.581926@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17697.48800.933642.581926@cse.unsw.edu.au>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 11:36:32AM +1000, Neil Brown wrote:
> The only real problem is that NFSv4 can have arbitrarily large
> non-payload data, and arbitrarily many payloads.  But I guess any
> client that trying to send two full-sized payloads in the one request
> is asking for trouble (I don't suppose the RPC spells this out at
> all?).

The RFC?  Well, it does have a "RESOURCE" error that the server can
return for overly complicated compounds.  It doesn't give much guidance
on when exactly that could happen, but if there's ever a clear case for
returning NFS4ERR_RESOURCE, I think it must be the case of a client
trying to circumvent the maximum read/write size by using multiple read
or write operations in a single compound.

(We have some other odd restrictions on the sorts of compounds we can
accept, which I'd like to relax.  But that's a problem for another day.)

> And the fact that the code change to effect this is so tiny seems to
> imply that most of the code was already assuming that sv_bufsz was
> really the payload size rather than the packet size.

There's also the check at the end of svc_tcp_recvfrom():

	if (svsk->sk_reclen > serv->sv_bufsz) {
		printk(KERN_NOTICE "RPC: bad TCP reclen 0x%08lx (large)\n",
		       (unsigned long) svsk->sk_reclen);
		goto err_delete;
	}

--b.
