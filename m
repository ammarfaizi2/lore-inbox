Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936100AbWLAH5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936100AbWLAH5i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 02:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936105AbWLAH5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 02:57:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:54723 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S936100AbWLAH5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 02:57:37 -0500
Date: Fri, 1 Dec 2006 02:57:18 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Willy Tarreau <w@1wt.eu>
Cc: Keith Owens <kaos@ocs.com.au>, Andrew Morton <akpm@osdl.org>,
       Nicholas Miell <nmiell@comcast.net>, linux-kernel@vger.kernel.org,
       davem@davemloft.net, ak@suse.de
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Message-ID: <20061201075718.GR6570@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20061201052653.GB11835@1wt.eu> <23790.1164954762@kao2.melbourne.sgi.com> <20061201072816.GA16684@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201072816.GA16684@1wt.eu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 08:28:16AM +0100, Willy Tarreau wrote:
> Oh, I'm perfectly aware of this. That's in part why I started the hotfix
> branch in the past :-) But sometimes, fixes consist in merging all the
> patches from the maintenance branch (eg: from 4.1.0 to 4.1.1), and if
> this is the case, there would not be much justification not to simply
> update the version. In fact, what's really missing is a "fixlevel" in
> the packages, to inform the user that 4.1.0 as shipped by the distro
> has the same level of fixes as 4.1.1. But this is what the version is
> used for today.

This is even more complicated by the fact that upstream GCC release branches
(and also several Linux distributors) start announcing the upcoming version
already a few days after a release is tagged.
E.g. 14 days old gcc-4_1-branch says:
./xgcc -B ./ --version; ./xgcc -B ./ -dD -E -xc /dev/null | grep GNU
xgcc (GCC) 4.1.2 20061114 (prerelease)
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#define __GNUC__ 4
#define __GNUC_MINOR__ 1
#define __GNUC_PATCHLEVEL__ 2

but GCC 4.1.2 has not been released yet.
In Fedora Core/RHEL and I think a few other distros the version number
is only changed when it is officially released, e.g.:

gcc --version; gcc -dD -E -xc /dev/null | grep GNU
gcc (GCC) 4.1.1 20061011 (Red Hat 4.1.1-30)
Copyright (C) 2006 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

#define __GNUC__ 4
#define __GNUC_MINOR__ 1
#define __GNUC_PATCHLEVEL__ 1
#define __GNUC_RH_RELEASE__ 30

Note, 4.1.1 was released end of May this year and 4.1.2 has not been
released.  So, using __GNUC_PATCHLEVEL__ to detect if a bug has been fixed
or not isn't very useful (you'd need to rule out also __GNUC_PATCHLEVEL__ <= 1
because gcc-4_1-branch was announcing that patchlevel already since
beggining of March, on the other side there is a lot of GCCs with
__GNUC_PATCHLEVEL__ == 1 that certainly have that bug fixed).

You perhaps could parse the prerelease vs. release vs. vendor strings,
but that could be quite difficult, perhaps easier would be just parse the
date in the --version output.  Checking for the bug is best though, because
that will catch even backports of the bugfix without rebasing from the
release branch.

	Jakub
