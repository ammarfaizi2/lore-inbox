Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265148AbUFDBNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265148AbUFDBNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 21:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUFDBNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 21:13:19 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:10234 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S265148AbUFDBNQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 21:13:16 -0400
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
From: Rusty Russell <rusty@rustcorp.com.au>
To: Paul Jackson <pj@sgi.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, ak@suse.de, Greg KH <greg@kroah.com>
In-Reply-To: <20040603012728.42713a30.pj@sgi.com>
References: <20040602161115.1340f698.pj@sgi.com>
	 <1086222156.29391.337.camel@bach> <20040602212547.448c7cc7.pj@sgi.com>
	 <1086243997.29390.527.camel@bach>  <20040603012728.42713a30.pj@sgi.com>
Content-Type: text/plain
Message-Id: <1086311544.7991.868.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 04 Jun 2004 11:12:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-03 at 18:27, Paul Jackson wrote:
> > +	BUILD_BUG_ON(NR_CPUS/4 > PAGE_SIZE/2);
> 
> Interesting.  This would be the only use in the entire kernel of
> BUILD_BUG_ON().
> 
> An alternative mechanism would be:
> 
>     #if(badthing) ... #error "darn" ... #endif

Whatever, I like BUILD_BUG_ON().

>     #if ALIGN(NR_CPUS,32)*9/32 > PAGE_SIZE
>     #error "Need 9 bytes space per 32 CPUs in PAGE_SIZE buffer"
>     #endif

Honestly, I dislike the static check altogether, since it's tied too
closely to the implementation of independent code.  Since glibc will
break on > 1024 cpus, I'm not too concerned about the 10000+ CPU limit.

> > +	len = cpumask_scnprintf(buf, -1UL, mask);
> 
> Why not instead:
> 
> > +	len = cpumask_scnprintf(buf, PAGE_SIZE-1, mask);
> 
> I see no sense in giving cpumask_scnprintf() license to write past the
> end of the buffer, independent of any build-time checks (the -1 is for
> the trailing newline).  And since the contract says "PAGE_SIZE", we
> should code exactly to that value "PAGE_SIZE", for clarity as to our
> understandings.  Once again - I hate fuzz ;).

Because now you have silently truncated, which is much worse than
blowing up loudly.  My version also works correctly when sysfs starts
handing out two pages rather than one because something else needed it.

If you want to do this, then please do:

	len = cpumask_scnprintf(buf, PAGE_SIZE, mask);
	if (len == PAGE_SIZE)
		return -ENOMEM;

> > +	BUG_ON(count > PAGE_SIZE);
> 
> Only 'BUG_ON' ??  We have in hand almost certain proof of just
> having scrogged kernel memory.  Time to panic, no?

That would be extremely unusual; we tend not to panic even when things
are bad.  In this case, things are bad because of a static configuration
error, so I find it hard to really care...

> ==
> 
> What are we going to do about the removal of the node_dev->cpumap field,
> and changing this node_read_cpumap() routine to display instead the
> value of node_to_cpumask(node_dev->sysdev.id)?
> 
> Should I do it, or you?  Should it presume your patch above, or collide
> with it, or replace and extend it?

I'll do it; seems like we need negotiation with Greg-KH, too.

> Since I am most impressed with your abilities, since you doubt my
> abilities, and since I'm a lazy s.o.b., you're welcome to it.

That's not true.  I have faith in your abilities; I question anyone's
ability to produce a perfectly balanced solution without any external
input.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

