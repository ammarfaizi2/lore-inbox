Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbVHQOPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVHQOPT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 10:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbVHQOPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 10:15:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:2543 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751137AbVHQOPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 10:15:17 -0400
Date: Wed, 17 Aug 2005 07:14:38 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Steven Whitehouse <steve@chygwyn.com>
Cc: Suzanne Wood <suzannew@cs.pdx.edu>, linux-kernel@vger.kernel.org,
       walpole@cs.pdx.edu, patrick@tykepenguin.com
Subject: Re: rcu read-side protection
Message-ID: <20050817141438.GD1300@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <000f01c5a2bf$f8e752d0$6401a8c0@woodworkxi42l4> <20050817020156.GF1319@us.ibm.com> <20050817082552.GA25537@souterrain.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050817082552.GA25537@souterrain.chygwyn.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 09:25:52AM +0100, Steven Whitehouse wrote:
> Hi,
> 
> On Tue, Aug 16, 2005 at 07:01:57PM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 16, 2005 at 05:09:29PM -0700, Suzanne Wood wrote:
> > [ . . . ]
> > > A read-side critical section is marked to protect the dereference of the 
> > > dn_ptr and assignment to dn_db which is a pointer to a dn_dev.  (struct 
> > > net_device is defined in /linux/netdevice.h and its dn_ptr in 
> > > /include/net/dn_dev.h)  Should this rcu-protection be extended to the line 
> > > following rcu_read_lock()?  Even though use_long is a simple char, it 
> > > appears to be a member of an rcu-protected structure.
> > 
> > Looks to me that this could indeed be a problem -- the structure
> > pointed to by dn_db could potentially be freed immediately after the
> > rcu_read_unlock(), unless there is some other non-obvious locking
> > mechanism protecting it.  In which case, why the rcu_read_lock()
> > and rcu_read_unlock()...
> > 
> > 						Thanx, Paul
> 
> The dev->dn_ptr points to the DECnet specific portion of a net device which
> is allocated in dn_dev.c/dn_dev_up and freed in dn_dev.c/dn_dev_delete when
> the net device goes up and down.
> 
> So I think you are right in that as far as I can see, its possible for a
> net device going down to race with this, but the window of opportunity is
> very small indeed (in fact possibly zero?) due to the ordering of operations
> in dn_dev_delete where dev->dn_ptr is set to NULL (esentially preventing
> any more DECnet packets being received on that device) before flushing all
> neighbours and only then releasing dn_db.

I agree that the window is quite small, but suppose that there was a
lengthy interrupt received just after the rcu_read_unlock()?

> Also, Patrick Caulfield is maintaining this code now, so I've added him to
> the CC list. Thanks for the report though,

How about the following patch?  Untested, but seems pretty straightforward.

							Thanx, Paul

Fix RCU race condition in dn_neigh_construct().

---

Signed-off-by: <paulmck@us.ibm.com>

diff -urpNa -X dontdiff linux-2.6.13-rc6/net/decnet/dn_neigh.c linux-2.6.13-rc6-db_db/net/decnet/dn_neigh.c
--- linux-2.6.13-rc6/net/decnet/dn_neigh.c	2005-08-08 19:59:25.000000000 -0700
+++ linux-2.6.13-rc6-db_db/net/decnet/dn_neigh.c	2005-08-17 07:08:10.000000000 -0700
@@ -148,12 +148,12 @@ static int dn_neigh_construct(struct nei
 
 	__neigh_parms_put(neigh->parms);
 	neigh->parms = neigh_parms_clone(parms);
-	rcu_read_unlock();
 
 	if (dn_db->use_long)
 		neigh->ops = &dn_long_ops;
 	else
 		neigh->ops = &dn_short_ops;
+	rcu_read_unlock();
 
 	if (dn->flags & DN_NDFLAG_P3)
 		neigh->ops = &dn_phase3_ops;
