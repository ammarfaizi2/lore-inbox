Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVADSW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVADSW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbVADSWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:22:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:35768 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261767AbVADSWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:22:06 -0500
Date: Tue, 4 Jan 2005 13:20:17 -0500
From: Dave Jones <davej@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Bill Davidsen <davidsen@tmr.com>, "L. A. Walsh" <law@tlinx.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Reviving the concept of a stable series (was Re: starting with 2.7)
Message-ID: <20050104182017.GE19167@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Bill Davidsen <davidsen@tmr.com>, "L. A. Walsh" <law@tlinx.org>,
	linux-kernel@vger.kernel.org
References: <41D91707.6040102@tlinx.org> <41D9C53A.3030503@tmr.com> <20050104130846.GD2708@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104130846.GD2708@holomorphy.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 05:08:46AM -0800, William Lee Irwin III wrote:
 > On Mon, Jan 03, 2005 at 05:20:42PM -0500, Bill Davidsen wrote:
 > > If the -rc process were in place, new feature freeze until the big green 
 > > bugs were fixed just before the next release, that actually might be 
 > > most of a solution.
 > > No one bug akpm can accurately asses how well fixes come back from 
 > > vendors, but I suspect that the kernel is moving too fast and vendors 
 > > "pick one" and stabilize that, by which time the kernel.org is 
 > > generations down the road. It's possible that some fixes are then 
 > > rediffed against the current kernel and fed, but I have zero information 
 > > on that happening or not.
 > 
 > It does happen. I can't give a good estimate of how often. Someone at a
 > distro may be able to help here, though it's unclear what this specific
 > point is useful for.
 
Pull up a chair, this is going to be a long one.

When we shipped Fedora Core 3, we drew a line in the sand, and
decided that 2.6.9 was the kernel we were going to ship with.
It happened to coincide nicely with the final release date, and
everyone was happy.

Post release, the myriad of users filled RH bugzilla diligently
with their many reports of interesting failures.  Upstream had
now started charging ahead with what was to be 2.6.10.

The delta between 2.6.9 -> 2.6.10 was around 4000 changesets.
Cherry picking csets to backport to 2.6.9 at this rate of
change is nigh on impossible. You /will/ miss stuff.
In the absense of a 2.6.9.1, we chose to use Alan's -ac
patches as a base to pick up most of the interesting meat,
and then cherry pick anything else which people had noticed
go past, or in some cases, after investigation into a
bugreport.

So now we're at our 2.6.9-ac+a few dozen 2.6.10 csets
and all is happy with the world. Except for the regressions.
As an example, folks upgrading from Fedora core 2, with its
2.6.8 kernel found that ACPI no longer switched off their
machines for example. Much investigation went into
trying to pin this down. Kudos to Len Brown and team for
spending many an hour staring into bug reports on this
issue, but ultimately the cause was never found.
It was noted by several of our users seeing this problem
that 2.6.10 no longer exhibits this flaw.  Yet our
2.6.9-ac+backports+every-2.6.10-acpi-cset also was broken.
It's likely Fedora will get a 2.6.10 based update before
the fault is ever really found for a 2.6.9 backport.

This is just one example of a regression that crept in
unnoticed, and got fixed almost by accident. (If it
was intentionally fixed, we'd know which patches
we needed to backport 8-)

For distro kernels to be the 'stable' branch, we *rely*
on help from various subsystem maintainers to continue
to bugfix old kernels, despite it being unsexy.
I admit it's painful, and given the option, replying
"just use 2.6.10-bk6" is a much easier alternative,
but with thousands of changes going into tree each
month, it's not feasable for a distro to ship updates
on that basis without something happening to deal with
regressions.

As for stuff going back upstream.. You may be surprised how
many bugs our 2.6.9-ac-many-backports hybrid has turned up
which turned out to be just as relevant on 2.6.10
Here's the patchcount in our current trees..

Fedora Core 2:     245
Fedora Core 3:      63
Rawhide:            76

FC2 is our 2.6.9 hybrid (the fc3 kernel got backport to fc2
as an update), FC3 is a rebase to 2.6.10-ac2.
rawhide (FC4-to-be) is 2.6.10-bk6.

Note we still have 63 patches in FC3. Out of those, just over
a dozen are 'features' that we added. The majority of the
rest are real bugfixes, currently languishing in out-of-tree
repositories for projects like NFS, s390, e1000 updates etc..
Note also that when FC3 first shipped, before we started
backporting 2.6.10 bits, the patchcount was around 40 or so,
so in the 2.6.9->2.6.10 rebase, we 'grew' around 13 patches.
Each time I rebase to a new upstream, I want to get back to
(or better than) the original patchcount where possible.
When this doesn't happen, it means we're accumulating stuff
that isn't making its way upstream fast enough.

So, of those 182 patches we dropped in our 2.6.10 rebase..
Some of them were upstream backports, but some of them were
patches we pushed upstream that we now get to drop on a rebase.
So the push/pull ecosystem is working out pretty well in this regard
Whilst I'd like to get even more of this stuff upstream,
it's the job of those out-of-tree pool maintainers to push
their work, not mine.

		Dave

