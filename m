Return-Path: <linux-kernel-owner+w=401wt.eu-S1752648AbWLRSES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752648AbWLRSES (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 13:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbWLRSES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 13:04:18 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59195 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645AbWLRSES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 13:04:18 -0500
Date: Mon, 18 Dec 2006 10:03:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
cc: Andrew Morton <akpm@osdl.org>, andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <1166460945.10372.84.camel@twins>
Message-ID: <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrei,
 could you try Peter's patch (on top of Andrew's patch - it depends on 
it, and wouldn't work on an unmodified -git kernel, but add the WARN_ON() 
I mention in this email? You seem to be able to reproduce this easily.. 
Thanks)

On Mon, 18 Dec 2006, Peter Zijlstra wrote:
> 
> This should be safe; page_mkclean walks the rmap and flips the pte's
> under the pte lock and records the dirty state while iterating.
> Concurrent faults will either do set_page_dirty() before we get around
> to doing it or vice versa, but dirty state is not lost.

Ok, I really liked this patch, but the more I thought about it, the more I 
started to doubt the reasons for liking it.

I think we have some core fundamental problem here that this patch is 
needed at all.

So let's think about this: we apparently have two cases of 
"clear_page_dirty()":

 - the one that really wants to clear the bit unconditionally (Andrew 
   calls this the "must_clean_ptes" case, which I personally find to be a 
   really confusing name, but whatever)

 - the other case. The case that doesn't want to really clear the pte 
   dirty bits.

and I thought your patch made sense, because it saved away the pte state 
in the page dirty state, and that matches my mental model, but the more I 
think about it, the less sense that whole "the other case" situation makes 
AT ALL.

Why does "the other case" exist at all? If you want to clear the dirty 
page flag, what is _ever_ the reason for not wanting to drop PTE dirty 
information? In other words, what possible reason can there ever be for 
saying "I want this page to be clean", while at the same time saying "but 
if it was dirty in the page tables, don't forget about that state".

So I absolutely detested Andrew's original patch, because that one made 
zero sense at all even from a code standpoint. With your patch on top, it 
all suddenly makes sense: at least you don't just leave dirty pages in the 
PTE's with a "struct page" that is marked clean, and the end result is 
undeniably at least _consistent_.

So Andrew's patch I can't stand, because the whole point of it seems to be 
to leave the system in an inconsistent state (dirty in the pte's but 
marked "clean"), and if we want to have that state, then we should just 
revert _everything_ to the 2.6.18 situation, and not play these games at 
all.

Andrew's patch with your patch on top makes me happy, because now we're 
at least honoring all the basic rules (we don't get into an inconsistent 
state), so on a local level it all makes sense. HOWEVER, I then don't 
actually understand how it could ever actually make sense to ask for 
"please clean the page, but don't actually clean it".

So _I_ think that we should add a honking huge WARN_ON() for this case. 
Ie, do your patch, but instead of re-dirtying the page:

+                       if (!must_clean_ptes && cleaned)
+                               set_page_dirty(page);

we would do

+                       if (!must_clean_ptes && cleaned) {
+                               WARN_ON(1);
+                               set_page_dirty(page);
+                       }

and ask the people who see this problem to see if they get the WARN_ON() 
(assuming it _fixes_ their data corruption).

Because whoever calls "clean_dirty_page()" without actually wanting to 
clean the PTE's is really a bug: those dirty PTE's had better not exist.

Or maybe the WARN_ON() just points out _why_ somebody would want to do 
something this insane. Right now I just can't see why it's a valid thing 
to do.

Maybe I'm still confused. 

		Linus
