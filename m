Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVDZFqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVDZFqY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 01:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVDZFqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 01:46:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58861 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261337AbVDZFqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 01:46:03 -0400
Date: Tue, 26 Apr 2005 13:49:33 +0800
From: David Teigland <teigland@redhat.com>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050426054933.GC12096@redhat.com>
References: <20050425165826.GB11938@redhat.com> <1114466097.30427.32.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114466097.30427.32.camel@persist.az.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 02:54:58PM -0700, Steven Dake wrote:
> On Mon, 2005-04-25 at 09:58, David Teigland wrote:
> > The core dlm functions.  Processes dlm_lock() and dlm_unlock() requests.
> > Creates lockspaces which give applications separate contexts/namespaces in
> > which to do their locking.  Manages locks on resources' grant/convert/wait
> > queues.  Sends and receives high level locking operations between nodes.
> > Delivers completion and blocking callbacks (ast's) to lock holders.
> > Manages the distributed directory that tracks the current master node for
> > each resource.
> > 
> 
> David
> 
> Very positive there are some submissions relating to cluster kernel work
> for lkml to review..  good job..
> 
> I have some questions on the implementation:
> 
> It appears as though a particular processor is identified as the "lock
> master" or processor that maintains the state of the lock.  So for
> example, if a processor wants to acquire a lock, it sends a reqeust to
> the lock master which either grants or rejects the request for the
> lock.  What happens in the scenario that a lock master leaves the
> current configuration?  This scneario is very likely in practice.  

Of course, every time a node fails.

> How do you synchronize the membership events that occur with the kernel
> to kernel communication that takes place using SCTP?

SCTP isn't much different than TCP, so I'm not sure how that's relevant.
It's used primarily so we can take advantage of multi-homing when you have
redundant networks.

When the membership of a lockspace needs to change, whether adding or
removing a node, activity is suspended in that lockspace on all the nodes
using it.  After all are suspended, the lockspace is then told (on all
lockspace members) what the new membership is.  Recovery then takes place:
new masters are selected and waiting requests redirected.


> It appears from your patches there is some external (userland)
> application that maintains the current list of processors that qualify
> as "lock servers".  

correct

> Is there then a dependence on external membership algorithms?

We simply require that the membership system is in agreement before the
lockspace is told what the new members are.  The membership system
ultimately drives the lockspace membership and we can't have the
membership system on different nodes telling the dlm different stories
about who's in/out.

So, yes, the membership system ultimately needs to follow some algorithm
that guarantees agreement.  There are rigorous, distributed ways of doing
that (your evs work which I look forward to using), and simpler methods,
e.g.  driving it from some single point of control.


> What user application today works to configure the dlm services in the
> posted patch?

I've been using the command line program "dlm_tool" where I act as the
membership system myself.  We're just putting together pieces that will
drive this from a membership system (like openais).  Again, the pieces you
decide to use in userspace are flexible and depend on how you want to use
the dlm.


> With usage of SCTP protocol, there is now some idea of moving the
> protocol for cluster communication into the kernel and using SCTP as
> that protocol...

Neither SCTP nor the dlm are about cluster communication, they're both
about simple point-to-point messages.  When you move up to userspace and
start talking about membership, then the issue of group communication
models comes up and your openais/evs work is very relevant.  Might you be
misled about what SCTP does?

Dave

