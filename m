Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263956AbSJ3EGE>; Tue, 29 Oct 2002 23:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbSJ3EGD>; Tue, 29 Oct 2002 23:06:03 -0500
Received: from packet.digeo.com ([12.110.80.53]:29109 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263956AbSJ3EF4>;
	Tue, 29 Oct 2002 23:05:56 -0500
Message-ID: <3DBF5C1C.5ACD296A@digeo.com>
Date: Tue, 29 Oct 2002 20:12:12 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll 0.14 ...
References: <3DBF581E.EAFA478A@digeo.com> <Pine.LNX.4.44.0210292008370.1457-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Oct 2002 04:12:13.0333 (UTC) FILETIME=[86505C50:01C27FCA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> On Tue, 29 Oct 2002, Andrew Morton wrote:
> 
> > I was referring to these guys:
> >
> > +#define list_first(head)     (((head)->next != (head)) ? (head)->next: (struct list_head *) 0)
> > +#define list_last(head)      (((head)->prev != (head)) ? (head)->prev: (struct list_head *) 0)
> > +#define list_next(pos, head) (((pos)->next != (head)) ? (pos)->next: (struct list_head *) 0)
> > +#define list_prev(pos, head) (((pos)->prev != (head)) ? (pos)->prev: (struct list_head *) 0)
> >
> > if we are to add such things to list.h then lots of people need
> > to hum and hah over them first and ask questions like "why doesn't
> > it use list_empty?"  ;)
> >
> > It would be better to recode epoll's list walks to use the existing
> > list accessors.
> 
> Andrew, don't they better describe what you're actually doing instead of
> the list_empty() trick ?
> 

They are a reasonable addition to the list library.  They
should be implemented as:

/*
 * kernel-doc description goes here
 */
static inline struct list_head *list_first(struct list_head *list)
{
	if (list_empty(list))
		return NULL;
	return list->next;
}

But it shouldn't be quietly snuck in as part of epoll.   Everyone in
the world uses list.h.

Given that they are used in just a handful of places in epoll and nowhere
else in the kernel it is a little hard to justify adding them.

Unless people leap out and say "I've always wanted one of them" it would
be best to redo epoll to use

	while (!list_empty(list)) {
		item = list_entry(list, ...);
		list_del(item->list);
		...
	}

or one of the other eighty-seven list helpers which we already have.
