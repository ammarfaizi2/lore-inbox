Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbUCPEwT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 23:52:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbUCPEwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 23:52:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:41417 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261578AbUCPEwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 23:52:14 -0500
Date: Mon, 15 Mar 2004 20:52:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1 - 4g patch breaks when X86_4G not selected
Message-Id: <20040315205201.7699e1c1.akpm@osdl.org>
In-Reply-To: <16470.22982.831048.924954@notabene.cse.unsw.edu.au>
References: <20040310233140.3ce99610.akpm@osdl.org>
	<16465.3163.999977.302378@notabene.cse.unsw.edu.au>
	<20040311172244.3ae0587f.akpm@osdl.org>
	<16465.20264.563965.518274@notabene.cse.unsw.edu.au>
	<20040311235009.212d69f2.akpm@osdl.org>
	<16466.57738.590102.717396@notabene.cse.unsw.edu.au>
	<16469.2797.130561.885788@notabene.cse.unsw.edu.au>
	<20040315091843.GA21587@elte.hu>
	<16470.22982.831048.924954@notabene.cse.unsw.edu.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown <neilb@cse.unsw.edu.au> wrote:
>
>  Thanks for the pointer. I now have something useful to report.
> 
>  start_kernel calls setup_arch 
>   which calls paging_init
>   which calls pagetable_init
>   which calls setup_identity_mappings
>   which calls page_address
> 
>  If I put 
>          asm("push %eax; movb $0x3,%al; outb %al,$0x61; popl %eax\n");
>  before the call to page_address, and
>          asm("push %eax; movb $0x0,%al; outb %al,$0x61; popl %eax\n");
>  afterwards, then I get a tone after boot, suggesting that page_address
>  isn't returning.
> 
>  I'm guessing that the problem is:
> 
>  page_address calls
>  	spin_lock_irqsave(&pas->lock, flags);
> 
>  but the spinlock isn't initialised by page_address_init 
>  until much later in start_kernel.

That is useful, thanks.  Sorry about the hassle.

Calling page_address_init() earlier isn't the fix though - pmd pages aren't
in highmem so we should never have got that far.  Looks like the pgd or the
pmd page contains garbage.  Did you try it without CONFIG_DEBUG_SLAB?

Nick was seeing slab 0x6b patterns on the NUMAQ, inside the pmd, so there's
some consistency there.  We do have one early setup fix from Manfred, but
it's unlikely to cure this.

I'll have a play with your .config, see if I can reproduce it.  If not I'll
squeeze off -mm3 and would ask you to retest on that if poss.

