Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVAIN7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVAIN7y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 08:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVAIN7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 08:59:54 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52632 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261421AbVAIN7v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 08:59:51 -0500
Date: Sun, 9 Jan 2005 09:06:30 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Lukasz Trabinski <lukasz@wsisiz.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
Message-ID: <20050109110630.GA9144@logos.cnet>
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl> <20050107170712.GK29176@logos.cnet> <1105136446.7628.11.camel@localhost.localdomain> <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org> <20050107221255.GA8749@logos.cnet> <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org> <20050108182841.GD2701@logos.cnet> <Pine.LNX.4.58.0501081734400.2339@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0501081734400.2339@ppc970.osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2005 at 05:38:50PM -0800, Linus Torvalds wrote:
> 
> On Sat, 8 Jan 2005, Marcelo Tosatti wrote:
> >
> > > No, I'd just fix them up.
> > 
> > What do you mean by "fix them up" ? With your minimal fix the other do_brk() callers 
> > do not have the lock, you dont mean "fix" by grabbing the lock? 
> 
> I'm saying that if we decide to do the debugging warning (and I think 
> everybody is agreeing that we should), then we _will_ fix it by just 
> grabbing the lock in all the paths. That's what we already did with 
> do_mmap(), after all.

OK - you dont like the idea of having a wrapper to grab the lock and use that ?

> I suspect it's not strictly needed, but as Alan has said, even though 
> nothing else can chaneg the vma's at the same time, it's the right thing 
> to do to keep /proc reads happy (which _can_ happen) anyway. And more 
> importantly, invariants are nice - to the point where it's good to follow 
> the rules even if it might not be strictly necessary.

I agree. The chance of getting this wrong in the future is smaller if we use the
the "do_brk requires mmap_sem" rule.

> I just wanted to keep these two issues separate. I think it's one thing to 
> fix a known bug, and another thing to add some debug infrastructure to 
> make sure that it doesn't happen in the future. So I think the WARN_ON() + 
> adding of extra locking is a separate stage from fixing the known problem.

OK - I think v2.4 being consistent wrt function names and calling convetion in 
this area is important. 

If you don't like the wrapper I'll change all callers do grab the lock accordingly.

And have this warning as you suggested (which makes a hell lot more sense): 

--- mm/mmap.c.orig      2005-01-07 09:14:01.000000000 -0200
+++ mm/mmap.c 2005-01-09 08:56:55.521436072 -0200
@@ -1061,6 +1061,13 @@
        }
 
        /*
+        * mm->mmap_sem is required to protect against another thread
+        * changing the mappings while we sleep (on kmalloc for one).
+        */
+       if (down_read_trylock(&mm->mmap_sem))
+               BUG();
+
+       /*
         * Clear old maps.  this also does some error checking for us
         */
  munmap_back:

