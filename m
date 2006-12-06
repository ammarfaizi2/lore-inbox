Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936983AbWLFSHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936983AbWLFSHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936985AbWLFSHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:07:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:51736 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936983AbWLFSHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:07:40 -0500
Date: Wed, 6 Dec 2006 10:07:15 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
In-Reply-To: <457702E2.3000703@garzik.org>
Message-ID: <Pine.LNX.4.64.0612060958250.3542@woody.osdl.org>
References: <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org> 
 <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org>
 <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
 <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
 <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
 <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
 <20061206075729.b2b6aa52.akpm@osdl.org> <21690.1165426993@redhat.com>
 <457702E2.3000703@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 6 Dec 2006, Jeff Garzik wrote:
>
> Honestly I wonder if some of these situations really want
> "kill_scheduled_work_unless_it_is_already_running_right_now_if_so_wait_for_it"

We could do that, and the code to do it would be fairly close to what the 
"run it" code is. Just replace the

	if (!test_bit(WORK_STRUCT_NOAUTOREL, &work->management))
		work_release(work);
	f(work);

with an unconditional

	work_release(work);

instead.

However, I think I'd prefer my patch for now, if only because that 
"work_release()" thing kind of worries me. You're supposed to either do 
the release yourself in the work function _after_ you've done all 
book-keeping, or if the thing doesn't need any book-keeping at all, you 
can do the "autorelease" thing. The "kill without running" breaks that 
conceptual model.

So a "kill_work()" usage should almost always end up being something like

	if (kill_work(work))
		release anything that running the work function would release

but then for the (probably common) case where there is nothing that the 
work function releases, that would obviously boil down to just a

	kill_work(work);

However, my point is that the _workqueue_ logic cannot know what the user 
of the workqueue wants, so the "run_scheduled_work()" approach is much 
saner in this respect.

NOTE NOTE NOTE! In neither case can we do anything at all about a 
workqueue entry that is actually _already_ running on another CPU. My 
suggested patch will simply not run it at all synchronously (and return 
0), and a "kill_work()" thing couldn't do anything either. The required 
synchronization for something like that simply doesn't exist.

		Linus
