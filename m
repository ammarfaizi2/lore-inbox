Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWFBLiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWFBLiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 07:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWFBLiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 07:38:19 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:63691 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751037AbWFBLiS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 07:38:18 -0400
Subject: Re: [RFC 3/5] sched: Add CPU rate hard caps
From: Matt Helsley <matthltc@us.ibm.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       dev@openvz.org, Srivatsa <vatsa@in.ibm.com>,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Con Kolivas <kernel@kolivas.org>, Sam Vilain <sam@vilain.net>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>
In-Reply-To: <447F956B.3090402@bigpond.net.au>
References: <200606020003.51504.a1426z@gawab.com>
	 <447F956B.3090402@bigpond.net.au>
Content-Type: text/plain
Date: Fri, 02 Jun 2006 04:23:04 -0700
Message-Id: <1149247384.28649.691.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 11:33 +1000, Peter Williams wrote:
> Al Boldi wrote:
> > Chandra Seetharaman wrote:
> >> On Thu, 2006-06-01 at 14:04 +0530, Balbir Singh wrote:
> >>> Kirill Korotaev wrote:
> >>>>> Do you have any documented requirements for container resource
> >>>>> management?
> >>>>> Is there a minimum list of features and nice to have features for
> >>>>> containers
> >>>>> as far as resource management is concerned?
> >>>> Sure! You can check OpenVZ project (http://openvz.org) for example of
> >>>> required resource management. BTW, I must agree with other people here
> >>>> who noticed that per-process resource management is really useless and
> >>>> hard to use :(
> >> I totally agree.
> >>
> >>> I'll take a look at the references. I agree with you that it will be
> >>> useful to have resource management for a group of tasks.
> > 
> > For Resource Management to be useful it must depend on Resource Control.  
> > Resource Control depends on per-process accounting.  Per-process accounting, 
> > when abstracted sufficiently, may enable higher level routines, preferrably 
> > in userland, to extend functionality at will.  All efforts should really go 
> > into the successful abstraction of per-process accounting.
> 
> I couldn't agree more.  All that's needed in the kernel is low level per 
> task control and statistics gathering.  The rest can be done in user space.

<snip>

	I'm assuming by "The rest can be done in user space" you mean that
tasks can be grouped, accounting information updated (% CPU), and
various knobs (nice) can be turned to keep task resource (CPU) usage
under control.

If I seem to be describing your suggestion then I don't think it will
work. Below you'll find the reasons I've come to this conclusion. Am I
oversimplifying or misunderstanding something critical?

	Groups are needed to prevent processes from consuming unlimited
resources using clone/fork. However, since our accounting sources and
control knobs are per-task we must adjust per-task knobs within a group
every time accounting indicates a change in resource usage.

	Let us suppose we have a UP system with 3 tasks -- group X: X1, X2; and
Z. By adjusting nice values of X1 and X2 Z is responsible for ensuring
that group X does not exceed its limit of 50% CPU. Further suppose that
X1 and X2 are each using 25% of the CPU. In order to prevent X1 + X2
from exceeding 50% each must be limited to 25% by an appropriate nice
value. [Note the hand wave: I'm assuming nice can be mapped to a
predictable percentage of CPU on a UP system.]

	When accounting data indicates X2 has dropped to 15% of the CPU, Z may
raise X1's limit (to 35% at most) and it must lower X2's limit (down to
as little as 15%). Z must raise X1's limit by some amount (delta)
otherwise X1 could never increase its CPU usage. Z must decrease X2 to
25 - delta, otherwise the sum could exceed 50%. [Aside: In fact, if we
have N tasks in group X then it seems Z ought to adjust N nice values by
a total of delta. How delta gets distributed limits the rate at which
CPU usage may increase and would ideally depend on future changes in
usage.]

There are two problems as I see it:

1) If X1 grows to use 35% then X2's usage can't grow back from 15% until
X1 relents. This is seems unpleasantly like cooperative scheduling
within group X because if we take this to its limit X2 gets 0% and X1
gets 50% -- effectively starving X2. What little I know about nice
suggests this wouldn't really happen. However I think may highlight one
case where fiddling with nice can't effectively control CPU usage.

2) Suppose we add group Y with tasks Y1-YM, Y's CPU usage is limited to
49%, each task of Y uses its limit of (M/49)% CPU, and the remaining 1%
is left for Z (i.e. the single CPU is being used heavily). Z must use
this 1% to read accounting information and adjust nice values as
described above. If X1 spawns X3 we're likely in trouble -- Z might not
get to run for a while but X3 has inheritted X1's nice value. If we
return to our initial assumption that X1 and X2 are each using their
limit of 25% then X3 will get limited to 25% too. The sum of Xi can now
exceed 50% until Z is scheduled next. This only gets worse if there is
an imbalance between X1 and X2 as described earlier. In that case group
X could use 100% CPU until Z is scheduled! It also probably gets worse
as load increases and the number of scheduling opportunities for Z
decrease.


	I don't see how task Z could solve the second problem. As with UP, in
SMP I think it depends on when Z (or one Z fixed to each CPU) is
scheduled.

	I think these are simple scenarios that demonstrate the problem with
splitting resource management into accounting and control with userspace
in between.

Cheers,
	-Matt Helsley

