Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261232AbUGaSsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUGaSsu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 14:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUGaSsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 14:48:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:49638 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261232AbUGaSsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 14:48:46 -0400
Date: Sat, 31 Jul 2004 11:47:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.8-rc2-mm1
Message-Id: <20040731114714.37359c2d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0407311230330.4095@montezuma.fsmlabs.com>
References: <20040728020444.4dca7e23.akpm@osdl.org>
	<Pine.LNX.4.58.0407311230330.4095@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> Ingo i believe you have a patch for this, could you push it to Andrew?

I suspect Ingo's patch will be livelockable under some circumstances.

I suspect mine is too, only less so.

> I reckon it's provoked by CONFIG_PREEMPT.

This should fix.


diff -puN fs/jbd/checkpoint.c~journal_clean_checkpoint_list-latency-fix-fix fs/jbd/checkpoint.c
--- 25/fs/jbd/checkpoint.c~journal_clean_checkpoint_list-latency-fix-fix	2004-07-31 11:43:39.320530424 -0700
+++ 25-akpm/fs/jbd/checkpoint.c	2004-07-31 11:44:11.859583736 -0700
@@ -497,8 +497,7 @@ int __journal_clean_checkpoint_list(jour
 		 * We don't test cond_resched() here because another CPU could
 		 * be waiting on j_list_lock() while holding a different lock.
 		 */
-		if ((ret & 127) == 127) {
-			spin_unlock(&journal->j_list_lock);
+		if (transaction && (ret & 127) == 127) {
 			/*
 			 * We need to schedule away.  Rotate both this
 			 * transaction's buffer list and the checkpoint list to
@@ -512,6 +511,7 @@ int __journal_clean_checkpoint_list(jour
 			if (transaction)
 				journal->j_checkpoint_transactions =
 					transaction->t_cpnext;
+			spin_unlock(&journal->j_list_lock);
 			return ret;
 		}
 #endif
_

