Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317867AbSGWAC4>; Mon, 22 Jul 2002 20:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317868AbSGWAC4>; Mon, 22 Jul 2002 20:02:56 -0400
Received: from users.ccur.com ([208.248.32.211]:56909 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id <S317867AbSGWACz>;
	Mon, 22 Jul 2002 20:02:55 -0400
From: jak@rudolph.ccur.com (Joe Korty)
Message-Id: <200207230005.AAA24267@rudolph.ccur.com>
Subject: [PATCH] ext3 lockup fix to lock-break-rml-2.4.18-1.patch
To: rml@tech9.net (Robert Love)
Date: Mon, 22 Jul 2002 20:05:11 -0400 (EDT)
Cc: akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org
Reply-To: joe.korty@ccur.com (Joe Korty)
In-Reply-To: <1027362145.932.49.camel@sinai> from "Robert Love" at Jul 22, 2002 11:22:25 AM
X-Mailer: ELM [version 2.5 PL0b1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,
The following patch fixes an apparent mismerge of Andrew Morton's low
latency work into the lock breaking patch.  Without this fix,
journal_commit_transaction() will loop forever, without making
forward progress, if need_resched was set on entry.

Base to which the patch was derived:

    linux.2.4.18.tar.bz2
    + sched-O1-2.4.18-pre8-K3.patch
    + preempt-kernel-rml-2.4.18-rc1-ingo-K3-1.patch
    + lock-break-rml-2.4.18-1.patch

Regards,
Joe


--- fs/jbd/commit.c.orig	Mon Jul 22 19:51:43 2002
+++ fs/jbd/commit.c	Mon Jul 22 19:52:00 2002
@@ -278,6 +278,7 @@
 			debug_lock_break(551);
 			spin_unlock(&journal_datalist_lock);
 			unlock_journal(journal);
+			unconditional_schedule();
 			lock_journal(journal);
 			spin_lock(&journal_datalist_lock);
 			continue;
