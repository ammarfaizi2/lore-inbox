Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWGOT5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWGOT5u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 15:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWGOT5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 15:57:50 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:62628 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030255AbWGOT5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 15:57:50 -0400
Date: Sat, 15 Jul 2006 15:54:35 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: memory corruptor in .18rc1-git
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, Willy Tarreau <w@1wt.eu>
Message-ID: <200607151556_MC3-1-C510-CFA2@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060714043112.GA20478@redhat.com>

On Fri, 14 Jul 2006 00:31:12 -0400, Dave Jones wrote:

> +/**
> + * list_add - add a new entry
> + * @new: new entry to be added
> + * @head: list head to add it after
> + *
> + * Insert a new entry after the specified head.
> + * This is good for implementing stacks.
> + */
> +void list_add(struct list_head *new, struct list_head *head)
> +{
> +     if (head->next->prev != head) {
> +             printk("List corruption. next->prev should be %p, but was %p\n",
> +                     head, head->next->prev);
> +             BUG();
> +     }
> +     if (head->prev->next != head) {
> +             printk("List corruption. prev->next should be %p, but was %p\n",
> +                     head, head->prev->next);
> +             BUG();
> +     }
> +
> +     __list_add(new, head, head->next);
> +}
> +EXPORT_SYMBOL(list_add);
> +
> +/**
> + * list_del - deletes entry from list.
> + * @entry: the element to delete from the list.
> + * Note: list_empty on entry does not return true after this, the entry is
> + * in an undefined state.
> + */
> +void list_del(struct list_head *entry)
> +{
> +     if (entry->prev->next != entry) {
> +             printk("List corruption. prev->next should be %p, but was %p\n",
> +                     entry, entry->prev->next);
> +             BUG();
> +     }
> +     if (entry->next->prev != entry) {
> +             printk("List corruption. next->prev should be %p, but was %p\n",
> +                     entry, entry->next->prev);
> +             BUG();
> +     }
> +     __list_del(entry->prev, entry->next);
> +     entry->next = LIST_POISON1;
> +     entry->prev = LIST_POISON2;
> +}
> +EXPORT_SYMBOL(list_del);
> +
>

Shouldn't those four 'if' statements use unlikely()?  There's no sense
causing more slowdown than necessary, even in debug code.

And I'd change the messages slightly, e.g.:

        "list_add: corruption: next->prev should be %p, was %p\n"

Some people build (accidentally?) without verbose debug info and
don't get line numbers.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
