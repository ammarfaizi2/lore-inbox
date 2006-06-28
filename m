Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbWF1Gec@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbWF1Gec (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 02:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932747AbWF1Geb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 02:34:31 -0400
Received: from mga02.intel.com ([134.134.136.20]:12724 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932746AbWF1Geb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 02:34:31 -0400
X-IronPort-AV: i="4.06,186,1149490800"; 
   d="scan'208"; a="57746530:sNHT14727223"
Subject: [Patch] jbd commit code deadloop when installing Linux
From: Zou Nan hai <nanhai.zou@intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1151470123.6052.17.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 28 Jun 2006 12:48:43 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We see system hang in ext3 jbd code
when Linux install program anaconda copying 
packages. 

That is because anaconda is invoked from linuxrc 
in initrd when system_state is still SYSTEM_BOOTING.

Thus the cond_resched checks in  journal_commit_transaction 
will always return 1 without actually schedule, 
then the system fall into deadloop.

The patch will fix the issue.

Zou Nan hai

Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>


--- linux-2.6.17/fs/jbd/commit.c	2006-06-18 09:49:35.000000000 +0800
+++ b/fs/jbd/commit.c	2006-06-28 14:15:41.000000000 +0800
@@ -625,8 +625,17 @@ wait_for_iobuf:
 			wait_on_buffer(bh);
 			goto wait_for_iobuf;
 		}
-		if (cond_resched())
-			goto wait_for_iobuf;
+		if (cond_resched())  {
+			if (commit_transaction->t_iobuf_list != NULL) {
+				jh = commit_transaction->t_iobuf_list->b_tprev;
+				bh = jh2bh(jh);
+				if (buffer_locked(bh)) {
+					wait_on_buffer(bh);
+					goto wait_for_iobuf;
+				}
+			} else
+				break;
+		}
 
 		if (unlikely(!buffer_uptodate(bh)))
 			err = -EIO;
@@ -681,8 +690,17 @@ wait_for_iobuf:
 			wait_on_buffer(bh);
 			goto wait_for_ctlbuf;
 		}
-		if (cond_resched())
-			goto wait_for_ctlbuf;
+		if (cond_resched()) {
+			if(commit_transaction->t_log_list != NULL) {
+				jh = commit_transaction->t_log_list->b_tprev;
+				bh = jh2bh(jh);
+				if (buffer_locked(bh)) {
+					wait_on_buffer(bh);
+					goto wait_for_ctlbuf;
+				}
+			}else
+				break;
+		}
 
 		if (unlikely(!buffer_uptodate(bh)))
 			err = -EIO;

