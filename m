Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWBJWr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWBJWr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 17:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932230AbWBJWr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 17:47:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39116 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932228AbWBJWrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 17:47:25 -0500
Date: Fri, 10 Feb 2006 14:46:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
In-Reply-To: <1139608513.7877.9.camel@lade.trondhjem.org>
Message-ID: <Pine.LNX.4.64.0602101432400.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com> 
 <20060209094815.75041932.akpm@osdl.org> <43EC16D8.8030300@yahoo.com.au> 
 <20060209204314.2dae2814.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au> 
 <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au> 
 <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au> 
 <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au> 
 <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au> 
 <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org>  <43ECC13F.5080109@yahoo.com.au>
  <Pine.LNX.4.64.0602100846170.19172@g5.osdl.org>  <43ECCF68.3010605@yahoo.com.au>
  <Pine.LNX.4.64.0602100944280.19172@g5.osdl.org>  <43ECDD9B.7090709@yahoo.com.au>
  <Pine.LNX.4.64.0602101056130.19172@g5.osdl! .org>  <43ECF182.9020505@yahoo.com.au>
  <Pine.LNX.4.64.0602101254081.19172@g5.osdl.org> <1139608513.7877.9.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 10 Feb 2006, Trond Myklebust wrote:
> 
> The Single Unix Spec appears to have a very different interpretation.

Hmm. Very different wording, but same meaning, I think.

>         When MS_INVALIDATE is specified, msync() shall invalidate all
>         cached copies of mapped data that are inconsistent with the
>         permanent storage locations such that subsequent references
>         shall obtain data that was consistent with the permanent storage
>         locations sometime between the call to msync() and the first
>         subsequent memory reference to the data.

Again, this says that the _mapping_ is invalidated, and should match 
persistent storage.

Any dirty bits in the mapping (ie anything that hasn't been msync'ed) 
should be made persistent with permanent storage. Again, that is entirely 
consistent with just throwing the mmap'ed page away (dirty state and all) 
in a non-coherent environment.

I don't think we really have any modern Unixes with non-coherent mmap's 
(although HP-UX used to be that way for a _loong_ time). But in the 
timeframe that was written, it was probably still an issue.

Now, in a _coherent_ environment (like Linux) it should probably be a 
no-op, since the mapping is always consistent with storage (where 
"storage" doesn't actyally mean "disk", but the virtual file underneath 
the mapping).

If the page is dirty in the page tables, we've modified the page contents 
in the backing store (since we share it). But it would be consistent with 
the standard wrt MS_INVALIDATE (but totally insane) to throw the dirty 
state - and the page cache page - away if the page cache is clean.

The point being that a truly portable app can't really know what the hell 
it does - it hass to know whether mmap is coherent or not, and if mmap is 
coherent, then MS_INVALIDATE should _probably_ be a no-op.

(Which it is under modern Linux - MS_INVALIDATE is effectively a no-op, 
except we still have the old check that you can't invalidate a locked 
area. It _used_ to actually clear the page tables)

		Linus
