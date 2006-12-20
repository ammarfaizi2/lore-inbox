Return-Path: <linux-kernel-owner+w=401wt.eu-S1030275AbWLTTB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030275AbWLTTB7 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030280AbWLTTB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:01:59 -0500
Received: from smtp.osdl.org ([65.172.181.25]:56719 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030275AbWLTTB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:01:58 -0500
Date: Wed, 20 Dec 2006 11:01:13 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Michlmayr <tbm@cyrius.com>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <20061220175309.GT30106@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
 <1166571749.10372.178.camel@twins> <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
 <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org>
 <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
 <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Martin Michlmayr wrote:
> 
> > Anyway, the page_mkclean_one() fixes (along with _most_ things we've
> > looked at) shouldn't matter on UP, at least certainly not without
> > PREEMPT.
> 
> Hmm.  So what about UP without PREEMPT then...

So that's why I've been harping on the fact that I think we simply do 
really wrong things with PG_dirty at times, and that I find it confusing 
that there's

 - clear_page_dirty_for_io(): this one makes sense. The name makes sense, 
   and the implementation makes sense (which is _not_ the same thing as 
   "works", of course - "makes sense" does not mean "no bugs" ;).

 - test_clear_page_dirty: this one makes no sense WHATSOEVER, except as a 
   buggy way to do the "_for_io()" case.. This makes sense neither from a 
   concept angle _or_ an implementation angle (the whole "test_" part is 
   nonsense: why would anybody care? What operation does this? What can it 
   do if the page is dirty? It also has no sensible thing it can do to the 
   page tables.

 - clear_page_dirty(): this one makes sense only as a "cancel" operation, 
   for vmtruncate and friends (it's different from the "_for_io()" case in 
   several ways:
	(a) we should have unmapped such pages forcibly _anyway_, so 
	    looking at the PTE's make no sense.
	(b) because we're not starting IO, we don't have the "mark for 
	    writeback" case, and we need to clear the dirty tags from the 
	    radix trees etc since the writeback logic won't do it for us.
   The _implementation_ of "clear_page_dirty()" doesn't make sense, but 
   the concept does.

I've repeated that theory a few times, but neither Andrew nor Nick seem to 
really believe in it. So I'll just repeat it once more, only to be shot 
down. I think we have three operations, one of which is totally idiotic 
and senseless, and one of which is just badly implemented.

> Maybe the following information is helpful in some way: remember how I
> said that we have applied 6 mm patches to 2.6.18 in Debian?  According
> to Gordon Farquharson, who's helping me a great deal with testing
> installation on this ARM machine (Linksys NSLU2), the corruption
> doesn't always show up when you only apply
> mm-tracking-shared-dirty-pages.patch to 2.6.18 but it shows up all the
> time with all six patches applied.

I think the "it hapepns occasionally with just the first patch" is the 
really important part. The other patches really are likely to just change 
writeback timing behaviour (_especially_ the "tracking-shared-dirty-pages" 
patch), but if it happens occasionally even with the first one, that's the 
one that almost certainly introduced the real problem.

And my argument above is actually that the "real problem" goes a hell of a 
lot further back in time, but it didn't use to be a problem because we 
just considered dirty bits in the page tables to be something _completely_ 
independent of the "page dirty" status, so historically, it just didn't 
matter that we had insane implementations and senseless operations.

			Linus
