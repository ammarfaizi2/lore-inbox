Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVDEQ7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVDEQ7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVDEQui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:50:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:63385 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261819AbVDEQsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:48:41 -0400
Date: Tue, 5 Apr 2005 09:46:28 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: jack@suse.cz, markw@osdl.org, sct@redhat.com, mason@suse.com
Subject: [02/08] Prevent race condition in jbd
Message-ID: <20050405164628.GC17299@kroah.com>
References: <20050405164539.GA17299@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405164539.GA17299@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------


This patch from Stephen Tweedie which fixes a race in jbd code (it
demonstrated itself as more or less random NULL dereferences in the
journal code).

Acked-by: Jan Kara <jack@suse.cz>
Acked-by: Chris Mason <mason@suse.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- linux-2.6-ext3/fs/jbd/transaction.c.=K0000=.orig
+++ linux-2.6-ext3/fs/jbd/transaction.c
@@ -1775,10 +1775,10 @@ static int journal_unmap_buffer(journal_
 			JBUFFER_TRACE(jh, "checkpointed: add to BJ_Forget");
 			ret = __dispose_buffer(jh,
 					journal->j_running_transaction);
+			journal_put_journal_head(jh);
 			spin_unlock(&journal->j_list_lock);
 			jbd_unlock_bh_state(bh);
 			spin_unlock(&journal->j_state_lock);
-			journal_put_journal_head(jh);
 			return ret;
 		} else {
 			/* There is no currently-running transaction. So the
@@ -1789,10 +1789,10 @@ static int journal_unmap_buffer(journal_
 				JBUFFER_TRACE(jh, "give to committing trans");
 				ret = __dispose_buffer(jh,
 					journal->j_committing_transaction);
+				journal_put_journal_head(jh);
 				spin_unlock(&journal->j_list_lock);
 				jbd_unlock_bh_state(bh);
 				spin_unlock(&journal->j_state_lock);
-				journal_put_journal_head(jh);
 				return ret;
 			} else {
 				/* The orphan record's transaction has
@@ -1813,10 +1813,10 @@ static int journal_unmap_buffer(journal_
 					journal->j_running_transaction);
 			jh->b_next_transaction = NULL;
 		}
+		journal_put_journal_head(jh);
 		spin_unlock(&journal->j_list_lock);
 		jbd_unlock_bh_state(bh);
 		spin_unlock(&journal->j_state_lock);
-		journal_put_journal_head(jh);
 		return 0;
 	} else {
 		/* Good, the buffer belongs to the running transaction.

