Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbUFCI3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbUFCI3N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 04:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUFCI3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 04:29:13 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:62736 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261723AbUFCI25 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 04:28:57 -0400
Date: Thu, 3 Jun 2004 01:27:28 -0700
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, greg@kroah.com
Subject: Re: [PATCH] fix sys cpumap for > 352 NR_CPUS
Message-Id: <20040603012728.42713a30.pj@sgi.com>
In-Reply-To: <1086243997.29390.527.camel@bach>
References: <20040602161115.1340f698.pj@sgi.com>
	<1086222156.29391.337.camel@bach>
	<20040602212547.448c7cc7.pj@sgi.com>
	<1086243997.29390.527.camel@bach>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	BUILD_BUG_ON(NR_CPUS/4 > PAGE_SIZE/2);

Interesting.  This would be the only use in the entire kernel of
BUILD_BUG_ON().

An alternative mechanism would be:

    #if(badthing) ... #error "darn" ... #endif

There are over 300 such constructs in the kernel.  And it has the
advantage of providing an accurate source line number and a specifiable
string.

My preference when checking limits is to check for the exact limit.
Adding fuzz only serves to disguise details.  Whether coding correctly,
or screwing up, best to do so with clarity and precision.

Given all that, how about:

    #if ALIGN(NR_CPUS,32)*9/32 > PAGE_SIZE
    #error "Need 9 bytes space per 32 CPUs in PAGE_SIZE buffer"
    #endif

==

I also could be tempted to remove BUILD_BUG_ON() from kernel.h, and
replace it with a comment:

    /* BUILD_BUG_ON() obsolete - consider using #if ... #error ... #endif */

==

> +	len = cpumask_scnprintf(buf, -1UL, mask);

Why not instead:

> +	len = cpumask_scnprintf(buf, PAGE_SIZE-1, mask);

I see no sense in giving cpumask_scnprintf() license to write past the
end of the buffer, independent of any build-time checks (the -1 is for
the trailing newline).  And since the contract says "PAGE_SIZE", we
should code exactly to that value "PAGE_SIZE", for clarity as to our
understandings.  Once again - I hate fuzz ;).

==

> +	BUG_ON(count > PAGE_SIZE);

Only 'BUG_ON' ??  We have in hand almost certain proof of just
having scrogged kernel memory.  Time to panic, no?

==

What are we going to do about the removal of the node_dev->cpumap field,
and changing this node_read_cpumap() routine to display instead the
value of node_to_cpumask(node_dev->sysdev.id)?

Should I do it, or you?  Should it presume your patch above, or collide
with it, or replace and extend it?

Since I am most impressed with your abilities, since you doubt my
abilities, and since I'm a lazy s.o.b., you're welcome to it.  Or if you
prefer to ask me, that's fine.  Seems to me this should be two patches -
the one discussed above to limit how many bytes cpumask_scnprintf can
posit, and a second to nuke node_dev->cpumap.  The second patch would
depend on the first, for the trivial reason that they collide on some of
the same code.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
