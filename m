Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132611AbRDQNPl>; Tue, 17 Apr 2001 09:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132607AbRDQNPc>; Tue, 17 Apr 2001 09:15:32 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:57143 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132606AbRDQNPU>; Tue, 17 Apr 2001 09:15:20 -0400
Date: Tue, 17 Apr 2001 14:09:28 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alexander Viro <viro@math.psu.edu>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: generic_osync_inode/ext2_fsync_inode still not safe
Message-ID: <20010417140928.C2505@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0104140632300.1615-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0104140632300.1615-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Sat, Apr 14, 2001 at 07:24:42AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Apr 14, 2001 at 07:24:42AM -0300, Marcelo Tosatti wrote:
> 
> As described earlier, code which wants to write an inode cannot rely on
> the I_DIRTY bits (on inode->i_state) being clean to guarantee that the
> inode and its dirty pages, if any, are safely synced on disk.

Indeed --- for all such structures, including pages, buffer_heads and
inodes, you can only assume that the object is safely on disk if you
have checked both the dirty bit AND the locked bit.  If you find it
locked but clean, then a writeout may be in progress, so you need to
do a wait_on_* to be really sure that the write has completed.

> The reason for that is sync_one() --- it cleans the I_DIRTY bits of an
> inode, sets the I_LOCK and starts a writeout. 

As long as it is setting the I_LOCK bit, then that's fine.

> The easy and safe fix is to simply remove the I_DIRTY_* checks from
> generic_osync_inode and ext2_fsync_inode. Easy but slow. Another fix would
> be to make sync_one() unconditionally synchronous... slow.

Just make the *sync functions look for the locked bit and do a wait on
the inode if it is locked.

Cheers,
 Stephen
