Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262721AbUKZV4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbUKZV4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 16:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbUKZTvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:51:44 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4291 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262417AbUKZT3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:29:50 -0500
Date: Thu, 25 Nov 2004 15:12:42 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, bgagnon@coradiant.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@novell.com>, davem@redhat.com
Subject: Re: Memory leak in 2.4.27 kernel, using mmap raw packet sockets
Message-ID: <20041125171242.GL16633@logos.cnet>
References: <OFDDC77A23.4D34536B-ON85256F2D.00514F15-85256F2D.00517F52@coradiant.com> <20041015182352.GA4937@logos.cnet> <1097980764.13226.21.camel@localhost.localdomain> <20041125150206.GF16633@logos.cnet> <20041125203248.GD5904@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041125203248.GD5904@dualathlon.random>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Thu, Nov 25, 2004 at 09:32:48PM +0100, Andrea Arcangeli wrote:
> On Thu, Nov 25, 2004 at 01:02:06PM -0200, Marcelo Tosatti wrote:
> > On Sun, Oct 17, 2004 at 03:39:26AM +0100, Alan Cox wrote:
> > > On Gwe, 2004-10-15 at 19:23, Marcelo Tosatti wrote:
> > > > I prefer doing the "if (PageReserved(page)) put_page_testzero(page)" as
> > > > you propose instead of changing get_user_pages(), as there are several
> > > > users which rely on its behaviour.
> > > > 
> > > > I have applied your fix to the 2.4 BK tree.
> > > 
> > > That isnt sufficient. Consider anything else taking a reference to the
> > > page and the refcount going negative. And yes 2.6.x has this problem and
> > > far worse in some ways, but it also has the mechanism to fix it.
> > > 
> > > 2.6.x uses VM_IO as a VMA flag which tells the kernel two things
> > > a) get_user_pages fails on it
> > > b) core dumping of it is forbidden
> > > 
> > > 2.6.x is missing a whole pile of these (fixed in the 2.6.9-ac tree I'm
> > > putting together). I *think* remap_page_range() in 2.6.x can just set
> > > VM_IO, but older kernels didn't pass the vma so all the users would need
> > > fixing (OSS audio, media/video, usb audio, usb video, frame buffer
> > > etc).
> > 
> > I dont see any practical problem with 2.4.x right now.
> > 
> > get_user_pages() wont be called on driver created VMA's with PageReserved 
> > pages because of the VM_IO bit which is set at remap_page_range(). 
> > 
> > Its not possible to have any vma mapped by a driver without VM_IO set.
> > 
> > But the network packet mmap was an isolated case, so I'll apply Andrea's 
> > fix just for safety, although I can't find any offender in the tree.
> > 
> > 
> > --- memory.c    2004-10-22 15:58:28.000000000 -0200
> > +++ memory.c  2004-10-28 14:32:26.585813200 -0200
> > @@ -499,7 +499,7 @@
> >                                 /* FIXME: call the correct function,
> >                                  * depending on the type of the found page
> >                                  */
> > -                               if (!pages[i])
> > +                               if (!pages[i] || PageReserved(pages[i]))
> >                                         goto bad_page;
> >                                 page_cache_get(pages[i]);
> >                         }
> 
> this needs to be modified to take the ZERO_PAGE(start) into account.
> It's a minor detail, but we should allow that. (my 2.4-aa tree was
> already checking the zeropage for other reasons, so it didn't need any
> change)
> 
> in short the above fix should be modified like this:
> 
> 	if (!pages[i] || PageReserved(pages[i])) {
> 		if (pages[i] != ZERO_PAGE(start))
> 			goto bad_page;
> 	} else
> 		page_cache_get(pages[i]);
> 
> the zero page is guaranteed to remain reserved. the major bug is that
> get_user_pages was allowing _temporarily_ reserved pages to be pinned.
> __free_pages isn't checking the VM_IO, and as such get_user_pages should
> be robust against its __free_pages counterpart, this is why I believe
> the above fix is the right fix.
> 
> ZEROPAGE is special because:
> 
> 1) it's guaranteed to never be unpinned
> 2) it's the only reserved page that handle_mm_fault is allowed to
> istantiate for a filesystem data mapping
>
> The VM_IO enforcment is a nice improvement on top of the above.

get_user_pages() bails out if ! VM_IO. 

Is that what you mean with "VM_IO enforcement" ? 

> Checking the PageReserved bitflag is a good thing at least for the
> zeropage, so we don't overflow the zeropage count, which isn't nice.
> 
> If you really want to fix it only using VM_IO, I still recommend to
> apply the above patch, and to turn 'goto bad_page' into BUG().
> It'd be a bad idea not to at least add the above code as a robustness
> check.
>
> Comments welcome. thanks.

I thought about the BUG() to catch potential offenders, but I was
not sure if it was possible for a PG_reserved page to be part of VMA's 
which was being get_user_pages'd.

Now you tell me it is possible, and thats only the ZERO page. Fine. 

This is what you suggests plus some extra hopefully useful debugging 


--- memory.c.orig	2004-11-25 14:51:00.074508952 -0200
+++ memory.c	2004-11-25 15:08:38.026675776 -0200
@@ -454,8 +454,9 @@
 int get_user_pages(struct task_struct *tsk, struct mm_struct *mm, unsigned long start,
 		int len, int write, int force, struct page **pages, struct vm_area_struct **vmas)
 {
-	int i;
+	int i, s;
 	unsigned int flags;
+	struct vm_area_struct *savevma = NULL;
 
 	/*
 	 * Require read or write permissions.
@@ -463,7 +464,7 @@
 	 */
 	flags = write ? (VM_WRITE | VM_MAYWRITE) : (VM_READ | VM_MAYREAD);
 	flags &= force ? (VM_MAYREAD | VM_MAYWRITE) : (VM_READ | VM_WRITE);
-	i = 0;
+	i = s = 0;
 
 	do {
 		struct vm_area_struct *	vma;
@@ -499,9 +500,13 @@
 				/* FIXME: call the correct function,
 				 * depending on the type of the found page
 				 */
-				if (!pages[i] || PageReserved(pages[i]))
-					goto bad_page;
-				page_cache_get(pages[i]);
+				if (!pages[i] || PageReserved(pages[i])) {
+					if (pages[i] != ZERO_PAGE(start)) {
+						savevma = vma;
+						goto bad_page;
+					}
+				} else
+					page_cache_get(pages[i]);
 			}
 			if (vmas)
 				vmas[i] = vma;
@@ -520,9 +525,15 @@
 	 */
 bad_page:
 	spin_unlock(&mm->page_table_lock);
+	s = i;
 	while (i--)
 		page_cache_release(pages[i]);
-	i = -EFAULT;
+	/* catch bad uses of PG_reserved on !VM_IO vma's */
+	printk(KERN_ERR "get_user_pages PG_reserved page on"
+			"vma:%p flags:%lx page:%d\n", savevma,
+			savevma->flags, s);
+	BUG();
+	i = -EFAULT;
 	goto out;
 }
