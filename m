Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268031AbUHXPyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268031AbUHXPyL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268052AbUHXPyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:54:11 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:59600 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S268031AbUHXPyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:54:04 -0400
Date: Tue, 24 Aug 2004 17:54:00 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Rik van Riel <riel@redhat.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [patch] make oom killer points unsigned long
Message-ID: <Pine.LNX.4.53.0408241745020.6266@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

it seems a little unsafe to me to have oom killer badness points of type
int, when all the underlying objects are unsigned long.

I can't immediately think of a case where this matters much, but e.g. a
long-running job or daemon on a 64 bit machine might lose it's bonus
because of that.

Tim


Signed-off-by: Tim Schmielau <tim@physik3.uni-rostock.de>

--- linux-2.6.8.1/mm/oom_kill.c		2004-08-17 21:38:55.000000000 +0200
+++ linux-2.6.8.1-oom/mm/oom_kill.c	2004-08-24 17:40:58.000000000 +0200
@@ -41,9 +41,9 @@
  *    of least surprise ... (be careful when you change it)
  */
 
-static int badness(struct task_struct *p)
+static unsigned long badness(struct task_struct *p)
 {
-	int points, cpu_time, run_time, s;
+	unsigned long points, cpu_time, run_time, s;
 
 	if (!p->mm)
 		return 0;
@@ -108,13 +108,13 @@ static int badness(struct task_struct *p
  */
 static struct task_struct * select_bad_process(void)
 {
-	int maxpoints = 0;
+	unsigned long maxpoints = 0;
 	struct task_struct *g, *p;
 	struct task_struct *chosen = NULL;
 
 	do_each_thread(g, p)
 		if (p->pid) {
-			int points = badness(p);
+			unsigned long points = badness(p);
 			if (points > maxpoints) {
 				chosen = p;
 				maxpoints = points;
