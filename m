Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267470AbTACJSI>; Fri, 3 Jan 2003 04:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbTACJSI>; Fri, 3 Jan 2003 04:18:08 -0500
Received: from packet.digeo.com ([12.110.80.53]:24035 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267470AbTACJSH>;
	Fri, 3 Jan 2003 04:18:07 -0500
Message-ID: <3E155747.6894A289@digeo.com>
Date: Fri, 03 Jan 2003 01:26:31 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dada1 <dada1@cosmosbay.com>, William Lee Irwin III <wli@holomorphy.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: Linux v2.5.54
References: <00fe01c2b303$c3e67790$760010ac@edumazet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jan 2003 09:26:31.0886 (UTC) FILETIME=[33BCEEE0:01C2B30A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dada1 wrote:
> 
> >   o remove hugetlb syscalls
> 
> So finally they did it ...
> 
> But mmap(NULL, ...) is not yet supported, this is really sad.

Bill, this appears to be a matter of implementing a suitable ->get_unmapped_area()
within hugetlbfs?

> And arch/i386/Kconfig and Documentation/vm/hugetlbpage.txt still document
> the sys_alloc_hugepages()/sys_free_hugepages() syscalls.

OK.
 
> A simple program that doesnt know at all how the memory is layed out by
> kernel/glibc can not easily get some 4Mo pages in a single syscall.
> sys_alloc_hugepage() was very convenient for that.

Well.  One would expect userspace library functions to emerge.  The
glibc people take patches.

 
> Another problem :
> 
> if you mount hugetlbfs in /huge, then create a file /huge/BIG of size 4Mo,
> then use :
> 
> dd if=/huge/BIG of=/dev/null
> 
> the dd process hangs on 'D' state : the read() syscall just hang forever.
> 

erk.  Thanks.

--- 25/fs/hugetlbfs/inode.c~hugetlbfs_readpage-fix	Fri Jan  3 01:04:42 2003
+++ 25-akpm/fs/hugetlbfs/inode.c	Fri Jan  3 01:04:49 2003
@@ -79,6 +79,7 @@ static int hugetlbfs_file_mmap(struct fi
  */
 static int hugetlbfs_readpage(struct file *file, struct page * page)
 {
+	unlock_page(page);
 	return -EINVAL;
 }
