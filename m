Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284117AbRLKXAl>; Tue, 11 Dec 2001 18:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284147AbRLKXA3>; Tue, 11 Dec 2001 18:00:29 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17018 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S284117AbRLKXAP>; Tue, 11 Dec 2001 18:00:15 -0500
Date: Tue, 11 Dec 2001 23:59:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Leigh Orf <orf@mailbag.com>, linux-kernel@vger.kernel.org,
        Ken Brownfield <brownfld@irridia.com>, Andrew Morton <akpm@zip.com.au>,
        Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: 2.4.16 memory badness (reproducible)
Message-ID: <20011211235908.L4801@athlon.random>
In-Reply-To: <200112082142.fB8LgAb02089@orp.orf.cx> <Pine.LNX.4.21.0112111850090.1164-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0112111850090.1164-100000@localhost.localdomain>; from hugh@veritas.com on Tue, Dec 11, 2001 at 07:07:41PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 07:07:41PM +0000, Hugh Dickins wrote:
> On Sat, 8 Dec 2001, Leigh Orf wrote:
> > 
> > So I don't know if it's a symptom or a cause, but modify_ldt seems to be
> > triggering the problem. Not being a kernel hacker, I leave the analysis
> > of this to those who are.
> > 
> > home[1029]:/home/orf% free
> >              total       used       free     shared    buffers     cached
> > Mem:       1029772     967096      62676          0     443988      98312
> > -/+ buffers/cache:     424796     604976
> > Swap:      2064344          0    2064344
> > 
> > modify_ldt(0x1, 0xbffff1fc, 0x10)       = -1 ENOMEM (Cannot allocate memory)
> 
> I believe this error comes, not from a (genuine or mistaken) shortage
> of free memory, but from shortage or fragmentation of vmalloc's virtual

definitely agreed. This is the same I was wondering about right now here
while reading his report.

He always get vmalloc failures, this is way too suspect. If the VM
memory balancing was the culprit he should get failures with all the
other allocations too. So it has to be a problem with a shortage of the
address space available to vmalloc, not a problem with the page
allocator.

> address space.  Does patch below (to 2.4.17-pre4-aa1 since I think that's
> what you tried last; easily adaptible to other trees) doubling vmalloc's
> address space (on your 1GB machine or larger) make any difference?
> Perhaps there's a vmalloc leak and this will only delay the error.
> 
> Hugh
> 
> --- 1704aa1/arch/i386/kernel/setup.c	Tue Dec 11 15:22:53 2001
> +++ linux/arch/i386/kernel/setup.c	Tue Dec 11 19:01:37 2001
> @@ -835,7 +835,7 @@
>  /*
>   * 128MB for vmalloc and initrd
>   */
> -#define VMALLOC_RESERVE	(unsigned long)(128 << 20)
> +#define VMALLOC_RESERVE	(unsigned long)(256 << 20)
>  #define MAXMEM		(unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE)
>  #ifdef CONFIG_HIGHMEM_EMULATION
>  #define ORDER_DOWN(x)	((x >> (MAX_ORDER-1)) << (MAX_ORDER-1))

yes, this will tend to hide it.

Even better would be to change fs/ntfs/* to avoid using vmalloc for tons
of little pieces. It's not only a matter of wasting direct mapped
address space, but it's also a matter of running fast, mainly on SMP
with the IPI for the tlb flushes...

attr.c:233:		new = ntfs_vmalloc(new_size);
attr.c:235:			ntfs_error("ntfs_insert_run:
ntfs_vmalloc(new_size = "
attr.c:458:			rlt = ntfs_vmalloc(rl_size);
inode.c:1297:		rl = ntfs_vmalloc(rlen << sizeof(ntfs_runlist));
inode.c:1638:					rlt =
ntfs_vmalloc(rl_size);
inode.c:1942:		rl2 = ntfs_vmalloc(rl2_size);
inode.c:2006:			rlt = ntfs_vmalloc(rl_size);
super.c:810:				rlt = ntfs_vmalloc(rlsize);
super.c:1335:		buf = ntfs_vmalloc(buf_size);
support.h:29:#include <linux/vmalloc.h>
support.h:35:#define ntfs_vmalloc(size)	vmalloc_32(size)


In short there are three solutions avaialble:

1) don't use ntfs
2) fix ntfs
3) enlarge vmalloc address space with the above patch, but this won't be
   a final solution because you'll overflow again the vmalloc address
   space by adding the double of files in your fs

So I'd redirect this report to Anton Altaparmakov <aia21@cam.ac.uk> and
I still have no VM bugreport pending from my part.

thanks,

Andrea
