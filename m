Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280714AbRKOEGE>; Wed, 14 Nov 2001 23:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280717AbRKOEFy>; Wed, 14 Nov 2001 23:05:54 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:34829 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S280714AbRKOEFp>;
	Wed, 14 Nov 2001 23:05:45 -0500
Date: Thu, 15 Nov 2001 15:03:03 +1100
From: Anton Blanchard <anton@samba.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix livelock in non atomic brlocks
Message-ID: <20011115150303.D22552@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

One characteristic of brlocks is that you must be able to take recursive
read locks (sparc64, ppc64 interrupt handling and netfilter make use of
this property). On a 16 cpu ppc64 machine I have seen the following
scenario:

cpu 1 (in br_write_lock)
again:
	spin_lock(&__br_write_locks[idx].lock);
		/* discover reader is present so backoff */
	spin_unlock(&__br_write_locks[idx].lock);
	goto again;

cpu 2 (in br_read_lock)
again:
	read_count++;
	mb();
	/* discover __br_write_locks[idx].lock is locked */
	read_count--;
	wmb();
	goto again;

If the read retry path is much slower than the write retry path (in this
case mb(); read_count--; wmb(); is quite slow), then both cpus will spin
forever and get nowhere.

We need to make sure the write retry path backs off long enough to
ensure forward progress. A udelay(1) is a rather large hammer but a
br_write_lock is known to be very slow and should not be called much.

Anton

--- 2.4.15-pre4/lib/brlock.c	Thu Nov 15 13:38:04 2001
+++ linuxppc64_2_4_rochester/lib/brlock.c	Thu Nov 15 13:33:35 2001
@@ -14,6 +14,7 @@
 
 #include <linux/sched.h>
 #include <linux/brlock.h>
+#include <linux/delay.h>
 
 #ifdef __BRLOCK_USE_ATOMICS
 
@@ -54,7 +55,8 @@
 		if (__brlock_array[cpu_logical_map(i)][idx] != 0) {
 			spin_unlock(&__br_write_locks[idx].lock);
 			barrier();
-			cpu_relax();
+			/* We must allow recursive readers to make progress */
+			udelay(1);
 			goto again;
 		}
 }
