Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264040AbUCZNIm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 08:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264039AbUCZNIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 08:08:41 -0500
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:7604 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S264037AbUCZNIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 08:08:35 -0500
Message-ID: <4064245C.50B74C67@nospam.org>
Date: Fri, 26 Mar 2004 13:38:52 +0100
From: Zoltan Menyhart <Zoltan.Menyhart_AT_bull.net@nospam.org>
Organization: Bull S.A.
X-Mailer: Mozilla 4.78 [en] (X11; U; AIX 4.3)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Robin Holt in <holt@sgi.com>
CC: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Migrate pages from a ccNUMA node to another
References: <4063F188.66DB690A@nospam.org> <20040326103959.GB14360@lnx-holt>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt wrote:
> 
> We have found that "automatic" migration ends to result in the
> system deciding to move the wrong pieces around.  Since applications
> can be so varied, I would recommend we let the application decide
> when it thinks it is beneficial to move a memory range to a nearby
> node.

I am not saying it is for every application
(see the paragraph of the "if's").
There are a couple of applications which run for long time, with
relatively stable memory working sets. And I can help them.
You launch your application with and without, and you use if you
gain enough.

> The placement policy doesn't really fit the bill entirely.  We are
> currently tracking a problem with repeatability of a benchmark.  We
> found that the newer libc we are using used to result in a newly
> forked process touching a page before the parent did and therefore
> the page, which had been marked COW, would, on the old libc end up
> on the childs node for the child and parents node for the parent.
> After the update, both pages ended up on the parents.

I haven't modified anything in the existing page fault handler.
Nor I've changed the placement policy.
You need to specify explicitly where the pages go for my proposed
syscall.

> If you syscall would simply do the copy to the destination node
> for COW pages, this would have worked terrifically in both cases.

The COW pages are referenced by more than one PGDs (by that of the
parent and its children). As I state in RESTRICTIONS, I skip these
pages.

I think this issue with the COW pages is a fork() - exec()
placement problem, i do not address it with my stuff.


> >
> > 3. NUMA aware scheduler
> > .......................
> >
> 
> Back to my earlier comment about magic.  This is a second tier of
> magic.  Here we are talking about infering a reason to migrate based
> on memory access patterns, but what if that migration results in
> some other process being hurt more than this one is helped.
> 
> Honestly, we have beaten on the scheduler quite a bit and the "allocate
> memory close to my node" has helped considerably.
> 
> One thing that would probably help considerably, in addition to the
> syscall you seem to be proposing, would be an addition to the
> task_struct.  The new field would specify which node to attempt
> allocations on.  Before doing a fork, the parent would do a
> syscall to set this field to the node the child will target.  It
> would then call fork.  The PGDs et al and associated memory, including
> the task struct and pages would end up being allocated based upon
> that numa node's allocation preference.
> 
> What do you think of combining these two items into a single syscall?

I can agree with Robin Holt, it's NUMA API issue.
I just give a tool, if someone somehow knows that this piece of memory
would be better on another node, I can do it.

> > NAME
> >         migrate_ph_pages        - migrate pages to another NUMA node
> 
> At first, I thought "Wow, this could result in some nice admin tools."
> The more I scratch my head on this, the less useful I see it, but
> would not argue against it.

We are working on the prototype of a device driver to read out the
"hot page" counters on n-th Scalable Node Controller
(say: "/dev/snc/n/hotpage").
An "artificial intelligence" can guess what to move and calls this service.


BTW Has someone a machine with a chip set other than i82870 ?


Thanks,


Zoltan Menyhart
