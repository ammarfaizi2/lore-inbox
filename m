Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319428AbSH3E7t>; Fri, 30 Aug 2002 00:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319429AbSH3E7s>; Fri, 30 Aug 2002 00:59:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33807 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319428AbSH3E7s>; Fri, 30 Aug 2002 00:59:48 -0400
Date: Thu, 29 Aug 2002 22:10:53 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: linux-mm@kvack.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: weirdness with ->mm vs ->active_mm handling
In-Reply-To: <20020829193413.H17288@redhat.com>
Message-ID: <Pine.LNX.4.44.0208292206130.1336-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Aug 2002, Benjamin LaHaise wrote:
> 
> In trying to track down a bug, I found routines like generic_file_read 
> getting called with current->mm == NULL.  This seems to be a valid state 
> for lazy tlb tasks, but the code throughout the kernel doesn't seem to 
> assume that.

Hmm.. Have you actually ever seen this?

When tsk->mm is NULL, you should never EVER get a page fault, except for 
the one special case of the vmalloc'ed area (which is tested for in 
do_page_fault() before we even _look_ at "tsk->mm").

In fact, do_page_fault() very much checks

	if (in_atomic() || !mm)
		goto no_context;  

which says that a page fault when in a lazy TLB context should always
cause a trap, killing the thing (or, if the access has a fixup, calling
the fixup - although I don't think that should happen in any normal code)

In other words: I think your patch is "functionally correct", in that it
should work fine, but on the other hand having a NULL tsk->mm and trying
to do any user-level access is _so_ wrong that I'd much rather take a NULL
pointer fault than try to do something "sane" about it.

		Linus

