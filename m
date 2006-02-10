Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbWBJXPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbWBJXPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWBJXPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:15:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56021 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750832AbWBJXPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:15:47 -0500
Date: Fri, 10 Feb 2006 15:15:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <1139612574.7877.17.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0602101507530.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com> 
 <20060209094815.75041932.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au> 
 <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au> 
 <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au> 
 <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au> 
 <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au> 
 <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org>  <43ECC13F.5080109@yahoo.com.au>
  <Pine.LNX.4.64.0602100846170.19172@g5.osdl.org>  <43ECCF68.3010605@yahoo.com.au>
  <Pine.LNX.4.64.0602100944280.19172@g5.osdl.org>  <43ECDD9B.7090709@yahoo.com.au>
  <Pine.LNX.4.64.0602101056130.19172@g5.osdl! .org>  <43ECF182.9020505@yahoo.com.au>
  <Pine.LNX.4.64.0602101254081.19172@g5.osdl.org>  <1139608513.7877.9.camel@lade.trondhjem.org>
  <Pine.LNX.4.64.0602101432400.19172@g5.osdl.org> <1139612574.7877.17.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Feb 2006, Trond Myklebust wrote:
> > 
> > Now, in a _coherent_ environment (like Linux) it should probably be a 
> > no-op, since the mapping is always consistent with storage (where 
> > "storage" doesn't actyally mean "disk", but the virtual file underneath 
> > the mapping).
> 
> Hmmm.... When talking about syncing to _permanent_ storage one usually
> is talking about what is actually on the disk.

Ok, in that case Linux has never done what MS_INVALIDATE says, and I doubt 
anybody else has either. It's neither sane nor even really doable (you'd 
have to yank out everybody _elses_ caches too, not just your own).

So I think that within this context, the "permanent storage" really means 
the "file" that is mapped, and doesn't care about whether it has actually 
hit the disk yet.

> In any case, we do have non-coherent mmapped environments in Linux (need 
> I mention NFS, CIFS, ... ;-)?).

Good point. That's an argument for actually dropping the local page cache 
entirely on such a filesystem, since such a filesystem really isn't 
fundamentally coherent.

However, that would be some really _nasty_ semantics, because it would 
mean that something like NFS would behave very fundamentally differently 
than a local filesystem, even if the user only actually uses it on the 
local machine and there are no other writers ("..but there _could_ be 
other writers that we don't know about").

So I'd have to veto that just on the grounds of trying to keep users sane.

> IIRC msync(MS_INVALIDATE) on Solaris was actually often used by some
> applications to resync the client page cache to the server when using
> odd locking schemes, so I believe this interpretation is a valid one.

I think you're right. Although I would also guess that 99% of the time, 
you'd only do that for read-only mappings. Doing the same in the presense 
of also doing writes is just asking for getting shot.

Even for read-only mappings, it's actually quite hard to globally flush a 
page cache page if somebody else happens to be using it for a read() or 
something at exactly the same time.

		Linus
