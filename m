Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbTA1SFE>; Tue, 28 Jan 2003 13:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267487AbTA1SFE>; Tue, 28 Jan 2003 13:05:04 -0500
Received: from sophia.inria.fr ([138.96.64.20]:15496 "EHLO sophia.inria.fr")
	by vger.kernel.org with ESMTP id <S267484AbTA1SFC>;
	Tue, 28 Jan 2003 13:05:02 -0500
Message-ID: <3E36C87A.F1F172F4@sophia.inria.fr>
Date: Tue, 28 Jan 2003 19:14:18 +0100
From: David Geldreich <David.Geldreich@sophia.inria.fr>
Organization: INRIA Sophia Antipolis
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ioremap returning NULL and non-NULL for the same high 
 memory adresses
References: <3E355BAA.BF0FADC3@sophia.inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello again,

    this problem is reproducable with 2.4.20 kernel ...

    with mem=800M, ioremap returns NULL for some high adresses.
    and with mem=950M, I got the following "trap"

Jan 28 18:47:31 forceps kernel: mem1[mem1_module_init]: loading driver (dmask: 0x0)  
Jan 28 18:47:31 forceps kernel: kernel BUG at page_alloc.c:102!  
Jan 28 18:47:31 forceps kernel: invalid operand: 0000  
Jan 28 18:47:31 forceps kernel: CPU:    0  
Jan 28 18:47:31 forceps kernel: EIP:    0010:[__free_pages_ok+84/744]    Not tainted  
Jan 28 18:47:31 forceps kernel: EFLAGS: 00010282  
Jan 28 18:47:31 forceps kernel: eax: c1ae1000   ebx: c1a81280   ecx: c1a8129c   edx: c1ad8a00  
Jan 28 18:47:31 forceps kernel: esi: 00000000   edi: f7e4931c   ebp: f6e8fe74   esp: f6e8fe40  
Jan 28 18:47:31 forceps kernel: ds: 0018   es: 0018   ss: 0018  
Jan 28 18:47:31 forceps kernel: Process insmod (pid: 1247, stackpage=f6e8f000)  
Jan 28 18:47:31 forceps kernel: Stack: 000c7000 000c8000 f7e4931c 00000001 00000001 f6e8fe70 c\
0112610 c01125b0   
Jan 28 18:47:31 forceps kernel:        00000000 00000001 00000001 00400000 f6e8feb0 f6e8fe7c c\
0137617 f6e8fea8   
Jan 28 18:47:31 forceps kernel:        c01324f8 f55eadac f88c6000 00062000 f8cc6000 c0101f8c c\
0101f8c 004c6000   
Jan 28 18:47:31 forceps kernel: Call Trace:    [flush_tlb_all+20/96] [flush_tlb_all_ipi+0/76] \
[__free_pages+31/36] [vmfree_area_pages+296/380] [vfree+57/180]  
Jan 28 18:47:31 forceps kernel:   [<f88c4063>] [iounmap+25/29] [<f88c430d>] [<f88c48f3>] [<f88\
c48f3>] [<f88c4065>]  
Jan 28 18:47:31 forceps kernel:   [<f88c43c8>] [<f88c407e>] [<f88c4540>] [<f88c4065>] [free_pa\
ges+32/36] [sys_init_module+1363/1596]  
Jan 28 18:47:31 forceps kernel:   [<f88c4060>] [system_call+51/56]  
Jan 28 18:47:31 forceps kernel:   
Jan 28 18:47:31 forceps kernel: Code: 0f 0b 66 00 83 5c 29 c0 89 d8 2b 05 10 6b 38 c0 69 c0 ab\
 aa   

    Is there any documentation on how the high memory above the one reserved by mem=800M is handled ? Why ioremap
returns non NULL if I do ioremap/iounmap for each pages from 800M to 1GB and then returns NULL after some ioremapping
pages (without unmapping) from 800M to some size ?

    Thanks in advance.

David Geldreich wrote:
> 
> [1.] ioremap returning NULL and non-NULL for the same high memory adresses
> 
> [2.] some drivers uses high memory limiting the kernel usage with
> mem=800M and using the above memory. With a kernel compiled with
> CONFIG_HIGHMEM4G=y, ioremap returns NULL for some high memory
> adress where it returned a non-NULL value for the same high memory adress.
> 
> To test the available memory, the driver starts at high-memory and
> probes each page (ioremap it, write into it, read the written value,
> iounmap it). When the read value != from the written value it assumes
> that it is the end of the physical memory.
> 
> After the driver try to ioremap buffers in this high memory, for the
> first buffers ioremap returns right values but after some calls it
> returns 0x00000. In the case of mem=800M, it stops around 180M (430
> buffers of 442368 bytes) instead of the 224M free reported by the
> available memory test.
> 
> [3.] keywords: kernel, memory, ioremap
