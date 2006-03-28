Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWC1Jm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWC1Jm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 04:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWC1Jm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 04:42:57 -0500
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:53411 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751282AbWC1Jm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 04:42:57 -0500
In-Reply-To: <1143489794.2886.43.camel@laptopd505.fenrus.org>
Subject: Re: RFC - Approaches to user-space probes
Sensitivity: 
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       davem@davemloft.net, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       prasanna@in.ibm.com, suparna@in.ibm.com,
       "Theodore Ts'o" <tytso@mit.edu>
X-Mailer: Lotus Notes Release 6.5.1IBM February 19, 2004
Message-ID: <OF74E934C4.97847922-ON8025713F.00310595-8025713F.00355BC1@uk.ibm.com>
From: Richard J Moore <richardj_moore@uk.ibm.com>
Date: Tue, 28 Mar 2006 10:42:48 +0100
X-MIMETrack: Serialize by Router on D06ML065/06/M/IBM(Release 6.53HF247 | January 6, 2005) at
 28/03/2006 10:43:20
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





I think the example of probes on  malloc is possibly not a good one. And I
think also that one has to accept that there can be no tool that will be a
panacea for all problems.  So, for me it comes down to whether one should
make life easier when dealing with:

1) a class of problems that are more easily tackled using a global or
module-orientated probing mechanism

Consider a server process to which work is queued asynchronously via a
shared library.
Here is culprit process or processes might well not be known at the start
of diagnosis.

2) system problems that have side effects in user-space.

Because probe-handlers operate in kernel space, access to all kernel and
CPU state data is available when the probe fires as well as user space
data.
I sometimes hear the argument that because user-space can't or shouldn't
cause the kernel to die then there's no need to support system-wide
debugging tools.
To me that's limiting the problem space to kernel crashes, but more
significantly doesn't permit the existence of a problem where user-space
could significantly affect the kernel in an adverse way.  The converse
however is always true - user-space can easily be adversely affect by
kernel space - a rogue driver for example.

3) User problems that have side-effects in the kernel or device interface.
Problems that are IO related come to mind: correlation of user events and
user data with driver device events and data is more easily handled though
a tool that can easily get a all these items data.

It will always be the case that there are harder ways to tackle global
problems using process-orientated tools and conversely simpler ways to
tackle process-specific problems than using system-orientated tools. But I
do think that ptrace won't scale to a global or system-wide level without
switching its internal mechanism to something along the lines of krprobes.
There are two reason I can think of:

1) ptrace is orientated to debugging a specific process tree and a
nominated debug process. Having it operate on arbitrary process would
require kernel extensions to achieve that but would also have a major
impact on performance if each event were to result in a context switch to
the debugger process.

2) ptrace operates by privatizing memory via COW, but kprobes doesn't. The
probes are fixed-up when a page is brought into memory by using an alias
r/w virtual address. Using existing the ptrace mechanism across all, or
most, processes could have a significant affect on swapfile and paging
rate. And that has to be bad news when investigating performance and race
conditions problems.

If we want to make life easier for debugging the types of problems
indicated above, then it's seems very reasonable to ask whether ptrace can
be extended to use the (user) kprobes mechanism.


Richard J Moore


Arjan van de Ven <arjan@infradead.org> wrote on 27/03/2006 20:03:14:

> On Mon, 2006-03-27 at 15:30 +0530, Prasanna S Panchamukhi wrote:
> > On Mon, Mar 27, 2006 at 09:37:48AM +0200, Arjan van de Ven wrote:
> > > On Mon, 2006-03-27 at 12:24 +0530, Prasanna S Panchamukhi wrote:
> > >
> > > > - Low overhead and user can have thousands of active probes on the
> > > >   system and detect any instance when the probe was hit including
> > > >   probes on shared library etc.
> > >
> > > I suspect this is the only reason for doing it inside the kernel;
> > > anything else still really shouts "do it in userspace via ptrace" to
me.
> > >
> >
> > Other reasons would be:
> >
> > - to view some privilaged data, such as system regs while you are
> >   debugging in user-space
>
> root can do that anyway afaics
>
> > - to view many arbitrary process address-space that use a common set
> >   of modules - user or kernel space
>
> that's just a matter of userspace tooling.
>
> > Yes, insertion of the breakpoint happens at the physical
> > page level and it gets written back to the disc.
>
> at which point you get to deal with tripwire and other intrusion
> detection systems.... and you prevent doing this on binaries residing on
> read-only mounts (which isn't as uncommon as it sounds, read only
> shared /usr is quite common in enterprise)
>

