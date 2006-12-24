Return-Path: <linux-kernel-owner+w=401wt.eu-S1754222AbWLXJ1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbWLXJ1T (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 04:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754221AbWLXJ1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 04:27:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52909 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217AbWLXJ1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 04:27:18 -0500
Date: Sun, 24 Dec 2006 01:26:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Andrei Popa <andrei.popa@i-neo.ro>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <20061224005752.937493c8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612240115560.3671@woody.osdl.org>
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
 <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
 <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org> <20061222100004.GC10273@deprecation.cyrius.com>
 <20061222021714.6a83fcac.akpm@osdl.org> <1166790275.6983.4.camel@localhost>
 <20061222123249.GG13727@deprecation.cyrius.com> <20061222125920.GA16763@deprecation.cyrius.com>
 <1166793952.32117.29.camel@twins> <20061222192027.GJ4229@deprecation.cyrius.com>
 <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
 <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org> <20061224005752.937493c8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Dec 2006, Andrew Morton wrote:
> 
> > I now _suspect_ that we're talking about something like
> > 
> >  - we started a writeout. The IO is still pending, and the page was 
> >    marked clean and is now in the "writeback" phase.
> >  - a write happens to the page, and the page gets marked dirty again. 
> >    Marking the page dirty also marks all the _buffers_ in the page dirty, 
> >    but they were actually already dirty, because the IO hasn't completed 
> >    yet.
> >  - the IO from the _previous_ write completes, and marks the buffers clean 
> >    again.
> 
> Some things for the testers to try, please:
> 
> - mount the fs with ext2 with the no-buffer-head option.  That means either:

[ snip snip ]

This is definitely worth testing, but the exact schenario I outlined is 
probably not the thing that happens. It was really meant to be more of an 
exmple of the _kind_ of situation I think we might have.

That would explain why we didn't see this before: we simply didn't mark 
pages clean all that aggressively, and an app like rtorrent would normally 
have caused its flushes to happen _synchronously_ by using msync() (even 
if the IO itself was done asynchronously, all the dirty bit stuff would be 
synchronous wrt any rtorrent behaviour).

And the things that /did/ use to clean pages asynchronously (VM scanning) 
would always actually look at the "young" bit (aka "accessed") and not 
even touch the dirty bit if an application had accessed the page recently, 
so that basically avoided any likely races, because we'd touch the dirty 
bit ONLY if the page was "cold".

So this is why I'm saying that it might be an old bug, and it would be 
just the new pattern of handling dirty bits that triggers it.

But avoiding buffer heads and testing that part is worth doing. Just to 
remove one thing from the equation.

		Linus
