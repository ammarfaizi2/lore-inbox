Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262489AbVCaCUG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbVCaCUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 21:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVCaCUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 21:20:06 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:6300 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262484AbVCaCT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 21:19:56 -0500
Subject: Re: [NFS] [PATCH] SGI 926917: make knfsd interact cleanly with HSMs
From: Greg Banks <gnb@melbourne.sgi.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Linux NFS Mailing List <nfs@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Filesystem Development List 
	<linux-fsdevel@vger.kernel.org>
In-Reply-To: <16971.22880.262928.543410@cse.unsw.edu.au>
References: <20050315074949.GA4541@sgi.com>
	 <1112233192.1991.1031.camel@hole.melbourne.sgi.com>
	 <16971.22880.262928.543410@cse.unsw.edu.au>
Content-Type: text/plain
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1112235521.1991.1082.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 31 Mar 2005 12:18:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-31 at 11:58, Neil Brown wrote:
> On Thursday March 31, gnb@melbourne.sgi.com wrote:
> > On Tue, 2005-03-15 at 18:49, Greg Banks wrote:
> > > This patch seeks to remedy the interaction between knfsd and HSMs by
> > > providing mechanisms to allow knfsd to tell an underlying filesystem
> > > (which supports HSMs) not to block for reads, writes and truncates
> > > of offline files.  It's a port of a Linux 2.4 patch used in SGI's
> > > ProPack distro for the last 12 months.  The patch:
> > 
> > Any news on this patch?  Is it good, bad, ugly, or what?
> [...]
> Yes, it looks reasonably sane.
> 
> I'm not very comfortable about the
> 
> +		if (rqstp->rq_vers == 3)
> 
> usage.  Shouldn't it be 
> +		if (rqstp->rq_vers >= 3)
> as presumably NFSv4 would like NFSERR_JUKEBOX returns too.

I guess so, but I haven't tested it with v4.  I'll update the patch.

> Also, it assumes an extension to the semantics of IFREG files such
> that O_NONBLOCK has a meaning... 

Yes.

> What exactly is that meaning?
> "Returned -EAGAIN if the request will take a long time for some vague
> definition of long" ...

This is one of the issues I'd appreciate some real feedback on, so
I've cc'ed lkml and fsdevel.

The specific and practical answer is "Return -EAGAIN if DMAPI decides
it needs to queue an event", but that only applies to XFS (and JFS
in SLES) so it's not really a generic definition.

>From knfsd's point of view, the desired definition is "Return -EAGAIN
if the operation is likely to take longer than a client RPC timeout".
Of course, the server doesn't know what that number is, although 1.1 sec
is a pretty good guess.

Perhaps the best definition is "Return -EAGAIN if the operation needs
to block on something other than a disk IO".  This covers what actually
happens in the guts of XFS, what needs generically to happen for HSMs,
and suits the needs of knfsd.

> Is this new semantic in any way 'standard' or accepted by the
> filesystem gurus (e.g. Al Viro)??

It's not currently standard; my hope is to extend the standard.
I've cc'ed Al Viro in the hope of some feedback.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


