Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316750AbSFCNzf>; Mon, 3 Jun 2002 09:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316765AbSFCNzf>; Mon, 3 Jun 2002 09:55:35 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:48771 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S316750AbSFCNzd>; Mon, 3 Jun 2002 09:55:33 -0400
Date: Mon, 3 Jun 2002 09:55:35 -0400
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2/16] list_head debugging
Message-ID: <20020603135534.GA7668@ravel.coda.cs.cmu.edu>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CF88863.BF3AF0FA@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 01, 2002 at 01:40:03AM -0700, Andrew Morton wrote:
> The patch nulls out the dangling pointers so we get a nice oops at the
> site of the buggy code.
...
>  static __inline__ void list_del(struct list_head *entry)
>  {
>  	__list_del(entry->prev, entry->next);
> +	/*
> +	 * This is debug.  Remove it when the kernel has no bugs ;)
> +	 */
> +	entry->next = 0;
> +	entry->prev = 0;
>  }

We've had this before, and it breaks some code that removes items from
lists as follows,

    list_for_each(p, list)
	if (condition)
	    list_del(p);

These would have to either use __list_del, or need to do,

    for(p = list.next; p != &list;) {
	struct list_head *n = p->next;
	if (condition)
	    list_del(p);
	p = n;
    }

I'm not sure how many places are using the list_for_each/list_del
construction, but there were a couple when this was in the tree
previously. Converting most places that use list_del to use
list_del_init should fix the same bugs, but not cause problems for
existing code.

Just did a grep for list_del and didn't find any obvious places where we
are doing the above construction, except for drivers/isdn/capi/capilib.c
and maybe drivers/hotplug/pcihp_skeleton.c, but it could be hidden in
many more places by a macro or function call (or a larger loop than my 3
line context was showing). But there are not that many places where
we're calling list_del while not immediately re-initializing or adding
the unlinked list_head to another list.

You could probably also add list_move

    list_move(entry, head)
    {
	if (!list_empty(entry))
	    __list_del(entry->prev, entry->next);
	list_add(entry, head);
    }

And just delete list_del completely, because all existing places where
list_del is currently used should probably use either list_del_init, or
list_move.

Jan

