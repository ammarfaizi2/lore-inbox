Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270754AbTHAMcu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 08:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270755AbTHAMcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 08:32:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:49354 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S270754AbTHAMcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 08:32:48 -0400
Date: Fri, 1 Aug 2003 14:32:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Ian Kumlien <pomac@vapor.com>
Cc: Ihar Philips Filipau <filia@softhome.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [SHED][IO-SHED] Are we missing the big picture?
Message-ID: <20030801123236.GS7920@suse.de>
References: <fw7N.3DP.11@gated-at.bofh.it> <3F2A2C14.9030801@softhome.net> <1059740622.30747.67.camel@big.pomac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059740622.30747.67.camel@big.pomac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 01 2003, Ian Kumlien wrote:
> On Fri, 2003-08-01 at 11:00, Ihar "Philips" Filipau wrote:
> >    Am I right - judging from your posting - that we finally reached 
> > moment than Linux will have network-like queueing disciplines for disks 
> > and CPUs?
> 
> CPU's? well, we do have a nice sheduler but i wouldn't say network-like
> queuing.
> 
> >    In any way, CPU/disk throughput just another types of limited resource.
> >    It would be nice to be able to manage it - who gets more, who gets 
> > less. CPU/disk schedulers by manageability are far behind network.
> >    IMHO must have for servers.
> 
> Yes, but, thats not what I'm saying.
> 
> CFQ as it apparently was called, builds a queue list when the disk is

I coined that phrase as a variant of SFQ, with C being Complete.

> under load. So you get really fast data access if there is no load, and
> a common queue when there is load. The common queue is the bad thing
> about CFQ, imagine putting AS there instead... This would mean fast data
> access on unloaded systems, better throughput on loaded systems and
> prioritization features could hook right in since AS would only be used
> during load. IE, you can add all kinds of patches that only matters
> during heavy load.

I dunno where you get this from, but you seem to have a misguide picture
of how io schedulers work in Linux. AS works like deadline, but adds
anticipation. This means you try to anticipate whether a process will
issue a nearby read soon, and if so stall the disk head. deadline itself
has a single queue for merging/sorting, and a single queue as a deadline
fifo (for each data direction, read and write).

Where CFQ differs is that it maintains such a backend system for each
"class" (user, could be a task grouping of some sort too), with a small
front end (class independent scheduler is used in some contexts) to
select which class we do IO from. The old design just round-robined
between all "busy" tasks, with some heuristics to minimize seeks.

So for a single task, deadline and CFQ works the same basically. AS
differs because of the anticipation of course.

> > > I liked Jens Axobe's 'CBQ' alike implementation (based on the idea of
> > > Andrea A. (afair i have the names right) since it does the most

Nope, it's Axboe :)

-- 
Jens Axboe

