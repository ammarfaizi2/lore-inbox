Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265243AbUFVS2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbUFVS2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265154AbUFVSTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:19:54 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:7380 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265099AbUFVRzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:55:33 -0400
Date: Tue, 22 Jun 2004 23:20:58 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce rcu_head size [2/2]
Message-ID: <20040622175058.GB3968@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040616054604.GA3658@in.ibm.com> <20040616054713.GB3658@in.ibm.com> <20040616054746.GC3658@in.ibm.com> <20040619120414.57d985f1.akpm@osdl.org> <20040620061224.GA14123@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040620061224.GA14123@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20, 2004 at 11:42:24AM +0530, Dipankar Sarma wrote:
> On Sat, Jun 19, 2004 at 12:04:14PM -0700, Andrew Morton wrote:
> > Dipankar Sarma <dipankar@in.ibm.com> wrote:
> > >
> > >  This patch changes the call_rcu() API and avoids passing an
> > >  argument to the callback function as suggested by Rusty. 
> > 
> > This breaks the bridge driver:
> > 
> > 
> > static void destroy_nbp(struct rcu_head *head)
> > 
> > int br_add_if(struct net_bridge *br, struct net_device *dev)
> > {
> > 	struct net_bridge_port *p;
> > 
> > 	...
> > 		destroy_nbp(p);
> 
> Crap. New patch that compiles fine.
> 

Applies on top of the earlier patches.

Thanks
Dipankar


OK, yet another mistake. Add fastcall directive to call_rcu().

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 kernel/rcupdate.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN kernel/rcupdate.c~rcu-no-arg-fastcall-fix kernel/rcupdate.c
--- linux-2.6.6-rcu/kernel/rcupdate.c~rcu-no-arg-fastcall-fix	2004-06-22 23:14:22.000000000 +0530
+++ linux-2.6.6-rcu-dipankar/kernel/rcupdate.c	2004-06-22 23:19:26.000000000 +0530
@@ -65,7 +65,8 @@ static DEFINE_PER_CPU(struct tasklet_str
  * The read-side of critical section that use call_rcu() for updation must 
  * be protected by rcu_read_lock()/rcu_read_unlock().
  */
-void call_rcu(struct rcu_head *head, void (*func)(struct rcu_head *rcu))
+void fastcall call_rcu(struct rcu_head *head, 
+				void (*func)(struct rcu_head *rcu))
 {
 	int cpu;
 	unsigned long flags;

_
