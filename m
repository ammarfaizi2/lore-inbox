Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUC3IGQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 03:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263436AbUC3IGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 03:06:15 -0500
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:19722
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263365AbUC3IGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 03:06:07 -0500
Date: Tue, 30 Mar 2004 00:01:42 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: Storage Architect Part 1: Re: [PATCH] speed up SATA (resend 3)
Message-ID: <Pine.LNX.4.10.10403300000270.11654-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



##### FIRST, FLAME OFF #####

Why not make BLOCK intelligent?  Spilt transfer sizes by direction?

READ has a smaller request size, while WRITE has a larger one or dynamic?

Clearly this would require BLOCK become adaptive to the transport layer,
and this is the same drum I have beaten in the past and will roll out one
more time.  While I am here, will expose an overview for 2.7.  Lets talk
about the design shortage in all of storage for Linux and put nice big fat
labels and subsystem under achievements (my previous work, too).

This is going to touch a lot of sensitive areas and bruse a lot of ego's,
and by now everyone knows I really do not care which maintainer is
offended or made to look bad (myself included), all I care about is the
enduser's experience with data integrity and stablity.  If anyone choose
to focus on the small issues (stupid anal kernel politics, ego's, blowing
horns, screaming foul, blah blah), be nice about it ... Whatever and get
over it ... you are not that important and have zero value to the people
who depending on your so called expertise.  This statement is only valid
for those who are so arrogant to not listen to what is important for the
endusers.  This is not a two-bit graduate student thesis, it is a real
value <offending spam filter word removed!> to be deployed.

Areas effected are Low-level transport, Block, VM (swap), scheduler, file
systems ... the remainder of the kernel is trivial and only needed for
execution.  I have a bias in priority of listing and will clearly justify
why these are requirements.

1) Low-level device driver
2) Block, VM (swap), scheduler
3) file systems

LLDD is to and will always specify its requirements to properly statistfy
its requirements to correctly, period.  Failure to model the requirements
of the FSM (or Bus-Phase) is begging for problems.

LLDD expects and requires a fastpath notification back to the application
layer and should deploy enhanced error recovery path to secure data to
platter or media regardless.

Since File-Systems are generally the agent caller (ie the effective
application layer) then need to have the ability to recover and protect
data regardless, with the few exceptions to be listed later.

Scheduler is the most painful and in the past the strangest creature of
the lot.  It has its grasp on way to many kernel policies which defer IO
and will/have cause/d problems observed in the past (may still be present
today).  Recall the rules "NO KERNEL POLICIES" this according to the
benevolent dictator himself, Linus Torvalds.

VM, I can now see the war between Andrea and Rik (names are in
alphabetical, as not to get roasted) will spiral into something worthless.
The key point is priorty event schedule access for SWAP and an modified
extention of page aging applied to block requests only on writes!  Failure
to properly address priority events like SWAP will have side effects of
increased OOMage.

<very important point!>
Request Aging is a requirement for protecting the data commits on writes.
This most basic shortage will corrupt data, on a PCI master abort where
writeback caching is enabled.  This error is so painful and fatal, that it
can not be stressed enough.  I have never been able to express this point
clearly for people to understand, and do not expect but one or two people
to get it.

Request Aging must be FOUR (4) times the detected size of expected
writeback cache, period.  In conjunction one must add to all LLDD's the
functional equivalent of "READ VERIFY".

Flush Cache is cute, but latency (wank wank) can/will get its doors blown
off.

The painful details will be covered later.
</very important point!>

Latency is a trivial joke and label everyone wants to toss around.
What does it actually mean and how does it apply to storage, or does
anyone even care?

Providing nobody elects to roast me for being blunt, I will return with a
full model in the next several segments.  With any luck I will make the
points clear and the reasons why rational.

S: Why different and flexable requests sizes are needed.
S: Why Request Aging is as important or more than VM's.
S: Why priority markers or classes are needed for requests.
S: Why scheduler is brain damaged, first three titles are missing.
S: Why goto platter, when filesystem invalidates request.
S: Why filesystems are cute bitbuckets which act like Crazy Ivan.
	(submarine term, not cultural or political)

There are a few more things which have really bugged me of the past 6+
years.  If people are willing to cut me a little slack and realize email
is not my strong suit for communicating points, I will maintain pure
technical points, otherwise it is easier to walk away and not care.

Lastly if nobody cares about my input please say so now and include a
direct reply in addition to a CC.  "Anything@vger.kernel.org" is procmail
sorted and never looked at until someone emails me directly and tells me
to go look for a specific subject.

Kind Regards,

Andre Hedrick
LAD Storage Consulting Group





