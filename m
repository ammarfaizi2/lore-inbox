Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbVHRQja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbVHRQja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 12:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbVHRQj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 12:39:29 -0400
Received: from ns2.suse.de ([195.135.220.15]:991 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932296AbVHRQj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 12:39:29 -0400
To: Wieland Gmeiner <e8607062@student.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc6 1/2] New Syscall: get rlimits of any process 	(update)
References: <1124326652.8359.3.camel@w2.suse.lists.linux.kernel>
	<p7364u40zld.fsf@verdi.suse.de.suse.lists.linux.kernel>
	<1124381951.6251.14.camel@w2.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 Aug 2005 18:39:27 +0200
In-Reply-To: <1124381951.6251.14.camel@w2.suse.lists.linux.kernel>
Message-ID: <p737jejtd1c.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wieland Gmeiner <e8607062@student.tuwien.ac.at> writes:

> On Thu, 2005-08-18 at 04:05 +0200, Andi Kleen wrote:
> 
> > Is there a realistic use case where this new system call is actually useful
> > and solves something that cannot be solved without it?
> 
> As an example: It seems to be a common problem with numerous services to
> run out of available file descriptors. There are several workarounds to
> this problem, the most common seems to be increasing the systemwide max
> number of filedescriptors and restarting the service. If you google for
> e.g. 'linux "too many open files"' you get a bunch of mailing list
> support requests about that problem.

Consider a process that runs out of fds. If that happens it's already
too late - it lost some of its files and is probably in a inconsistent
state internally because usually error handling parts for such things
are not working very well. The best thing to do is to restart it.

The only way to handle it properly would be to constantly monitor the
process and then try to increase it shortly before it runs out of
fds. First there is no reliable race free way to do this, and if you
really do all this overhead then it's far easier to just increase the
max number of fds in the first place.

In short your new call doesn't solve the problem in a sufficient way.

The real fix probably would be to just increase the default limits
even further, possible coupled with more aggressive per user memory
management. The main reason these limits tends to too small
is to avoid a user to fill up kernel memory too much, and there
is no global "per user" accounting which accounts all memory
used by a user. If that was available the per process limit
could be raised much further.

And e.g.  on 64bit machines there tends to be more usable low mem for
these purposes anyways so even without additional accounting the 
limits could be higher there.

-Andi
