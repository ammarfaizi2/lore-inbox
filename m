Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282654AbRKZXht>; Mon, 26 Nov 2001 18:37:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282656AbRKZXhl>; Mon, 26 Nov 2001 18:37:41 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:6859 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S282654AbRKZXh0>; Mon, 26 Nov 2001 18:37:26 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: trond.myklebust@fys.uio.no
Date: Tue, 27 Nov 2001 10:35:26 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15362.53694.192797.275363@esther.cse.unsw.edu.au>
Cc: NFS maillist <nfs@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fix knfsd readahead cache in 2.4.15
In-Reply-To: message from Trond Myklebust on Monday November 26
In-Reply-To: <15362.18626.303009.379772@charged.uio.no>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 26, trond.myklebust@fys.uio.no wrote:
> Hi Neil,
> 
>   The following patch fixes a bug in the knfsd readahead code. The
> memset() that is referenced in the patch below is clobbering the
> pointer to the next list element (ra->p_next), thus reducing the inode
> readahead cache to 1 entry upon the very first call to
> nfsd_get_raparms().

Thanks.
This is definately a bug, but I don't think it is quite as dramatic as
you suggest.

The "struct raparms" that ra points to will almost always be the last
one on the list, so ra->p_next will almost always be NULL anyway.
Nevertheless, it is a bug and your fix looks good.

> 
>   BTW: looking at the choice of cache size. Why is this set to number
> of threads * 2? Isn't it better to have a minimum cache size? After
> all, the fact that I have 8 threads running does not at all reflect
> the number of inodes that I might have open on my various clients...

Historical reasons... That's the way it was when I started looking at
the code, and I never saw any reason to change it.  
I did add some statistics gathering so that you could watch the usage
of the racache to see if it was big enough, but I haven't looked at
any numbers yet...

I have a fairly busy nfs server that has been running 2.4.something
for 20 days with 32 nfsd threads.  The "ra" line from the stats file
( /proc/net/rpc/nfsd ) is:

ra 64 8921281 74404 43817 25150 18806 17611 12894 11859 8342 6919 1605176

which says that 64 entries were allocated,
8921281 searches found a hit in the first 10% of the cache
74404 searches found a hit in the next 10%
and so on.
6919 searches found a hit in the last 10%
1605176 searches (20%) didn't find a hit.

Obviously these numbers would vary a lot with different loads.  I
suspect that 20% miss rate reflects average file size, as the first
read request on a file will always miss.  Maybe we have an average
file size of 40K (5 times 8K read size).

However this set of numbers suggests to me that 64 entries is
reasonable for us.  Doubling the number of entries would reduce the
miss rate by less than 10*6919.  Probably only 30,000 at most, which
is 2%.

Ideally the size should be tunable.  Then you could monitor these
stats over several days, and adjust the size until you get the number
of searches that hit in the last 10% suitably low.

But then again, maybe we should store the cache in a hash table for
faster lookup.  It would make the stats harder to collect, but would
make searches faster which is more important.

The bottom line is that it is a heuristic that seems to work well
enough.  The cache needs to be at least as big as the number of
servers so that each thread can always find an entry when it needs
one.  Making it twice that big seems to work.

NeilBrown


> 
> Cheers,
>    Trond
> 
> --- linux-2.4.16-pre1/fs/nfsd/vfs.c.orig	Fri Oct  5 21:23:53 2001
> +++ linux-2.4.16-pre1/fs/nfsd/vfs.c	Mon Nov 26 14:32:09 2001
> @@ -560,9 +560,13 @@
>  		return NULL;
>  	rap = frap;
>  	ra = *frap;
> -	memset(ra, 0, sizeof(*ra));
>  	ra->p_dev = dev;
>  	ra->p_ino = ino;
> +	ra->p_reada = 0;
> +	ra->p_ramax = 0;
> +	ra->p_raend = 0;
> +	ra->p_ralen = 0;
> +	ra->p_rawin = 0;
>  found:
>  	if (rap != &raparm_cache) {
>  		*rap = ra->p_next;
