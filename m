Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKNRt3>; Tue, 14 Nov 2000 12:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbQKNRtT>; Tue, 14 Nov 2000 12:49:19 -0500
Received: from hvmta01-ext.us.psimail.psi.net ([38.202.36.29]:61428 "EHLO
	hvmta01-stg.us.psimail.psi.net") by vger.kernel.org with ESMTP
	id <S129045AbQKNRtP>; Tue, 14 Nov 2000 12:49:15 -0500
From: "Chris Swiedler" <chris.swiedler@sevista.com>
To: <torvalds@transmeta.com>, "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH] bugfix in oom_kill.c
Date: Tue, 14 Nov 2000 12:22:49 -0500
Message-ID: <NDBBIAJKLMMHOGKNMGFNEEJFCPAA.chris.swiedler@sevista.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a bug in oom_kill. The way it was written, the OOM killer
would try to kill the idle task if the task selected immediately before it
had the most "badness". Probably because of the order of for_each_task(),
this wouldn't ever happen, but I don't think we want to depend on that.

chris

--- official/linux-2.4.0/mm/oom_kill.c	Mon Nov  6 23:53:01 2000
+++ work/linux-2.4.0-test10/mm/oom_kill.c	Thu Nov  9 23:12:10 2000
@@ -124,11 +143,12 @@
 	read_lock(&tasklist_lock);
 	for_each_task(p)
 	{
-		if (p->pid)
+		if (p->pid) {
 			points = badness(p);
-		if (points > maxpoints) {
-			chosen = p;
-			maxpoints = points;
+			if (points > maxpoints) {
+				chosen = p;
+				maxpoints = points;
+			}
 		}
 	}
 	read_unlock(&tasklist_lock);

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
