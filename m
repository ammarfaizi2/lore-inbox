Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWDXSXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWDXSXm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 14:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWDXSXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 14:23:41 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:19102 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751087AbWDXSXl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 14:23:41 -0400
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Al Boldi <a1426z@gawab.com>
Cc: Matt Helsley <matthltc@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200604231422.36963.a1426z@gawab.com>
References: <200604212207.44266.a1426z@gawab.com>
	 <200604222340.41332.a1426z@gawab.com>
	 <1145759622.7099.73.camel@localhost.localdomain>
	 <200604231422.36963.a1426z@gawab.com>
Content-Type: text/plain
Organization: IBM
Date: Mon, 24 Apr 2006 11:23:24 -0700
Message-Id: <1145903004.1400.14.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-23 at 14:22 +0300, Al Boldi wrote:
> Matt Helsley wrote:
> > On Sat, 2006-04-22 at 23:40 +0300, Al Boldi wrote:
> > > Chandra Seetharaman wrote:
> > > > On Sat, 2006-04-22 at 07:08 +0300, Al Boldi wrote:
> > > > > i.e: it should be possible to run the RCs w/o CKRM.
> > > > >
> > > > > The current design pins the RCs on CKRM, when in fact this is not
> > > > > necessary. One way to decouple them, could be to pin them against
> > > > > pid, thus allowing an RC to leverage the pid hierarchy w/o the need
> > > > > for CKRM. And only when finer RM control is necessary, should CKRM
> > > > > come into play, by dynamically adjusting the RC to achieve the
> > > > > desired effect.
> > > >
> > > > This model works well in universities, where you associate some
> > > > resource when a student logs in, or a virtualised environment (like a
> > > > UML or vserver), where you attach resource to the root process.
> > > >
> > > > It doesn't work with web servers, database servers etc.,, where the
> > > > main application will be forking tasks for different set of end users.
> > > > In that case you have to group tasks that are not related to one
> > > > another and attach resources to them.
> > > >
> > > > Having a unified interface gives the system administrator ability to
> > > > group the tasks as they see them in real life (a department or
> > > > important transactions or just critical apps in a desktop).
> > >
> > > So, why drag this unified interface around when it is only needed in
> > > certain models.  The underlying interface via pid comes for free and

The "pid tree" approach will not allow ISPs to provide workload
management capabilities inside a virual server also.

> > > should be leveraged as such to yield a low overhead implementation.

As you can see "pid based resource control" does not lead to a low
overhead implementation.

>  
> > > Then maybe, when a more complex model is involved should CKRM come into
> > > play.
> >
> > Assuming I'm not misinterpretting your brief description above:
> >
> > 	The interface "via pid" does not come for free. You'd essentially
> > attach the shares structures to the task and implement inheritance and
> > hierarchy of those shares during fork
> 
> No, attach the shares struct to the parent RC, and allow it to take advantage 
> of the free pid hierarchy.
> 
> > I'm willing to discuss your ideas without patches but I think patches
> > (even if incomplete) would be clearer.
> 
> The discussion here is more about design rather than implementation.

"pid based RC" does sound as easily understandable design. But IMHO, we
should consider how the implementation will be (in this context
comparing it with CKRM). As Matt pointed it may not be any less
complex. 
> 
> > > > It also has the added advantage that the resource controller writer do
> > > > not have to spend their time in coming up with an interface for their
> > > > controller. On the other hand if they do, the user finally ends up
> > > > with multiple interface (/proc, sysfs, configfs, /dev etc.,) to do
> > > > their resource management.
> > >
> > > So, maybe what is needed is an abstract parent RC that implements this
> > > interface and lets the child RCs implement the specifics, and allows
> > > CKRM to connect to the parent RC to allow finer RM control when a
> > > specific model requires it.
> >
> > 	I'm not sure what advantage that would give compared to CKRM as it
> > stands now -- it sounds much more complex. Could you give an example of
> > what kind of interfaces you're suggesting?
> 
> Nothing wrong w/ CKRM per se, other than its monolithic approach.
> 
> The suggestion here would be to modularize CKRM by removing dependencies, 
> effectively splitting CKRM into 3 parts:
> 
> 	  RM --- RC parent (no-op)
> 		/ | \
> 	      RC child (ntask, cpu, mem, .....)
> 

If the "RC parent" is _only_ going to allow attaching resource shares
with a "pid hierarchy", then how can an RM attach unrelated tasks to any
resource share ?

CKRM brings in grouping of unrelated tasks, which IMO is not possible
with the "pid tree" approach. On the other hand, CKRM takes care of
different scenarios.

> So it could be possible to:
> 1. Load the RC parent to provide for simple stats based on pid-hierarchy.
> 2. Load an RC child for rc-enforcement.
> 3. Load the RM for finer control across different tasks by way of an 
> orthogonal hierarchy.
> 
> Although this may look more complex than the monolithic approach, it is in 
> fact lots simpler, due to its "division of labor" approach.
> 
> Thanks!
> 
> --
> Al
> 
-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


