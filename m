Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbUCDF1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 00:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261388AbUCDF10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 00:27:26 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:22285
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261459AbUCDF1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 00:27:13 -0500
Date: Thu, 4 Mar 2004 06:27:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: peter@mysql.com, riel@redhat.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040304052753.GJ4922@dualathlon.random>
References: <20040228072926.GR8834@dualathlon.random> <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040303200704.17d81bda.akpm@osdl.org> <20040304045212.GG4922@dualathlon.random> <20040303211042.33cd15ce.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303211042.33cd15ce.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2004 at 09:10:42PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > On Wed, Mar 03, 2004 at 08:07:04PM -0800, Andrew Morton wrote:
> >  > That's a larger difference than I expected.  But then, everyone has been
> > 
> >  mysql is threaded
> 
> There is a patch in -mm's 4g/4g implementation
> (4g4g-locked-userspace-copy.patch) which causes all kernel<->userspace
> copies to happen under page_table_lock.  In some threaded apps on SMP this
> is likely to cause utterly foul performance.

I see, I wasn't aware about this issue with the copy-user code, thanks
for the info, I definitely agree having a profiling of the run would be
nice since it maybe part of the overhead is due this lock (though I
doubt it's most the overhead), so we can see if it was that spinlock
generating part of the slowdown.

> That's why I'm keeping it as a separate patch.  The problem which it fixes
> is very obscure indeed and I suspect most implementors will simply drop it
> after they'e had a two-second peek at the profile results.

I doubt one can ship without it without feeling a bit like cheating, the
garbage collectors sometime depends on mprotect to generate protection
faults, it's not like nothing is using mprotect in racy ways against
other threads.

> It is a judgement call.  Personally, I wouldn't ship a production kernel
> with this patch.  People need to be aware of the tradeoff and to think and
> test very carefully.

test what? there's no way to know what soft of proprietary software
people will run on the thing.

Personally I wouldn't feel safe to ship a kernel with a known race
condition add-on. I mean, if you don't know about it and it's an
implementation bug you know nobody is perfect and you try to fix it if
it happens, but if you know about it and you don't apply it, that's
pretty bad if something goes wrong.  Especially because it's a race,
even you test it, it may still happen only a long time later during
production. I would never trade performance for safety, if something I'd
try to find a more complex way to serialize against the vmas or similar.
