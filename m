Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbUKCBb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbUKCBb0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 20:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUKCBb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 20:31:26 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:50610 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261285AbUKCBbJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 20:31:09 -0500
Date: Tue, 02 Nov 2004 17:30:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Brent Casavant <bcasavan@sgi.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       hugh@veritas.com
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
Message-ID: <255590000.1099445425@flay>
In-Reply-To: <Pine.SGI.4.58.0411021832240.79056@kzerza.americas.sgi.com>
References: <Pine.SGI.4.58.0411011901540.77038@kzerza.americas.sgi.com><14340000.1099410418@[10.10.2.4]><20041102155507.GA323@wotan.suse.de><40740000.1099414515@[10.10.2.4]><Pine.SGI.4.58.0411021613300.79056@kzerza.americas.sgi.com> <239530000.1099435919@flay> <Pine.SGI.4.58.0411021832240.79056@kzerza.americas.sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Tuesday, November 02, 2004 19:12:10 -0600 Brent Casavant <bcasavan@sgi.com> wrote:

> On Tue, 2 Nov 2004, Martin J. Bligh wrote:
> 
>> > The manner I'm concerned about is when a long-lived file (long-lived
>> > meaning at least for the duration of the run of a large multithreaded app)
>> > is placed in memory as an accidental artifact of the CPU which happened
>> > to create the file.
>> 
>> Agreed, I see that point - if it's a globally accessed file that's
>> created by one CPU, you want it spread around. However ... how the hell
>> is the VM meant to distinguish that? The correct way is for the application
>> to tell us that - ie use the NUMA API.
> 
> Right.  The application can already tell us that without this patch,
> but only if the file is mapped.  Using writes there doesn't appear to
> be any way to control this behavior (unless I overlooked something).
> So it is impossible to use normal system utilities (i.e. cp, dd, tar)
> and get appropriate placement.

Ah yes, I see your point.
 
> This change gives us a method to get a different default (i.e write)
> behavior.

OK. Might still be more useful to have it per filehandle, but we'd need
a way to send info on an existing filehandle.

> Yep.  Also, bear in mind that many applications/utilities are not going
> to be very savvy in regard to tmpfs placement, and really shouldn't be.
> I wouldn't expect a compiler to have special code to lay out the generated
> objects in a friendly manner.  Currently, all it takes is one unaware
> application/utility to mess things up for us.

Well, on certain extreme workloads, yes. But not for most people.
 
> With local-by-default placement, as today, every single application and
> utility needs to cooperate in order to be successful.
> 
> Which, I guess, might be something to consider (thinking out loud here)...

I don't like apps having to co-operate any more than you do, as they
obviously won't. However, remember that most workloads won't hit this,
and there are a couple of other approaches:

1) your global switch is making more sense to me now.
2) We can balance nodes under mem pressure (we don't currently)

Number 2 fixes a variety of evils, and we've been talking about fixing
that for a while (see the previous one on pagecache ... do we have to
fix each case?).

What scares me is that what all these discussions are pointing towards
is "we want global striping for all allocations, because Linux is too 
crap to deal with cross-node balancing pressure". I don't want to see 
us go that way ;-). Some things are more obviously global than others
(eg shmem is more likely to be shared) ... whether we think the usage
of tmpfs is local or global is very much up to debate though. 

There are a few other indicators I could see us using as hints from the 
OS that might help - the size of the file vs the amount of mem in the
node, for one. How many processes have the file open, and which nodes
they're on for another. Neither of which are flawless, or even terribly
simple, but we're making heuristic guesses.

> An application which uses the NUMA API obviously cares about placement.
> If it causes data to be placed locally when it would otherwise be placed
> globally, it will not cause a problem for a seperate application/utility
> which doesn't care (much?) about locality.

99.9% of apps won't be NUMA aware, nor should they have to be. Standard
code should just work out the box ... I'm not going to take the viewpoint
that these are only specialist servers running one or two apps - they'll
run all sorts of stuff, esp with the advent of AMD in the marketplace,
and hopefully Intel will get their ass into gear and do local mem soon
as well.

> However, if an application/utility which does not care (much?) about
> locality fails to use the NUMA API and causes data to be placed locally,
> it may very well cause a problem for a seperate application which does
> care about locality.
> 
> Thus, to me, a default of spreading the allocation globally makes
> sense.  The burden of adding code to "do the right thing" falls to
> the applications which care.  No other program requires changes and
> as such everything will "just work".
> 
> But, once again, I fess up to a bias. :)

Yeah ;-) I'm strongly against taking the road of "NUMA performance will
suck unless your app is NUMA aware" (ie default to non-local alloc).
OTOH, I don't like us crapping out under imbalance either. However,
I think there are other ways to solve this (see above).
 
>> Another way might be a tmpfs mount option ... I'd prefer that to a sysctl
>> personally, but maybe others wouldn't. Hugh, is that nuts?
> 
> I kind of like that -- it shouldn't be too hard to stuff into the tmpfs
> superblock.  But I agree, Hugh knows better than I do.

OK, that'd be under the sysadmin's control fairly easily at least. 

M>

