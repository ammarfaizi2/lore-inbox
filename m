Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUHYRis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUHYRis (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUHYRis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:38:48 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:17226 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S266896AbUHYRiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:38:12 -0400
Date: Wed, 25 Aug 2004 10:34:24 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>,
       "SELinux-ML(Eng)" <selinux@tycho.nsa.gov>,
       "Linux Kernel ML(Eng)" <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: RCU issue with SELinux (Re: SELINUX performance issues)
Message-ID: <20040825173423.GC1244@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <Xine.LNX.4.44.0408161119160.4659-100000@dhcp83-76.boston.redhat.com> <032901c486ba$a3478970$f97d220a@linux.bs1.fc.nec.co.jp> <1093014789.16585.186.camel@moss-spartans.epoch.ncsc.mil> <042b01c489ab$8a871ce0$f97d220a@linux.bs1.fc.nec.co.jp> <20040824230245.GA1243@us.ibm.com> <024b01c48a89$26765b60$f97d220a@linux.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <024b01c48a89$26765b60$f97d220a@linux.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 06:51:53PM +0900, Kaigai Kohei wrote:

Hello again, Kai,

> Hi Paul, thanks for your comments.
> 
> > > I modified the following points:
> > > - We hold the lock for hash backet when avc_insert() and avc_ss_reset() are
> > >   called for safety.
> > > - list_for_each_rcu() and list_entry() are replaced by list_for_entry().
> > 
> > One subtlety here...
> > 
> > The traversals that are protected by rcu_read_lock() (rather than an
> > update-side spinlock) need to be list_for_each_entry_rcu() rather than
> > list_for_each_entry().  The "_rcu()" is required in order to work
> > reliably on Alpha, and has the added benefit of calling out exactly
> > which traversals are RCU-protected.
> > 
> > Update-side code remains list_for_each_entry().
> 
> It was a simple misconception.
> I fixed them in the take3-patch.

Let's take them one at a time:

1.	The list_for_each_entry_rcu() in avc_hash_eval() is correct.
	It is protected by rcu_read_lock(), so it is documenting
	a RCU-protected traversal of the list, and inserting needed
	memory barriers on Alpha CPUs.

2.	The list_for_each_entry_rcu() in avc_reclaim_node() should
	instead by list_for_each_entry(), with no _rcu().  This is
	because this traversal is guarded by the update-side lock,
	not by RCU.  The fact that the lock is held means that no
	other CPU can be changing this list during the traversal.

3.	The list_for_each_entry_rcu() in avc_search_node() is correct.
	As in item #1, it is protected by rcu_read_lock().

4.	The list_for_each_entry_rcu() in avc_insert() is more interesting,
	but needs to be list_for_each_entry().  It is protected by -both-
	the spinlock and by an rcu_read_lock() acquired by the caller!

	However, the spinlock prevents any other CPU from modifying the
	data structure, so this should be list_for_each_entry() rather
	than the current list_for_each_entry_rcu().

	What is happening is that the code is upgrading from a read-side
	rcu_read_lock() to an update-side spin_lock_irqsave().  This
	is legal, though perhaps a bit unconventional.

	However, looking closer, I don't understand why the rcu_read_lock()
	needs to be re-acquired before the call to avc_insert() in
	avc_has_perm_noaudit():

	o	avc_latest_notif_update() allocates a sequence number
		under a lock.

	o	avc_get_node() allocates and initializes a node.  It does
		call avc_reclaim_node(), but this function is guarded
		by a spinlock.

	o	avc_insert() calls the above two functions, and other
		than that, initializes the new node (which no other CPU
		has access to), and inserts it under the spinlock.

	So I do not believe that avc_insert() needs rcu_read_lock().
	Unless I am missing something, the rcu_read_lock() acquired
	in avc_has_perm_noaudit() should be moved after the call to
	avc_insert().

	I was concerned about the possibility that avc_has_perm_noaudit()
	might be preempted between the rcu_read_unlock() and the
	rcu_read_lock(), but this issue appears to be correctly handled
	by the code in avc_insert(), which handles either case, updating
	the existing node or inserting a new one.

5.	The list_for_each_entry_rcu() in avc_update_node() should be
	changed to list_for_each_entry(), since it is protected
	by the update-side spinlock, and therefore does not need
	RCU protection, as in item #2 above.  This is another case
	where an rcu_read_lock() is "upgraded" to a write-side lock
	by acquiring a spinlock.

6.	The list_for_each_entry_rcu() in avc_update_cache() is correct.
	It is protected only by rcu_read_lock(), so RCU protection is
	required.

7.	The list_for_each_entry_rcu() in avc_ss_reset() needs to be
	changed to list_for_each_entry(), since it is protected by
	the update-side spinlock.  Since the array is statically allocated,
	there is no need for the enclosing rcu_read_lock() and
	rcu_read_unlock(), and they should be removed.

I clearly need to provide more documentation.  ;-)  This is in progress.

