Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268203AbUIBQgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268203AbUIBQgt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 12:36:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268341AbUIBQgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 12:36:49 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:39896 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S268203AbUIBQft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 12:35:49 -0400
Date: Thu, 2 Sep 2004 09:31:50 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: "David S. Miller" <davem@redhat.com>
Cc: vatsa@in.ibm.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com
Subject: Re: [RFC] Use RCU for tcp_ehash lookup
Message-ID: <20040902163149.GB1258@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20040831125941.GA5534@in.ibm.com> <20040901224108.3b2d692d.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040901224108.3b2d692d.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2004 at 10:41:08PM -0700, David S. Miller wrote:
> On Tue, 31 Aug 2004 18:29:41 +0530
> Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
> > - Biggest problem I had converting over to RCU was the refcount race between
> >   sock_put and sock_hold. sock_put might see the refcount go to zero and decide
> >   to free the object, while on some other CPU, sock_get's are pending against
> >   the same object. The patch handles the race by deciding to free the object
> >   only from the RCU callback.
> 
> That's exactly what I was concerned about when I saw that you had attempted
> this change.  It is incredibly important for state changes and updates to
> be seen as atomic by the packet input processing engine.  It would be illegal
> for a cpu running TCP input to see a socket in two tables at the same time
> (for example, in the main established area and in the second half for TIME_WAIT
> buckets).
> 
> If the visibility of the socket is wrong, sockets could be erroneously
> be reset during the transition from established to TIME_WAIT state.
> Beware!

If the usages is too write-intensive, then RCU will certainly be less
likely to work well.  But there is nothing quite like actually trying
it to see how it works.  ;-)

That aside, it -is- possible to make such state changes appear atomic,
even when moving elements from one list to another.  One way of doing
this is to atomically replace the element with a "tombstone" element.
Normal pointer writes suffice.  The "tombstone" is set up so that searches
for the outgoing element will stall (e.g., spin or sleep, depending
on the environment).  The element is moved to its destination list.
At this point, searches for the element in the old list will still
stall, while searches for the element in the new list will succeed.
The tombstone is now marked so that CPUs stall on it now resume, but
indicating failure to find the element in the old list.

Of course, this approach makes writes more expensive than they otherwise
would be, so, again, RCU is best for read-intensive uses.  ;-)

The fact that this data structure is not very read-intensive is due
to the fact that short-lived TCP connections are quite common, right?
Or am I missing the finer points of this data structure's workings?

						Thanx, Paul
