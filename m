Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261307AbULWVsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261307AbULWVsg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 16:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbULWVsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 16:48:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:56034 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261309AbULWVs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 16:48:27 -0500
Date: Thu, 23 Dec 2004 13:48:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: Christoph Lameter <clameter@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, torvalds@osdl.org, linux-mm@kvack.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Prezeroing V2 [0/3]: Why and When it works
In-Reply-To: <16843.13418.630413.64809@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0412231325420.2654@ppc970.osdl.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
 <16843.13418.630413.64809@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Dec 2004, Paul Mackerras wrote:
> 
> I did some measurements once on my G5 powermac (running a ppc64 linux
> kernel) of how long clear_page takes, and it only takes 96ns for a 4kB
> page.  This is real-life elapsed time in the kernel, not just some
> cache-hot benchmark measurement.  Thus I don't think your patch will
> gain us anything on ppc64.

Well, the thing is, if we really _know_ the machine is idle (and not just 
waiting for something like disk IO), it might be a good idea to just 
pre-zero everything we can.

The question to me is whether we can have a good enough heuristic to
notice that it triggers often enough to matter, but seldom enough that it
really won't disturb anybody.

And "disturb" very much includes things like laptop battery life,
scheduling latencies, memory bus traffic _and_ cache contents. 

And I really don't see a very good heuristic. Maybe it might literally be
something like "five-second load average goes down to zero" (we've got
fixed-point arithmetic with eleven fractional bits, so we can tune just
how close to "zero" we want to get). The load average is system-wide and
takes disk load (which tends to imply latency-critical work) into account,
so that might actually work out reasonably well as a "the system really is
quiescent".

So if we make the "what load is considered low" tunable, a system 
administrator can use that to make it more aggressive. And indeed, you 
might have a cron-job that says "be more aggressive at clearing pages 
between 2AM and 4AM in the morning" or something - if you have so much 
memory that it actually matters if you clear the memory just occasionally.

And the tunable load-average check has another advantage: if you want to 
benchmark it, you can first set it to true zero (basically never), and run 
the benchmark, and then you can set it to something very agressive ("clear 
pages every five seconds regardless of load") and re-run.

Does this sound sane? Christoph - can you try making the "scrub deamon" do 
that? Instead of the "scrub-low" and "scrub-high" (or in _addition_ to 
them), do a "scub-load" thing that takes a scaled integer, and compares it 
with "avenrun[0]" in kernel/timer.c: calc_load() when the average is 
updated every five seconds..

Personally, at least for a desktop usage, I think that the load average 
would work wonderfully well. I know my machines are often at basically 
zero load, and then having low-latency zero-pages when I sit down sounds 
like a good idea. Whether there is _enough_ free memory around for a 
5-second thing to work out well, I have no idea..

		Linus
