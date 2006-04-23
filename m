Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWDWLYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWDWLYO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 07:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751375AbWDWLYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 07:24:13 -0400
Received: from [212.70.37.24] ([212.70.37.24]:26891 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751369AbWDWLYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 07:24:13 -0400
From: Al Boldi <a1426z@gawab.com>
To: Matt Helsley <matthltc@us.ibm.com>
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
Date: Sun, 23 Apr 2006 14:22:36 +0300
User-Agent: KMail/1.5
Cc: sekharan@us.ibm.com, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200604212207.44266.a1426z@gawab.com> <200604222340.41332.a1426z@gawab.com> <1145759622.7099.73.camel@localhost.localdomain>
In-Reply-To: <1145759622.7099.73.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604231422.36963.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Helsley wrote:
> On Sat, 2006-04-22 at 23:40 +0300, Al Boldi wrote:
> > Chandra Seetharaman wrote:
> > > On Sat, 2006-04-22 at 07:08 +0300, Al Boldi wrote:
> > > > i.e: it should be possible to run the RCs w/o CKRM.
> > > >
> > > > The current design pins the RCs on CKRM, when in fact this is not
> > > > necessary. One way to decouple them, could be to pin them against
> > > > pid, thus allowing an RC to leverage the pid hierarchy w/o the need
> > > > for CKRM. And only when finer RM control is necessary, should CKRM
> > > > come into play, by dynamically adjusting the RC to achieve the
> > > > desired effect.
> > >
> > > This model works well in universities, where you associate some
> > > resource when a student logs in, or a virtualised environment (like a
> > > UML or vserver), where you attach resource to the root process.
> > >
> > > It doesn't work with web servers, database servers etc.,, where the
> > > main application will be forking tasks for different set of end users.
> > > In that case you have to group tasks that are not related to one
> > > another and attach resources to them.
> > >
> > > Having a unified interface gives the system administrator ability to
> > > group the tasks as they see them in real life (a department or
> > > important transactions or just critical apps in a desktop).
> >
> > So, why drag this unified interface around when it is only needed in
> > certain models.  The underlying interface via pid comes for free and
> > should be leveraged as such to yield a low overhead implementation. 
> > Then maybe, when a more complex model is involved should CKRM come into
> > play.
>
> Assuming I'm not misinterpretting your brief description above:
>
> 	The interface "via pid" does not come for free. You'd essentially
> attach the shares structures to the task and implement inheritance and
> hierarchy of those shares during fork

No, attach the shares struct to the parent RC, and allow it to take advantage 
of the free pid hierarchy.

> I'm willing to discuss your ideas without patches but I think patches
> (even if incomplete) would be clearer.

The discussion here is more about design rather than implementation.

> > > It also has the added advantage that the resource controller writer do
> > > not have to spend their time in coming up with an interface for their
> > > controller. On the other hand if they do, the user finally ends up
> > > with multiple interface (/proc, sysfs, configfs, /dev etc.,) to do
> > > their resource management.
> >
> > So, maybe what is needed is an abstract parent RC that implements this
> > interface and lets the child RCs implement the specifics, and allows
> > CKRM to connect to the parent RC to allow finer RM control when a
> > specific model requires it.
>
> 	I'm not sure what advantage that would give compared to CKRM as it
> stands now -- it sounds much more complex. Could you give an example of
> what kind of interfaces you're suggesting?

Nothing wrong w/ CKRM per se, other than its monolithic approach.

The suggestion here would be to modularize CKRM by removing dependencies, 
effectively splitting CKRM into 3 parts:

	  RM --- RC parent (no-op)
		/ | \
	      RC child (ntask, cpu, mem, .....)

So it could be possible to:
1. Load the RC parent to provide for simple stats based on pid-hierarchy.
2. Load an RC child for rc-enforcement.
3. Load the RM for finer control across different tasks by way of an 
orthogonal hierarchy.

Although this may look more complex than the monolithic approach, it is in 
fact lots simpler, due to its "division of labor" approach.

Thanks!

--
Al

