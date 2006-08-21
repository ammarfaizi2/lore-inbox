Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWHUStC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWHUStC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWHUSsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:48:38 -0400
Received: from ns2.suse.de ([195.135.220.15]:39868 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750730AbWHUSr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:47:58 -0400
Date: Mon, 21 Aug 2006 11:46:11 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Dmitry Mishin <dim@openvz.org>,
       Kirill Korotaev <dev@openvz.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 04/20] Fix timer race in dst GC code
Message-ID: <20060821184611.GE21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-timer-race-in-dst-gc-code.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Dmitry Mishin <dim@openvz.org>

[NET]: add_timer -> mod_timer() in dst_run_gc()

Patch from Dmitry Mishin <dim@openvz.org>:

Replace add_timer() by mod_timer() in dst_run_gc
in order to avoid BUG message.

   CPU1                            CPU2
dst_run_gc()  entered           dst_run_gc() entered
spin_lock(&dst_lock)                   .....
del_timer(&dst_gc_timer)         fail to get lock
   ....                         mod_timer() <--- puts
					     timer back
					     to the list
add_timer(&dst_gc_timer) <--- BUG because timer is in list already.

Found during OpenVZ internal testing.

At first we thought that it is OpenVZ specific as we
added dst_run_gc(0) call in dst_dev_event(),
but as Alexey pointed to me it is possible to trigger
this condition in mainstream kernel.

F.e. timer has fired on CPU2, but the handler was preeempted
by an irq before dst_lock is tried.
Meanwhile, someone on CPU1 adds an entry to gc list and
starts the timer.
If CPU2 was preempted long enough, this timer can expire
simultaneously with resuming timer handler on CPU1, arriving
exactly to the situation described.

Signed-off-by: Dmitry Mishin <dim@openvz.org>
Signed-off-by: Kirill Korotaev <dev@openvz.org>
Signed-off-by: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/core/dst.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.17.8.orig/net/core/dst.c
+++ linux-2.6.17.8/net/core/dst.c
@@ -95,12 +95,11 @@ static void dst_run_gc(unsigned long dum
 		dst_gc_timer_inc = DST_GC_INC;
 		dst_gc_timer_expires = DST_GC_MIN;
 	}
-	dst_gc_timer.expires = jiffies + dst_gc_timer_expires;
 #if RT_CACHE_DEBUG >= 2
 	printk("dst_total: %d/%d %ld\n",
 	       atomic_read(&dst_total), delayed,  dst_gc_timer_expires);
 #endif
-	add_timer(&dst_gc_timer);
+	mod_timer(&dst_gc_timer, jiffies + dst_gc_timer_expires);
 
 out:
 	spin_unlock(&dst_lock);

--
