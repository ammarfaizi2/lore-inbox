Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbWDWCdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbWDWCdu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 22:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWDWCdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 22:33:50 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:48266 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750837AbWDWCdt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 22:33:49 -0400
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Matt Helsley <matthltc@us.ibm.com>
To: Al Boldi <a1426z@gawab.com>
Cc: sekharan@us.ibm.com, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <200604222340.41332.a1426z@gawab.com>
References: <200604212207.44266.a1426z@gawab.com>
	 <200604220708.40018.a1426z@gawab.com>
	 <1145684800.21231.30.camel@linuxchandra>
	 <200604222340.41332.a1426z@gawab.com>
Content-Type: text/plain
Organization: IBM Linux Technology Center
Date: Sat, 22 Apr 2006 19:33:42 -0700
Message-Id: <1145759622.7099.73.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-22 at 23:40 +0300, Al Boldi wrote:
> Chandra Seetharaman wrote:
> > On Sat, 2006-04-22 at 07:08 +0300, Al Boldi wrote:
> > > i.e: it should be possible to run the RCs w/o CKRM.
> > >
> > > The current design pins the RCs on CKRM, when in fact this is not
> > > necessary. One way to decouple them, could be to pin them against pid,
> > > thus allowing an RC to leverage the pid hierarchy w/o the need for CKRM.
> > >  And only when finer RM control is necessary, should CKRM come into
> > > play, by dynamically adjusting the RC to achieve the desired effect.
> >
> > This model works well in universities, where you associate some resource
> > when a student logs in, or a virtualised environment (like a UML or
> > vserver), where you attach resource to the root process.
> >
> > It doesn't work with web servers, database servers etc.,, where the main
> > application will be forking tasks for different set of end users. In
> > that case you have to group tasks that are not related to one another
> > and attach resources to them.
> >
> > Having a unified interface gives the system administrator ability to
> > group the tasks as they see them in real life (a department or important
> > transactions or just critical apps in a desktop).
> 
> So, why drag this unified interface around when it is only needed in certain 
> models.  The underlying interface via pid comes for free and should be 
> leveraged as such to yield a low overhead implementation.  Then maybe, when 
> a more complex model is involved should CKRM come into play.

Assuming I'm not misinterpretting your brief description above:

	The interface "via pid" does not come for free. You'd essentially
attach the shares structures to the task and implement inheritance and
hierarchy of those shares during fork -- hardly lower overhead when you
consider that in most cases the number of tasks is going to be much
larger than the number of classes. Furthermore this would mean
duplicating the loops in ckrm_alloc_class, ckrm_free_class,
ckrm_register_controller, and ckrm_unregister_controller. I suspect the
loops would be deeper, more complex, execute more frequently, and have a
much wider performance impact when you consider that we'd be dealing
with the task struct directly instead of a class. The class structure
effectively factors most of the loops out of the fork() and exit() paths
and into mkdir() rmdir() calls that create and remove classes. The
remaining loops in fork() and exit() paths are proportional to the
number of resource controllers -- currently limitedto 8 by
CKRM_MAX_RES_CTLRS.

	Classes also have an advantage when it comes to administrating resource
management -- they are created and destroyed by an administrator and
hence are easier to control. In contrast, the resource management
decisions associated purely with tasks would disappear with the task. In
many cases a task would be too short-lived for an administrator to
manually intervene even if swarms of these tasks are created. Having
this orthogonal hierarchy gives us the opportunity to manage all of
these situations via a common interface and factors out overhead from
the per-task solution you seem to be advocating.

I'm willing to discuss your ideas without patches but I think patches
(even if incomplete) would be clearer.

> > It also has the added advantage that the resource controller writer do
> > not have to spend their time in coming up with an interface for their
> > controller. On the other hand if they do, the user finally ends up with
> > multiple interface (/proc, sysfs, configfs, /dev etc.,) to do their
> > resource management.
> 
> So, maybe what is needed is an abstract parent RC that implements this 
> interface and lets the child RCs implement the specifics, and allows CKRM to 
> connect to the parent RC to allow finer RM control when a specific model 
> requires it.

	I'm not sure what advantage that would give compared to CKRM as it
stands now -- it sounds much more complex. Could you give an example of
what kind of interfaces you're suggesting?

Cheers,
	-Matt Helsley

