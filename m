Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbTJAVXV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 17:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbTJAVXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 17:23:21 -0400
Received: from hockin.org ([66.35.79.110]:29193 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262573AbTJAVXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 17:23:15 -0400
Date: Wed, 1 Oct 2003 14:12:08 -0700
From: Tim Hockin <thockin@hockin.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Many groups patch.
Message-ID: <20031001211208.GB30014@hockin.org>
References: <20031001202910.GA30014@hockin.org> <Pine.LNX.4.44.0310011344070.838-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310011344070.838-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 01:46:55PM -0700, Linus Torvalds wrote:
> How about just putting it in "gid16.c" and then adding a CONFIG_GID16
> config variable. Then architectures that want it (pretty much all, no?)  
> can then obviously just do the
> 
> 	config GID16
> 		bool
> 		default y

uid16 has this same code in it, which could be moved to gid16.  The problem
is that architectures that currently use CONFIG_UID16 expect to use
old_gid_t and get all the highuid.h magic.  The 64-bit architectures want to
use stuff from uid16 (and by extension gid16) but they don't want it ALL the
time, just in their compat code.  Therefore, they don't have old_gid_t as 16
bits.

You end up with tons of duplicated code in the 64-bit architectures (most
copies straight from uid16.c  s/old_gid_t/short/).

You end up with places that include highuid.h and then undef functions and
redefine them exactly the same  s/old_gid_t/short/.

The gid16 way would work, but doesn't solve the real problem, which is all
the duplicated code and differing types.  Some use old_gid_t, some use
short, some use u16.

What if I broke CONFIG_UID16 into CONFIG_UID16_SYSCALLS and CONFIG_OLDUID?
UID16_SYSCALLS would make the build compile uid16.c.  CONFIG_OLDUID would
activate high2lowuid() and friends.  It would involve copying some of
highuid.h into uid16.c to make uid16.c always do high2lowuid().  But what
types?

Your call - I'll make gid16.c if that's good enough for you.  Or if you
prefer, I'll do a separate patch in which we find a way to REALLY solve it.

Here's the prior fixups but not the gid16 duplicated code cleanups.  If the
rest of this patch meets approval, I'll be happy to go ahead on whatever you
prefer for gid16 stuff.
o
-- 
Notice that as computers are becoming easier and easier to use,
suddenly there's a big market for "Dummies" books.  Cause and effect,
or merely an ironic juxtaposition of unrelated facts?

