Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135916AbREJAIz>; Wed, 9 May 2001 20:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135918AbREJAIq>; Wed, 9 May 2001 20:08:46 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:21312 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135916AbREJAIi>; Wed, 9 May 2001 20:08:38 -0400
Date: Thu, 10 May 2001 02:08:19 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Kurt Garloff <garloff@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs MAP_SHARED corruption fix
Message-ID: <20010510020819.F2506@athlon.random>
In-Reply-To: <15096.61962.130340.998058@charged.uio.no> <Pine.LNX.4.21.0105091859340.14172-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105091859340.14172-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, May 09, 2001 at 07:02:16PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 07:02:16PM -0300, Marcelo Tosatti wrote:
> Why don't you clean I_DIRTY_PAGES ? 

we don't have visibilty on the inode_lock from there, we could make a
function in fs/inode.c or export the inode_lock to do that, but the flag
will be collected when the inode is released anyways, and it's only an
hint to make the common case fast (the common case is when nobody ever
did a MAP_SHARED on the inode). Other places msync/fsync doesn't even
check for such bit but they fdatasync/fdatawait unconditionally. And on
the same lines also sys_fsync and sys_msync could clear the
I_DIRTY_PAGES but they don't for semplcity (it will be cleared by
kupdate later).

So in short we can clear it but it's not required and it won't make much
difference. If you really care you can clear it before calling fdatasync
though.

Andrea
