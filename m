Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUIIPxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUIIPxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266193AbUIIPxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:53:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:2240 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266139AbUIIPwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:52:19 -0400
Date: Thu, 9 Sep 2004 08:51:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Kirill Korotaev <dev@sw.ru>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adding per sb inode list to make invalidate_inodes()
 faster
In-Reply-To: <4140791F.8050207@sw.ru>
Message-ID: <Pine.LNX.4.58.0409090844410.5912@ppc970.osdl.org>
References: <4140791F.8050207@sw.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Sep 2004, Kirill Korotaev wrote:
> 
> This patch fixes the problem that huge inode cache
> can make invalidate_inodes() calls very long. Meanwhile
> lock_kernel() and inode_lock are being held and the system
> can freeze for seconds.

Hmm.. I don't mind the approach per se, but I get very nervous about the 
fact that I don't see any initialization of "inode->i_sb_list".

Yes, you do a

	list_add(&inode->i_sb_list, &sb->s_inodes);

in new_inode(), but there are a ton of users that allocate inodes other 
ways, and more importantly, even if this was the only allocation function, 
you do various "list_del(&inode->i_sb_list)" things which leaves the inode 
around but with an invalid superblock list.

So at the very _least_, you should document why all of this is safe very 
carefully (I get nervous about fundamental FS infrastructure changes), and 
it should be left to simmer in -mm for a longish time to make sure it 
really works..

Call me chicken.

		Linus "tweet tweet" Torvalds
