Return-Path: <linux-kernel-owner+w=401wt.eu-S1751149AbXAFCf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbXAFCf7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbXAFCdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:33:39 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36926 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbXAFCd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:33:28 -0500
Message-Id: <20070106023723.703921000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:42 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, hugh@veritas.com
Subject: [patch 49/50] fix OOM killing of swapoff
Content-Disposition: inline; filename=fix-oom-killing-of-swapoff.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Hugh Dickins <hugh@veritas.com>

These days, if you swapoff when there isn't enough memory, OOM killer gives
"BUG: scheduling while atomic" and the machine hangs: badness() needs to do
its PF_SWAPOFF return after the task_unlock (tasklist_lock is also held
here, so p isn't going to be freed: PF_SWAPOFF might get turned off at any
moment, but that doesn't really matter).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 mm/oom_kill.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.19.1.orig/mm/oom_kill.c
+++ linux-2.6.19.1/mm/oom_kill.c
@@ -61,12 +61,6 @@ unsigned long badness(struct task_struct
 	}
 
 	/*
-	 * swapoff can easily use up all memory, so kill those first.
-	 */
-	if (p->flags & PF_SWAPOFF)
-		return ULONG_MAX;
-
-	/*
 	 * The memory size of the process is the basis for the badness.
 	 */
 	points = mm->total_vm;
@@ -77,6 +71,12 @@ unsigned long badness(struct task_struct
 	task_unlock(p);
 
 	/*
+	 * swapoff can easily use up all memory, so kill those first.
+	 */
+	if (p->flags & PF_SWAPOFF)
+		return ULONG_MAX;
+
+	/*
 	 * Processes which fork a lot of child processes are likely
 	 * a good choice. We add half the vmsize of the children if they
 	 * have an own mm. This prevents forking servers to flood the

--
