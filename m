Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWFKFUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWFKFUY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 01:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWFKFUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 01:20:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62408 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932091AbWFKFUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 01:20:23 -0400
Date: Sat, 10 Jun 2006 22:19:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Neil Brown <neilb@suse.de>
cc: Jeff Garzik <jeff@garzik.org>, Theodore Tso <tytso@mit.edu>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Chase Venters <chase.venters@clientec.com>,
       Alex Tomas <alex@clusterfs.com>, Andreas Dilger <adilger@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com,
       linux-fsdevel@vger.kernel.org
Subject: Re: Stable/devel policy - was Re: [Ext2-devel] [RFC 0/13] extents
 and 48bit ext3
In-Reply-To: <17547.40585.982575.7069@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0606102207030.5498@g5.osdl.org>
References: <Pine.LNX.4.64.0606090933130.5498@g5.osdl.org>
 <20060609181020.GB5964@schatzie.adilger.int> <Pine.LNX.4.64.0606091114270.5498@g5.osdl.org>
 <m31wty9o77.fsf@bzzz.home.net> <Pine.LNX.4.64.0606091137340.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606091347590.5541@turbotaz.ourhouse> <4489C580.7080001@garzik.org>
 <17D07BC0-4B41-4981-80F5-7AAEC0BB6CC8@mac.com> <Pine.LNX.4.64.0606101238110.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606101248030.5498@g5.osdl.org> <20060610212624.GD6641@thunk.org>
 <448B45ED.1040209@garzik.org> <17547.40585.982575.7069@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 11 Jun 2006, Neil Brown wrote:
> 
> I'm wondering what all this has to say about general principles of
> sub-project development with the Linux kernel.

Yes. That's an interesting and relevant tangent.

> Due to the (quite appropriate) lack of a stable API for kernel
> modules, it isn't really practical (and definitely isn't encouraged)
> to distribute kernel-modules separately.  This seems to suggest that
> if we want a 'stable' and a 'devel' branch of a project, both branches
> need to be distributed as part of the same kernel tree.
> 
> Apart from ext2/3 - and maybe reiserfs - there doesn't seem to be much
> evidence of this happening.  Why is that?

I think part of it is "expense". It's pretty expensive to maintain on a 
bigger scale. For example, you mention "-mm", and there's no question that 
it's _very_ expensive to do that (ie you basically need a very respected 
person who must be spending a fair amount of effort and time on it).

Even in this case, I think a large argument has been that ext3 itself 
isn't getting a lot of active development outside of the suggested ext4 
effort, so the "expense" there is literally just the copying of the files. 
That works ok for a filesystem every once in a while, but it wouldn't 
scale to _everybody_ doing it often. 

Also, in order for it to work at all, it obviously needs to be a part of 
the kernel that -can- be duplicated. That pretty much means "filesystem" 
or "device driver". Other parts aren't as amenable to having multiple 
concurrent versions going on at the same time (although it clearly does 
happen: look at the IO schedulers, where a large reason for the pluggable 
IO scheduler model was to allow multiple independent schedulers exactly so 
that people _could_ do different ones in parallel).

People have obviously suggested pluggable CPU schedulers too, and even 
more radically pluggable VM modules (not that long ago).

> It seems a bit rough to insist that the ext-fs fork every so-often,
> but not impose similar requirements on other sections of code.

Well, as mentioned, it's actually quite common in drivers. It's clearly 
not the _main_ development model, but it's happened several times in 
almost every single driver subsystem (ie SCSI drivers, video drivers, 
network drivers, USB, IDE, have _all_ seen "duplicated" drivers where 
somebody just decided to do things differently, and rather than extend an 
existing driver, do an alternate one).

So it's not like this is _exceptional_. It happens all the time. It 
obviously happens less than normal development (we couldn't fork things 
every time something changes), but it's not unheard of, or even rare.

> So: what would you (collectively) suggest should be the policy for
> managing substantial innovation within Linux subsystems?  And how
> broadly should it be applied?

I think the interesting point is how we're moving away from the "global 
development" model (ie everything breaks at the same time between 2.4.x 
and 2.6.x), and how the fact that we're trying to maintain a more stable 
situation may well mean that we'll see more of the "local development" 
model where a specific subsystem goes through a development series, but 
where stability requirements mean that we must not allow it to disturb 
existing users.

And even more interestingly (at least to me), the question might become 
one of "how does that affect the tools and build and configuration 
infrastructure", and just the general flow of development.

I don't think one or two filesystems (and a few drivers) splitting is 
anythign new, but if this ends up becoming _more_ common, maybe that 
implies a new model entirely..

		Linus
