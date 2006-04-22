Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbWDVBtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWDVBtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 21:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWDVBtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 21:49:03 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:47078 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750834AbWDVBtB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 21:49:01 -0400
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: haveblue@us.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
In-Reply-To: <20060421155727.4212c41c.akpm@osdl.org>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
	 <1145630992.3373.6.camel@localhost.localdomain>
	 <1145638722.14804.0.camel@linuxchandra>
	 <20060421155727.4212c41c.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM
Date: Fri, 21 Apr 2006 18:48:56 -0700
Message-Id: <1145670536.15389.132.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 15:57 -0700, Andrew Morton wrote:
> Chandra Seetharaman <sekharan@us.ibm.com> wrote:
> >
> > On Fri, 2006-04-21 at 07:49 -0700, Dave Hansen wrote:
> > > On Thu, 2006-04-20 at 19:24 -0700, sekharan@us.ibm.com wrote:
> > > > CKRM has gone through a major overhaul by removing some of the complexity,
> > > > cutting down on features and moving portions to userspace.
> > > 
> > > What do you want done with these patches?  Do you think they are ready
> > > for mainline?  -mm?  Or, are you just posting here for comments?
> > > 
> > 
> > We think it is ready for -mm. But, want to go through a review cycle in
> > lkml before i request Andrew for that.
> 
> From a quick scan, the overall code quality is probably the best I've seen
> for an initial submission of this magnitude.  I had a few minor issues and

Thanks, and thanks to all that helped.

> questions, but it'd need a couple of hours to go through it all.
> 
> So.  Send 'em over when you're ready.

Great. I will wait for couple of days for comments and then send them
your way.

> 
> I have one concern.  If we merge this framework into mainline then we'd
> (quite reasonably) expect to see an ongoing dribble of new controllers
> being submitted.  But we haven't seen those controllers yet.  So there is a
> risk that you'll submit a major new controller (most likely a net or memory
> controller) and it will provoke a reviewer revolt.  We'd then be in a
> situation of cant-go-forward, cant-go-backward.
> 

I totally understand your concern.

CKRM's design is not tied with a specific implementation of a
controller. It allows hooking up different controllers for the same
resource. If a controller is considered complex, it can cut some of the
features and be made simpler. Or a simpler controller can replace an
earlier complex controller without affecting the user interface. 
 
This flexibility feature reduces the "cant-go-forward, cant-go-back"
problem, somewhat.

FYI, we found out that managing network resources was not falling into
this task based model and we had to invent complex layering to
accommodate it. So, we dropped our plans for network support. 

One can write controller for any resource that can be accounted at task
level. The corresponding subsystem stakeholders can ensure that it is
clean, and at acceptable level.

> It would increase the comfort level if we could see what the major
> controllers look like before committing.  But that's unreasonable.

You might have seen the CPU controller (different implementation than
what we had earlier) and the numtasks controller (can prevent fork
bombs) that followed this patchset.

>
> Could I ask that you briefly enumerate
> 
> a) which controllers you think we'll need in the forseeable future
> 

Our main object is to provide resource control for the hardware
resources: CPU, I/O and memory.

We have already posted the CPU controller.

We have two implementations of memory controller and a I/O controller. 

Memory controller is understandably more complex and controversial, and
that is the reason we haven't posted it this time around (we are looking
at ways to simplify the design and hence the complexity). Both the
memory controllers has been posted to linux-mm.

I/O controller is based on CFQ-scheduler.

> b) what they need to do

Both memory controllers provide control for LRU lists.

 - One maintains the active/inactive lists per class for each zone. It
   is of order O(1). Current code is little complex. We are looking at
   ways to simplify it.

 - Another creates pseudo zones under each zones (by splitting the 
   number of pages available in a zone) and attaches them with
   each class.

I/O Controller that we are working on is based on CFQ scheduler and
provides bandwidth control.  
> 
> c) pointer to prototype code if poss

Both the memory controllers are fully functional. We need to trim them
down.

active/inactive list per class memory controller:
http://prdownloads.sourceforge.net/ckrm/mem_rc-f0.4-2615-v2.tz?download

pzone based memory controller:
http://marc.theaimsgroup.com/?l=ckrm-tech&m=113867467006531&w=2

i/o controller: This controller is not ported to the framework posted,
but can be taken for a prototype version. New version would be simpler
though.

http://prdownloads.sourceforge.net/ckrm/io_rc.tar.bz2?download


Thanks & Regards,

chandra
> 
> Thanks.
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


