Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267244AbTBDM0G>; Tue, 4 Feb 2003 07:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267246AbTBDM0G>; Tue, 4 Feb 2003 07:26:06 -0500
Received: from mario.gams.at ([194.42.96.10]:33568 "EHLO mario.gams.at")
	by vger.kernel.org with ESMTP id <S267244AbTBDM0F>;
	Tue, 4 Feb 2003 07:26:05 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Axel Kittenberger <Axel.Kittenberger@maxxio.com>
Organization: Maxxio Technologies
To: linux-kernel@vger.kernel.org
Subject: Patch: oom_kill
Date: Tue, 4 Feb 2003 13:32:05 +0100
User-Agent: KMail/1.4.1
Cc: riel@nl.linux.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200302041332.05096.Axel.Kittenberger@maxxio.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A small patch to discuss, it's about killing an process in an out-of-memory 
condition. First from the code I don't see any prohibition that it kills 
init, if reaches maximum badness points, don't think thats something anybody 
anytime wants. Sure for desktop systems this very unlikely to ever occur, but 
for small embedded systems that could happen. 

Second proposal is to give processes that are direct childs from init a 
special bonus, normally that are those we don't want to get killed. They are 
either important or get respawned eitherway creating an endless oom condition 
loop when killing them.

A position to think about is to generally bonus processes from their distance 
to init. The further down in the hirachy to more unlikely it is for the 
process to be important.

Greetings, Axel


diff -ru linux-2.4.20-org/mm/oom_kill.c linux-2.4.20/mm/oom_kill.c
--- linux-2.4.20-org/mm/oom_kill.c	Fri Nov 29 00:53:15 2002
+++ linux-2.4.20/mm/oom_kill.c	Tue Feb  4 12:10:40 2003
@@ -62,6 +62,11 @@
 	if (!p->mm)
 		return 0;
 	/*
+	 * Never kill init
+	 */
+	if (p->pid == 1)
+		return 0:        
+	/*
 	 * The memory size of the process is the basis for the badness.
 	 */
 	points = p->mm->total_vm;
@@ -101,6 +106,15 @@
 	 */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
 		points /= 4;
+
+	/*
+	 * Give childs from init a bonus, they usually get respawned
+	 * eitherway, killing them might not help to solve the out of memory 
+	 * condition in the long run.
+	 */
+	if (p->p_pptr != NULL && p->p_pptr->pid == 1) 
+		points /= 4;
+        
 #ifdef DEBUG
 	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
 	p->pid, p->comm, points);

