Return-Path: <linux-kernel-owner+w=401wt.eu-S932413AbXABSZM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbXABSZM (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 13:25:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754913AbXABSZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 13:25:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38261 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906AbXABSZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 13:25:08 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20061229200357.GA5940@elte.hu> 
References: <20061229200357.GA5940@elte.hu>  <65dd6fd50610101705t3db93a72sc0847cd120aa05d3@mail.gmail.com> <1160572460.2006.79.camel@taijtu> <65dd6fd50610111448q7ff210e1nb5f14917c311c8d4@mail.gmail.com> <65dd6fd50610241048h24af39d9ob49c3816dfe1ca64@mail.gmail.com> 
To: Ingo Molnar <mingo@elte.hu>
Cc: Ollie Wild <aaw@google.com>, linux-kernel@vger.kernel.org,
       parisc-linux@lists.parisc-linux.org, Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-mm@kvack.org,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-arch@vger.kernel.org, David Howells <dhowells@redhat.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [patch] remove MAX_ARG_PAGES 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 02 Jan 2007 18:18:48 +0000
Message-ID: <23996.1167761928@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:

> FYI, i have forward ported your MAX_ARG_PAGES limit removal patch to 
> 2.6.20-rc2 and have included it in the -rt kernel. It's working great - 
> i can now finally do a "ls -t patches/*.patch" in my patch repository - 
> something i havent been able to do for years ;-)

I get a NULL kernel pointer reference with this patch with FRV in MMU mode.
It's whilst the kernel is attempting to execute init:

(gdb) bt
#0  0xc0063d54 in do_anonymous_page (mm=0xc05c1a04, vma=0xc05c884c, address=3221225457, page_table=0xdc00bffc, pmd=0xc05c6f00, write_access=0) at pgtable.h:525
#1  0xc006468c in __handle_mm_fault (mm=0xbffffff1, vma=0xc05c884c, address=3691036668, write_access=1) at memory.c:2404
#2  0xc0061c18 in get_user_pages (tsk=0xc034eba0, mm=0xc05c1a04, start=3221225457, len=1, write=1, force=0, pages=0xc0353b80, vmas=0x0) at memory.c:1064
#3  0xc0084c7c in copy_strings (argc=0, argv=0xc0388c3c, bprm=0xc0388b88) at exec.c:326
#4  0xc0084dac in copy_strings_kernel (argc=1, argv=0xc05c884c, bprm=0xbffffff1) at exec.c:365
#5  0xc0085f5c in do_execve (filename=0xc0387000 "/sbin/init", argv=0xc026e8c8, envp=0xc026e950, regs=0xc0353bf8) at exec.c:1158
#6  0xc000f55c in sys_execve (name=0x1 <Address 0x1 out of bounds>, argv=0xc026e8c8, envp=0xc026e950) at process.c:263
#7  0xc000e1e0 in __syscall_call () at arch/frv/kernel/entry.S:878
#8  0xc000e1e0 in __syscall_call () at arch/frv/kernel/entry.S:878

The problem appears to be that current->mm is NULL.  It's a bit difficult to
say for sure because gdb or gcc determined that the error is in pgtable.h, but
doesn't seem to have determined which one.

However, looking at the code, I think it must be this:

	static int do_anonymous_page(struct mm_struct *mm, ...)
	{
		...
		update_mmu_cache(vma, address, entry);
		...
	}

But that uses current->mm, which is NULL, via this function:

	[include/asm-frv/pgtable.h]

	/* * preload information about a newly instantiated PTE into the SCR0/SCR1 PGE
	cache */

	static inline void update_mmu_cache(struct vm_area_struct *vma,
					unsigned long address, pte_t pte)
	{
		unsigned long ampr;
		pgd_t *pge = pgd_offset(current->mm, address);
		pud_t *pue = pud_offset(pge, address);
		pmd_t *pme = pmd_offset(pue, address);

		ampr = pme->ste[0] & 0xffffff00;
		ampr |= xAMPRx_L | xAMPRx_SS_16Kb | xAMPRx_S | xAMPRx_C | xAMPRx_V;

		asm volatile("movgs %0,scr0\n"
			     "movgs %0,scr1\n"
			     "movgs %1,dampr4\n"
			     "movgs %1,dampr5\n"
			     :
			     : "r"(address), "r"(ampr)
			     );
	}

This really oughtn't to be called in this situation, I suspect.  I could just
skip the operation if current->mm is NULL, but I'm not sure that that's the
right thing to do.  Maybe I should be using current->active_mm instead.

Everything works fine without the patch.

David
