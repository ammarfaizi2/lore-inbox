Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310517AbSCGUpv>; Thu, 7 Mar 2002 15:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310519AbSCGUpl>; Thu, 7 Mar 2002 15:45:41 -0500
Received: from brick.egenera.com ([208.51.147.252]:58911 "EHLO egenera.com")
	by vger.kernel.org with ESMTP id <S310517AbSCGUpX>;
	Thu, 7 Mar 2002 15:45:23 -0500
From: "Patrick O'Rourke" <porourke@egenera.com>
Message-Id: <200203072045.PAA08386@egenera.com>
Subject: [PATCH] Prevent max_threads from exceeding PID_MAX
To: linux-kernel@vger.kernel.org
Date: Thu, 7 Mar 2002 15:45:17 -0500 (EST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible on large memory systems that the default process limits
can exceed PID_MAX.  This will allow a non-root user to consume all pids
resulting in the kernel to basically hang in get_pid().

The following patch to fork_init() will prevent max_threads from exceeding
PID_MAX.

Pat

--- linux-2.4.19-pre2-x/kernel/fork.c	Mon Feb 25 14:38:13 2002
+++ linux-2.4.19-pre2/kernel/fork.c	Wed Mar  6 09:15:17 2002
@@ -74,6 +74,11 @@
 	 */
 	max_threads = mempages / (THREAD_SIZE/PAGE_SIZE) / 8;
 
+	/* don't let threads go beyond PID_MAX */
+	if (max_threads > PID_MAX) {
+		max_threads = PID_MAX;
+	}
+
 	init_task.rlim[RLIMIT_NPROC].rlim_cur = max_threads/2;
 	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
 }
