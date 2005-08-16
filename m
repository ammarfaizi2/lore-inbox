Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbVHPGR7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVHPGR7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 02:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVHPGR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 02:17:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36555 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932602AbVHPGR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 02:17:58 -0400
Date: Mon, 15 Aug 2005 23:17:49 -0700
From: Chris Wright <chrisw@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org, chrisl@vmware.com,
       hpa@zytor.com, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       pratap@vmware.com, virtualization@lists.osdl.org,
       zwane@arm.linux.org.uk
Subject: Re: [PATCH 3/6] i386 virtualization - Make ldt a desc struct
Message-ID: <20050816061749.GM7991@shell0.pdx.osdl.net>
References: <200508152259.j7FMxdh2005320@zach-dev.vmware.com> <20050816052352.GV7762@shell0.pdx.osdl.net> <43017DB1.6010506@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43017DB1.6010506@vmware.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zachary Amsden (zach@vmware.com) wrote:
> Chris Wright wrote:
> >>@@ -30,7 +33,7 @@
> >>static inline unsigned long get_desc_base(struct desc_struct *desc)
> >>{
> >>	unsigned long base;
> >>-	base = ((desc->a >> 16)  & 0x0000ffff) |
> >>+	base = (desc->a >> 16) |
> >
> >Seemingly unrelated.
> 
> Yes, alas my bucket has leaks.  I was hoping for better assembly, but 
> never got around to verifying.  So I matched this to shorter C code 
> which I had obsoleted.

OK.

> >>@@ -28,28 +28,27 @@
> >>}
> >>#endif
> >>
> >>-static inline int alloc_ldt(mm_context_t *pc, const int oldsize, int 
> >>mincount, const int reload)
> >>+static inline int alloc_ldt(mm_context_t *pc, const int old_pages, int 
> >>new_pages, const int reload)
> >>{
> >>-	void *oldldt;
> >>-	void *newldt;
> >>+	struct desc_struct *oldldt;
> >>+	struct desc_struct *newldt;
> >>
> >
> >Not quite related here (since change was introduced in earlier patch),
> >but old alloc_ldt special cased when room was available.  This is gone,
> >so am I reading this correctly, each time through it will allocate a
> >new one, and free the old one (if it existed)?  Just double checking
> >that change doesn't introduce possible mem leak.
> >
> 
> Since LDT is now in pages, it is only called when page reservation 
> increases.   I chose a slightly bad name here for new_pages.  See 
> further down:
> 
>        if (page_number >= mm->context.ldt_pages) {

OK, nice, I had missed that.

>                error = alloc_ldt(&current->mm->context, 
> mm->context.ldt_pages,
>                                        page_number+1, 1);
>                if (error < 0)
>                        goto out_unlock;
>        }
> 
> I actually had to check the code here to verify there is no leak, and I 
> don't believe I changed any semantics, but was very happy when I found this:
> 
>        if (old_pages) {
>                ClearPagesLDT(oldldt, old_pages);
>                if (old_pages > 1)
>                        vfree(oldldt);
>                else
>                        kfree(oldldt);
>        }

Yeah, I saw that bit too, so I was assuming it was OK, and wanted to
double-check.

> >>-	mincount = (mincount+511)&(~511);
> >>-	if (mincount*LDT_ENTRY_SIZE > PAGE_SIZE)
> >>-		newldt = vmalloc(mincount*LDT_ENTRY_SIZE);
> >>+	if (new_pages > 1)
> >>+		newldt = vmalloc(new_pages*PAGE_SIZE);
> >>	else
> >>-		newldt = kmalloc(mincount*LDT_ENTRY_SIZE, GFP_KERNEL);
> >>+		newldt = kmalloc(PAGE_SIZE, GFP_KERNEL);
> >
> >If so, then full page is likely to be reusable in common case, no? (If
> >there's such a thing as LDT common case ;-)
> 
> Yeah, there is no LDT common case.  This code could be made 100% optimal 
> with a lot of likely/unlikely wrappers and additional cleanup, but 
> seeing as it is already uncommon, the only worthwhile optimizations for 
> this code are ones that reduce code size or make it more readable and 
> less error prone.  I had to write a test that emits inline assembler 
> onto a crossing page boundary, clones the VM, and tests strict 
> conformance to byte/page limits to actually test this.  :)

Ouch, sounds painful ;-)

> >>	if (!newldt)
> >>		return -ENOMEM;
> >>
> >>-	if (oldsize)
> >>-		memcpy(newldt, pc->ldt, oldsize*LDT_ENTRY_SIZE);
> >>+	if (old_pages)
> >>+		memcpy(newldt, pc->ldt, old_pages*PAGE_SIZE);
> >>	oldldt = pc->ldt;
> >>	if (reload)
> >>-		memset(newldt+oldsize*LDT_ENTRY_SIZE, 0, 
> >>(mincount-oldsize)*LDT_ENTRY_SIZE);
> >>+		memset(newldt+old_pages*LDT_ENTRIES_PER_PAGE, 0, 
> >>(new_pages-old_pages)*PAGE_SIZE);
> >
> >In fact, I _think_ this causes a problem.  Who says newldt is bigger
> >than old one?  This looks like user-triggerable oops to me.
> 
> Safe -- two call sites.  One has no LDT (cloning), and the other is here:
> 
>        if (page_number >= mm->context.ldt_pages) {

Yes, thanks, as I mentioned above, that's what I was missing.

>                error = alloc_ldt(&current->mm->context, 
> mm->context.ldt_pages,
> 
> Note page_number is zero-based, ldt_pages is not.
> 
> >>@@ -113,13 +114,13 @@
> >>	unsigned long size;
> >>	struct mm_struct * mm = current->mm;
> >>
> >>-	if (!mm->context.size)
> >>+	if (!mm->context.ldt_pages)
> >>		return 0;
> >>	if (bytecount > LDT_ENTRY_SIZE*LDT_ENTRIES)
> >>		bytecount = LDT_ENTRY_SIZE*LDT_ENTRIES;
> >>
> >>	down(&mm->context.sem);
> >>-	size = mm->context.size*LDT_ENTRY_SIZE;
> >>+	size = mm->context.ldt_pages*PAGE_SIZE;
> >>	if (size > bytecount)
> >>		size = bytecount;
> >
> >This now looks like you can leak data?  Since full page is unlikely
> >used, but accounting is done in page sizes.  Asking to read_ldt with
> >bytcount of PAGE_SIZE could give some uninitialzed data back to user.
> >Did I miss the spot where this is always zero-filled?
> 
> You could leak data, but the code already takes care to zero the page.  
> This is especially important, since random present segments could allow 
> a violation of kernel security ;)

Right, good point.

>        if (reload)
>                memset(newldt+old_pages*LDT_ENTRIES_PER_PAGE, 0, 
> (new_pages-old_pages)*PAGE_SIZE);

Ah, I misread reload as being same arg as oldmode in write_ldt(), so
had myself thinking that was user controlled.

> Wow.  Thanks for a completely thorough review.  I have tested this code 
> quite intensely, but I very much appreciate having more eyes on it, 
> since it is quite a tricky biscuit.

Agreed, the more eyes the better.

thanks,
-chris
