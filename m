Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132271AbRAXVP7>; Wed, 24 Jan 2001 16:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132438AbRAXVPu>; Wed, 24 Jan 2001 16:15:50 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:2650 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S132271AbRAXVPh>;
	Wed, 24 Jan 2001 16:15:37 -0500
Message-ID: <3A6F45F4.8020004@valinux.com>
Date: Wed, 24 Jan 2001 14:15:32 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Timur Tabi <ttabi@interactivesi.com>
CC: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
        Linux MM mailing list <linux-mm@kvack.org>
Subject: Re: Page Attribute Table (PAT) support?
In-Reply-To: <20010124174824Z129401-18594+948@vger.kernel.org> <20010124203012Z129444-18594+1042@vger.kernel.org> <20010124204811Z129375-18594+1059@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:

> ** Reply to message from Jeff Hartmann <jhartmann@valinux.com> on Wed, 24 Jan
> 2001 13:41:41 -0700
> 
> 
>> When you mark a page UCWC, you better 
>> have removed all cached mappings or your asking for REAL trouble.
> 
> 
> What exactly do you mean by "removed all cached mappings"?  Does that mean that
> if one virtual address is a UCWC mapping of a physical page, then ALL virtual
> addresses mapped to that page must also be UCWC?
> 
> In my driver, I use ioremap_nocache() on physical memory (real RAM) to create
> an uncached "alias" (a virtual address) to a physical page of RAM.  When I
> access the memory via this virtual address, the memory access is not cached.
> What I reall need is to be able to also have that virtual address as Write
> Combined.

	Pages with multiple mappings aren't really supported by the Intel ia32 
architecture.  The trick you do above works, but is strongly discouraged 
by the Intel documentation.  The documentation says that if you do this 
with UCWC memory, it won't work (and will result in undefined processor 
behavior.)  My experiments with the PAT seem to agree with the 
documentation.

> 
> Since all physical RAM is mapped as cached via the kernel (on a 1-to-1 basis),
> and since there can be several other virtual addresses that point to that memory
> (e.g. user virtual address), I can't see how these virtual addresses can be
> removed.

	We have to remove the kernel page table mappings.  (Convert the 4MB pages 
to individual pte's, then change the individual pte so its pgprot value 
is correct.)

	When you allocate memory in the kernel, you OWN it.  Its not mapped into 
a user space process unless you put it there.  I have to point out that 
this interface requires the user to insure these pages are never ever 
swapped, or mapped cached.  This isn't a huge restriction, since we 
aren't providing a user land interface.  If we try to handle all/some of 
these cases in the kernel, it becomes a very large problem.  We would 
have to add arch specific bits for special cache handling, Do smp cache 
flushes all over the place, etc.  Its really not worth it.

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
