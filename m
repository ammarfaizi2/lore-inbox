Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266243AbUA3Id4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 03:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266303AbUA3Id4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 03:33:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61418 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266243AbUA3Idy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 03:33:54 -0500
Date: Fri, 30 Jan 2004 03:33:10 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ulrich Drepper <drepper@redhat.com>, john stultz <johnstul@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040130083310.GH31589@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040129132623.GB13225@mail.shareable.org> <40194B6D.6060906@redhat.com> <20040129191500.GA1027@mail.shareable.org> <4019A5D2.7040307@redhat.com> <20040130041708.GA2816@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040130041708.GA2816@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 04:17:08AM +0000, Jamie Lokier wrote:
> Ulrich Drepper wrote:
> > > As this is x86, can't the syscall routines in Glibc call directly
> > > without a PLT entry?
> > 
> > No, since this is just an ordinary jump through the PLT.  That the
> > target DSO is synthesized is irrelevant.  It's ld.so which needs the PIC
> > setup, not the called DSO.
> 
> I have not explained well.  Please read carefully, as I am certain no
> indirect jumps on the userspace side are needed, including the one
> currently in libc.
> 
> It is possible to compile, assemble and link a shared library with
> -fno-PIC on x86, and this does work.  I just tested it to make sure.
> Furthermore, the "prelink" program is effective on these libraries.

Only if there are no prelink conflicts in the read-only sections.
Furthermore, there is additional overhead of remapping RW and back RX
and wasted page.  You can get around that by making a RWX section (which
ends up in the RW segment which gets a PF_X bit set as well), but that means
all the data in that segment is executable, which is obviously not
desirable, especially for libc.so.

> I'm talking about the "prelink" program.  When you run "prelink" on a
> libc.so which has direct jump instructions as described above, is
> patches the libc.so file to contain the address of the kernel entry
> point at the time "prelink" was run.

Prelink ATM doesn't take VDSO into account at all and surely it would
be best if it did not have to.  For example if VDSO is randomized, userspace
has no control over its placement like it has for shared libraries
(if DSO base is NULL, kernel randomizes, if non-NULL (usually means
prelinked), then does not randomize unless the binary is PIE).

	Jakub
