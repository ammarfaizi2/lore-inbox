Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbWFSTNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWFSTNJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 15:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932532AbWFSTNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 15:13:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:16020 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932465AbWFSTNG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 15:13:06 -0400
Date: Mon, 19 Jun 2006 20:13:06 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5]: ufs: missed brelse and wrong baseblk
Message-ID: <20060619191306.GK27946@ftp.linux.org.uk>
References: <20060617101403.GA22098@rain.homenetwork> <20060618162054.GW27946@ftp.linux.org.uk> <20060618175045.GX27946@ftp.linux.org.uk> <20060619064721.GA6106@rain.homenetwork> <20060619073229.GI27946@ftp.linux.org.uk> <20060619131750.GA14770@rain.homenetwork> <20060619182833.GJ27946@ftp.linux.org.uk> <20060619185816.GA26513@rain.homenetwork>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619185816.GA26513@rain.homenetwork>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 10:58:16PM +0400, Evgeniy Dushistov wrote:
> On Mon, Jun 19, 2006 at 07:28:33PM +0100, Al Viro wrote:
> > On Mon, Jun 19, 2006 at 05:17:50PM +0400, Evgeniy Dushistov wrote:
> > > In case of 1k fragments, msync of two pages
> > > cause 8 calls of ufs's get_block_t with create == 1,
> > > they will be consequent because of synchronization.
> > 
> > _What_ synchronization?
> > Now, which lock would, in your opinion, provide serialization between these
> > two calls?  They apply to different pages, so page locks do not help.
> >  
> you can look at fs/ufs/inode.c: ufs_getfrag_block.
> It is ufs's get_block_t,
> if create == 1 it uses "[un]lock_kernel". 

Which is fsck-all protection, since then you proceed to do a lot of
blocking operations.  Now, lock_super() down in balloc.c _might_ be
enough, but I wouldn't bet on that.
