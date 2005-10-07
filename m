Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbVJGMie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbVJGMie (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 08:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVJGMie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 08:38:34 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:9152 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932500AbVJGMid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 08:38:33 -0400
Date: Fri, 7 Oct 2005 08:38:25 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc3-rt2
In-Reply-To: <20051007111544.GB857@elte.hu>
Message-ID: <Pine.LNX.4.58.0510070810160.7222@localhost.localdomain>
References: <1128458707.13057.68.camel@tglx.tec.linutronix.de>
 <5bdc1c8b0510041349g1a4f2484qd17a11812c8ccac3@mail.gmail.com>
 <20051005105605.GA27075@elte.hu> <5bdc1c8b0510051014q3bb02d5bl80d2c88cc884fe35@mail.gmail.com>
 <Pine.LNX.4.58.0510060403210.28535@localhost.localdomain> <20051006081055.GA20491@elte.hu>
 <Pine.LNX.4.58.0510060433010.28535@localhost.localdomain> <20051006084920.GB22397@elte.hu>
 <Pine.LNX.4.58.0510061122530.418@localhost.localdomain>
 <Pine.LNX.4.58.0510070706100.6608@localhost.localdomain> <20051007111544.GB857@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Oct 2005, Ingo Molnar wrote:
>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > I was compiling a kernel in a shell that I set to a priority of 20,
> > and it locked up on the bit_spin_lock crap of jbd.  Did you want me to
> > send you that patch again that adds another spinlock to the buffer
> > head and uses that instead of the bit_spins?
>
> yeah, please do.
>

OK, here it is.  I tested it out by doing what locked up the first time.
Compiling the kernel under a shell with a priority of 20.

It survived a "make clean; make -j2".

-- Steve

patched against 2.6.14-rc3-rt10

Index: linux-rt-quilt/fs/buffer.c
===================================================================
--- linux-rt-quilt.orig/fs/buffer.c	2005-10-06 08:04:55.000000000 -0400
+++ linux-rt-quilt/fs/buffer.c	2005-10-07 07:46:25.000000000 -0400
@@ -3055,6 +3055,7 @@
 {
 	BUG_ON(!list_empty(&bh->b_assoc_buffers));
 	BUG_ON(spin_is_locked(&bh->b_uptodate_lock));
+	BUG_ON(spin_is_locked(&bh->b_state_lock));
 	kmem_cache_free(bh_cachep, bh);
 	get_cpu_var(bh_accounting).nr--;
 	recalc_bh_state();
@@ -3072,6 +3073,7 @@
 		memset(bh, 0, sizeof(*bh));
 		INIT_LIST_HEAD(&bh->b_assoc_buffers);
 		spin_lock_init(&bh->b_uptodate_lock);
+		spin_lock_init(&bh->b_state_lock);
 	}
 }

Index: linux-rt-quilt/include/linux/buffer_head.h
===================================================================
--- linux-rt-quilt.orig/include/linux/buffer_head.h	2005-10-06 08:04:56.000000000 -0400
+++ linux-rt-quilt/include/linux/buffer_head.h	2005-10-07 07:46:25.000000000 -0400
@@ -62,6 +62,7 @@
  	void *b_private;		/* reserved for b_end_io */
 	struct list_head b_assoc_buffers; /* associated with another mapping */
 	spinlock_t b_uptodate_lock;
+	spinlock_t b_state_lock;
 };

 /*
Index: linux-rt-quilt/include/linux/jbd.h
===================================================================
--- linux-rt-quilt.orig/include/linux/jbd.h	2005-10-06 08:04:00.000000000 -0400
+++ linux-rt-quilt/include/linux/jbd.h	2005-10-07 07:46:25.000000000 -0400
@@ -327,32 +327,32 @@

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

