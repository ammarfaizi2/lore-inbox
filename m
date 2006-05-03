Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964960AbWECBU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964960AbWECBU6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 21:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965064AbWECBU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 21:20:57 -0400
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:50025 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S964960AbWECBU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 21:20:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=eQtugmXpO5Gcb3sUtVT4pgreWeeHSnYOzkMYLAdU9p3m7VOP3jQmHyGR7QrxEGtrSDuu2PyDvPsw127ygbuwkAiRDC4+f/u7sgmgKIlXfjoiTbiJxwXXx7dzJmlIWJwFn+AkcRmavhJ589nug/vTiAxE74doy3AcrP+f91yXXDs=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
Subject: Re: [patch 00/14] remap_file_pages protection support
Date: Wed, 3 May 2006 03:20:48 +0200
User-Agent: KMail/1.8.3
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Ulrich Drepper <drepper@redhat.com>, Val Henson <val.henson@intel.com>
References: <20060430172953.409399000@zion.home.lan> <4456D5ED.2040202@yahoo.com.au> <1146590207.5202.17.camel@localhost.localdomain>
In-Reply-To: <1146590207.5202.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605030320.50055.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 19:16, Lee Schermerhorn wrote:
> On Tue, 2006-05-02 at 13:45 +1000, Nick Piggin wrote:
> > blaisorblade@yahoo.it wrote:

> > I think I would rather this all just folded under VM_NONLINEAR rather
> > than having this extra MANYPROTS thing, no? (you're already doing that in
> > one direction).

> One way I've seen this done on other systems

I'm curious, which ones?

> is to use something like a 
> prio tree [e.g., see the shared policy support for shmem] for sub-vma
> protection ranges.
Which sub-vma ranges? The ones created with mprotect?

I'm curious about what is the difference between this sub-tree and the main 
tree... you have some point, but I miss which one :-) Actually when doing a 
lookup in the main tree the extra nodes in the subtree are not searched, so 
you get an advantage.

One possible point is that a VMA maps to one mmap() call (with splits from 
mremap(),mprotect(),partial munmap()s), and then they use sub-VMAs instead of 
VMA splits.

> Most vmas [I'm guessing here] will have only the 
> original protections or will be reprotected in toto.

> So, one need only 
> allocate/populate the protection tree when sub-vma protections are
> requested.   Then, one can test protections via the vma, perhaps with
> access/check macros to hide the existence of the protection tree.  Of
> course, adding a tree-like structure could introduce locking
> complications/overhead in some paths where we'd rather not [just
> guessing again].  Might be more overhead than just mucking with the ptes
> [for UML], but would keep the ptes in sync with the vma's view of
> "protectedness".
>
> Lee

Ok, there are two different situations, I'm globally unconvinced until I 
understand the usefulness of a different sub-tree.

a) UML. The answer is _no_ to all guesses, since we must implement page tables 
of a guest virtual machine via mmap() or remap_file_pages. And they're as 
fragmented as they get (we get one-page-wide VMAs currently).

b) the proposed glibc usage. The original Ulrich's request (which I cut down 
because of problems with objrmap) was to have one mapping per DSO, including 
code,data and guard page. So you have three protections in one VMA.

However, this is doable via this remap_file_pages, adding something for 
handling private VMAs (handling movement of the anonymous memory you get on 
writes); but it's slow on swapout, since it stops using objrmap. So I've not 
thought to do it.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
