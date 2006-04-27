Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWD0UJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWD0UJQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWD0UJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:09:15 -0400
Received: from smtp-2.llnl.gov ([128.115.3.82]:12750 "EHLO smtp-2.llnl.gov")
	by vger.kernel.org with ESMTP id S1030217AbWD0UJO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:09:14 -0400
From: Dave Peterson <dsp@llnl.gov>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2 (repost)] mm: avoid unnecessary looping in out_of_memory()
Date: Thu, 27 Apr 2006 13:08:11 -0700
User-Agent: KMail/1.5.3
Cc: linux-mm@kvack.org, riel@surriel.com, nickpiggin@yahoo.com.au, ak@suse.de,
       akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604271308.11553.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I see no reason to loop in out_of_memory().  If oom_kill_process()
returns 1, this may be because the task that select_bad_process()
chose is now exiting (and therefore oom_kill_task() found the ->mm
pointer of the chosen task to be NULL).  out_of_memory() may as well
return to its caller, perhaps avoiding the need to shoot a process.
If the memory issues are still not resolved, out_of_memory() will be
called again so there's no reason to loop.

Signed-Off-By: David S. Peterson <dsp@llnl.gov>
---
This is a repost of a previous patch.  It applies to kernel
2.6.17-rc3 (after applying patch 1/2).


Index: linux-2.6.17-rc3-oom/mm/oom_kill.c
===================================================================
--- linux-2.6.17-rc3-oom.orig/mm/oom_kill.c	2006-04-27 12:08:36.000000000 -0700
+++ linux-2.6.17-rc3-oom/mm/oom_kill.c	2006-04-27 12:08:36.000000000 -0700
@@ -366,7 +366,6 @@ void out_of_memory(struct zonelist *zone
 		break;
 
 	case CONSTRAINT_NONE:
-retry:
 		/*
 		 * Rambo mode: Shoot down a process and hope it solves whatever
 		 * issues we may have.
@@ -385,9 +384,7 @@ retry:
 			panic("Out of memory and no killable processes...\n");
 		}
 
-		if (oom_kill_process(p, points, "Out of memory"))
-			goto retry;
-
+		cancel = oom_kill_process(p, points, "Out of memory");
 		break;
 	}
 
