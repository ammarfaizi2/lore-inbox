Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282365AbRKXFsG>; Sat, 24 Nov 2001 00:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282355AbRKXFrz>; Sat, 24 Nov 2001 00:47:55 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:31264 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282375AbRKXFrn>; Sat, 24 Nov 2001 00:47:43 -0500
Date: Sat, 24 Nov 2001 06:47:39 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011124064739.J1324@athlon.random>
In-Reply-To: <Pine.GSO.4.21.0111231606150.2422-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.GSO.4.21.0111231606150.2422-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Nov 23, 2001 at 04:22:17PM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 04:22:17PM -0500, Alexander Viro wrote:
> 	Sigh...  Supposed fix to problems with stale inodes was completely
> broken.
> 
> 	What we need is "if we are doing last iput() on fs that is getting
> shut, sync it and don't leave it in cache".  And yes, we have a similar

What's this "stale inode" problem? invalidate_inodes in kill_super will
obviously get rid of all of them or we would be getting the
"selfdestructing in 5 seconds" message all the time.

I'm probably missing something, but actually to me it seems the patch in
pre9 plus this your further fix are completly superflous. And if you
mean that there's a race in the sync+invalidate_inode sequence (I didn't
checked) that should be serialized at the higher dcache/mnt layer,
without messing and slowing down all of the iput()s just for the unmount
case where the fsync+invalidate can be serialized by design at the mnt
layer without iput intervention. I actually believe this is the right
fix and it should work fine as far as anything <= 2.4.15pre8 was working
correctly. I'm going to release a 2.4.15aa1 with the below fix applied
(while waiting your comments of course, thanks!).

--- 2.4.15pre9aa1/fs/inode.c.~1~	Thu Nov 22 20:48:23 2001
+++ 2.4.15pre9aa1/fs/inode.c	Sat Nov 24 06:30:20 2001
@@ -1071,7 +1071,7 @@
 			if (inode->i_state != I_CLEAR)
 				BUG();
 		} else {
-			if (!list_empty(&inode->i_hash) && sb && sb->s_root) {
+			if (!list_empty(&inode->i_hash)) {
 				if (!(inode->i_state & (I_DIRTY|I_LOCK))) {
 					list_del(&inode->i_list);
 					list_add(&inode->i_list, &inode_unused);

Andrea
