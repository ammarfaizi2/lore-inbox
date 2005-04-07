Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbVDGVWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbVDGVWz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 17:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVDGVWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 17:22:54 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:61153 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262606AbVDGVV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 17:21:56 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1112358445.28076.23.camel@localhost.localdomain>
References: <1112212608.3691.147.camel@localhost.localdomain>
	 <1112218750.3691.165.camel@localhost.localdomain>
	 <20050331110330.GA24842@elte.hu>
	 <1112273378.3691.228.camel@localhost.localdomain>
	 <20050331141040.GA2544@elte.hu>
	 <1112290916.12543.19.camel@localhost.localdomain>
	 <20050331174927.GA11483@elte.hu>
	 <1112317173.28076.10.camel@localhost.localdomain>
	 <20050401044307.GB22753@elte.hu>
	 <1112332426.28076.21.camel@localhost.localdomain>
	 <20050401051947.GA23990@elte.hu>
	 <1112358445.28076.23.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 07 Apr 2005 17:21:50 -0400
Message-Id: <1112908910.22577.54.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-01 at 07:27 -0500, Steven Rostedt wrote:
> On Fri, 2005-04-01 at 07:19 +0200, Ingo Molnar wrote:
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > > could you send me your latest patch for the bit-spin issue? My main 
> > > > issue was cleanliness, so that the patch doesnt get stuck in the -RT 
> > > > tree forever.
> > > 
> > > I think that's the main problem. Without changing the design of the 
> > > ext3 system, I don't think there is a clean patch.  The implementation 
> > > that I finally settled down with was to make the j_state and 
> > > j_journal_head locks two global locks. I had to make a few 
> > > modifications to some spots to avoid deadlocks, but this worked out 
> > > well. The problem I was worried about was this causing too much 
> > > overhead. So the ext3 buffers would have to contend with each other. I 
> > > don't have any tests to see if this had too much of an impact.
> > 
> > yeah - i think Andrew said that a global lock at that particular place 
> > might not be that much of an issue.
> > 
> 
> OK, I'll start stripping it out of my kernel today and make a clean
> patch for you.
> 

Ingo, I haven't forgotten about this, I just been heavily bug wacking
lately and just haven't had the time to do this. 

I've pulled out both the lock_bh_state and lock_bh_journal_head and made
them two global locks.  I haven't noticed any slowing down here, but
then again I haven't ran any real benchmarks.  There's a BH flag set to
know when the lock is pending on a specific buffer head.

I don't know how acceptable this patch is. Take a look and if you have
any better ideas then let me know.  I prefer this patch over the
wait_on_bit patch I sent you earlier since this patch still accounts for
priority inheritance, as the wait_on_bits don't.

-- Steve

Index: include/linux/jbd.h
===================================================================
--- include/linux/jbd.h	(revision 113)
+++ include/linux/jbd.h	(working copy)
@@ -313,47 +313,100 @@
 BUFFER_FNS(RevokeValid, revokevalid)
 TAS_BUFFER_FNS(RevokeValid, revokevalid)
 BUFFER_FNS(Freed, freed)
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+BUFFER_FNS(State,state)
 
-static inline struct buffer_head *jh2bh(struct journal_head *jh)
+extern spinlock_t journal_bh_state_lock;
+extern spinlock_t journal_bh_journal_lock;
+
+static inline void jbd_lock_bh_state(struct buffer_head *bh)
 {
-	return jh->b_bh;
+	spin_lock(&journal_bh_state_lock);
+	BUG_ON(buffer_state(bh));
+	set_buffer_state(bh);
+	__acquire(journal_bh_state_lock);
 }
 
-static inline struct journal_head *bh2jh(struct buffer_head *bh)
+static inline int jbd_trylock_bh_state(struct buffer_head *bh)
 {
-	return bh->b_private;
+	if (!spin_trylock(&journal_bh_state_lock)) 
+		return 0;
+
+	BUG_ON(buffer_state(bh));
+	set_buffer_state(bh);
+	__acquire(journal_bh_state_lock);
+	return 1;
 }
 
+static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
+{
+	return buffer_state(bh);
+}
+
+static inline void jbd_unlock_bh_state(struct buffer_head *bh)
+{
+	BUG_ON(!buffer_state(bh));
+	clear_buffer_state(bh);
+	spin_unlock(&journal_bh_state_lock);
+	__release(journal_bh_state_lock);
+}
+
+static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
+{
+	spin_lock(&journal_bh_journal_lock);
+	__acquire(journal_bh_journal_lock);
+}
+
+static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
+{
+	spin_unlock(&journal_bh_journal_lock);
+	__release(journal_bh_journal_lock);
+}
+
+#else  /* ! (CONFIG_SMP || CONFIG_DEBUG_SPINLOCK || CONFIG_PREEMPT) */
+
 static inline void jbd_lock_bh_state(struct buffer_head *bh)
 {
-	bit_spin_lock(BH_State, &bh->b_state);
+	__acquire(journal_bh_state_lock);
 }
 
 static inline int jbd_trylock_bh_state(struct buffer_head *bh)
 {
-	return bit_spin_trylock(BH_State, &bh->b_state);
+	__acquire(journal_bh_state_lock);
+	return 1;
 }
 
 static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
 {
-	return bit_spin_is_locked(BH_State, &bh->b_state);
+	return 1;
 }
 
 static inline void jbd_unlock_bh_state(struct buffer_head *bh)
 {
-	bit_spin_unlock(BH_State, &bh->b_state);
+	__release(journal_bh_state_lock);
 }
 
 static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
 {
-	bit_spin_lock(BH_JournalHead, &bh->b_state);
+	__acquire(journal_bh_journal_lock);
 }
 
 static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
 {
-	bit_spin_unlock(BH_JournalHead, &bh->b_state);
+	__release(journal_bh_journal_lock);
 }
+#endif /* (CONFIG_SMP || CONFIG_DEBUG_SPINLOCK || CONFIG_PREEMPT) */
 
+static inline struct buffer_head *jh2bh(struct journal_head *jh)
+{
+	return jh->b_bh;
+}
+
+static inline struct journal_head *bh2jh(struct buffer_head *bh)
+{
+	return bh->b_private;
+}
+
 struct jbd_revoke_table_s;
 
 /**
Index: fs/jbd/journal.c
===================================================================
--- fs/jbd/journal.c	(revision 113)
+++ fs/jbd/journal.c	(working copy)
@@ -82,6 +82,14 @@
 
 static int journal_convert_superblock_v1(journal_t *, journal_superblock_t *);
 
+#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
+spinlock_t journal_bh_state_lock = SPIN_LOCK_UNLOCKED;
+spinlock_t journal_bh_journal_lock = SPIN_LOCK_UNLOCKED;
+
+EXPORT_SYMBOL(journal_bh_state_lock);
+EXPORT_SYMBOL(journal_bh_journal_lock);
+#endif
+
 /*
  * Helper function used to manage commit timeouts
  */


