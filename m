Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbVILOzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbVILOzf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVILOzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:55:35 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11939 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751268AbVILOza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:55:30 -0400
Date: Mon, 12 Sep 2005 07:51:55 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       nikita@clusterfs.com
Subject: Re: [PATCH] cpuset semaphore depth check optimize
Message-Id: <20050912075155.3854b6e3.pj@sgi.com>
In-Reply-To: <20050912043943.5795d8f8.akpm@osdl.org>
References: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
	<20050912043943.5795d8f8.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Better, but still hacky.  The rest of the kernel manages to avoid the need
> for nestable semaphores by getting the locking design sorted out.  Can
> cpusets do that sometime?

Short answer:
=============
Yup - absolutely a hack.  So far it's working better than what I had
before.  I have no plans to replace it.  I'm open to suggestions.


Long answer:
============
I had this without such a hack for a year, with the code that required
calling refresh_mems() after getting cpuset_sem in the top level
cpuset code, before any path that might get to __alloc_pages().
It was *the* primary source of serious bugs in the cpuset code this
last year.  You've been lucky enough to only see a couple of them.

I've got paths in __alloc_pages() and below that acquire cpuset_sem,
but only rarely.  I am not aware of any other global kernel lock
that routinely shows up both _above_ and _below_ __alloc_pages on
the stack.  Normally such would be a big problem for numa scaling.
This one avoids the scaling problem by only being on rare paths when
called within __alloc_pages.  But that means I can't test for bugs;
I have to code so it is obviously right in the first place (not a
bad idea in general ;).

I have *never* actually recreated such a deadlock myself, on a stock
kernel.  I've seen exactly one live kernel backtrace showing such
a deadlock from a customer site in my life, and reliable reports of
a few more.  I've never seen such a backtrace or heard evidence of a
such a deadlock on an internal test machine running a stock kernel.

I've spent days trying to concoct test scenarios that would trip these
deadlocks on a stock kernel, with no success.  The specific low memory
conditions required, along with other timing races, are too difficult
(so far anyway) to recreate on demand.

But for one time, everyone of these bugs (double tripping on
cpuset_sem) was found, and fixed, solely by inspection.  And the bugs
kept coming.

The final straw came when I took a vacation, came back, forgot how my
scheme worked and started writing totally broken code and stupid
comments, based on my newly acquired misunderstanding.

Something had to give.

It was time to cast elegance aside and find a locking scheme that even
a stupid person could understand and get right.

This hack has two serious advantages:
 1) It's as obvious as a big old scar on one's face.  In just a
    couple days, it has generated more informed discussion than the
    old one ever did, by readers who had no trouble seeing what it
    did, commenting without hesitation on alternatives.  The rare
    comments I got on the previous scheme came only after hours of
    head scratching, and with some uncertainty.
 2) It works.  Every variation of this I've coded has, so far as I
    know, been rock solid.  The discussion has only been over style
    and data space issues.  It looks like it will continue to work
    if per chance I add more cpuset features that allocate memory
    somewhere in the code.  The only rule is that every up/down on
    cpuset_sem has to be done by the wrappers, which is why I have
    insisted on having the wrapper calls look like regular calls
    to "up(&cpuset_sem)" and "down(&cpuset_sem)", so this convention
    would be rather obvious.

  "If you're going to hack, at least do it in plain sight."

If someone would like to recommend a better scheme, I'm all ears.
I am well aware that there are others in the kernel who know locking
better than I do.  And I am well aware that the experts in such stuff
don't end up coding hacks such as this.

Barring some inspiration however, probably requiring the help of input
from others, it is unlikely that I will be posting a patch to remove
this hack anytime soon.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
