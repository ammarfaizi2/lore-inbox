Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964844AbWEJIBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964844AbWEJIBF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 04:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWEJIBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 04:01:04 -0400
Received: from verein.lst.de ([213.95.11.210]:34979 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S964844AbWEJIBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 04:01:03 -0400
Date: Wed, 10 May 2006 10:00:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Benjamin LaHaise <bcrl@kvack.org>,
       cel@citi.umich.edu
Subject: Re: [PATCH 1/3] Vectorize aio_read/aio_write methods
Message-ID: <20060510080037.GA2484@lst.de>
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147198025.28388.0.camel@dyn9047017100.beaverton.ibm.com> <20060509120105.7255e265.akpm@osdl.org> <20060509190310.GA19124@lst.de> <20060509121305.0840e770.akpm@osdl.org> <20060509192051.GA19378@lst.de> <1147219062.30738.8.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147219062.30738.8.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 04:57:42PM -0700, Badari Pulavarty wrote:
> > > we can get the followup patch done within the next week or two so we can
> > > get it all tested at the same time.  Although from your description it
> > > doesn't sound like it'll be completely trivial...
> > 
> > That patch is lots of tirival and boring work.  If anyone wants to beat
> > me to it:
> 
> Well, I am not sure if you mean *exactly* this..
> 
> So far, I have this. I really don't like the idea of
> adding .aio_read/.aio_write methods for the filesystems who currently
> don't have one (so we can force their .read/.write to do_sync_*()). 

Why don't you like this idea?  It helps to sort out callers into two
categories.  The following is a something I wrote up to put into
Documentation/ somewhere once these patches are in.


-------- snip --------

There are two ways to implement read/write for filesystems and drivers:

The simple way is to implement the read and write methods.  Normal
synchronous, single buffer requests are handed directly to the driver in
this case.  Vectored requests are emulated using a loop in the higher
level code.  AIO requests are silently performed synchronous.
This method is normally used for character drivers and synthetic
filesystems.

The advanced method is to implement the aio_read and aio_write methods.
These allow the request to be done asynchronously and submit multiple
IO vectores in parallel.  A page cache based filesystem gets this
functionality by freee by using the routines from filemap.c - in fact
there is not easy way to use the generic page cache code without
implementing aio_read and aio_write.  The other big user of this
interface are sockets.  Very few character driver need this complexity.

-------- snip --------

> Is there a way to fix callers of .read/.write() methods to use
> something like do_sync_read/write - that way we can take out
> .read/.write completely ?

The only way to fix this is to add some kernel_read/kernel_write helpers
that factor out the use aio_read / aio_write if present and wait for
I/O completion logic from vfs_read/vfs_write.  I started on that but it
got very messy.

> Anyway, here it is compiled but untested.. I think I can clean up
> more in filemap.c (after reading through your suggestions). Please
> let me know, if I am on wrong path ...

Currently I don't have time to actually apply the patchlkit and look at
the result, so I'll defer further comments.  Beside maybe not doing all
possible cleanups (e.g. I still see generic_file_write_nolock) this
patch looks very good.

