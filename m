Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263407AbUCPBmf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263400AbUCPBmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:42:14 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:46759 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S263387AbUCPBfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 20:35:14 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Ingo Molnar <mingo@elte.hu>
Date: Tue, 16 Mar 2004 12:35:02 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16470.22982.831048.924954@notabene.cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1 - 4g patch breaks when X86_4G not selected
In-Reply-To: message from Ingo Molnar on Monday March 15
References: <20040310233140.3ce99610.akpm@osdl.org>
	<16465.3163.999977.302378@notabene.cse.unsw.edu.au>
	<20040311172244.3ae0587f.akpm@osdl.org>
	<16465.20264.563965.518274@notabene.cse.unsw.edu.au>
	<20040311235009.212d69f2.akpm@osdl.org>
	<16466.57738.590102.717396@notabene.cse.unsw.edu.au>
	<16469.2797.130561.885788@notabene.cse.unsw.edu.au>
	<20040315091843.GA21587@elte.hu>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 15, mingo@elte.hu wrote:
> 
> * Neil Brown <neilb@cse.unsw.edu.au> wrote:
> 
> > And it turns out it was spot on. Applying 4g-2.6.0-test2-mm2-A5.patch
> > (on top of preceding -mm1 patches) causes my server not to boot.
> 
> hm. Since your .config boots on akpm's box, this is some BIOS dependency
> creating an early-boot problem i fear. Debugging such bugs is hard. One 
> way would be via the PC speaker:
> 
> 	movb $0x3,%al; outb %al,$0x61
> 
> this will cause a continuous beep on a typical PC - it works in 16-bit
> code too, doesnt have any memory-model assumptions, etc.
> 
> the first place to put this would be startup_32 - do we get to this
> point at all? (check CONFIG_4G first, to make sure the beep triggers.) 
> If it beeps, then move it down until you find the place that crashes.
> 
> 	Ingo

Thanks for the pointer. I now have something useful to report.

start_kernel calls setup_arch 
 which calls paging_init
 which calls pagetable_init
 which calls setup_identity_mappings
 which calls page_address

If I put 
        asm("push %eax; movb $0x3,%al; outb %al,$0x61; popl %eax\n");
before the call to page_address, and
        asm("push %eax; movb $0x0,%al; outb %al,$0x61; popl %eax\n");
afterwards, then I get a tone after boot, suggesting that page_address
isn't returning.

I'm guessing that the problem is:

page_address calls
	spin_lock_irqsave(&pas->lock, flags);

but the spinlock isn't initialised by page_address_init 
until much later in start_kernel.

NeilBrown
