Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285259AbRLFW0p>; Thu, 6 Dec 2001 17:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285255AbRLFW0e>; Thu, 6 Dec 2001 17:26:34 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:41089 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S285256AbRLFW0X>; Thu, 6 Dec 2001 17:26:23 -0500
Message-ID: <3C0FEF74.D2C726E8@us.ibm.com>
Date: Thu, 06 Dec 2001 14:21:40 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] cpus_allowed/launch_policy patch, 2.4.16
In-Reply-To: <3C0ECBE0.F21464FA@us.ibm.com>
		<Pine.LNX.4.40.0112051800400.1644-100000@blue1.dev.mcafeelabs.com> 
		<3C0ED52E.B15F0ED7@us.ibm.com> <1007606568.814.15.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> On Wed, 2001-12-05 at 21:17, Matthew Dobson wrote:
> 
> > but, as soon as one of them exec()'s their no longer going to be using your
> > functions.
> 
> But cpus_allowed is inherited, so why does it matter?
You're right, cpus_allowed would inherit just fine on its own, but...

> 
> The only benefit I see to having it part of the fork operation as
> opposed to Ingo's or my own patch, is that the parent need not be given
> the same affinity.
...this is the important part.  As soon as you start a process executing 
on a particular CPU/Node (more important on a NUMA box) it begins to develop
a memory footprint.  Things start getting allocated to that CPU's or Node's
memory.  When you push the process to a different node for no good reason
(just to fork() and then come back to the original node) it is inefficient.
You are going to be causing all kinds of remote memory accesses that don't need
to happen.  As the kernel gets more NUMA-aware, this will be even more of a
discrepancy between the two methods.

> 
> And honestly I don't see that as a need.  You could always change it
> back after the exec.  If that is unacceptable (you point out the cost of
> forcing a task on and off a certain CPU), you could just have a wrapper
> you exec that changes its affinity and then it execs the children.
This seems to me to be a bit of a kludgy (although perfectly valid) way of 
doing something that could be done much more elegantly and efficiently with 
a launch_policy.  If you use the wrapper method, the task structure and 
various other internal kernel data structures could be allocated on the
incorrect node.  This data will eventually migrate to the correct place,
but why start the process out on the wrong foot, when the cost of doing
the correct allocation is so small (or nonexistent)?

Cheers!

-matt
