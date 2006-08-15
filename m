Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752095AbWHODx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbWHODx6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 23:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752096AbWHODx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 23:53:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12230 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752095AbWHODx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 23:53:57 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: What's in kbuild.git for 2.6.19 
In-reply-to: Your message of "Mon, 14 Aug 2006 12:02:55 MST."
             <20060814120255.A25857@unix-os.sc.intel.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Aug 2006 13:53:37 +1000
Message-ID: <20560.1155614017@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 12:02:09AM -0700, Keith Owens wrote:
>Sam Ravnborg (on Sun, 13 Aug 2006 21:45:03 +0200) wrote:
>>Outstanding kbuild issues (I should fix a few of these for 2.6.18):
>>o make -j N is not as parallel as expected (latest report from Keith
>>  Ownens but others has complained as well). I assume it is a kbuild
>>  thing but has no clue how to fix it or debug it further.
>
>It is the make jobserver code.  make -j<n> causes the various make
>tasks to communicate and work out how many versions are currently
>running, to avoid overrunning the -j<n> value.  Every recursive
>invocation of make subtracts one from the -j value, reducing the value
>that is left when make finally get down to doing some useful work
>instead of just recursing.  Jobserver problems are yet another reason
>why recursive make is bad.
>
>kbuild is full of recursive make.  The user cannot just add an excess
>to <n>, the number of recursive invocations changes from kernel to
>kernel as people try to fix bugs in makefile generation, so the
>required excess value keeps changing.

This is beginning to look like a bug in make which is exacerbated by
the large number of recursive make commands issued in 2.6.  Using an
instrumented version of make 3.80, I see some jobserver tokens being
consumed and not returned to the pool, which results in a restricted
number of processes actually running.

The bug is timing dependent, it depends on when child processes die and
are reaped relative to the rest of the make process tree.  Recursive
make generates many more processes when compared to running make
against a single Makefile, these extra processes affect the timing.

I am testing a couple of patches against make which will be going to
gnu.org.  When I get a reply from gnu.org I will do a follow up to
lkml.

BTW, make -j<n> does not quite do what you expect.  info make says "If
the '-j' option is followed by an integer, this is the number of
commands to execute at once".  Looking at the source for make, the top
level make task actually consumes one of those slots, even though it
does little except run sub-makes.  Even with my bug fix, make -j4
really only uses about 3.3 cpus, 3 doing compiles and about 0.3 of a
load keeping track of the first level sub-makes.

