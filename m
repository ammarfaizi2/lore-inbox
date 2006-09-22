Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbWIVQxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWIVQxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWIVQxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:53:34 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:51119 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932588AbWIVQxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:53:34 -0400
Date: Fri, 22 Sep 2006 11:53:31 -0500
From: Michael Halcrow <mhalcrow@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Erez Zadok <ezk@cs.sunysb.edu>, Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: 2.6.19 -mm merge plans (ecryptfs)
Message-ID: <20060922165331.GB3186@us.ibm.com>
Reply-To: Michael Halcrow <mhalcrow@us.ibm.com>
References: <20060920135438.d7dd362b.akpm@osdl.org> <20060922144233.GA25478@infradead.org> <20060922090337.ed835b06.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922090337.ed835b06.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 09:03:37AM -0700, Andrew Morton wrote:
> On Fri, 22 Sep 2006 15:42:33 +0100
> Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > ecryptfs-versioning-fixes-tidy.patch
> > > 
> > >  Will fold into a single patch and will then merge.
> > 
> > Please add a
> > 
> > Not-Acked-By: Christoph Hellwig <hch@lst.de>
> > 
> > here as you don't seem to listen to any of the comments I had
> > against the current state and I want this clearly documented.
> 
> I thought everything got addressed, apart from
> 
>  - please split all the generic stackable filesystem passthorugh routines
>    into a separated stackfs layer, in a few files in fs/stackfs/ that
>    you depend on.  They'll get _GPL exported to all possible stackable
>    filesystem.  They'll need their own store underlying object helpers,
>    but that can be made to work by embedding the generic stackfs data
>    as first thing in the ecryptfs object.
> 
> which seemed rather a lot to ask.

A common framework that would be useful for all potential stackable
filesystems is indeed a major project in and of itself, and such a
thing right now would be premature. We need to see how code for other
stackable filesystems will look once it is actually in the
kernel. There is core behavior that differs between eCryptfs and
Unionfs -- for instance, how inodes are referenced. eCryptfs, in its
current form, can do just fine with referencing the internal inode
struct pointer, whereas Unionfs implements persistent inodes. Then
there are issues with readdir/filldir semantics, wherein Unionfs needs
a mechanism to implement whiteout operations. eCryptfs just has a
simple one-to-one VFS layer mapping, while Unionfs has to merge
several VFS mounts under it. The core *_info data structure diverge
quite a bit between the two. Right now, eCryptfs and Unionfs can get
by with a page-to-page mapping between the upper and lower files, but
that would not necessarily be the case for a compressing stacked
layer; the common framework would have to take that into
consideration.

Stacked filesystem authors are certainly interested in addressing
these sorts of issues, but an iterative strategy for solving them is
the most reasonable approach. The first step is to get at least two
stacked filesystems into the kernel (eCryptfs and Unionfs) and then
follow up with a series of patches to extract the common functionality
once we see somewhat finalized code bases for both.

Mike
