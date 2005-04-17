Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbVDQU5t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbVDQU5t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 16:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261471AbVDQU5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 16:57:48 -0400
Received: from mail.dif.dk ([193.138.115.101]:14472 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261457AbVDQU5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 16:57:19 -0400
Date: Sun, 17 Apr 2005 23:00:15 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/fcntl.c : don't test unsigned value for less than
 zero
In-Reply-To: <20050415132145.GA8669@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.62.0504172252300.2586@dragon.hyggekrogen.localhost>
References: <20050415113218.GA22528@infradead.org> <E1DMPXN-0004sh-00@gondolin.me.apana.org.au>
 <20050415132145.GA8669@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005, Matthew Wilcox wrote:

> On Fri, Apr 15, 2005 at 10:03:05PM +1000, Herbert Xu wrote:
> > I suppose it could be smart and stay quiet about
> > 
> > val < 0 || val > BOUND
> > 
> > However, gcc is slow enough as it is without adding unnecessary
> > smarts like this.
> 
> It only warns with -W on, not with -Wall, so I see no compelling
> reason to fix this.

Fixing the -W warning was not the main point. The main point was simply 
that the check makes no sense at all.

>  I think the real problem here is that 'arg'
> is declared 2 pages earlier in the function prototype (aka the
> function-growth-hormone-imbalance syndrome).
> 
> There's two good ways of fixing this, adding a f_setsig() function:
> 
[...]
> or add a function that checks a variable to see if it's a valid signal number:
[...]
> 
> Looks like futex.c, ptrace.c, signal.c, sys.c and almost every
> architecture's ptrace code could easily make use of the latter, but not
> the former.  It also looks like we have a few off-by-one errors.  For
[...]
> so I'd recommend the second solution.

Thank you for your feedback, that makes a lot of sense. That should get 
rid of the pointless tests, get rid of the -W warning and get rid of the 
off-by-one errors - sounds good to me.
I'll create patches and send them along shortly.


>  But be careful not to "fix up"
> cases like:
> 
> ./kernel/exit.c:        if (sig < 1 || sig > _NSIG)
> 
> where we really don't want to allow zero.
> 
I'll watch out for those.  
I can either leave them alone or re-write as one of
    if (valid_signal(sig) && sig != 0)
    if (valid_signal(sig) && sig > 0)
any preference?
Personally I would probably go with the 
'rewrite as  if (valid_signal(sig) && sig > 0)' one to encourage use of 
the new valid_signal() function and make usage consistent.


-- 
Jesper Juhl


