Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161102AbVKDIHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161102AbVKDIHi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 03:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161103AbVKDIHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 03:07:38 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:3726 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161102AbVKDIHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 03:07:37 -0500
Date: Fri, 4 Nov 2005 09:07:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: pbadari@gmail.com, torvalds@osdl.org, jdike@addtoit.com, rob@landley.net,
       nickpiggin@yahoo.com.au, gh@us.ibm.com, kamezawa.hiroyu@jp.fujitsu.com,
       haveblue@us.ibm.com, mel@csn.ul.ie, mbligh@mbligh.org,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [patch] swapin rlimit
Message-ID: <20051104080731.GB21321@elte.hu>
References: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com> <200511021747.45599.rob@landley.net> <43699573.4070301@yahoo.com.au> <200511030007.34285.rob@landley.net> <20051103163555.GA4174@ccure.user-mode-linux.org> <1131035000.24503.135.camel@localhost.localdomain> <20051103205202.4417acf4.akpm@osdl.org> <20051104072628.GA20108@elte.hu> <20051103233628.12ed1eee.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103233628.12ed1eee.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Ingo Molnar <mingo@elte.hu> wrote:
> >
> > * Andrew Morton <akpm@osdl.org> wrote:
> > 
> >  > Similarly, that SGI patch which was rejected 6-12 months ago to kill 
> >  > off processes once they started swapping.  We thought that it could be 
> >  > done from userspace, but we need a way for userspace to detect when a 
> >  > task is being swapped on a per-task basis.
> > 
> >  wouldnt the clean solution here be a "swap ulimit"?
> 
> Well it's _a_ solution, but it's terribly specific.
> 
> How hard is it to read /proc/<pid>/nr_swapped_in_pages and if that's 
> non-zero, kill <pid>?

on a system with possibly thousands of taks, over /proc, on a 
high-performance node where for a 0.5% improvement they are willing to 
sacrifice maidens? :)

Seriously, while nr_swapped_in_pages ought to be OK, i think there is a 
generic problem with /proc based stats.

System instrumentation people are already complaining about how costly 
/proc parsing is. If you have to get some nontrivial stat from all 
threads in the system, and if Linux doesnt offer that counter or summary 
by default, it gets pretty expensive.

One solution i can think of would be to make a binary representation of 
/proc/<pid>/stats readonly-mmap-able. This would add a 4K page to every 
task tracked that way, and stats updates would have to update this page 
too - but it would make instrumentation of running apps really 
unintrusive and scalable.

Another addition would be some mechanism for a monitoring app to capture 
events in the PID space: so that they can mmap() new tasks [if they are 
interested] on a non-polling basis, i.e. not like readdir on /proc. This 
capability probably has to be a system-call though, as /proc seems too 
quirky for it. The system does not wait on the monitoring app(s) to 
catch up - if it's too slow in reacting and the event buffer overflows 
then tough luck - monitoring apps will have no impact on the runtime 
characteristics of other tasks. In theory this is somewhat similar to 
auditing, but the purpose would be quite different, and it only cares 
about PID-space events like 'fork/clone', 'exec' and 'exit'.

	Ingo
