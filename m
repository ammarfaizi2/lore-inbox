Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTE2LKQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 07:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTE2LKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 07:10:16 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:38835 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262145AbTE2LKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 07:10:15 -0400
Date: Thu, 29 May 2003 04:23:33 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm2
Message-Id: <20030529042333.3dd62255.akpm@digeo.com>
In-Reply-To: <20030529012914.2c315dad.akpm@digeo.com>
References: <20030529012914.2c315dad.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 May 2003 11:23:33.0080 (UTC) FILETIME=[BD019D80:01C325D4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm2/
> 
> 
> . A couple more locking mistakes in ext3 have been fixed.
> 

But not all of them.  The below is needed on SMP.

diff -puN fs/jbd/transaction.c~x fs/jbd/transaction.c
--- 25-whoops/fs/jbd/transaction.c~x	2003-05-29 04:21:51.000000000 -0700
+++ 25-whoops-akpm/fs/jbd/transaction.c	2003-05-29 04:22:09.000000000 -0700
@@ -2077,12 +2077,13 @@ void __journal_refile_buffer(struct jour
  */
 void journal_refile_buffer(journal_t *journal, struct journal_head *jh)
 {
-	struct buffer_head *bh;
+	struct buffer_head *bh = jh2bh(jh);
 
+	jbd_lock_bh_state(bh);
 	spin_lock(&journal->j_list_lock);
-	bh = jh2bh(jh);
 
 	__journal_refile_buffer(jh);
+	jbd_unlock_bh_state(bh);
 	journal_remove_journal_head(bh);
 
 	spin_unlock(&journal->j_list_lock);

_

