Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbUKCBNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbUKCBNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbUKCBNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:13:09 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:62180 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261276AbUKCBM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:12:28 -0500
Date: Tue, 2 Nov 2004 19:12:10 -0600
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       hugh@veritas.com
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
In-Reply-To: <239530000.1099435919@flay>
Message-ID: <Pine.SGI.4.58.0411021832240.79056@kzerza.americas.sgi.com>
References: <Pine.SGI.4.58.0411011901540.77038@kzerza.americas.sgi.com><14340000.1099410418@[10.10.2.4]>
 <20041102155507.GA323@wotan.suse.de><40740000.1099414515@[10.10.2.4]>
 <Pine.SGI.4.58.0411021613300.79056@kzerza.americas.sgi.com> <239530000.1099435919@flay>
Organization: "Silicon Graphics, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Nov 2004, Martin J. Bligh wrote:

> > The manner I'm concerned about is when a long-lived file (long-lived
> > meaning at least for the duration of the run of a large multithreaded app)
> > is placed in memory as an accidental artifact of the CPU which happened
> > to create the file.
>
> Agreed, I see that point - if it's a globally accessed file that's
> created by one CPU, you want it spread around. However ... how the hell
> is the VM meant to distinguish that? The correct way is for the application
> to tell us that - ie use the NUMA API.

Right.  The application can already tell us that without this patch,
but only if the file is mapped.  Using writes there doesn't appear to
be any way to control this behavior (unless I overlooked something).
So it is impossible to use normal system utilities (i.e. cp, dd, tar)
and get appropriate placement.

This change gives us a method to get a different default (i.e write)
behavior.

> > It's a tough situation, as shown above.  The HPC workload I mentioned
> > would much prefer the tmpfs file to be distributed.  A non-HPC workload
> > would prefer the tmpfs files be local.  Short of a sysctl I'm not sure
> > how the system could make an intelligent decision about what to do under
> > memory pressure -- it simply isn't knowledge the kernel can have.
>
> It is if you tell it from the app ;-) But otherwise yes, I'd agree.

Yep.  Also, bear in mind that many applications/utilities are not going
to be very savvy in regard to tmpfs placement, and really shouldn't be.
I wouldn't expect a compiler to have special code to lay out the generated
objects in a friendly manner.  Currently, all it takes is one unaware
application/utility to mess things up for us.

With local-by-default placement, as today, every single application and
utility needs to cooperate in order to be successful.

Which, I guess, might be something to consider (thinking out loud here)...

An application which uses the NUMA API obviously cares about placement.
If it causes data to be placed locally when it would otherwise be placed
globally, it will not cause a problem for a seperate application/utility
which doesn't care (much?) about locality.

However, if an application/utility which does not care (much?) about
locality fails to use the NUMA API and causes data to be placed locally,
it may very well cause a problem for a seperate application which does
care about locality.

Thus, to me, a default of spreading the allocation globally makes
sense.  The burden of adding code to "do the right thing" falls to
the applications which care.  No other program requires changes and
as such everything will "just work".

But, once again, I fess up to a bias. :)

> Another way might be a tmpfs mount option ... I'd prefer that to a sysctl
> personally, but maybe others wouldn't. Hugh, is that nuts?

I kind of like that -- it shouldn't be too hard to stuff into the tmpfs
superblock.  But I agree, Hugh knows better than I do.

Brent

-- 
Brent Casavant             bcasavan@sgi.com        Forget bright-eyed and
Operating System Engineer  http://www.sgi.com/     bushy-tailed; I'm red-
Silicon Graphics, Inc.     44.8562N 93.1355W 860F  eyed and bushy-haired.
