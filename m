Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265583AbUFDEbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265583AbUFDEbf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 00:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265592AbUFDEbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 00:31:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:17542 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265583AbUFDEb3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 00:31:29 -0400
Date: Thu, 3 Jun 2004 21:30:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: davidc@debian.org, 252391@bugs.debian.org, linux-kernel@vger.kernel.org
Subject: Re: Bug#252391: kernel-source-2.6.6: Assertion failure in
 journal_flush() ... "!journal->j_running_transaction"
Message-Id: <20040603213039.359697c3.akpm@osdl.org>
In-Reply-To: <20040603114029.GA7912@gondor.apana.org.au>
References: <20040603034037.70176BA0E0@zona.someotherplace.org>
	<20040603114029.GA7912@gondor.apana.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Andrew, what's stopping a journal_start() from setting j_running_transaction
>  just before the last spin_lock(&journal->j_state_lock) that guards the
>  J_ASSERT that was hit below?

Not much, it appears.  I'll queue the below for post-2.6.7.


--- 25/fs/ext3/super.c~ext3-journal_flush-needs-journal_lock_updates	2004-06-03 21:15:57.911628872 -0700
+++ 25-akpm/fs/ext3/super.c	2004-06-03 21:15:57.916628112 -0700
@@ -1907,13 +1907,17 @@ static void ext3_commit_super (struct su
 static void ext3_mark_recovery_complete(struct super_block * sb,
 					struct ext3_super_block * es)
 {
-	journal_flush(EXT3_SB(sb)->s_journal);
+	journal_t *journal = EXT3_SB(sb)->s_journal;
+
+	journal_lock_updates(journal);
+	journal_flush(journal);
 	if (EXT3_HAS_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_RECOVER) &&
 	    sb->s_flags & MS_RDONLY) {
 		EXT3_CLEAR_INCOMPAT_FEATURE(sb, EXT3_FEATURE_INCOMPAT_RECOVER);
 		sb->s_dirt = 0;
 		ext3_commit_super(sb, es, 1);
 	}
+	journal_unlock_updates(journal);
 }
 
 /*
_

