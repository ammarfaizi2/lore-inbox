Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293135AbSCRWZ6>; Mon, 18 Mar 2002 17:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293129AbSCRWZt>; Mon, 18 Mar 2002 17:25:49 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:36107 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S293133AbSCRWZe>;
	Mon, 18 Mar 2002 17:25:34 -0500
Date: Mon, 18 Mar 2002 19:25:19 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFT][PATCH] oom killer fix ???
Message-ID: <Pine.LNX.4.44L.0203181923490.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The -rmap VM has had some problems with the OOM killer
triggering before the machine actually ran out of freeable
memory. The patch below is an attempt at fixing the OOM killer,
it works by:

1) making sure userland allocations can always allocate
   right down to zone->pages_min, albeit slowly

2) not OOM killing if any zone has more than zone->pages_min
   in freeable pages

I'd appreciate it if the CONFIG_DISCONTIGMEM people could give
this patch a try.

thank you,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/


===== mm/vmscan.c 1.97 vs edited =====
--- 1.97/mm/vmscan.c	Thu Feb 28 20:38:19 2002
+++ edited/mm/vmscan.c	Mon Mar 18 16:57:41 2002
@@ -605,7 +605,7 @@
 	 * Hmm.. Cache shrink failed - time to kill something?
 	 * Mhwahahhaha! This is the part I really like. Giggle.
 	 */
-	if (!ret && free_low(ANY_ZONE) > 0)
+	if (!ret && free_min(ANY_ZONE) > 0)
 		out_of_memory();

 	return ret;
@@ -703,9 +703,11 @@
 	}
 }

+static int kswapd_overloaded;
 DECLARE_WAIT_QUEUE_HEAD(kswapd_wait);
 DECLARE_WAIT_QUEUE_HEAD(kswapd_done);
-#define VM_SHOULD_SLEEP (free_low(ALL_ZONES) > (freepages.min / 2))
+#define VM_SHOULD_SLEEP ((free_low(ALL_ZONES) > (freepages.min / 2)) && \
+				!kswapd_overloaded)

 /**
  * wakeup_kswapd - wake up the pageout daemon
@@ -751,27 +753,25 @@
 {
 	DECLARE_WAITQUEUE(wait, current);

-	/* Enough free RAM, we can easily keep up with memory demand. */
 	add_wait_queue(&kswapd_wait, &wait);
 	set_current_state(TASK_INTERRUPTIBLE);

+	/* Don't let the processes waiting on memory get stuck, ever. */
+	wake_up(&kswapd_done);
+
+	/* Enough free RAM, we can easily keep up with memory demand. */
 	if (free_high(ALL_ZONES) <= 0) {
-		wake_up(&kswapd_done);
 		schedule_timeout(HZ);
 		remove_wait_queue(&kswapd_wait, &wait);
 		return;
 	}
 	remove_wait_queue(&kswapd_wait, &wait);

-	/*
-	 * kswapd is going to sleep for a long time. Wake up the waiters to
-	 * prevent them to get stuck while waiting for us.
-	 */
-	wake_up(&kswapd_done);
-
 	/* OK, the VM is very loaded. Sleep instead of using all CPU. */
+	kswapd_overloaded = 1;
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule_timeout(HZ / 4);
+	kswapd_overloaded = 0;
 	return;
 }


