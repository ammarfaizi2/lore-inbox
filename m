Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTIAN76 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 09:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbTIAN75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 09:59:57 -0400
Received: from [203.145.184.221] ([203.145.184.221]:41227 "EHLO naturesoft.net")
	by vger.kernel.org with ESMTP id S262906AbTIAN7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 09:59:52 -0400
Subject: Re: [PATCH 2.4.22-pre1][NET] timer cleanups
From: Vinay K Nallamothu <vinay-rc@naturesoft.net>
To: "David S. Miller" <davem@redhat.com>
Cc: netdev@oss.sgi.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030830203311.0b8c0807.davem@redhat.com>
References: <1062258097.8532.26.camel@lima.royalchallenge.com>
	 <20030830203311.0b8c0807.davem@redhat.com>
Content-Type: text/plain
Organization: NatureSoft Private Limited
Message-Id: <1062424850.4414.40.camel@lima.royalchallenge.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 01 Sep 2003 19:30:51 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Sun, 2003-08-31 at 09:03, David S. Miller wrote:
> On Sat, 30 Aug 2003 21:11:37 +0530
> Vinay K Nallamothu <vinay-rc@naturesoft.net> wrote:
> 
> > This patch does the following timer code cleanup:
> > 
> > 1. Change del_timer/add_timer to mod_timer
> > 2. Use static timer initialisation wherever applicable
> 
> I'm not accepting this.  In particular, the ip6_flowlabel.c
> change is a bad idea because the code remains racey.


>   Someone
> submitted a similar move to mod_timer() for ip6_flowlabel
That too was submitted by me. Unfortunately I never got to see your
mail. No excuses though.


> 
> Just blindly doing these kinds of conversions to mod_timer()
> is foolhardy.  You need to apply some brains to it to make
> sure you really are getting rid of whatever potential races
> exist in the code. 
You are correct. While I tried to make sure that new bugs are not
introduced, I haven't paid attention to the existing ones.

>  And in the ip6_flowlabel.c case things are
> as buggy as they were before.

Please find the updated patch below and let me know if it's ok.

Thanks
Vinay

ip6_flowlabel.c: 
1. Use static timer initializer
2. Use timer macros to handle jiffie wrap in comparisions
3. Convert del_timer/add_timer to mod_timer

ip6_flowlabel.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff -urN linux-2.4.22/net/ipv6/ip6_flowlabel.c	linux-2.4.22-nvk/net/ipv6/ip6_flowlabel.c
--- linux-2.4.22/net/ipv6/ip6_flowlabel.c	2003-06-14 10:03:12.000000000 +0530
+++ linux-2.4.22-nvk/net/ipv6/ip6_flowlabel.c	2003-09-01 16:47:03.000000000 +0530
@@ -48,7 +48,8 @@
 static atomic_t fl_size = ATOMIC_INIT(0);
 static struct ip6_flowlabel *fl_ht[FL_HASH_MASK+1];
 
-static struct timer_list ip6_fl_gc_timer;
+static void ip6_fl_gc(unsigned long dummy);
+static struct timer_list ip6_fl_gc_timer = TIMER_INITIALIZER(ip6_fl_gc, 0, 0);
 
 /* FL hash table lock: it protects only of GC */
 
@@ -92,10 +93,12 @@
 
 static void fl_release(struct ip6_flowlabel *fl)
 {
+	write_lock_bh(&ip6_fl_lock);
+
 	fl->lastuse = jiffies;
 	if (atomic_dec_and_test(&fl->users)) {
 		unsigned long ttd = fl->lastuse + fl->linger;
-		if ((long)(ttd - fl->expires) > 0)
+		if (time_after(ttd, fl->expires))
 			fl->expires = ttd;
 		ttd = fl->expires;
 		if (fl->opt && fl->share == IPV6_FL_S_EXCL) {
@@ -103,11 +106,12 @@
 			fl->opt = NULL;
 			kfree(opt);
 		}
-		if (!del_timer(&ip6_fl_gc_timer) ||
-		    (long)(ip6_fl_gc_timer.expires - ttd) > 0)
-			ip6_fl_gc_timer.expires = ttd;
-		add_timer(&ip6_fl_gc_timer);
+		if (!timer_pending(&ip6_fl_gc_timer) ||
+		    time_after(ip6_fl_gc_timer.expires, ttd))
+			mod_timer(&ip6_fl_gc_timer, ttd);
 	}
+
+	write_unlock_bh(&ip6_fl_lock);
 }
 
 static void ip6_fl_gc(unsigned long dummy)
@@ -124,16 +128,16 @@
 		while ((fl=*flp) != NULL) {
 			if (atomic_read(&fl->users) == 0) {
 				unsigned long ttd = fl->lastuse + fl->linger;
-				if ((long)(ttd - fl->expires) > 0)
+				if (time_after(ttd, fl->expires))
 					fl->expires = ttd;
 				ttd = fl->expires;
-				if ((long)(now - ttd) >= 0) {
+				if (time_after_eq(now, ttd)) {
 					*flp = fl->next;
 					fl_free(fl);
 					atomic_dec(&fl_size);
 					continue;
 				}
-				if (!sched || (long)(ttd - sched) < 0)
+				if (!sched || time_before(ttd, sched))
 					sched = ttd;
 			}
 			flp = &fl->next;
@@ -262,11 +266,11 @@
 	if (!expires)
 		return -EPERM;
 	fl->lastuse = jiffies;
-	if (fl->linger < linger)
+	if (time_before(fl->linger, linger))
 		fl->linger = linger;
-	if (expires < fl->linger)
+	if (time_before(expires, fl->linger))
 		expires = fl->linger;
-	if ((long)(fl->expires - (fl->lastuse+expires)) < 0)
+	if (time_before(fl->expires, fl->lastuse + expires))
 		fl->expires = fl->lastuse + expires;
 	return 0;
 }
@@ -609,8 +613,6 @@
 
 void ip6_flowlabel_init()
 {
-	init_timer(&ip6_fl_gc_timer);
-	ip6_fl_gc_timer.function = ip6_fl_gc;
 #ifdef CONFIG_PROC_FS
 	create_proc_read_entry("net/ip6_flowlabel", 0, 0, ip6_fl_read_proc, NULL);
 #endif


