Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVGSNkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVGSNkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 09:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVGSNkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 09:40:40 -0400
Received: from [210.76.114.20] ([210.76.114.20]:29077 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S261229AbVGSNki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 09:40:38 -0400
Message-ID: <42DD029B.2000103@ccoss.com.cn>
Date: Tue, 19 Jul 2005 21:39:39 +0800
From: "liyu@WAN" <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How linear address translate to physical address in kernel	space?
References: <42DCE551.80104@ccoss.com.cn> <1121775177.6125.28.camel@localhost.localdomain>
In-Reply-To: <1121775177.6125.28.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

    Thanks for steven. but I think you don't understand real intention 
of my question.

    First, please allow me make a bit explain about intel architecture. 
If it include
any error, please tell me. 3ks.

    On i386, that all addresses can be used directly in program, is 
called "logical address",
logical address include a pointer(16bit) to segment descriptor table and 
one offset(32bit).
the logical address must be pass segment translation. this process use 
segment descriptor in
GDT or LDT (Global/Local segment Descriptor Table).  Each segment 
descriptor includes
one base address of the segment, then, the offset in "logical address" 
and this base address
will combine "linear address", if we disable paging, this linear address 
just is physcial address.
however, if we enable great paging, it still need do paging translate to 
physical address yet.
In paging process, CR3 register take one important role, it include page 
table directory base address.

    On i386 Linux, segment tranlstion just is dummy process, all logical 
address is translated to same
address. in other words, all segments (KERNEL_CS, KERNEL_DS, USER_DS, 
USER_CS) have zero value base
address.

    And we must note, in above words, the terms "logical address" , 
"linear address" are came from intel
architecture manual, they are not completely equal with linux kernel 
terms. but both "linear address" are
the most like.

    The paging at i386 architecture must use CR3 register, as we known, 
at least. So in linux kernel, if it
is going to map its "linear address" to low end physical address, it 
also need use CR3 register. but it can
not use CR3 directly ,in switch_mm() function at least, this function 
will change CR3 register value to switch
user task memory address space.

    I known kernel often do not setup page table for itself, except some 
special cases, for example, vmalloc.
This feature say kernel use page table(and CR3) in reverse.

    I want to know how kernel translate itself address , especially, How 
code after kernel change CR3 register
work? It use CR3, or no? As steven said, I am confused here really.

    It is like kernel have many secrets I don't know. these secrets 
drive me study it.

    3ks in advanced.


                                                                         
         liyu/NOW~








   




   



   









Steven Rostedt wrote:

>Hi Liyu,
>
>I'm not that strong in the Intel world, but after all the fancy
>registers, intel is not much different than say PPC. So I'll keep this
>more of a generic platform discussion, and only talk about physical and
>virtual address space.
>
>The kernel is usually mapped down to the lower end of memory, which in
>most platforms starts at physical address zero (I've worked with
>platforms that don't do this, but that's offtopic). Then the kernel maps
>this physical location to some upper address (with intel it's usually
>0xc0000000).
>
>All the user space addresses are mapped below this kernel address. Now
>the magic here, and it probably confuses you, is that all
>tasks/processes have the kernel address mapped to the same location.  So
>on context switches, the kernel is still in the same location in virtual
>address.  It's just that when the CPU is in user mode, the kernel
>address is protected from being read or written to. So if a user space
>process tries to write or read from it (like *(char*)(0xc0000000) = 1;)
>it will get a page fault. But when the CPU switches to kernel mode
>(through a system call or interrupt), it has full access to this area.
>
>So you have this mapping:
>
>             Physical               Virtual
>0x00000000  ------------          -------------
>            | kernel   | --+      |  user      |
>            |          |   |      |            | 
>            +----------+   |      |            |
>            | general  |   |      |            |
>            | memory   |   |      |            |
>            .          .   |      .            .
>            .          .   |      .            . 
>            | end of   |   |      |            |
>            | memory   |   |      |            |
>            +----------+   |      |            |
>            |          |   +--->  +------------+ 0xc0000000
>            |          |          |  kernel    |
>            .          .          .            .
>            .          .          .            .
>
>Usually all of memory is mapped to the address 0xc0000000. But this
>becomes a problem when you have a gig or more of RAM.  Since you run out
>of virtual space to map there. And you still need room to map device
>memory as well (you can't have user space conflicting with devices). So
>if you have a lot of RAM, you need to turn on highmem support, which
>then plays around to get memory above a certain point. But that's
>another discussion.
>
>So to access physical memory from the kernel, you can use __pa and back
>with __va.  These are used to communicate with devices usually, which
>are also mapped to some location.  But these only work when the mapping
>is direct as show above. When highmem support is on, you can't get to
>memory that is not mapped in. But there's no need to use __pa or __va to
>get to memory just for itself.  Usually they are used when dealing with
>devices that have DMA or some other need to find a physical address. If
>a device needs to write to memory (usually only knowing about the
>physical location of the memory) you get that memory with GFP_DMA flag,
>which guarantees that you will get memory that is mapped directly.
>
>-- Steve
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

