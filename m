Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265213AbUFROrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265213AbUFROrS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 10:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265201AbUFROqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 10:46:31 -0400
Received: from cantor.suse.de ([195.135.220.2]:12506 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265200AbUFROq1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 10:46:27 -0400
Subject: Re: [PATCH RFC] __bd_forget should wait for inodes using the
	mapping
From: Chris Mason <mason@suse.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20040618142207.GW12308@parcelfarce.linux.theplanet.co.uk>
References: <1087523668.8002.103.camel@watt.suse.com>
	 <20040618021043.GV12308@parcelfarce.linux.theplanet.co.uk>
	 <1087563810.8002.116.camel@watt.suse.com>
	 <20040618142207.GW12308@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Message-Id: <1087570031.8002.153.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 18 Jun 2004 10:47:11 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-06-18 at 10:22, viro@parcelfarce.linux.theplanet.co.uk
wrote:
> On Fri, Jun 18, 2004 at 09:03:31AM -0400, Chris Mason wrote:
> > sync_sb_inodes, the filesystem block device inode ends up on some dirty
> > list, and under memory pressure balance_dirty_pages_ratelimited will
> > trigger writeback on it.  
> > 
> > There's nothing to write back of course, the real block device address
> > space has no dirty pages at all.  But, writeback is looking through the
> > mapping and __bd_forget can't drop it until writeback has finished
> > checking it.
> 
> So WTF does writeback bother with that?  _That_ is the real bug here -
> the only kind of bdev inodes that can have accesses to ->i_mapping
> is fs/block_dev.c-created stuff.

During writeback, we need to answer the question: "are there dirty pages
attached to this inode", and the only way to answer it is via the
address space.

If bdev inodes don't want other inodes using their address space, they
shouldn't be setting the i_mapping on other inodes.  Since they are, the
bdev code needs to be aware that someone else might be using it.

-chris



