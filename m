Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUI0PWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUI0PWy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUI0PWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:22:54 -0400
Received: from smtp.jaluna.com ([212.11.48.245]:20751 "EHLO smtp.Jaluna.COM")
	by vger.kernel.org with ESMTP id S266459AbUI0PVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:21:40 -0400
Message-ID: <41583036.9010907@jaluna.com>
Date: Mon, 27 Sep 2004 17:22:30 +0200
From: Vladimir Grouzdev <vladimir.grouzdev@Jaluna.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: johnstul@us.ibm.com
Subject: 2.6.8.1: xtime value may become incorrect
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    The xtime value may become incorrect when the
    update_wall_time(ticks) function is called with "ticks" > 1.
    In such a case, the xtime variable is updated multiple times
    inside the loop but it is normalized only once outside of
    the loop.

    This bug was reported at:

    http://bugme.osdl.org/show_bug.cgi?id=3403

    Patch to fix the problem:

diff -Nrca linux-2.6.8.1/kernel/timer.c linux-2.6.8.1-patched/kernel/timer.c
*** linux-2.6.8.1/kernel/timer.c    2004-08-14 12:56:00.000000000 +0200
--- linux-2.6.8.1-patched/kernel/timer.c    2004-09-27 
16:24:48.000000000 +0200
***************
*** 776,788 ****
      do {
          ticks--;
          update_wall_time_one_tick();
      } while (ticks);
-
-     if (xtime.tv_nsec >= 1000000000) {
-         xtime.tv_nsec -= 1000000000;
-         xtime.tv_sec++;
-         second_overflow();
-     }
  }
 
  static inline void do_process_times(struct task_struct *p,
--- 776,787 ----
      do {
          ticks--;
          update_wall_time_one_tick();
+         if (xtime.tv_nsec >= 1000000000) {
+             xtime.tv_nsec -= 1000000000;
+             xtime.tv_sec++;
+             second_overflow();
+         }
      } while (ticks);
  }
 
  static inline void do_process_times(struct task_struct *p,


