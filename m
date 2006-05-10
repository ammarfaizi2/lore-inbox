Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751520AbWEJW6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWEJW6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751524AbWEJW6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:58:40 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:15552 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751520AbWEJW6j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:58:39 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH -mm] swsusp: support creating bigger images
Date: Thu, 11 May 2006 00:26:47 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, pavel@suse.cz
References: <200605021200.37424.rjw@sisk.pl> <200605091219.17386.rjw@sisk.pl> <Pine.LNX.4.64.0605091301140.21281@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0605091301140.21281@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605110026.48445.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 May 2006 14:30, Hugh Dickins wrote:
> On Tue, 9 May 2006, Rafael J. Wysocki wrote:
> > On Tuesday 09 May 2006 09:33, Andrew Morton wrote:
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > I have a host of minor problems with this patch.
> > > 
> > > > --- linux-2.6.17-rc3-mm1.orig/mm/rmap.c
> > > > +++ linux-2.6.17-rc3-mm1/mm/rmap.c
> > > >  
> > > > +#ifdef CONFIG_SOFTWARE_SUSPEND
> > > > +static int page_mapped_by_task(struct page *page, struct task_struct *task)
> > > > +{
> > > > +	struct vm_area_struct *vma;
> > > > +	int ret = 0;
> > > > +
> > > > +	spin_lock(&task->mm->page_table_lock);
> > > > +
> > > > +	for (vma = task->mm->mmap; vma; vma = vma->vm_next)
> > > > +		if (page_address_in_vma(page, vma) != -EFAULT) {
> > > > +			ret = 1;
> > > > +			break;
> > > > +		}
> > > > +
> > > > +	spin_unlock(&task->mm->page_table_lock);
> > > > +
> > > > +	return ret;
> > > > +}
> > > 
> > > task_struct.mm can sometimes be NULL.  This function assumes that it will
> > > never be NULL.  That makes it a somewhat risky interface.  Are we sure it
> > > can never be NULL?
> > 
> > Well, now it's only called for task == current, but I can add a check.
> 
> Better fold it into the (renamed and recommented) page_to_copy,
> applying only to current.
> 
> The "use" of page_table_lock there is totally bogus.  Normally you
> need down_read(&current->mm->mmap_sem) to walk that vma chain; but
> I'm guessing you have everything sufficiently frozen here that you
> don't need that.

So I think it can be changed into something like this:

--- linux-2.6.17-rc3-mm1.orig/mm/rmap.c	2006-05-01 14:11:50.000000000 +0200
+++ linux-2.6.17-rc3-mm1/mm/rmap.c	2006-05-10 23:10:58.000000000 +0200
@@ -857,3 +857,38 @@ int try_to_unmap(struct page *page, int 
 	return ret;
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+/**
+ *	suspend_safe_page - determine if a page can be included in the
+ *	suspend image without copying (returns true if so).
+ *
+ *	It is safe to include the page in the suspend image without
+ *	copying if (a) it's on the LRU and (b) it's mapped by a frozen task
+ *	(all tasks except for the current task should be frozen when it's
+ *	called).  Otherwise the page should be copied for this purpose
+ *	(compound pages are avoided for simplicity).
+ */
+
+int suspend_safe_page(struct page *page)
+{
+	struct vm_area_struct *vma;
+	int ret = 0;
+
+	if (!PageLRU(page) || PageCompound(page))
+		return 0;
+
+	if (page_mapped(page)) {
+		ret = 1;
+		down_read(&current->mm->mmap_sem);
+		/* Return 0 if the page is mapped by the current task */
+		for (vma = current->mm->mmap; vma; vma = vma->vm_next)
+			if (page_address_in_vma(page, vma) != -EFAULT) {
+				ret = 0;
+				break;
+			}
+		up_read(&current->mm->mmap_sem);
+	}
+
+	return ret;
+}
+#endif /* CONFIG_SOFTWARE_SUSPEND */

I've left the locking, because the functions is called when we're freeing
memory and I'm not 100% sure it's safe to drop it.

> But if it is sufficiently frozen, I'm puzzled as to why pages mapped
> into the current process are (potentially) unsafe, while those mapped
> into others are safe.  If the current process can get back to messing
> with its mapped pages, what if it maps a page you earlier judged safe?

The current task is forbidden to map anything at this point.

Greetings,
Rafael

