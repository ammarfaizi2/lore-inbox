Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262221AbSJFWG1>; Sun, 6 Oct 2002 18:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262222AbSJFWG1>; Sun, 6 Oct 2002 18:06:27 -0400
Received: from packet.digeo.com ([12.110.80.53]:33433 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262221AbSJFWGZ>;
	Sun, 6 Oct 2002 18:06:25 -0400
Message-ID: <3DA0B52C.6E1E53FD@digeo.com>
Date: Sun, 06 Oct 2002 15:11:56 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: 2.5.40-mm2
References: <3DA0854E.CF9080D7@digeo.com> <3DA0A144.8070301@us.ibm.com> <3DA0B151.6EF8C8D9@digeo.com> <3DA0B422.C23B23D4@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Oct 2002 22:11:57.0632 (UTC) FILETIME=[62D9E400:01C26D85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grr.  So that's what that "send" button does.

Updated patch:


--- 2.5.40/kernel/timer.c~timer-tricks	Sun Oct  6 15:08:02 2002
+++ 2.5.40-akpm/kernel/timer.c	Sun Oct  6 15:08:45 2002
@@ -265,23 +265,19 @@ repeat:
  */
 int del_timer_sync(timer_t *timer)
 {
-	tvec_base_t *base = tvec_bases;
 	int i, ret;
 
 	ret = del_timer(timer);
 
 	for (i = 0; i < NR_CPUS; i++) {
-		if (!cpu_online(i))
-			continue;
-		if (base->running_timer == timer) {
-			while (base->running_timer == timer) {
-				cpu_relax();
-				preempt_disable();
-				preempt_enable();
+		if (cpu_online(i)) {
+			tvec_base_t *base = tvec_bases + i;
+			if (base->running_timer == timer) {
+				while (base->running_timer == timer)
+					cpu_relax();
+				break;
 			}
-			break;
 		}
-		base++;
 	}
 	return ret;
 }
@@ -359,9 +355,9 @@ repeat:
 #if CONFIG_SMP
 			base->running_timer = timer;
 #endif
-			spin_unlock_irq(&base->lock);
+			spin_unlock_irqrestore(&base->lock, flags);
 			fn(data);
-			spin_lock_irq(&base->lock);
+			spin_lock_irqsave(&base->lock, flags);
 			goto repeat;
 		}
 		++base->timer_jiffies; 

.
