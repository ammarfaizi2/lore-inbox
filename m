Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289667AbSAJUrb>; Thu, 10 Jan 2002 15:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289670AbSAJUrW>; Thu, 10 Jan 2002 15:47:22 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:34801 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S289667AbSAJUrF>;
	Thu, 10 Jan 2002 15:47:05 -0500
Date: Thu, 10 Jan 2002 13:46:57 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: linux-kernel@vger.kernel.org, Bruce Guenter <bruceg@em.ca>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Where's all my memory going?
Message-ID: <20020110134657.A26688@lynx.adilger.int>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Bruce Guenter <bruceg@em.ca>, Rik van Riel <riel@conectiva.com.br>
In-Reply-To: <E16OMpF-0001pj-00@the-village.bc.nu> <Pine.LNX.4.33L.0201092034590.2985-100000@imladris.surriel.com> <20020110024520.A29045@em.ca> <20020110030537.C771@lynx.adilger.int> <20020110145542.B2499@mould.bodgit-n-scarper.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020110145542.B2499@mould.bodgit-n-scarper.com>; from matt@bodgit-n-scarper.com on Thu, Jan 10, 2002 at 02:55:42PM +0000
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 10, 2002  14:55 +0000, Matt Dainty wrote:
> Pretty much the same as Bruce here, mostly same culprits anyway:
> 
> inode_cache        84352  90800    480 11340 11350    1 :  124   62
> dentry_cache      240060 240060    128 8002 8002    1 :  252  126
> buffer_head       215417 227760     96 5694 5694    1 :  252  126
> size-32           209954 209954     32 1858 1858    1 :  252  126
> 
> On Thu, Jan 10, 2002 at 03:05:38AM -0700, Andreas Dilger wrote:
> > The other question would of course be whether we are calling into
> > shrink_dcache_memory() enough, but that is an issue for Matt to
> > see by testing "postal" with and without the patch, and keeping an
> > eye on the slab caches.
> 
> Patch applied cleanly, and I redid the 'test'. I've attached the output
> of free and /proc/slabinfo, *.1 is without patch, *.2 is with. In both
> cases postal was left to run for about 35 minutes by which time it had
> delivered around ~54000 messages locally.

One question - what happens to the emails after they are delivered?  Are
they kept on the local filesystem?  That would be one reason why you have
so many inodes and dentries in the cache - they are cacheing all of these
newly-accessed inodes in the assumption that they may be used again soon.

Even on my system, I have about 35000 items in the inode and dentry caches.

> Overall, with the patch, the large numbers in /proc/slabinfo are *still*
> large, but not as large as without the patch. Overall memory usage still
> seems similar.

Well, Linux will pretty much always use up all of your memory.  The real
question always boils down to how to use it most effectively.

Without patch:
>              total       used       free     shared    buffers     cached
> Mem:       1029524     992848      36676          0      54296     139212
> -/+ buffers/cache:     799340     230184
> Swap:      2097136        116    2097020
>
> inode_cache        84352  90800    480 11340 11350    1 :  124   62
> dentry_cache      240060 240060    128 8002 8002    1 :  252  126
> buffer_head       215417 227760     96 5694 5694    1 :  252  126
> size-32           209954 209954     32 1858 1858    1 :  252  126

With patch:
>              total       used       free     shared    buffers     cached
> Mem:       1029524     992708      36816          0      43792     144516
> -/+ buffers/cache:     804400     225124
> Swap:      2097136        116    2097020
> 
> inode_cache        55744  62440    480 7801 7805    1 :  124   62
> dentry_cache      125400 125400    128 4180 4180    1 :  252  126
> buffer_head       223430 236160     96 5904 5904    1 :  252  126
> size-32           100005 100005     32  885  885    1 :  252  126

Well with the patch, you have:

((11350 - 7805) + (8002 - 4180) + (1858 - 885)) * 4096 bytes = 32MB

more RAM to play with.  Granted that it is not a ton on a 1GB machine,
but it is nothing to sneeze at either.  In your case, we could still
be a lot more aggressive in removing dentries and inodes from the cache,
but under many workloads (not the artificial use-once case of such a
benchmark) that may be a net performance loss.

One interesting tidbit is the number of size-32 items in use.  This means
that the filename does not fit into the 16 bytes provided inline with
the dentry.  There was another patch available which increased the size
of DNAME_INLINE_LEN so that it filled the rest of the cacheline, since
the dentries are aligned this way anyways.  Depending on how much space
that gives you, and the length of the filenames used by qmail, you could
save another (whopping) 3.5MB of space and avoid extra allocations for
each and every file.

Still, these slabs only total 18744 pages = 73 MB, so there must be
another culprit hiding elsewhere using the other 720MB of RAM.  What
does the output of Ctrl-Alt-SysRQ-M show you (either kernel is fine).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

