Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315042AbSESTo2>; Sun, 19 May 2002 15:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315259AbSESTnP>; Sun, 19 May 2002 15:43:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19204 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315210AbSESTl6>;
	Sun, 19 May 2002 15:41:58 -0400
Message-ID: <3CE800DF.BDAE210@zip.com.au>
Date: Sun, 19 May 2002 12:45:35 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [patch 14/15] fix ext3 race with writeback
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



The ext3-no-steal patch has exposed a long-standing race in ext3.  It
has been there all the time in 2.4, but never triggered until some
timing change in the ext3-no-steal patch exposed it.  The race was not
present in 2.2 because 2.2's bdflush runs inside lock_kernel().

The problem is that when ext3 is shuffling a buffer between journalling
lists there is a small window where the buffer is marked BH_dirty. 
Aonther CPU can grab it, mark it clean and write it out.  Then ext3
puts the buffer onto a list of buffers which are expected to be dirty,
and gets confused later on when the buffer turns out to be clean.

The patch from Stephen records the expected dirtiness of the buffer in
a local variable, so BH_dirty is not transiently set while ext3
shuffles.


=====================================

--- 2.5.16/fs/jbd/transaction.c~sct-jbddirty	Sun May 19 11:49:50 2002
+++ 2.5.16-akpm/fs/jbd/transaction.c	Sun May 19 11:49:50 2002
@@ -1941,6 +1941,8 @@ void __journal_file_buffer(struct journa
 			transaction_t *transaction, int jlist)
 {
 	struct journal_head **list = 0;
+	int was_dirty = 0;
+	struct buffer_head *bh = jh2bh(jh);
 
 	assert_spin_locked(&journal_datalist_lock);
 	
@@ -1951,13 +1953,24 @@ void __journal_file_buffer(struct journa
 	J_ASSERT_JH(jh, jh->b_transaction == transaction ||
 				jh->b_transaction == 0);
 
-	if (jh->b_transaction) {
-		if (jh->b_jlist == jlist)
-			return;
+	if (jh->b_transaction && jh->b_jlist == jlist)
+		return;
+	
+	/* The following list of buffer states needs to be consistent
+	 * with __jbd_unexpected_dirty_buffer()'s handling of dirty
+	 * state. */
+
+	if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
+	    jlist == BJ_Shadow || jlist == BJ_Forget) {
+		if (test_clear_buffer_dirty(bh) ||
+		    test_clear_buffer_jbddirty(bh))
+			was_dirty = 1;
+	}
+
+	if (jh->b_transaction)
 		__journal_unfile_buffer(jh);
-	} else {
+	else
 		jh->b_transaction = transaction;
-	}
 
 	switch (jlist) {
 	case BJ_None:
@@ -1994,12 +2007,8 @@ void __journal_file_buffer(struct journa
 	__blist_add_buffer(list, jh);
 	jh->b_jlist = jlist;
 
-	if (jlist == BJ_Metadata || jlist == BJ_Reserved || 
-	    jlist == BJ_Shadow || jlist == BJ_Forget) {
-		if (test_clear_buffer_dirty(jh2bh(jh))) {
-			set_bit(BH_JBDDirty, &jh2bh(jh)->b_state);
-		}
-	}
+	if (was_dirty)
+		set_buffer_jbddirty(bh);
 }
 
 void journal_file_buffer(struct journal_head *jh,
--- 2.5.16/include/linux/jbd.h~sct-jbddirty	Sun May 19 11:49:50 2002
+++ 2.5.16-akpm/include/linux/jbd.h	Sun May 19 11:50:46 2002
@@ -235,6 +235,7 @@ enum jbd_state_bits {
 
 BUFFER_FNS(JBD, jbd)
 BUFFER_FNS(JBDDirty, jbddirty)
+TAS_BUFFER_FNS(JBDDirty, jbddirty)
 
 static inline struct buffer_head *jh2bh(struct journal_head *jh)
 {

-
