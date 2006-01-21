Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbWAUHKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWAUHKm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 02:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWAUHKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 02:10:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751004AbWAUHKl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 02:10:41 -0500
Date: Fri, 20 Jan 2006 23:10:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: sho@tnes.nec.co.jp, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [PATCH] ext3: Extends blocksize up to pagesize
Message-Id: <20060120231016.40b40fd7.akpm@osdl.org>
In-Reply-To: <20060118185249.GN4124@schatzie.adilger.int>
References: <000001c61c30$00814e80$4168010a@bsd.tnes.nec.co.jp>
	<20060118185249.GN4124@schatzie.adilger.int>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> wrote:
>
> On Jan 18, 2006  22:06 +0900, Takashi Sato wrote:
> > As a disk tends to get large, a disk storage has had a capacity to
> > supply multi-TB.  But now, ext3 can't support more than 8TB filesystem
> > when blocksize is 4KB.  That's why I think ext3 needs to be
> > more than 8TB.
> > 
> > Therefore I think filesystem size can increase on architectures
> > which has more than 4KB pagesize by extending blocksize to pagesize on
> > ext3.  For example, the following is in case of ia64.  (Blocksize have
> > already been supported up to pagesize on ext2. Why is the max blocksize
> > restricted to 4KB on ext3?)
> > 
> > Max filesystem size on ia64:
> > Original                                   :4096(blocksize) * 2^31 =  8TB
> > After modification [pagesize=16KB(default)]:16384(blocksize) * 2^31 = 32TB
> > After modification [pagesize=64KB(max)]    :65536(blocksize) * 2^31 = 128TB
> 
> Just for others' info - the fill_super change has been tested in the past
> by Sonny Rao at IBM also.  e2fsprogs has supported this for a long time
> already.

I have a vague memory that there's some piece of metadata (per-block-group
info, I think) which will overflow at 8kb blocksize.  I say this in the
hope that you'll remmeber what it was ;)


> > - ext3_readdir
> >   Currently read-ahead 16 sectors when reading a directory, but not
> >   if blocksize is more than 8KB.  Then I modified to read-ahead
> >   one fs-block if blocksize is more than 8KB.

I've rewritten ext3 directory readahead to use the generic pagecache
functions, so changes here shouldn't be needed.

But I haven't yet got around to performance-testing it.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/2.6.16-rc1-mm2/broken-out/ext3_readdir-use-generic-readahead.patch
