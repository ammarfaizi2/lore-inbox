Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267457AbUH3Iac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267457AbUH3Iac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 04:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbUH3Iac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 04:30:32 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:6624 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S267457AbUH3Ia1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 04:30:27 -0400
Date: Mon, 30 Aug 2004 10:29:00 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: John Hesterberg <jh@sgi.com>
cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Arthur Corliss <corliss@digitalmages.com>,
       Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>, erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       Ragnar Kj?rstad <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
In-Reply-To: <20040827193134.GA3706@sgi.com>
Message-ID: <Pine.LNX.4.53.0408301001210.16164@gockel.physik3.uni-rostock.de>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org>
 <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.58.0408261111520.22750@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de>
 <20040827054218.GA4142@frec.bull.fr> <20040827193134.GA3706@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, John Hesterberg wrote:

> On Fri, Aug 27, 2004 at 07:42:18AM +0200, Guillaume Thouvenin wrote:
> > On Thu, Aug 26, 2004 at 10:05:37PM +0200, Tim Schmielau wrote:
> > 
> > > With the new BSD acct v3 format, it should be possible to do per job
> > > accounting entirely from userspace, using pid and ppid information to
> > > reconstruct the process tree and some userland database for the
> > > pid -> job mapping. It would, however, be greatly simplified if the
> > > accounting records provided some kind of job id, and some indicator
> > > whether or not this process was the last of a job (group).
> > 
> > I like this solution.
> > In fact what I proposed was to have PAGG and a modified BSD accounting
> > that can be used with PAGG as both are already in the -mm tree. But
> > manage group of processes from userspace is, IMHO, a better solution as
> > modifications in the kernel will be minimal. 
> 
> The kernel part of linux-job is a module that uses PAGG, and 
> isn't difficult.  We've been running it in production for a
> couple years.

Well, I'm rethinking my opinion of not wanting two accounting methods in 
the kernel. Make them share as much code as possible, with the only
remaining difference being the format of the record and wether it is 
written per process or per job. Then we just have to make sure that both
mechanisms get exercised regulary, to prevent bit-rot.

> I don't think a kernel-based job is a requirement, though,
> so I'd like to hear more about how you'd do it otherwise.
> 
> The other comments about only one acct record per job vs one
> per process might be important, and that might mean the kernel
> has to know about the job.

Yes, it would probably be easier if the kernel knows about the job and 
could stuff a job ID into the acct record. If that means going from 64 
byte records to 128 bytes, this would again double the already larger 
overhead of BSD accounting, however. This lightweightness of CSA is why I 
am not opposed to its inclusion.

On the other hand, there are a few uses (and users) of per-process
accounting records, i.e. for security auditing, so we should not back
it out of the kernel.

> How does the BSD accounting define jobs?
> What determines the job that a process is part of?

BSD accounting doesn't have the concept of a job at all. When we discussed 
the v3 format, we considered adding a job ID field from PAGG, but a) 
nobody answered and b) there wasn't any space left in the record anyways.
So a decision was postponed for a future 128 byte acct v4 structure. 

> An important aspect of linux-job (ie the job part of the pagg/job/csa
> stack) is that it is inescapable.  The user doesn't get to determine or
> change their job (unlike process groups).  For true accounting, that
> determines the real $$$ chargebacks on shared machines, this is
> necessary.

My proposed solution for a userspace method would also be inescapable:
To start a new job, just write out it's pid to a file that is only ever 
appended to, and consider all children of it as belonging to the same job.

Inescapeable, but probably some overhead in userspace.

Oh, wait - I think there is a problem in current BSD accounting, if the 
parent process dies before the child, and the child gets reparented to 
init. I should investigate that...
 
> Another aspect of jobs that isn't directly related to accounting
> is that it gives users and admins a way to query, and kill :-),
> all the processes that are part of the job.  The inescapable part
> is again important...you can't fork off a process and detach it from
> the job to hide it.  In fact, I've heard that some sites use pagg/job
> without CSA for this reason.  It might have been an ISP or ASP, and
> they liked the containment linux-job provided.

Yes, it's probably a lot easier if you don't have to search accounting
files to do that.

So from my view, we might turn the discussion from whether we want CSA to 
how we integrate it, i.e. do some code review.

Tim
