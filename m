Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTJQF4t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 01:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263311AbTJQF4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 01:56:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:65192 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263310AbTJQF4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 01:56:48 -0400
Date: Thu, 16 Oct 2003 22:56:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alberto Bertogli <albertogli@telpin.com.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5/6 (and probably 7 too) size-4096 memory leak
Message-Id: <20031016225653.7f3ff0c3.akpm@osdl.org>
In-Reply-To: <20031016025554.GH4292@telpin.com.ar>
References: <20031016025554.GH4292@telpin.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alberto Bertogli <albertogli@telpin.com.ar> wrote:
>
> I want to report a memory leak for 2.6.0-test5 that I've noticed today on
>  a mail server after 32 days of uptime.

'twas in ext3.

 fs/jbd/commit.c  |    8 ++++++++
 fs/jbd/journal.c |    2 ++
 2 files changed, 10 insertions(+)

diff -puN fs/jbd/commit.c~jbd-leak-fix fs/jbd/commit.c
--- 25/fs/jbd/commit.c~jbd-leak-fix	2003-10-16 21:47:28.000000000 -0700
+++ 25-akpm/fs/jbd/commit.c	2003-10-16 22:10:58.000000000 -0700
@@ -172,6 +172,14 @@ void journal_commit_transaction(journal_
 	while (commit_transaction->t_reserved_list) {
 		jh = commit_transaction->t_reserved_list;
 		JBUFFER_TRACE(jh, "reserved, unused: refile");
+		/*
+		 * A journal_get_undo_access()+journal_release_buffer() may
+		 * leave undo-committed data.
+		 */
+		if (jh->b_committed_data) {
+			kfree(jh->b_committed_data);
+			jh->b_committed_data = NULL;
+		}
 		journal_refile_buffer(journal, jh);
 	}
 
diff -puN fs/jbd/journal.c~jbd-leak-fix fs/jbd/journal.c
--- 25/fs/jbd/journal.c~jbd-leak-fix	2003-10-16 22:11:45.000000000 -0700
+++ 25-akpm/fs/jbd/journal.c	2003-10-16 22:11:56.000000000 -0700
@@ -1729,6 +1729,8 @@ static void __journal_remove_journal_hea
 			J_ASSERT_BH(bh, buffer_jbd(bh));
 			J_ASSERT_BH(bh, jh2bh(jh) == bh);
 			BUFFER_TRACE(bh, "remove journal_head");
+			J_ASSERT_BH(bh, !jh->b_frozen_data);
+			J_ASSERT_BH(bh, !jh->b_committed_data);
 			bh->b_private = NULL;
 			jh->b_bh = NULL;	/* debug, really */
 			clear_buffer_jbd(bh);

_

