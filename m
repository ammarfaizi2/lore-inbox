Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751173AbWCYAbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbWCYAbq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 19:31:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWCYAbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 19:31:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36825 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751173AbWCYAbo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 19:31:44 -0500
Date: Fri, 24 Mar 2006 16:33:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michael Halcrow <mhalcrow@us.ibm.com>
Cc: phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mcthomps@us.ibm.com, yoder1@us.ibm.com, toml@us.ibm.com,
       emilyr@us.ibm.com, daw@cs.berkeley.edu
Subject: Re: eCryptfs Design Document
Message-Id: <20060324163358.557ac5f7.akpm@osdl.org>
In-Reply-To: <20060325001345.GC13688@us.ibm.com>
References: <20060324222517.GA13688@us.ibm.com>
	<20060324154920.11561533.akpm@osdl.org>
	<20060325001345.GC13688@us.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Halcrow <mhalcrow@us.ibm.com> wrote:
>
> On Fri, Mar 24, 2006 at 03:49:20PM -0800, Andrew Morton wrote:
> > Michael Halcrow <mhalcrow@us.ibm.com> wrote:
> > > On a page read, the eCryptfs page index is interpolated into the
> > > corresponding lower page index, taking into account the header page in
> > > the file.
> > 
> > I trust that PAGE_CACHE_SIZE is not implicitly encoded into the file
> > layout?
> 
> For release 0.1, it is. Managing differing page sizes is one of the
> not-so-trivial changes to eCryptfs that we have planned for the 0.2
> release. For this release, we can easily include a flag setting in the
> header that indicates the page size, so that at least eCryptfs will
> return a -EIO when the file is moved between hosts with different page
> sizes. We will make sure that this is in the code before it is
> submitted.
> 
> Do you think that this is an acceptable approach for the initial
> release of eCryptfs?

Well it's not good.  Will ecryptfs-0.1 files be both-way compatible with
ecryptfs-0.2 files?

The basic unit of a pagecache page's backing store should be a
filesystem-determined blocksize, divorced from page sizes.

For your purposes we can abstract things out a bit and not have to worry
about the actual on-underlying-disk blocksize.  Which is fortunate, because
you want an ecryptfs-on-ext3-on-1kblocksize file to work when copied to an
ecryptfs-on-ext2-on-2kblocksize filesystem.

I think it would be acceptable to design ecryptfs to assume that its
underlying store has a 4096-byte "blocksize".  So all the crypto operates
on 4096-byte hunks and the header is 4096-bytes long and things are copied
to and from the underlying fs's pagecache in 4096-byte hunks.

That's because 4096 is, for practical purposes, the minimum Linux
PAGE_CACHE_SIZE.  Globally available and all filesystems support it.

> 
> ...
>
> Speaking of which, is there any particular way of breaking the code
> into patches that you would prefer for delivery of a new filesystem?
> In the past, we have been breaking the code into one patch for
> inode.c, another for dentry.c, and so forth.

That seems a reasonable way of doing it.  It's all logically one patch, but
for review purposes we need some sort of splitup.

> > One dutifully wonders whether all this functionality could be
> > provided via FUSE...
> 
> My main concern with FUSE has to do with shared memory mappings.

OK.  But I'm sure Miklos would appreciate help with that ;)

> My
> next concern is with regard to performance impact of constant context
> switching during page reads and writes.

Maybe.  One could estimate the cost of that by benchmarking an existing
(efficient) FUSE fs and then add fiddle factors.  If the number of copies
is the same for in-kernel versus FUSE then one would expect the performance
to be similar.  Especially if the encrypt/decryption cost perponderates.

