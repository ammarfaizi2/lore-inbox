Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262879AbUCRTAl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbUCRTAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:00:41 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49025
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262879AbUCRTAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:00:38 -0500
Date: Thu, 18 Mar 2004 20:01:26 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040318190126.GA2022@dualathlon.random>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org> <20040318145129.GA2246@dualathlon.random> <20040318093902.3513903e.akpm@osdl.org> <20040318175855.GB2536@dualathlon.random> <20040318102623.04e4fadb.akpm@osdl.org> <20040318183844.GD32573@dualathlon.random> <20040318104729.0de30117.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318104729.0de30117.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 10:47:29AM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > > hand so we should only fall into the kmap() if the page was suddenly stolen
> >  > again.
> > 
> >  Oh so you mean the page fault insn't only interrupting the copy-user
> >  atomically, but the page fault is also going to sleep and pagein the
> >  page? I though you didn't want to allow other tasks to steal the kmap
> >  before you effectively run the kunmap_atomic. I see it can be safe if
> >  kunmap_atomic is a noop though, but you're effectively allowing
> >  scheduling inside a kmap this way.
> 
> No, we don't schedule with the atomic kmap held.  What I meant was:

good to hear this (even scheduling inside an atomic kmap could be made
to work but I would find it less obviously safe since kumap_atomic would
need to be a noop for example).

> 
> 	get_user(page);		/* fault it in */
> 	kmap_atomic(page);
> 	if (copy_from_user(page))
> 		goto slow_path;
> 	kunmap_atomic(page);
> 
> 	...
> 
> slow_path:
> 	kunmap_atomic(page);
> 	kmap(page);
> 	copy_from_user(page);
> 	kunmap(page);
> 

I see what you mean now, so you suggest to run an unconditional
get_user(). It's hard to tell here, I agree the cost would be nearly
zero since the loaded byte from memory it'll go into l1 cache and it
would avoid a page fault in some unlikely case compared to what I
proposed, but I don't like too much it because I really like to optimize
as much as possible for the fast path always, so I still like to keep
the get_user out of the fast path. But you're right to argue since it's
hard to tell what's better in practice (certainly one could write a
malicious load where the additional pagefault could be measurable, while
the get_user would always be hardly measurable).
