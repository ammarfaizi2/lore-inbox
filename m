Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWFSHcb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWFSHcb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 03:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932235AbWFSHcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 03:32:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47534 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932209AbWFSHca
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 03:32:30 -0400
Date: Mon, 19 Jun 2006 08:32:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5]: ufs: missed brelse and wrong baseblk
Message-ID: <20060619073229.GI27946@ftp.linux.org.uk>
References: <20060617101403.GA22098@rain.homenetwork> <20060618162054.GW27946@ftp.linux.org.uk> <20060618175045.GX27946@ftp.linux.org.uk> <20060619064721.GA6106@rain.homenetwork>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619064721.GA6106@rain.homenetwork>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 10:47:21AM +0400, Evgeniy Dushistov wrote:
> On Sun, Jun 18, 2006 at 06:50:45PM +0100, Al Viro wrote:
> > 	* block may be bigger than page.  That can cause all sorts of fun
> > problems in interaction with our VM, since allocation can affect more than
> > one page and that has to be taken into account.
> 
> In fact this is not a problem. Blocks in terms of linux VFS
> is fragments in terms of UFS. 

And?

> And if fragment >4096 we just don't mount such file system.
> 
> So we can easily support 32K blocks.

...  Which means that we have allocation unit (aka UFS block) covering
several in-core pages.  Which means that if you have a file with 8Kb
hole in the beginning, mmap it shared and dirty the first couple of
pages, you will get the situation when parallel writeout on those two
pages will cause trouble.  Both times you'll allocate full block (file
is couple of megabytes long, so forget about partial blocks, relocations,
etc.)  And both will try to put the reference to what they'd allocated
into the same inode as the first direct block.  Do you see the problem?
