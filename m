Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261255AbUKBPK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbUKBPK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 10:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbUKBPJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 10:09:27 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:28297 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261184AbUKBPDa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 10:03:30 -0500
Date: Tue, 2 Nov 2004 16:03:14 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] cputime: fix do_setitimer.
Message-ID: <20041102150314.GA3908@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] cputime: fix do_setitimer.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Fix do_setitimer for ITIMER_VIRTUAL and ITIMER_PROF. Non-zero
it_virt_value and it_prof_value needs to get increamented by one
jiffies. Applications like konqueror depend on this behaviour.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 kernel/itimer.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -urN linux-2.6/kernel/itimer.c linux-2.6-cputime/kernel/itimer.c
--- linux-2.6/kernel/itimer.c	2004-11-02 14:30:36.000000000 +0100
+++ linux-2.6-cputime/kernel/itimer.c	2004-11-02 14:31:42.000000000 +0100
@@ -102,16 +102,18 @@
 			break;
 		case ITIMER_VIRTUAL:
 			cputime = timeval_to_cputime(&value->it_value);
-			if (cputime_eq(cputime, cputime_zero))
-				cputime = jiffies_to_cputime(1);
+			if (cputime_gt(cputime, cputime_zero))
+				cputime = cputime_add(cputime,
+						      jiffies_to_cputime(1));
 			current->it_virt_value = cputime;
 			cputime = timeval_to_cputime(&value->it_interval);
 			current->it_virt_incr = cputime;
 			break;
 		case ITIMER_PROF:
 			cputime = timeval_to_cputime(&value->it_value);
-			if (cputime_eq(cputime, cputime_zero))
-				cputime = jiffies_to_cputime(1);
+			if (cputime_gt(cputime, cputime_zero))
+				cputime = cputime_add(cputime,
+						      jiffies_to_cputime(1));
 			current->it_prof_value = cputime;
 			cputime = timeval_to_cputime(&value->it_interval);
 			current->it_prof_incr = cputime;
