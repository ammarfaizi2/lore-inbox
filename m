Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750818AbVHHKik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818AbVHHKik (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 06:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVHHKik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 06:38:40 -0400
Received: from mailfe14.tele2.se ([212.247.155.161]:33788 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1750818AbVHHKik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 06:38:40 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Mon, 8 Aug 2005 12:38:31 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5-mm1: oops when starting nscd on AMD64
Message-ID: <20050808103831.GA1210@localhost.localdomain>
References: <200508071851.16864.rjw@sisk.pl> <20050807102329.006f7d95.akpm@osdl.org> <200508072316.02918.rjw@sisk.pl> <20050808012809.2a708b3e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050808012809.2a708b3e.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I don't think it was supposed to do that.
> >  > 
> >  > Quite possibly it's something to do with the new debugging code - could you
> >  > please take a copy of the offending config, send it over and then try
> >  > removing debug options, see if the crash goes away?  CONFIG_DEBUG_PREEMPT
> >  > would be the first to try..
> > 
> >  The (offending) .config is attached and here's what happens without CONFIG_DEBUG_PREEMPT
> >  (the other debug options being unchanged):
> 
> Yes, my emt64 machine keels over with your .config too.  Maybe it's due to
> CONFIG_SMP=n, not sure.
> 
> Bisection searching shows that the bug was introduced by
> slab-leak-detector-give-longer-traces.patch.
> 

I was afraid it was when I first saw it but I couldn't reproduce (and
still can't).

> Call Trace:<ffffffff801a17bb>{sys_epoll_create+568} <ffffffff8018b1f7>{vfs_readdir+167}
>        <ffffffff80231000>{add_preempt_count+93} <ffffffff8010e8fa>{system_call+126}    
>                                                                                    

For some reason your compilers inline heavier than mine do, which makes
this:

kmem_cache_alloc
sys_epoll_create	(__builtin_return_address(0))
system_call		(__builtin_return_address(1))
			(__builtin_return_address(2))

and off the stack we go...

I guess it was naive to even try to use this for more than the first
caller, sorry. Please throw that thing away and I'll do some backtracing
similar to CONFIG_PAGE_OWNER
