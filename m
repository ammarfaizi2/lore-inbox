Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWGLFly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWGLFly (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 01:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWGLFly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 01:41:54 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:33952 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932227AbWGLFlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 01:41:52 -0400
Subject: Re: [Patch 6/6] per task delay accounting taskstats interface: fix
	clone skbs for each listener
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Jay Lan <jlan@sgi.com>, Chris Sturtivant <csturtiv@sgi.com>,
       Paul Jackson <pj@sgi.com>, Balbir Singh <balbir@in.ibm.com>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Jamal <hadi@cyberus.ca>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <20060711111525.GA11175@gondor.apana.org.au>
References: <20060711030524.39abc3d5.akpm@osdl.org>
	 <E1G0FU2-0002oE-00@gondolin.me.apana.org.au>
	 <20060711035731.63c087b3.akpm@osdl.org>
	 <20060711111525.GA11175@gondor.apana.org.au>
Content-Type: text/plain
Organization: IBM
Message-Id: <1152682909.6054.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 12 Jul 2006 01:41:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-11 at 07:15, Herbert Xu wrote:
> On Tue, Jul 11, 2006 at 03:57:31AM -0700, Andrew Morton wrote:
> >
> > > >>       down_write(&listeners->sem);
> > > >>       list_for_each_entry_safe(s, tmp, &listeners->list, list) {
> > > >> -             ret = genlmsg_unicast(skb, s->pid);
> > > >> +             skb_next = NULL;
> > > >> +             if (!list_islast(&s->list, &listeners->list)) {
> > > >> +                     skb_next = skb_clone(skb_cur, GFP_KERNEL);
> > > > 
> > > > If we do a GFP_KERNEL allocation with this semaphore held, and the
> > > > oom-killer tries to kill something to satisfy the allocation, and the
> > > > killed task gets stuck on that semaphore, I wonder of the box locks up.
> > > 
> > > We do GFP_KERNEL inside semaphores/mutexes in lots of places.  So if this
> > > can deadlock with the oom-killer we probably should fix that, preferably
> > > by having GFP_KERNEL fail in that case.
> > 
> > This lock is special, in that it's taken on the exit() path (I think).  So
> > it can block tasks which are trying to exit.
> 
> Sorry, missed the context.
> 
> If there is a deadlock then it's not just this allocation that you
> need worry about.  There is also an allocation within genlmsg_uniast
> that would be GFP_KERNEL.


Remove down_write() from taskstats code invoked on the exit() path.

In send_cpu_listeners(), which is called on the exit path, 
a down_write() was protecting operations like skb_clone() and 
genlmsg_unicast() that do GFP_KERNEL allocations. If the oom-killer 
decides to kill tasks to satisfy the allocations,the exit of those 
tasks could block on the same semphore.

The down_write() was only needed to allow removal of invalid 
listeners from the listener list. The patch converts the down_write 
to a down_read and defers the removal to a separate critical region. 
This ensures that even if the oom-killer is called, no other task's 
exit is blocked as it can still acquire another down_read.

Thanks to Andrew Morton & Herbert Xu for pointing out the oom 
related pitfalls, and to Chandra Seetharaman for suggesting this 
fix instead of using something more complex like RCU.

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Shailabh Nagar <nagar@watson.ibm.com>

---

 kernel/taskstats.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

Index: linux-2.6.18-rc1/kernel/taskstats.c
===================================================================
--- linux-2.6.18-rc1.orig/kernel/taskstats.c	2006-07-11 00:13:00.000000000 -0400
+++ linux-2.6.18-rc1/kernel/taskstats.c	2006-07-12 00:07:53.000000000 -0400
@@ -51,6 +51,7 @@ __read_mostly = {
 struct listener {
 	struct list_head list;
 	pid_t pid;
+	char valid;
 };
 
 struct listener_list {
@@ -127,7 +128,7 @@ static int send_cpu_listeners(struct sk_
 	struct listener *s, *tmp;
 	struct sk_buff *skb_next, *skb_cur = skb;
 	void *reply = genlmsg_data(genlhdr);
-	int rc, ret;
+	int rc, ret, delcount = 0;
 
 	rc = genlmsg_end(skb, reply);
 	if (rc < 0) {
@@ -137,7 +138,7 @@ static int send_cpu_listeners(struct sk_
 
 	rc = 0;
 	listeners = &per_cpu(listener_array, cpu);
-	down_write(&listeners->sem);
+	down_read(&listeners->sem);
 	list_for_each_entry_safe(s, tmp, &listeners->list, list) {
 		skb_next = NULL;
 		if (!list_islast(&s->list, &listeners->list)) {
@@ -150,14 +151,26 @@ static int send_cpu_listeners(struct sk_
 		}
 		ret = genlmsg_unicast(skb_cur, s->pid);
 		if (ret == -ECONNREFUSED) {
-			list_del(&s->list);
-			kfree(s);
+			s->valid = 0;
+			delcount++;
 			rc = ret;
 		}
 		skb_cur = skb_next;
 	}
-	up_write(&listeners->sem);
+	up_read(&listeners->sem);
+
+	if (!delcount)
+		return rc;
 
+	/* Delete invalidated entries */
+	down_write(&listeners->sem);
+	list_for_each_entry_safe(s, tmp, &listeners->list, list) {
+		if (!s->valid) {
+			list_del(&s->list);
+			kfree(s);
+		}
+	}
+	up_write(&listeners->sem);
 	return rc;
 }
 
@@ -290,6 +303,7 @@ static int add_del_listener(pid_t pid, c
 				goto cleanup;
 			s->pid = pid;
 			INIT_LIST_HEAD(&s->list);
+			s->valid = 1;
 
 			listeners = &per_cpu(listener_array, cpu);
 			down_write(&listeners->sem);


