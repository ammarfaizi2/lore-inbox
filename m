Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269351AbUJKXLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269351AbUJKXLv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 19:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269352AbUJKXLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 19:11:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:20668 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269351AbUJKXKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 19:10:03 -0400
Date: Mon, 11 Oct 2004 16:09:47 -0700
Message-Id: <200410112309.i9BN9lXO031634@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: joshk@triplehelix.org (Joshua Kwan)
X-Fcc: ~/Mail/linus
Cc: Andrew Morton <akpm@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
In-Reply-To: Joshua Kwan's message of  Monday, 11 October 2004 14:16:05 -0700 <20041011211605.GD3316@triplehelix.org>
X-Windows: the problem for your problem.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> All I know is that this doesn't happen in kernels where the waitid patch
> was not applied. It has *NEVER* happened until now.

That's obviously suggestive, but it's real hard to know whether it's just a
coincidental perturbation of the timing or who-knows-what triggering a bug
elsewhere, or a new kernel bug, without more concrete information about
what goes wrong.

If you can work more on providing a way for people like me and Andrew to
get this to reproduce for us, then we will be able to make quick progress
from there.  Right now, all we can really do is make suggestions to you for
how to proceed with debugging and you'll have to be the one to dig up more.

> Possibly it was strace catching the wrong end of whatever make was doing
> when it started ptracing it.

I don't know any sane scenario that would result in the value you showed in
that wait4 call from strace.  We really need to learn more about how that
happens.  

> Could it be glibc's problem.

This seems unlikely unless you changed your glibc very recently, but
anything is possible.  I think you should continue to work with tools like
strace and/or gdb to figure out where this bogus value comes from.  

If you have trouble catching make losing in gdb, you could also do
something funky like hack your kernel to do something like:

	if (pid != -1 && (pid & 0xff000000)) 
		force_sig_specific(SIGSEGV, current);

in do_waitid.  This should cause make to dump core at the bogus system
call, and then you could examine the core file with gdb to learn more about
how it wound up passing that bogus value.


Thanks,
Roland

