Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265853AbUA1FP4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 00:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265854AbUA1FP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 00:15:56 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:57083 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S265853AbUA1FPx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 00:15:53 -0500
Date: Wed, 28 Jan 2004 10:50:29 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: LKML <linux-kernel@vger.kernel.org>, Dipankar Sarma <dipankar@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6] is_subdir-fix
Message-ID: <20040128052029.GA1285@in.ibm.com>
Reply-To: maneesh@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o The following patch fixes is_subdir() races with d_move. Due to concurrent
  d_move, in is_subdir() we can end up accessing freed d_parent pointer in
  case of pre-emptible kernel. To avoid this we can use rcu_read_lock() and
  rcu_read_unlock().

o This also fixes the seqlock uses in is_subdir() as we need to restart the 
  the inner loop with the origianl new_dentry passed to the routine in case
  of any rename occured while we are traversing d_parent links.


 fs/dcache.c |    9 +++++++++
 1 files changed, 9 insertions(+)

diff -puN fs/dcache.c~is_subdir-fix fs/dcache.c
--- linux-2.6.2-rc2/fs/dcache.c~is_subdir-fix	2004-01-27 22:38:17.000000000 +0530
+++ linux-2.6.2-rc2-maneesh/fs/dcache.c	2004-01-27 23:43:17.000000000 +0530
@@ -1429,15 +1429,23 @@ out:
  *
  * Returns 1 if new_dentry is a subdirectory of the parent (at any depth).
  * Returns 0 otherwise.
+ * Caller must ensure that "new_dentry" is pinned before calling is_subdir()
  */
   
 int is_subdir(struct dentry * new_dentry, struct dentry * old_dentry)
 {
 	int result;
+	struct dentry * saved = new_dentry;
 	unsigned long seq;
 
 	result = 0;
+	/* need rcu_readlock to protect against the d_parent trashing due to
+	 * d_move
+	 */ 
+	rcu_read_lock();
         do {
+		/* for restarting inner loop in case of seq retry */
+		new_dentry = saved;
 		seq = read_seqbegin(&rename_lock);
 		for (;;) {
 			if (new_dentry != old_dentry) {
@@ -1451,6 +1459,7 @@ int is_subdir(struct dentry * new_dentry
 			break;
 		}
 	} while (read_seqretry(&rename_lock, seq));
+	rcu_read_unlock();
 
 	return result;
 }

_

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
