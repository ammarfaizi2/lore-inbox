Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWBJXDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWBJXDS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWBJXDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:03:18 -0500
Received: from pat.uio.no ([129.240.130.16]:49901 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932239AbWBJXDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:03:18 -0500
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
In-Reply-To: <Pine.LNX.4.64.0602101432400.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
	 <20060209094815.75041932.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au>
	 <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au>
	 <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au>
	 <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au>
	 <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au>
	 <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au>
	 <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org>
	 <43ECC13F.5080109@yahoo.com.au>
	 <Pine.LNX.4.64.0602100846170.19172@g5.osdl.org>
	 <43ECCF68.3010605@yahoo.com.au>
	 <Pine.LNX.4.64.0602100944280.19172@g5.osdl.org>
	 <43ECDD9B.7090709@yahoo.com.au>
	 <Pine.LNX.4.64.0602101056130.19172@g5.osdl! .org>
	 <43ECF182.9020505@yahoo.com.au>
	 <Pine.LNX.4.64.0602101254081.19172@g5.osdl.org>
	 <1139608513.7877.9.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0602101432400.19172@g5.osdl.org>
Content-Type: text/plain
Date: Fri, 10 Feb 2006 18:02:53 -0500
Message-Id: <1139612574.7877.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.661, required 12,
	autolearn=disabled, AWL 1.15, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 14:46 -0800, Linus Torvalds wrote:
> 
> On Fri, 10 Feb 2006, Trond Myklebust wrote:
> > 
> > The Single Unix Spec appears to have a very different interpretation.
> 
> Hmm. Very different wording, but same meaning, I think.
> 
> >         When MS_INVALIDATE is specified, msync() shall invalidate all
> >         cached copies of mapped data that are inconsistent with the
> >         permanent storage locations such that subsequent references
> >         shall obtain data that was consistent with the permanent storage
> >         locations sometime between the call to msync() and the first
> >         subsequent memory reference to the data.
> 
> Again, this says that the _mapping_ is invalidated, and should match 
> persistent storage.
> 
> Any dirty bits in the mapping (ie anything that hasn't been msync'ed) 
> should be made persistent with permanent storage. Again, that is entirely 
> consistent with just throwing the mmap'ed page away (dirty state and all) 
> in a non-coherent environment.
> 
> I don't think we really have any modern Unixes with non-coherent mmap's 
> (although HP-UX used to be that way for a _loong_ time). But in the 
> timeframe that was written, it was probably still an issue.
> 
> Now, in a _coherent_ environment (like Linux) it should probably be a 
> no-op, since the mapping is always consistent with storage (where 
> "storage" doesn't actyally mean "disk", but the virtual file underneath 
> the mapping).

Hmmm.... When talking about syncing to _permanent_ storage one usually
is talking about what is actually on the disk. In any case, we do have
non-coherent mmapped environments in Linux (need I mention NFS,
CIFS, ... ;-)?).

IIRC msync(MS_INVALIDATE) on Solaris was actually often used by some
applications to resync the client page cache to the server when using
odd locking schemes, so I believe this interpretation is a valid one.

Cheers,
  Trond

