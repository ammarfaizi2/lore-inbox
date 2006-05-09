Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWEJB65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWEJB65 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 21:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWEJB65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 21:58:57 -0400
Received: from silver.veritas.com ([143.127.12.111]:64320 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751181AbWEJB6z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 21:58:55 -0400
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.05,107,1146466800"; 
   d="scan'208"; a="38018411:sNHT37932684"
Date: Tue, 9 May 2006 13:30:48 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, pavel@suse.cz
Subject: Re: [PATCH -mm] swsusp: support creating bigger images
In-Reply-To: <200605091219.17386.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.64.0605091301140.21281@blonde.wat.veritas.com>
References: <200605021200.37424.rjw@sisk.pl> <20060509003334.70771572.akpm@osdl.org>
 <200605091219.17386.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 10 May 2006 01:58:55.0009 (UTC) FILETIME=[4AFEF910:01C673D5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2006, Rafael J. Wysocki wrote:
> On Tuesday 09 May 2006 09:33, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > I have a host of minor problems with this patch.
> > 
> > > --- linux-2.6.17-rc3-mm1.orig/mm/rmap.c
> > > +++ linux-2.6.17-rc3-mm1/mm/rmap.c
> > >  
> > > +#ifdef CONFIG_SOFTWARE_SUSPEND
> > > +static int page_mapped_by_task(struct page *page, struct task_struct *task)
> > > +{
> > > +	struct vm_area_struct *vma;
> > > +	int ret = 0;
> > > +
> > > +	spin_lock(&task->mm->page_table_lock);
> > > +
> > > +	for (vma = task->mm->mmap; vma; vma = vma->vm_next)
> > > +		if (page_address_in_vma(page, vma) != -EFAULT) {
> > > +			ret = 1;
> > > +			break;
> > > +		}
> > > +
> > > +	spin_unlock(&task->mm->page_table_lock);
> > > +
> > > +	return ret;
> > > +}
> > 
> > task_struct.mm can sometimes be NULL.  This function assumes that it will
> > never be NULL.  That makes it a somewhat risky interface.  Are we sure it
> > can never be NULL?
> 
> Well, now it's only called for task == current, but I can add a check.

Better fold it into the (renamed and recommented) page_to_copy,
applying only to current.

The "use" of page_table_lock there is totally bogus.  Normally you
need down_read(&current->mm->mmap_sem) to walk that vma chain; but
I'm guessing you have everything sufficiently frozen here that you
don't need that.

But if it is sufficiently frozen, I'm puzzled as to why pages mapped
into the current process are (potentially) unsafe, while those mapped
into others are safe.  If the current process can get back to messing
with its mapped pages, what if it maps a page you earlier judged safe?

Hugh
