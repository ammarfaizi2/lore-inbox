Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316629AbSEVSJX>; Wed, 22 May 2002 14:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316630AbSEVSJW>; Wed, 22 May 2002 14:09:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33801 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316629AbSEVSJU>; Wed, 22 May 2002 14:09:20 -0400
Date: Wed, 22 May 2002 11:08:27 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        "M. Edward Borasky" <znmeb@aracnet.com>,
        <linux-kernel@vger.kernel.org>, <andrea@suse.de>, <riel@surriel.com>,
        <akpm@zip.com.au>
Subject: Re: Have the 2.4 kernel memory management problems on large machines
 been fixed?
In-Reply-To: <E17AaR0-0002QM-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0205221048570.23621-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 May 2002, Alan Cox wrote:
> 
> On a more practical note its been true for years but nobody needed the
> memory to implement it that you can discard page tables for non anonymous
> objects when you need space (arguably they belong on the lru like
> everything else)

You don't strictly even need to LRU it - you could just keep a pte count 
aroudn, and when it goes to zero you zap the pmd. You can use the normal 
page_count() thing for it.

HOWEVER, I'm rather certain that this won't actually help in real life, 
and it does add complexity.

The solution really is a "don't do it then" kind of thing. If you have 
5000 processes that all want to map a big shared memory area, and you 
don't want to upgrade your CPU's, it's a _whole_ lot easier to just have a 
magic "map_large_page()" system call, and start using the 2MB page support 
of the x86.

And no, this should NOT be a mmap.

It's a magic x86-only system call, for the express purpose of adding 
something well-contained (but really ugly) for Oracle or other similar 
users. I don't mind "really ugly" as long as it doesn't have any impact 
on the rest of the system.

It should be less than a few hundred lines of code. Suggested starting 
point appended.

Making the _generic_ code jump through hoops because some stupid special 
case that nobody else is interested in is bad. 

		Linus

--- don't look too closely or you'll go blind! ---

static unsigned long get_magic_bigpage(int idx)
{
	unsigned long bigpage;

	if (idx >= MAXBIGPAGES)
		return 0;

	down(&bigpage_sem);
	bigpage = bigpage_array[idx];
	if (bigpage)
		goto out;
	bigpage = alloc_bigpage_from_magic_zone();
	if (bigpage) {
		bigpage_users[idx] = bigpage;
		bigpage_users[idx]++;
	}
out:
	up(&bigpage_sem);
	return bigpage;
}


asmlinkage unsigned long sys_map_ugly_big_page(
	unsigned long address,
	unsigned long size, 
	unsigned long idx)
{
	/*
	 * Only root can do this, because the
	 * allocation will be non-pageable.
	 */
	if (!capable(CAP_ADMIN))
		return -EPERM;

	/*
	 * We require the user to give us the exact
	 * address, and it has to be PMD_SIZE-aligned
	 */
	if ((address|size) & (PMD_SIZE-1))
		return -EINVAL;
	if (size > TASK_SIZE || TASK_SIZE - size < address)
		return -EINVAL;
	if (!size)
		return 0;

	down_write(&current->mm->mmap_sem);
	vma = find_vma(address);
	retval = -ENOMEM;

	/* We won't unmap any existing pages */
	if (vma && vma->start < address + size)
		goto out;

	vma = kmem_cache_alloc(&vma_slab, GFP_KERNEL);
	if (!vma)
		goto out;

	vma->vm_flags = VM_MAGIC;
	retval = 0;
	do {
		bigpage = get_magic_bigpage(idx);
		if (!bigpage)
			break;
		set_pmd(pgd_offset(mm, address), pmd_bigpage(bigpoage));
		idx++;
		retval += PMD_SIZE;
		address += PMD_SIZE;
		size -= PMD_SIZE;
	} while (size);
out:
	up_write(&current->mm->mmap_sem);
	return retval;
}

