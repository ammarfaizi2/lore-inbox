Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267675AbUBTHKi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 02:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267658AbUBTHKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 02:10:38 -0500
Received: from [66.35.79.110] ([66.35.79.110]:968 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S267675AbUBTHKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 02:10:34 -0500
Date: Thu, 19 Feb 2004 23:10:28 -0800
From: Tim Hockin <thockin@hockin.org>
To: Andrew Morton <akpm@osdl.org>
Cc: thockin@sun.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: PATCH: report NGROUPS_MAX via a sysctl (read-only)
Message-ID: <20040220071028.GA4948@hockin.org>
References: <20040220023927.GN9155@sun.com> <20040219213028.42835364.akpm@osdl.org> <20040220063519.GP9155@sun.com> <20040219224752.44da2712.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219224752.44da2712.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 10:47:52PM -0800, Andrew Morton wrote:
> > > Why does userspace actually care?  You try to do an oversized setgroups(),
> > > so you get an error?
> > 
> > I am systematically tracking down apps that use it.  glibc is almost free of
> > it.  sysconf() still uses it, but as long as the value compiled into glibc
> > as NGROUPS_MAX is less-than-or-equal-to the current kernel's idea, it meets
> > POSIX, right?  If any one goes into their kernel source and lowers
> > NGROUPS_MAX they might break things, but I guess that isn't too big of a
> > worry.  Some apps are still assuming that the value they get from sysconf()
> > is the absolute max number of groups.  Anyone with libc compiled against an
> > older kernel will see 32, when they could have 64k.
> 
> OK, well certainly fishing the number out of the currently-running kernel
> is the one sure way of getting it right.

Well, really I don't see how apps would want to use it in any way that was
correct.  You can't use it as the size of an array.  If it WERE defined as
INT_MAX...  :)

On the other hand, some obsessive-compulsive part of me says that a constant
like that SHOULD be exposed.  Which is why I asked about doing either a
sys_sysconf() call to expose those, or adding something to
sysfs/procfs/somethingfs to gather all the sysconf-mandated constants and
maybe other kernel constants.

> > > And why does NGROUPS_MAX still exist, come to that?  AFAICT the only thing
> > 
> > Because Linus would not let me set it to INT_MAX. Something about
> > "insanity" ;)
> 
> Is 64k enough?

64k makes our users happy.  It was a concession that had to be made.  Now
that the infrastructure for allocating, sorting, and searching is in place,
any user can change NGROUPS_MAX to 128k or 256k or INT_MAX and recompile -
no other work needed.  That's far better than where we were.

Of course, if we DON'T expose things like NGROUPS_MAX, then userspace won't
know if the user changes it to 256k.  But then again, what would they be
using it for that would not be wrong?  I'm not sure it is for the kernel to
say "you don't need to know this".
