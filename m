Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbTJAQak (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 12:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbTJAQ2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 12:28:17 -0400
Received: from hockin.org ([66.35.79.110]:6920 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262474AbTJAQ0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 12:26:30 -0400
Date: Wed, 1 Oct 2003 00:10:07 -0700
From: Tim Hockin <thockin@hockin.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, braam@clusterfs.com,
       rusty@rustcorp.com.au,
       Linux Kernel mailing list <linux-kernel@vger.kernel.edu>
Subject: Re: [PATCH] Many groups patch.
Message-ID: <20031001071007.GA29339@hockin.org>
References: <20030929155528.A14709@hockin.org> <Pine.LNX.4.44.0309291609460.12684-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309291609460.12684-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 29, 2003 at 04:10:23PM -0700, Linus Torvalds wrote:
> > On Mon, Sep 29, 2003 at 03:43:43PM -0700, Tim Hockin wrote:
> > > My version uses a struct group_info which has an array of pages.  The groups
> 
> I'm definitely happier about this one. 
> 
> Not that I'm any more thrilled about users using thousands of groups. But 
> this looks a bit saner.

OK, then.  Here's a brushed up version against 2.6.0-test6.  Linus, if you
like this, I can get it into a public BK for you.  If not, please indicate
the issues.



Summary: Get rid of the NGROUPS hard limit.

This patch removes all fixed-size arrays which depend on NGROUPS, and
replaces them with struct group_info, which is refcounted, and holds an
array of pages in which to store groups.  groups_alloc() and groups_free()
are used to allocate and free struct group_info, and set_group_info is used
to actually put a group_info into a task.  Groups are sorted and b-searched
for efficiency.  Because groups are stored in a 2-D array, the GRP_AT()
macro was added to allow simple 1-D style indexing.

This patch touches all the compat code in the 64-bit architectures.
These files have a LOT of duplicated code from uid16.c.  I did not try to
reduce duplicated code, and instead followed suit.  A proper cleanup of
those architectures code-bases would be fun.  Any sysconf() which used to
return NGROUPS now returns INT_MAX - there is no hard limit.

This patch also touches nfsd by imposing a limit on the number of groups in
an svc_cred struct.

This patch modifies /proc/pid/status to only display the first 32 groups.

This patch removes the NGROUPS define from all architectures as well as
NGROUPS_MAX.

This patch changes the security API to check a struct group_info, rather
than an array of gid_t.

This patch totally horks Intermezzo.

This was built and tested against 2.6.0-test6 (BK today) on an i386.
