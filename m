Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751619AbWEaQAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbWEaQAd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 12:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbWEaQAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 12:00:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37851 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751619AbWEaQAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 12:00:33 -0400
Date: Wed, 31 May 2006 08:57:14 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: linux-kernel@vger.kernel.org, hugh@veritas.com, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: <447DB765.6030702@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0605310840000.24646@g5.osdl.org>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org>
 <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org>
 <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
 <447BD31E.7000503@yahoo.com.au> <447BD63D.2080900@yahoo.com.au>
 <Pine.LNX.4.64.0605301041200.5623@g5.osdl.org> <447CE43A.6030700@yahoo.com.au>
 <Pine.LNX.4.64.0605301739030.24646@g5.osdl.org> <447D9A41.8040601@yahoo.com.au>
 <Pine.LNX.4.64.0605310740530.24646@g5.osdl.org> <447DAEDE.5070305@yahoo.com.au>
 <Pine.LNX.4.64.0605310809250.24646@g5.osdl.org> <447DB765.6030702@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Jun 2006, Nick Piggin wrote:
> 
> You're really keen on unplugging at the point of waiting. I don't get
> it.

Actually, no. I'm _not_ really keen on unplugging at the point of waiting.

I'm keen on unplugging at a point that makes sense, and is safe.

The problem is, you're not even exploring alternatives. Where the hell 
_would_ you unplug it?

You can't unplug it in the place where we submit IO. That's _insane_, 
because it basically means never plugging at all.

And most of the callers don't even _know_ whether we submit IO or not. For 
example, let's pick a real and relevant example (they don't get much more 
relevant than this): "do_generic_mapping_read()".

Tell me WHERE you can unplug in that sequence. I will tell you where you 
can NOT unplug:

 - you can NOT unplug _anywhere_ inside of the read-ahead logic, because 
   we obviously don't want it there (it would break the whole concept of 
   read-ahead, not to mention real code like sys_readahead()).

 - you can NOT unplug in "->readpage()", for similar reasons (readahead 
   again, and again, the whole point of unplugging is that we want to do 
   several readpages and then unplug later)

 - you can NOT just unplug in the path _after_ "readpage()", because the 
   IO may have been started by SOMEBODY ELSE that just did read-ahead, and 
   didn't unplug (on _purpose_ - the whole point of doing read-ahead is to 
   allow concurrent IO execution, so a read-aheader that unplugs is broken 
   by definition)

Those three are not just my "personal ideas". They are fundamental to how 
unplugging works, and more importantly, to the whole _point_ of plugging. 

Agreed?

Now, look at where we _currently_ unplug. I claim that there are exactly 
_two_ places where we have to unplug ((1) we find a page that is not 
up-to-date and (2) we've started a read on a page ourselves), and I claim 
that those two places are _exactly_ the two places where we currently do 
"lock_page()".

Again, this is not a "what if" schenario, or something where my "opinions" 
are at stake. This is hard, cold, fact. We could do the unplugging outside 
of the lock-page, but we'd do it in exactly that situation.

So what is your alternative? Put the explicit unplug at every possible 
occurrence of lock_page() (and keep in mind that some of them don't want 
it: we only want it when the lock-page will block, which is not always 
true. Some people lock the page not because it's under IO, and they're 
waiting for it to be unlocked, but because it's dirty and they're going to 
start IO on it - the lock_page() generally won't block on that, and if 
it doesn't, we don't want to kick previous IO).

In other words, we actually want to unplug at lock_page(), BUT ONLY IF IT 
NEEDS OT WAIT, which is by no means all of them. So it's more than just 
"add an unplug at lock_page()" it's literally "add an unplug at any 
lock-page that blocks".

Still wondering why it ends up being _inside_ lock_page()?

		Linus
