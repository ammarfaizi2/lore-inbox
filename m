Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267974AbTCFKLQ>; Thu, 6 Mar 2003 05:11:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268044AbTCFKLQ>; Thu, 6 Mar 2003 05:11:16 -0500
Received: from packet.digeo.com ([12.110.80.53]:43232 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267974AbTCFKLP>;
	Thu, 6 Mar 2003 05:11:15 -0500
Date: Thu, 6 Mar 2003 02:21:40 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm1
Message-Id: <20030306022140.7c816f32.akpm@digeo.com>
In-Reply-To: <m365qw3jcx.fsf@lexa.home.net>
References: <20030305230712.5a0ec2d4.akpm@digeo.com>
	<m365qw3jcx.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2003 10:21:40.0692 (UTC) FILETIME=[2D8D2940:01C2E3CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> 
> As far as I understand this isn't error path. 
> 
> 	lock_kernel();
> 
> 	sb = inode->i_sb;
> 
> 	if (is_dx(inode)) {
> 		err = ext3_dx_readdir(filp, dirent, filldir);
> 		if (err != ERR_BAD_DX_DIR)
> 			return err;
> 		/*
> 		 * We don't set the inode dirty flag since it's not
> 		 * critical that it get flushed back to the disk.
> 		 */
> 		EXT3_I(filp->f_dentry->d_inode)->i_flags &= ~EXT3_INDEX_FL;
> 	}
> 
> So, if ext3_dx_readdir() returns 0 (OK path), then ext3_readdir() finish
> w/o unlock_kernel(). The remain part of ext3_readdir() gets used if
> ext3_dx_readdir() can't use HTree and returns ERR_BAD_DX_DIR.
> 

hm, yes, it does look that way.

It could be that any task which travels that path ends up running under
lock_kernel() for the rest of its existence, and nobody noticed.

