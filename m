Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267166AbTACJrj>; Fri, 3 Jan 2003 04:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267306AbTACJrj>; Fri, 3 Jan 2003 04:47:39 -0500
Received: from holomorphy.com ([66.224.33.161]:54984 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267166AbTACJri>;
	Fri, 3 Jan 2003 04:47:38 -0500
Date: Fri, 3 Jan 2003 01:55:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: dada1 <dada1@cosmosbay.com>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Linux v2.5.54
Message-ID: <20030103095541.GB9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, dada1 <dada1@cosmosbay.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <00fe01c2b303$c3e67790$760010ac@edumazet> <3E155747.6894A289@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E155747.6894A289@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dada1 wrote:
>> So finally they did it ...
>> But mmap(NULL, ...) is not yet supported, this is really sad.

On Fri, Jan 03, 2003 at 01:26:31AM -0800, Andrew Morton wrote:
> Bill, this appears to be a matter of implementing a suitable
> ->get_unmapped_area() within hugetlbfs?

At the time of hugetlbfs' integration, it was desirable to be
minimalistic and the additional logic for placement had no clear
motivation, as both privilege and great self-awareness were assumed
of the applications using hugetlbfs. Since then, it's become apparent
that this placement logic is a requirement for userspace support.

Apologies in advance for great tardiness; however, I'll send in patches
implementing in-kernel automatic hugetlb vma placement within 36 hours.


dada1 wrote:
>> And arch/i386/Kconfig and Documentation/vm/hugetlbpage.txt still document
>> the sys_alloc_hugepages()/sys_free_hugepages() syscalls.

Documentation updates are also essential, they will also follow shortly,
in tandem with the automatic vma placement.


dada1 wrote:
>> A simple program that doesnt know at all how the memory is layed out by
>> kernel/glibc can not easily get some 4Mo pages in a single syscall.
>> sys_alloc_hugepage() was very convenient for that.

On Fri, Jan 03, 2003 at 01:26:31AM -0800, Andrew Morton wrote:
> Well.  One would expect userspace library functions to emerge.  The
> glibc people take patches.

Ulrich Drepper has already accepted a glibc patch integrating the
SHM_HUGETLB flag into glibc. dada1, I'm hopeful your distribution will
provide you with an upgrade path to a glibc version implementing it soon,
or that you'll otherwise be able to upgrade to a cvs glibc version.


dada1 wrote:
>> Another problem :
>> if you mount hugetlbfs in /huge, then create a file /huge/BIG of size 4Mo,
>> then use :
>> dd if=/huge/BIG of=/dev/null
>> the dd process hangs on 'D' state : the read() syscall just hang forever.

On Fri, Jan 03, 2003 at 01:26:31AM -0800, Andrew Morton wrote:
> erk.  Thanks.
> --- 25/fs/hugetlbfs/inode.c~hugetlbfs_readpage-fix	Fri Jan  3 01:04:42 2003
> +++ 25-akpm/fs/hugetlbfs/inode.c	Fri Jan  3 01:04:49 2003
> @@ -79,6 +79,7 @@ static int hugetlbfs_file_mmap(struct fi
>   */
>  static int hugetlbfs_readpage(struct file *file, struct page * page)
>  {
> +	unlock_page(page);
>  	return -EINVAL;
>  }

This fix is trivially correct; thanks for finding and addressing it.
Linus, please apply.


Thanks for the testing, bugreports, and fixes!


Thanks,
Bill
