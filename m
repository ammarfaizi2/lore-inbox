Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267361AbTB1BB5>; Thu, 27 Feb 2003 20:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbTB1BB5>; Thu, 27 Feb 2003 20:01:57 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:13251 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S267361AbTB1BB4>; Thu, 27 Feb 2003 20:01:56 -0500
Message-ID: <3E5EB9A8.3010807@kegel.com>
Date: Thu, 27 Feb 2003 17:21:44 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Protecting processes from the OOM killer
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For a while now, I've been trying to figure out how
to make the oom killer not kill important processes.

How about rewarding processes that have an
RSS limit if they stay well below it?
The operator can then mark processes that are important
by using 'ulimit -m'.
(This is orthogonal to Rik's recent patch.)

--- oom_kill.c.orig	2002-09-26 17:31:12.000000000 -0700
+++ oom_kill.c	2003-02-27 16:59:46.000000000 -0800
@@ -86,6 +90,18 @@
  		points *= 2;

  	/*
+	 * Processes which *have* an RSS limit, but which are under half of it,
+	 * are behaving well, so halve their badness points.
+	 * Do it again if they're under a quarter of their RSS limit.
+	 */
+	if (p->rlim[RLIMIT_RSS].rlim_max != ULONG_MAX) {
+		if (p->mm->rss < (p->rlim[RLIMIT_RSS].rlim_max >> (PAGE_SHIFT+1)))
+			points /= 2;
+		if (p->mm->rss < (p->rlim[RLIMIT_RSS].rlim_max >> (PAGE_SHIFT+2)))
+			points /= 2;
+	}
+
+	/*
  	 * Superuser processes are usually more important, so we make it
  	 * less likely that we kill those.
  	 */

-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045

