Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932441AbWFSNM2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbWFSNM2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 09:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWFSNM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 09:12:27 -0400
Received: from mx2.mail.ru ([194.67.23.122]:42014 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S932441AbWFSNM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 09:12:27 -0400
Date: Mon, 19 Jun 2006 17:17:50 +0400
From: Evgeniy Dushistov <dushistov@mail.ru>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5]: ufs: missed brelse and wrong baseblk
Message-ID: <20060619131750.GA14770@rain.homenetwork>
Mail-Followup-To: Al Viro <viro@ftp.linux.org.uk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20060617101403.GA22098@rain.homenetwork> <20060618162054.GW27946@ftp.linux.org.uk> <20060618175045.GX27946@ftp.linux.org.uk> <20060619064721.GA6106@rain.homenetwork> <20060619073229.GI27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619073229.GI27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 08:32:29AM +0100, Al Viro wrote:
> On Mon, Jun 19, 2006 at 10:47:21AM +0400, Evgeniy Dushistov wrote:
> > On Sun, Jun 18, 2006 at 06:50:45PM +0100, Al Viro wrote:
> > > 	* block may be bigger than page.  That can cause all sorts of fun
> > > problems in interaction with our VM, since allocation can affect more than
> > > one page and that has to be taken into account.
> > 
> > In fact this is not a problem. Blocks in terms of linux VFS
> > is fragments in terms of UFS. 
> 
> And?
> 
> > And if fragment >4096 we just don't mount such file system.
> > 
> > So we can easily support 32K blocks.
> 
> ....  Which means that we have allocation unit (aka UFS block) covering
> several in-core pages.  Which means that if you have a file with 8Kb
> hole in the beginning, mmap it shared and dirty the first couple of
> pages, you will get the situation when parallel writeout on those two
> pages will cause trouble.  Both times you'll allocate full block (file
> is couple of megabytes long, so forget about partial blocks, relocations,
> etc.)  And both will try to put the reference to what they'd allocated
> into the same inode as the first direct block.  Do you see the problem?

No, I don't see, can you explain in detail how this affect current
implementation?
In case of 1k fragments, msync of two pages
cause 8 calls of ufs's get_block_t with create == 1,
they will be consequent because of synchronization.
Only the first one allocate block, 
all other check if reference to block not 0, and just return 
appropriate value. See for example ufs_inode_getblock:
	p = (__fs32 *) bh->b_data + block;
	tmp = fs32_to_cpu(sb, *p);
	if (tmp) {
		*phys = tmp + blockoff;
		goto out;
and that's all, nothing will be allocated.		

So this is abstract theory about some abstract implementation of UFS,
or you see some problems in code?


-- 
/Evgeniy

