Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbVHZLVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbVHZLVT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 07:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbVHZLVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 07:21:18 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:26761 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932566AbVHZLVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 07:21:18 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050826060815.GB17783@elte.hu>
References: <1123011928.1590.43.camel@localhost.localdomain>
	 <1123025895.25712.7.camel@dhcp153.mvista.com>
	 <1123027226.1590.59.camel@localhost.localdomain>
	 <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123036936.1590.69.camel@localhost.localdomain>
	 <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123080606.1590.119.camel@localhost.localdomain>
	 <1123087447.1590.136.camel@localhost.localdomain>
	 <20050812125844.GA13357@elte.hu>
	 <1125030249.5365.23.camel@localhost.localdomain>
	 <20050826060815.GB17783@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 26 Aug 2005 07:20:49 -0400
Message-Id: <1125055250.5365.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 08:08 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > So, the only other solutions that I can think of is:
> > 
> > a) add yet another (bloat) lock to the buffer head.
> > 
> > b) Still use your b_update_lock for the jbd_lock_bh_journal_head and 
> > change the jbd_lock_bh_state to what I discussed earlier, and that 
> > being the hash wait_on_bit code.
> 
> could you try a), how clean does it get? Personally i'm much more in 
> favor of cleanliness. On the vanilla kernel a spinlock is zero bytes on 
> UP [the most RAM-sensitive platform], and it's a word on typical SMP.

Not only the cleanest, but also the simplest :-)

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux_realtime_ernie/fs/buffer.c
===================================================================
--- linux_realtime_ernie/fs/buffer.c	(revision 303)
+++ linux_realtime_ernie/fs/buffer.c	(working copy)
@@ -3053,6 +3053,7 @@
 {
 	BUG_ON(!list_empty(&bh->b_assoc_buffers));
 	BUG_ON(spin_is_locked(&bh->b_uptodate_lock));
+	BUG_ON(spin_is_locked(&bh->b_state_lock));
 	kmem_cache_free(bh_cachep, bh);
 	preempt_disable();
 	__get_cpu_var(bh_accounting).nr--;
@@ -3071,6 +3072,7 @@
 		memset(bh, 0, sizeof(*bh));
 		INIT_LIST_HEAD(&bh->b_assoc_buffers);
 		spin_lock_init(&bh->b_uptodate_lock);
+		spin_lock_init(&bh->b_state_lock);
 	}
 }
 
Index: linux_realtime_ernie/include/linux/buffer_head.h
===================================================================
--- linux_realtime_ernie/include/linux/buffer_head.h	(revision 303)
+++ linux_realtime_ernie/include/linux/buffer_head.h	(working copy)
@@ -62,6 +62,7 @@
  	void *b_private;		/* reserved for b_end_io */
 	struct list_head b_assoc_buffers; /* associated with another mapping */
 	spinlock_t b_uptodate_lock;
+	spinlock_t b_state_lock;
 };
 
 /*
Index: linux_realtime_ernie/include/linux/jbd.h
===================================================================
--- linux_realtime_ernie/include/linux/jbd.h	(revision 303)
+++ linux_realtime_ernie/include/linux/jbd.h	(working copy)
@@ -326,32 +326,32 @@
 
 static inline void jbd_lock_bh_state(struct buffer_head *bh)
 {
-	bit_spin_lock(BH_State, &bh->b_state);
+	spin_lock(&bh->b_state_lock);
 }
 
 static inline int jbd_trylock_bh_state(struct buffer_head *bh)
 {
-	return bit_spin_trylock(BH_State, &bh->b_state);
+	return spin_trylock(&bh->b_state_lock);
 }
 
 static inline int jbd_is_locked_bh_state(struct buffer_head *bh)
 {
-	return bit_spin_is_locked(BH_State, &bh->b_state);
+	return spin_is_locked(&bh->b_state_lock);
 }
 
 static inline void jbd_unlock_bh_state(struct buffer_head *bh)
 {
-	bit_spin_unlock(BH_State, &bh->b_state);
+	spin_unlock(&bh->b_state_lock);
 }
 
 static inline void jbd_lock_bh_journal_head(struct buffer_head *bh)
 {
-	bit_spin_lock(BH_JournalHead, &bh->b_state);
+	spin_lock(&bh->b_uptodate_lock);
 }
 
 static inline void jbd_unlock_bh_journal_head(struct buffer_head *bh)
 {
-	bit_spin_unlock(BH_JournalHead, &bh->b_state);
+	spin_unlock(&bh->b_uptodate_lock);
 }
 
 struct jbd_revoke_table_s;


