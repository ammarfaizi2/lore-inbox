Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVC3Dk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVC3Dk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 22:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVC3Dk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 22:40:58 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:18107 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261743AbVC3Dkg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 22:40:36 -0500
Date: Tue, 29 Mar 2005 21:40:34 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linuxppc64-dev@ozlabs.org
Subject: prefetch on ppc64
Message-ID: <20050330034034.GA1752@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

While investigating the inordinate performance impact one of my patches
seemed to be having, we tracked it down to two hlist_for_each_entry
loops, and finally to the prefetch instruction in the loop.

The machine I'm testing on has 4 power5 1.5Ghz cpus and 16G ram.  I was
mostly using dbench (v3.03) in runs of 50 and 100 on an ext2 system.
Kernel was 2.6.11-rc5.

I've not had much of a chance to test on x86, but the few tests I've run
have shown that prefetch does improve performance there.  From what I've
seen this seems to be a ppc (perhaps ppc64) specific symptom.

Following are two sets of interesting results on the ppc64 system.  The
first is on a stock 2.6.11-rc5 kernel.  The actual stock kernel gave the
following results for 100 runs of dbench:
# elements: 100, mean 862.580380, variance 5.973441, std dev 2.444062

When I patched fs/dcache.c to replace the three hlist_for_each_entry{,_rcu}
rules with manual loops, as shown in the attached file dcache-nohlist.patch,
I got:
# elements: 50, mean 881.804980, variance 10.695022, std dev 3.270325

The next set of results is based on 2.6.11-rc5 with the LSM stacking
patches (from www.sf.net/projects/lsm-stacker).  I was understandably
alarmed to find the original patched version gave me:
# elements: 100, mean 797.654870, variance 7.503588, std dev 2.739268

The code which I determined to be responsible contained two
list_for_each_entry loops,  Replacing one with a manual loop gave me
# elements: 50, mean 835.859980, variance 81.901719, std dev 9.049957
and replacing the second gave me
# elements: 50, mean 846.541060, variance 17.095401, std dev 4.134658

Finally I followed Paul McKenney's suggestion and just commented out the
ppc definition of prefetch altogether, which gave me:

# elements: 50, mean 860.823880, variance 47.567428, std dev 6.896914

I am currently testing this same patch against a non-stacking kernel.

thanks,
-serge

--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dcache-nohlist.patch"

Index: linux-2.6.11-rc5-nostack/fs/dcache.c
===================================================================
--- linux-2.6.11-rc5-nostack.orig/fs/dcache.c	2005-03-11 15:19:58.000000000 -0600
+++ linux-2.6.11-rc5-nostack/fs/dcache.c	2005-03-26 01:35:29.000000000 -0600
@@ -656,7 +656,7 @@
 	do {
 		found = 0;
 		spin_lock(&dcache_lock);
-		hlist_for_each(lp, head) {
+		for (lp=head->first; lp; lp = lp->next) {
 			struct dentry *this = hlist_entry(lp, struct dentry, d_hash);
 			if (!list_empty(&this->d_lru)) {
 				dentry_stat.nr_unused--;
@@ -1047,7 +1047,9 @@
 
 	rcu_read_lock();
 	
-	hlist_for_each_rcu(node, head) {
+	for (node=head->first; node;
+			({ node = node->next; smp_read_barrier_depends(); }))
+	{
 		struct dentry *dentry; 
 		struct qstr *qstr;
 
@@ -1123,7 +1125,7 @@
 
 	spin_lock(&dcache_lock);
 	base = d_hash(dparent, dentry->d_name.hash);
-	hlist_for_each(lhp,base) { 
+	for (lhp=base->first; lhp; lhp = lhp->next) {
 		/* hlist_for_each_rcu() not required for d_hash list
 		 * as it is parsed under dcache_lock
 		 */

--gKMricLos+KVdGMg--

