Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282380AbRKXHBb>; Sat, 24 Nov 2001 02:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282381AbRKXHBV>; Sat, 24 Nov 2001 02:01:21 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:15408 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S282380AbRKXHBL>; Sat, 24 Nov 2001 02:01:11 -0500
Date: Sat, 24 Nov 2001 08:01:13 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011124080113.A1316@athlon.random>
In-Reply-To: <Pine.GSO.4.21.0111240129470.4000-100000@weyl.math.psu.edu> <Pine.GSO.4.21.0111240132290.4000-100000@weyl.math.psu.edu> <20011124075045.B1601@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011124075045.B1601@athlon.random>; from andrea@suse.de on Sat, Nov 24, 2001 at 07:50:45AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2001 at 07:50:45AM +0100, Andrea Arcangeli wrote:
> On Sat, Nov 24, 2001 at 01:37:22AM -0500, Alexander Viro wrote:
> > 
> > 
> > On Sat, 24 Nov 2001, Alexander Viro wrote:
> > 
> > > On Sat, 24 Nov 2001, Andrea Arcangeli wrote:
> > > 
> > > > you are screwed because you were running a broken filesystem: it is its
> > > > own business to drop the inodes if it fails, all it needs to do is to
> > > > call invalidate_inodes(s) internally before returning from the read_super
> > > > in the failure case.
> > > 
> > > Cute.  Do you realize that _every_ fs would have to do that?
> > 
> > Put it that way:
> > 	* if ->read_super() decides to fail, it should evict all inodes
> > it had put into icache.
> > 	* if ->put_super() does any iput(), it should take care to evict
> > that inode from icache.
> 
> exactly.
> 
> > IOW,
> > 	* if we do iput() while we are outside of (success of ->read_super(),
> > call of ->put_super()) - we want that inode to be evicted ASAP.
> > 
> > Which is precisely what 2.4.15+patch does.
> 
> and it's slower and overlay complex compared to the right fix:
> 
> --- 2.4.15aa1/fs/ext2/super.c.~1~	Fri Nov 23 08:21:00 2001
> +++ 2.4.15aa1/fs/ext2/super.c	Sat Nov 24 07:50:19 2001
> @@ -643,6 +643,7 @@
>  			printk(KERN_ERR "EXT2-fs: corrupt root inode, run e2fsck\n");
>  		} else
>  			printk(KERN_ERR "EXT2-fs: get root inode failed\n");
> +		invalidate_inodes(sb);
>  		goto failed_mount2;
>  	}
>  	ext2_setup_super (sb, es, sb->s_flags & MS_RDONLY);

this one looks even better (and it doesn't need to propagate the fix to
the lowlevel):

--- 2.4.15aa1/fs/super.c.~1~	Fri Nov 23 08:21:01 2001
+++ 2.4.15aa1/fs/super.c	Sat Nov 24 07:58:37 2001
@@ -470,6 +470,7 @@
 	return s;
 
 out_fail:
+	invalidate_inodes(s);
 	s->s_dev = 0;
 	s->s_bdev = 0;
 	s->s_type = NULL;

Andrea
