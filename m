Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbSLIPRM>; Mon, 9 Dec 2002 10:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbSLIPRM>; Mon, 9 Dec 2002 10:17:12 -0500
Received: from sccrmhc03.attbi.com ([204.127.202.63]:26821 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S265637AbSLIPRL>; Mon, 9 Dec 2002 10:17:11 -0500
Message-ID: <3DF4B5C1.D36D4CCF@attbi.com>
Date: Mon, 09 Dec 2002 10:24:49 -0500
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: akpm@digeo.com, linux-kernel@vger.kernel.org, george@mvista.com
Subject: Re: [PATCH 3/3] High-res-timers part 3 (posix to hrposix) take 20
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Maybe I'm thick, but this whole id_resue layer seems rather obscure.
> 
> As it is being positioned as a general-purpose utility it needs
> API documentation as well as a general description.

Hi Andrew, George, Everyone,

This is derived from my "alternate Posix timers" patch.  It 
was intended to be a general purpose allocator and lookup
for user space ids (e.g. pids, timer_ids, msg_ids).
It uses a radix tree as a sparse array to map a user id value
to a kernel pointer.  In my version it did pid style allocation
avoiding immediate reuse of the same id values.  The goals
were to avoid hardwired limits, be memory efficient and fast.

I got started on this before Ingo did his magic for hashing
pids.  I prototyped in user space and did a quick hack to
make it work in the kernel.  Yes, it uses a recursive approach
for the allocate and remove path.  The recursion is limited 
to only a few levels and the stack frame is tiny.  For example
if there are 1000000 ids it will have 6 levels of recursion.

Here is my version of this interface:

void *id2ptr_lookup(struct id *idp, int id)

	This looks up the user id value in the idp name space
	and returns the associated kernel pointer.

int id2ptr_new(struct id *idp, void *ptr)

	This allocates and returns a new id and stores the 
	ptr value in the sparse array

void id2ptr_remove(struct id *idp, int id)

	removes the id from the idp name space.

void id2ptr_init(struct id *idp, int min_wrap)

	Initializes the idp name space.  The min_wrap value
	determines when to start reusing id values.

I think what I have done is useful and useable.  If/when I do 
this again I would separate growing the tree from the id
allocation.  I think this would avoid needing to keep 
the free list of preallocated memory.

Jim Houston - Concurrent Computer Corp.
