Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVBWLjl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVBWLjl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 06:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVBWLjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 06:39:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:31953 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261463AbVBWLji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 06:39:38 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org> 
References: <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org>  <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Olof Johansson <olof@austin.ibm.com>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Wed, 23 Feb 2005 11:39:08 +0000
Message-ID: <5316.1109158748@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> That is uglee. 

True. You could just wrap it up in inline functions and hide it in a header
file as I suggested in the email I've just sent.

> We really have this already, and it's called "current->preempt". It 
> handles any lock at all, and doesn't add yet another special case to all 
> the architectures.
> 
> Just do
> 
> 	repeat:

Alternately, you could just have do_page_fault() do:

	while (!down_read_trylock(&current->mm->mmap_sem))
		continue;

However, note that this can suffer from starvation due to a never ending flow
of mixed write-locks and read-locks on other CPUs. Unlikely, true, but not
impossible.


There is yet another way, now that I think about it... Another rwsem could be
added to mm_struct, one that you have to get immediately before mmap_sem and
release immediately after; one that page fault doesn't ever touch... but that
isn't very pleasant either:-/

A yet further way would be to make a second kind of rwsem; one that's
unfair. But if you do that, a few threads that're swapping a lot, combined
with a few tops could starve out another thread that's trying to do an mmap...


Actually, there's an added benefit to your suggested method... It doesn't
involve changing what's in task_struct or mm_struct and doesn't involve
changing the semantics of the mmap_sem lock.


> That's assuming we can't just make rwsem's nest nicely.

rwsems themselves? No, not really. It'd either mean keeing track of which task
holds what sort of lock on every rwsem (which'd be nice for debugging,
granted; but not something you really want in a normal system), or it'd mean
making rwsems unfair - something I think will be a really bad idea.

David
