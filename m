Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261587AbVDUWdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbVDUWdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 18:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261549AbVDUWbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 18:31:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:29162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261514AbVDUW36 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 18:29:58 -0400
Date: Thu, 21 Apr 2005 15:29:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Brice Figureau <brice+lklm@daysofwonder.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-ac10 oops in journal_commit_transaction
Message-ID: <20050421222946.GK23013@shell0.pdx.osdl.net>
References: <894E37DECA393E4D9374E0ACBBE74270013E8BA0@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894E37DECA393E4D9374E0ACBBE74270013E8BA0@pdsmsx402.ccr.corp.intel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Zou, Nanhai (nanhai.zou@intel.com) wrote:
> 	We have seen the same oops on the same point.
> Can you point to me the URL where the patch is? 
> I am not sure which patch should I get.

I believe it's fixed in 2.6.11-ac, and we fixed it in the current stable
2.6.11.7 tree.  The following patch is what went into 2.6.11.7:
---

From: Stephen Tweedie
Subject: Prevent race condition in jbd

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


