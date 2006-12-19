Return-Path: <linux-kernel-owner+w=401wt.eu-S932831AbWLSQrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932831AbWLSQrN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 11:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932836AbWLSQrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 11:47:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44665 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932831AbWLSQrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 11:47:10 -0500
Date: Tue, 19 Dec 2006 08:46:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       andrei.popa@i-neo.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <4587B3A4.1000605@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0612190834410.3479@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost>  <20061217040620.91dac272.akpm@osdl.org>
 <1166362772.8593.2.camel@localhost>  <20061217154026.219b294f.akpm@osdl.org>
 <1166460945.10372.84.camel@twins>  <Pine.LNX.4.64.0612180933560.3479@woody.osdl.org>
  <45876C65.7010301@yahoo.com.au> <1166512923.10372.114.camel@twins>
 <45879BEF.9060001@yahoo.com.au> <Pine.LNX.4.64.0612190011170.3479@woody.osdl.org>
 <4587B3A4.1000605@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Dec 2006, Nick Piggin wrote:
> 
> Now I'm not exactly sure how ext3 (or any other) filesystems make use
> of this particular feature of try_to_free_buffers(), but it is clear
> from the comments what it is for. So your patch isn't really a minimal
> fix (ie. it would require an OK from all filesystems, wouldn't it?)
> 
> Or did I miss a mail where you reasoned that it is safe to make this
> change (/me goes to reread the thread)...

I'm saying it had _better_ be safe, and no, low-level filesystems don't 
actually matter.

The page has to be cleanable _some_ way. So if we test for "page_dirty()" 
at the top, and just refuse to do it in try_to_free_pages(), we still know 
that the _proper_ page cleaning had better clean it. Because ttfp() is 
never going to clean the page in the general case _anyway_.

So I'm really saying:

 - the page WILL be cleaned by the real page cleaning action (ie memory 
   pressure or sync or something else causing us to go through the 
   bog-standard page-based writeout.

   Does anybody dispute this?

 - the "ttfp()" hack was a HACK. It was an ugly and nasty hack even when 
   it was first introduced. It gets doubly worse now that we know we have 
   something wrong with page cleaning, and it has distracted from the real 
   problem.

 - I removed tha ugly and disgusting hack entirely at first, but Andrew 
   points out that he really wants to keep the buffers there, because the 
   buffers being clean actually say something. That, together with the 
   fact that as long as the page is dirty, the buffers really do end up 
   have a job to do, made me add a much smaller hack to replace the big 
   ugly one ("don't even try, if the page is marked dirty").

 - so with that thing in place, there isn't even any change in behaviour 
   wrt the buffers and low-level filesystems. It's just that we make them 
   a bit harder to get rid of. But arguably that shouldn't actually ever 
   really _happen_ anyway (because I think it's a BUG if the page is 
   marked dirty but none of the buffers are), so I think that part is a 
   non-issue.

In other words, ttfp() _never_ had anything to do with "page cleaning". 
Not originally, not with the horrible hack, and not with my patch. 

Trying to mix it in just caused a bug that _everybody_ agrees is a bug. 
It's not the bug we're chasing, but we've got three different patches to 
fix it (Andrew's, mine and yours), and mine is the simplest one by far 
especially in the long run, because it just REMOVES the ugly dependency.

And yes, I probably care more about "in the long run" than most. To me, a 
bug is a bug even if it's _just_ a maintenance headache. Andrews patch 
made things _worse_ ("magic insane flag"), and while yours didn't make the 
code worse, it still introduced the notion of a totally insane "clean the 
page but if the PTE's are dirty, do something else" notion.

IF THE PAGE TRULY IS CLEAN (and both you and Andrew claim it is, if all 
buffers are clean - since you mark it clean in the non-mapped case) THEN 
YOU SHOULD BE ABLE TO CLEAN THE PAGE TABLE BITS TOO.

And by claiming that the page table bits are different from PG_dirty, 
you're just making the issues worse. They shouldn't be. That's what the 
whole point of Peter's patch was: PG_dirty fundmentally _means_ that the 
page tables might be dirty too. That was the whole _point_ of doing all 
this in 2.6.19 in the first place.

So if you cannot accept that page table bits should be on "equal footing" 
with PG_dirty, then you should just say "Let's remove Peter's patch 
entirely".

		Linus
