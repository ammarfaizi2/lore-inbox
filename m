Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262347AbUKVWPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbUKVWPY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262411AbUKVWN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:13:59 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:14301 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S262347AbUKVWNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:13:08 -0500
Date: Mon, 22 Nov 2004 14:13:06 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andrew Morton <akpm@osdl.org>
cc: hugh@veritas.com, torvalds@osdl.org, benh@kernel.crashing.org,
       nickpiggin@yahoo.com.au, linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: deferred rss update instead of sloppy rss
In-Reply-To: <20041122141148.1e6ef125.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0411221408540.22895@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
 <20041122141148.1e6ef125.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Nov 2004, Andrew Morton wrote:

> hrm.  I cannot see anywhere in this patch where you update task_struct.rss.

This is just the piece around it dealing with rss. The updating of rss
happens in the generic code. The change to that is trivial. I can repost
the whole shebang if you want.

> > +	/* only holding mmap_sem here maybe get page_table_lock too? */
> > +	mm->rss += tsk->rss;
> > +	tsk->rss = 0;
> >  	up_read(&mm->mmap_sem);
>
> mmap_sem needs to be held for writing, surely?

If there are no page faults occurring anymore then we would not need to
get the lock. Q: Is it safe to assume that no faults occur
anymore at this point?

> just to prevent transient gross inaccuracies.  For some value of "16".

The page fault code only increments rss. For larger transactions that
increase / decrease rss significantly the page_table_lock is taken and
mm->rss is updated directly. So no
gross inaccuracies can result.
