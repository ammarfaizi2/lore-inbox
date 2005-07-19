Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVGSOVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVGSOVI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 10:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVGSOVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 10:21:08 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:52654 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261330AbVGSOVG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 10:21:06 -0400
Subject: Re: How linear address translate to physical address in
	kernel	space?
From: Steven Rostedt <rostedt@goodmis.org>
To: "liyu@WAN" <liyu@ccoss.com.cn>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <42DD029B.2000103@ccoss.com.cn>
References: <42DCE551.80104@ccoss.com.cn>
	 <1121775177.6125.28.camel@localhost.localdomain>
	 <42DD029B.2000103@ccoss.com.cn>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 19 Jul 2005 10:20:57 -0400
Message-Id: <1121782857.6019.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-19 at 21:39 +0800, liyu@WAN wrote:
> Hi:
> 
>     Thanks for steven. but I think you don't understand real intention 
> of my question.

I think I actually do. I just haven't expressed myself well enough for
you to understand :-)

> 
>     First, please allow me make a bit explain about intel architecture. 
> If it include
> any error, please tell me. 3ks.
> 

[snip explaination of intel]

> 
>     On i386 Linux, segment tranlstion just is dummy process, all logical 
> address is translated to same
> address. in other words, all segments (KERNEL_CS, KERNEL_DS, USER_DS, 
> USER_CS) have zero value base
> address.

This is used to make intel look more like other architectures.

> 
>     And we must note, in above words, the terms "logical address" , 
> "linear address" are came from intel
> architecture manual, they are not completely equal with linux kernel 
> terms. but both "linear address" are
> the most like.

I always get confused with intel's terminology.  That's why I tried to
stay with the generic physical (what the bus sees) and the virtual (what
the CPU sees).

> 
>     The paging at i386 architecture must use CR3 register, as we known, 
> at least. So in linux kernel, if it
> is going to map its "linear address" to low end physical address, it 
> also need use CR3 register. but it can
> not use CR3 directly ,in switch_mm() function at least, this function 
> will change CR3 register value to switch
> user task memory address space.

OK, I'm too lazy to go open up my Intel books (they're buried someplace,
and my online documention is too big), so I'm assuming that the CR3
register is the pointer to the Global Page Table (GPT).

> 
>     I known kernel often do not setup page table for itself, except some 
> special cases, for example, vmalloc.
> This feature say kernel use page table(and CR3) in reverse.

Lets for sake of simplicity, forget about how the kernel fills up the
entries in the GPT (can be done from page faults).

> 
>     I want to know how kernel translate itself address , especially, How 
> code after kernel change CR3 register
> work? It use CR3, or no? As steven said, I am confused here really.
> 
>     It is like kernel have many secrets I don't know. these secrets 
> drive me study it.

OK, the CR3 (If I was right in my above statement) points to the page
tables. So we have

         GPT
CR3 -> +--------+
       |        | -> user page tables.
       |        |
       |        |
       |        |
       |0xc0000 | ->  Page table of kernel
       +--------+
      
If all the user's Global page tables (GPT) has a pointer to the kernel
page table for the address of 0xc0000000 and above, then there's no
problem in switching the CR3 register.  What happens is that the user's
page tables will change. But all the user tasks have the upper address
pointing to the same address (thus the kernel), with the proper
protection bits as described earlier that say that only when the CPU is
in kernel mode does it have access to this.

I hope this helps, since I'm just about to leave to Ottawa. (See
everyone there ;-)

-- Steve


