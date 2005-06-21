Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVFUQOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVFUQOs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVFUQOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:14:39 -0400
Received: from imf18aec.mail.bellsouth.net ([205.152.59.66]:33725 "EHLO
	imf18aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S262145AbVFUQOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:14:18 -0400
Message-ID: <027401c57683$a261a9f0$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: "Rik van Riel" <riel@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
References: <000d01c5762c$5e399dc0$2800000a@pc365dualp2> <Pine.LNX.4.61.0506210954090.14739@chimarrao.boston.redhat.com>
Subject: Re: [RFC] do_execve() perf improvement opportunity?
Date: Tue, 21 Jun 2005 13:06:53 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik, it would certainly fail miserably on any architecture where different
CPU's have any CPU local memory under kernel managment.

Anything resembling the old homogeneous Hydra scheme should be fine though I
would think.

NUMA is odd enough that the kernel is littered with conditionals for it, one
more wouldn't be a big deal ;->

I'll try to code this up and benchmark it and see if there's anything
measurable.  If there is, this sort of simple minded "cache the last one"
scheme might be applicable elsewhere too - pipes, maybe net packets, etc.
It looks like Slab already sort of "caches the last one" on the different
granularities, but it takes a bit more code to get to the point where it
finally figures out it can give you back a cached one.

Maybe there's something to be gained by having an internal special case
allocator for limited numbers of small things (like 32, 64, 128, 256 maybe
where a bit scan instruction or two can trivially find you an empty slot)?
Where the allocator degenerates to just setting a flag byte on the smaller
slices and generating the pointer from a bit index.


----- Original Message ----- 
From: "Rik van Riel" <riel@redhat.com>
To: <cutaway@bellsouth.net>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, June 21, 2005 09:56
Subject: Re: [RFC] do_execve() perf improvement opportunity?


> On Tue, 21 Jun 2005 cutaway@bellsouth.net wrote:
>
> > I'm thinking it may be possible to very cheaply cache a pointer to the
> > last allocation here rather than freeing it and just recycle it for the
> > next exec saving a trip through the slab machanism.
>
> Note that the slab mechanism can do allocations locally
> on each CPU in an SMP system, while your pointer would
> need some cross-CPU synchronisation.  Also, you could
> end up using the bprm from a CPU on a remote NUMA node,
> instead of a local piece of memory.
>
> Still, it would be interesting/educational to know if your
> optimisation makes a difference on single CPU systems.

