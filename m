Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268972AbTBWUsC>; Sun, 23 Feb 2003 15:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268975AbTBWUsC>; Sun, 23 Feb 2003 15:48:02 -0500
Received: from 5-077.ctame701-1.telepar.net.br ([200.193.163.77]:39646 "EHLO
	5-077.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S268972AbTBWUsB>; Sun, 23 Feb 2003 15:48:01 -0500
Date: Sun, 23 Feb 2003 17:57:56 -0300 (BRT)
From: Rik van Riel <riel@imladris.surriel.com>
To: "Marcelo W. Tosatti" <marcelo@imladris.surriel.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: [PATCH][TRIVIAL] don't let OOM killer kill same process repeatedly
Message-ID: <Pine.LNX.4.50L.0302231754590.2206-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If a process cannot exit because it's stuck in eg. a driver, it
doesn't make sense to have the OOM killer kill it repeatedly;
that could lead to a hung system.

Instead, kill another process if the first process we tried to
kill hasn't made any move to exit within 5 seconds.  This way
we have a much better chance of recovering the system.

Note: this patch applies without offset to both 2.4 and 2.5,
since oom_kill.c hasn't changed since about 2.4.14...

please apply,

Rik
-- 
Engineers don't grow up, they grow sideways.
http://www.surriel.com/		http://kernelnewbies.org/



===== mm/oom_kill.c 1.11 vs edited =====
--- 1.11/mm/oom_kill.c	Fri Aug 16 10:59:46 2002
+++ edited/mm/oom_kill.c	Sat Feb 22 17:31:49 2003
@@ -61,6 +61,9 @@

 	if (!p->mm)
 		return 0;
+
+	if (p->flags & PF_MEMDIE)
+		return 0;
 	/*
 	 * The memory size of the process is the basis for the badness.
 	 */