See below for a patch that applies on top of your take3 patch, since
the C code might be more clear than the English in this case.

> > > - avc_node_dual structure which contains two avc_node objects is defined. 
> > >   It allows to do avc_update_node() without kmalloc() or any locks.
> > 
> > What happens when you have two consecutive updates to the same object?
> > Don't you have to defer the second update until a grace period has
> > elapsed since the first update in order to avoid confusing readers that
> > are still accessing the original version?
> 
> I didn't imagine such a situation. Indeed, such thing may happen.
> 
> > One way to do this would be to set a "don't-touch-me" bit that is
> > cleared by an RCU callback.  An update to an element with the
> > "don't-touch-me" bit set would block until the bit clears.  There
> > are probably better ways...
> 
> I think we can't apply this approach for the implementation
> of avc_update_node(), because execution context isn't permitted to block.

That would certainly invalidate my suggestion!  ;-)

> I changed my opinion and implementation of avc_update_node().
> If kmalloc() returns NULL in avc_update_node(), it returns -ENOMEM.
> 
> But this effect of changing the prototype is limited, because only
> avc_has_perm_noaudit() and avc_update_cache() call avc_update_node().
> 
> Even if avc_update_node() return -ENOMEM to avc_has_perm_noaudit(),
> avc_has_perm_noaudit() can ignore it, because the purpose is only
> to control the audit-log floods.
> This adverse effect is only that audit-logs are printed twice.
> 
> Nobody calls avc_update_cache(), which is only defined.

Sounds good!

> Some other trivial fixes are as follows:
> - All list_for_each_entry() were replaced by list_for_each_entry_rcu().

See above.  ;-)

> - All spin_lock()/spin_unlock() were replaced by spin_lock_irqsave()
>   /spin_unlock_restore().
> - In avc_node_insert(), if an entry with the same ssid/tsid/tclass as new
>   one exists, the older entry is replaced by the new one.
> 
> Thank you for the opinion as a specialist of RCU!

Thank -you- for giving RCU a try!  Again, the performance results are
quite impressive!

						Thanx, Paul


diff -urpN -X dontdiff linux-2.6.8.1-selinux3.rcu/security/selinux/avc.c linux-2.6.8.1-selinux3.rcu.pem/security/selinux/avc.c
--- linux-2.6.8.1-selinux3.rcu/security/selinux/avc.c	Wed Aug 25 09:34:26 2004
+++ linux-2.6.8.1-selinux3.rcu.pem/security/selinux/avc.c	Wed Aug 25 10:30:10 2004
@@ -253,7 +253,7 @@ static inline int avc_reclaim_node(void)
 		if (!spin_trylock(&avc_cache.slots_lock[hvalue]))
 			continue;
 
-		list_for_each_entry_rcu(node, &avc_cache.slots[hvalue], list) {
+		list_for_each_entry(node, &avc_cache.slots[hvalue], list) {
 			if (!atomic_dec_and_test(&node->ae.used)) {
 				/* Recently Unused */
 				list_del_rcu(&node->list);
@@ -419,7 +419,7 @@ struct avc_node *avc_insert(u32 ssid, u3
 		node->ae.avd.seqno = ae->avd.seqno;
 
 		spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);
-		list_for_each_entry_rcu(pos, &avc_cache.slots[hvalue], list) {
+		list_for_each_entry(pos, &avc_cache.slots[hvalue], list) {
 			if (pos->ae.ssid == ssid &&
 			    pos->ae.tsid == tsid &&
 			    pos->ae.tclass == tclass) {
@@ -719,7 +719,7 @@ static int avc_update_node(u32 event, u3
 	hvalue = avc_hash(ssid, tsid, tclass);
 	spin_lock_irqsave(&avc_cache.slots_lock[hvalue], flag);
 
-	list_for_each_entry_rcu(pos, &avc_cache.slots[hvalue], list){
+	list_for_each_entry(pos, &avc_cache.slots[hvalue], list){
 		if ( ssid==pos->ae.ssid &&
 		     tsid==pos->ae.tsid &&
 		     tclass==pos->ae.tclass ){
@@ -912,16 +912,14 @@ int avc_ss_reset(u32 seqno)
 
 	avc_hash_eval("reset");
 
-	rcu_read_lock();
 	for (i = 0; i < AVC_CACHE_SLOTS; i++) {
 		spin_lock_irqsave(&avc_cache.slots_lock[i], flag);
-		list_for_each_entry_rcu(node, &avc_cache.slots[i], list){
+		list_for_each_entry(node, &avc_cache.slots[i], list){
 			list_del_rcu(&node->list);
 			call_rcu(&node->rhead, avc_node_free);
 		}
 		spin_unlock_irqrestore(&avc_cache.slots_lock[i], flag);
 	}
-	rcu_read_unlock();
 
 	for (i = 0; i < AVC_NSTATS; i++)
 		avc_cache_stats[i] = 0;
