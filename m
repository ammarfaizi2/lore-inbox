Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265777AbTBBXub>; Sun, 2 Feb 2003 18:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbTBBXub>; Sun, 2 Feb 2003 18:50:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:15518 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265777AbTBBXua>;
	Sun, 2 Feb 2003 18:50:30 -0500
Date: Sun, 2 Feb 2003 16:00:07 -0800
From: Andrew Morton <akpm@digeo.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.0, 2.2, 2.4, 2.5: fsync buffer race
Message-Id: <20030202160007.554be43d.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302022354570.11719-100000@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0302022354570.11719-100000@artax.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Feb 2003 23:59:54.0709 (UTC) FILETIME=[2EA5A850:01C2CB17]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:
>
> Hi
> 
> there's a race condition in filesystem
> 
> let's have a two inodes that are placed in the same buffer.
> 
> call fsync on inode 1
> it goes down to ext2_update_inode [update == 1]
> it calls ll_rw_block at the end
> ll_rw_block starts to write buffer
> ext2_update_inode waits on buffer
> 
> while the buffer is writing, another process calls fsync on inode 2
> it goes again to ext2_update_inode
> it calls ll_rw_block
> ll_rw_block sees buffer locked and exits immediatelly
> ext2_update_inode waits for buffer
> the first write finished, ext2_update_inode exits and changes made by
> second proces to inode 2 ARE NOT WRITTEN TO DISK.
> 

hmm, yes.  This is a general weakness in the ll_rw_block() interface.  It is
not suitable for data-integrity writeouts, as you've pointed out.

A suitable fix would be do create a new

void wait_and_rw_block(...)
{
	wait_on_buffer(bh);
	ll_rw_block(...);
}

and go use that in all the appropriate places.

I shall make that change for 2.5, thanks.
