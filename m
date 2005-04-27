Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVD0C6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVD0C6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 22:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVD0C6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 22:58:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17378 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261894AbVD0C6s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 22:58:48 -0400
Date: Wed, 27 Apr 2005 11:02:17 +0800
From: David Teigland <teigland@redhat.com>
To: Steven Dake <sdake@mvista.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 1b/7] dlm: core locking
Message-ID: <20050427030217.GA9963@redhat.com>
References: <20050425165826.GB11938@redhat.com> <1114466097.30427.32.camel@persist.az.mvista.com> <20050426054933.GC12096@redhat.com> <1114537223.31647.10.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114537223.31647.10.camel@persist.az.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 10:40:24AM -0700, Steven Dake wrote:
> Hate to admit ignorance, but I'm not really sure what SCTP does..  I
> guess point to point communication like tcp but with some other kind of
> characteristics..  I wanted to have some idea of how locking messages
> are related to the current membership.  I think I understand the system
> from your descriptions and reading the code.  One scenario I could see
> happeing is that there are 2 processors A, B.
> 
> B drops out of membership
> A sends lock to lock master B (but A doens't know B has dropped out of
> membership yet)
> B gets lock request, but has dropped out of membership or failed in some
> way
> 
> In this case the order of lock messages with the membership changes is
> important.  

I think this might help clarify:  no membership change is applied to the
lockspace on any nodes until the lockspace has first been suspended on
all.  Suspending means no locking activity is processed.  The lockspace on
all nodes is then told the new membership and does recovery.  Locking is
then resumed.

If some lock message from a failed node is somehow still in the network
and arrives at one of the lockspace members now running again, it will
simply be ignored when they see it's from a non-member node.


> This is the essential race that describes almost every issue with
> distributed systems...  virtual synchrony makes this scenario impossible
> by ensuring that messages are ordered in relationship to membership
> changes.

Yes, but the messages discussed in that context are a part of group
multicasts.  Specifically, one message from a particular processor needs
to be delivered on all other processors, and all processors must agree on
the order of that group message with respect to membership changes.  To do
that you do indeed need to employ VS algorithms.

I know you're more familiar with those details than I am.  What I keep
trying to explain is that the dlm is in a different, simpler category.
The dlm's point-to-point messages (think client-server on a per lock
basis) just don't require the same rigorous approach used for _group_
communication.


> Do you intend to eventually move the point to point communication into
> userspace, or keep it within kernel?  

In the kernel, there's nothing to it.


> I'd like to understand if there is a general need for cluster
> communication as a kernel service, or the intent is for all
> communication to be done in userspace...

I see no need for group communication in the kernel.


> Can I ask a performance question..  How many locks per second can be
> acquired and then released with a system of 2-3 processors?  

We haven't done any measurements.


> In the case that the processor requesting the lock is on the lock server
> processor, 

When a lock is requested on the master node, there's no communication, no
messages, it's all local processing.  No one else in the cluster even
knows about the lock.


> and in the case that the processor requesting the lock is not
> on the lock server processor...  (processor in this case is the system
> that processes the lock operations).  Assuming all locks are
> uncontended...

OK, we'll try to do some measurements at some point.

Thanks,
Dave

