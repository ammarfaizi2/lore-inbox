Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTE0Swv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTE0Swv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:52:51 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:41478 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263264AbTE0Swt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:52:49 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH 2.4.21-rc4] Fix oom killer braindamage
Date: Tue, 27 May 2003 21:05:45 +0200
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Message-Id: <200305272104.05802.m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Jc70+J+4Vy7qmFj"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_Jc70+J+4Vy7qmFj
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcelo,

attached patch fixes the oom killer braindamage where it tries to kill 
processes again and again and again w/o any ending or successfull killing of 
the selected processes in an OOM case.

The attached, very simple but effective, patch fixes it.

All the kudos go to Rik van Riel.

Patch tested and works, and also for a long time in my tree (and maybe also 
others?!)

This issue is out there for several years.

Please consider it for 2.4.21-rc5, thanks.

ciao, Marc





--Boundary-00=_Jc70+J+4Vy7qmFj
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="oomkiller-braindamage-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="oomkiller-braindamage-fix.patch"

===== mm/oom_kill.c 1.11 vs edited =====
--- 1.11/mm/oom_kill.c	Fri Aug 16 10:59:46 2002
+++ edited/mm/oom_kill.c	Sat Feb 22 17:31:49 2003
@@ -61,11 +61,16 @@ static int badness(struct task_struct *p
 
 	if (!p->mm)
 		return 0;
+
+	if (p->flags & PF_MEMDIE)
+		return 0;
+
 	/*
 	 * Never kill init
 	 */
 	if (p->pid == 1)
 		return 0;
+
 	/*
 	 * The memory size of the process is the basis for the badness.
 	 */

--Boundary-00=_Jc70+J+4Vy7qmFj--

