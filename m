Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135948AbREJAQz>; Wed, 9 May 2001 20:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135931AbREJAQg>; Wed, 9 May 2001 20:16:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:19985 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135924AbREJAQ1>; Wed, 9 May 2001 20:16:27 -0400
Date: Wed, 9 May 2001 19:38:01 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Kurt Garloff <garloff@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs MAP_SHARED corruption fix
In-Reply-To: <20010510020819.F2506@athlon.random>
Message-ID: <Pine.LNX.4.21.0105091931410.15959-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 May 2001, Andrea Arcangeli wrote:

> On Wed, May 09, 2001 at 07:02:16PM -0300, Marcelo Tosatti wrote:
> > Why don't you clean I_DIRTY_PAGES ? 
> 
> we don't have visibilty on the inode_lock from there, we could make a
> function in fs/inode.c or export the inode_lock to do that, but the flag
> will be collected when the inode is released anyways, and it's only an
> hint to make the common case fast (the common case is when nobody ever
> did a MAP_SHARED on the inode). Other places msync/fsync doesn't even
> check for such bit but they fdatasync/fdatawait unconditionally. 

Actually msync/fsync _can't_ rely on this bit because there is no
guarantee that data is fully synced on disk even if the bit is cleared.
(__sync_one (fs/inode.c) clears the bit _before_ starting the writeout,
and thats it).

You have the same problem with your code, so I guess its better to just
remove the I_DIRTY_PAGES check. 

> And on the same lines also sys_fsync and sys_msync could clear the
> I_DIRTY_PAGES but they don't for semplcity (it will be cleared by
> kupdate later).
> 
> So in short we can clear it but it's not required and it won't make much
> difference. If you really care you can clear it before calling fdatasync
> though.

Well, forget about that. :) 

