Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbWALGVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWALGVn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 01:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932683AbWALGVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 01:21:43 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:30157 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932684AbWALGVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 01:21:42 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: paulmck@us.ibm.com
cc: John Hesterberg <jh@sgi.com>, Matt Helsley <matthltc@us.ibm.com>,
       Jes Sorensen <jes@trained-monkey.org>,
       Shailabh Nagar <nagar@watson.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Jay Lan <jlan@engr.sgi.com>, LKML <linux-kernel@vger.kernel.org>,
       elsa-devel@lists.sourceforge.net, lse-tech@lists.sourceforge.net,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>, Paul Jackson <pj@sgi.com>,
       Erik Jacobson <erikj@sgi.com>, Jack Steiner <steiner@sgi.com>
Subject: Re: [Lse-tech] Re: [ckrm-tech] Re: [PATCH 00/01] Move Exit Connectors 
In-reply-to: Your message of "Wed, 11 Jan 2006 21:04:53 -0800."
             <20060112050453.GA23673@us.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Jan 2006 17:19:01 +1100
Message-ID: <15187.1137046741@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" (on Wed, 11 Jan 2006 21:04:53 -0800) wrote:
>On Thu, Jan 12, 2006 at 02:29:52PM +1100, Keith Owens wrote:
>> John Hesterberg (on Wed, 11 Jan 2006 15:39:10 -0600) wrote:
>> >On Wed, Jan 11, 2006 at 01:02:10PM -0800, Matt Helsley wrote:
>> >> 	Have you looked at Alan Stern's notifier chain fix patch? Could that be
>> >> used in task_notify?
>> >
>> >I have two concerns about an all-tasks notification interface.
>> >First, we want this to scale, so don't want more global locks.
>> >One unique part of the task notify is that it doesn't use locks.
>> 
>> Neither does Alan Stern's atomic notifier chain.  Indeed it cannot use
>> locks, because the atomic notifier chains can be called from anywhere,
>> including non maskable interrupts.  The downside is that Alan's atomic
>> notifier chains require RCU.
>> 
>> An alternative patch that requires no locks and does not even require
>> RCU is in http://marc.theaimsgroup.com/?l=linux-kernel&m=113392370322545&w=2
>
>Interesting!  Missed this on the first time around...
>
>But doesn't notifier_call_chain_lockfree() need to either disable
>preemption or use atomic operations to update notifier_chain_lockfree_inuse[]
>in order to avoid problems with preemption?

OK, I have thought about it and ...

  notifier_call_chain_lockfree() must be called with preempt disabled.

The justification for this routine is to handle all the nasty
corner cases in the notify_die() and similar chains, including panic,
spinlocks being held and even non maskable interrupts.  It is silly to
try to make notifier_call_chain_lockfree() handle the preemptible case
as well.

If notifier_call_chain_lockfree() is to be called for task
notification, then the caller must disable preempt around the call to
notifier_call_chain_lockfree().  Scalability over lots of cpus should
not be an issue, especially if notifier_chain_lockfree_inuse[] is
converted to a per cpu variable.  The amount of time spent with preempt
disabled is proportional to the number of registered callbacks on the
task notifcation chain and to the amount of work performed by those
callbacks, neither of which should be high.

