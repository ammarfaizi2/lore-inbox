Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269735AbRHDBBw>; Fri, 3 Aug 2001 21:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269733AbRHDBBn>; Fri, 3 Aug 2001 21:01:43 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:50192 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269731AbRHDBB1>; Fri, 3 Aug 2001 21:01:27 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Mike Black" <mblack@csihq.com>, "Rik van Riel" <riel@conectiva.com.br>,
        "David Ford" <david@blue-labs.org>
Subject: [PATCH] Disable kswapd through proc (was Ongoing 2.4 VM suckage)
Date: Sat, 4 Aug 2001 01:58:57 +0200
X-Mailer: KMail [version 1.2]
Cc: "Jeffrey W. Baker" <jwbaker@acm.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108031751590.11893-100000@imladris.rielhome.conectiva> <007801c11c67$87d55980$b6562341@cfl.rr.com>
In-Reply-To: <007801c11c67$87d55980$b6562341@cfl.rr.com>
MIME-Version: 1.0
Message-Id: <0108040158570K.01827@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 03 August 2001 23:59, Mike Black wrote:
> I floated this idea a while ago but didn't receive any comments (or
> flames)...
> Couldn't kswapd just gracefully back-off when it doesn't make any progress?
>
> In my case (with ext3/raid5 and a tiobench test) kswapd NEVER actually
> swaps anything out.
> It just chews CPU time.
> So...if kswapd just said "didn't make any progress...*2 last sleep" so it
> would degrade itself.
> Doesn't sound like a major rewrite to me.

See attached patch, it lets you disable kswapd yourself through proc:

  echo 1 >/proc/sys/kernel/disable_kswapd

You can find out for yourself if it actually helps.

--- ../2.4.7.clean/include/linux/swap.h	Fri Jul 20 21:52:18 2001
+++ ./include/linux/swap.h	Wed Aug  1 19:35:27 2001
@@ -78,6 +78,7 @@
 	int next;			/* next entry on swap list */
 };
 
+extern int disable_kswapd;
 extern int nr_swap_pages;
 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_inactive_clean_pages(void);
--- ../2.4.7.clean/include/linux/sysctl.h	Fri Jul 20 21:52:18 2001
+++ ./include/linux/sysctl.h	Wed Aug  1 19:35:28 2001
@@ -118,7 +118,8 @@
 	KERN_SHMPATH=48,	/* string: path to shm fs */
 	KERN_HOTPLUG=49,	/* string: path to hotplug policy agent */
 	KERN_IEEE_EMULATION_WARNINGS=50, /* int: unimplemented ieee instructions */
-	KERN_S390_USER_DEBUG_LOGGING=51  /* int: dumps of user faults */
+	KERN_S390_USER_DEBUG_LOGGING=51, /* int: dumps of user faults */
+	KERN_DISABLE_KSWAPD=52,	/* int: disable kswapd for testing */
 };
 
 
--- ../2.4.7.clean/kernel/sysctl.c	Thu Apr 12 21:20:31 2001
+++ ./kernel/sysctl.c	Wed Aug  1 19:35:28 2001
@@ -249,6 +249,8 @@
 	{KERN_S390_USER_DEBUG_LOGGING,"userprocess_debug",
 	 &sysctl_userprocess_debug,sizeof(int),0644,NULL,&proc_dointvec},
 #endif
+	{KERN_DISABLE_KSWAPD, "disable_kswapd", &disable_kswapd, sizeof (int),
+	 0644, NULL, &proc_dointvec},
 	{0}
 };
 
--- ../2.4.7.clean/mm/vmscan.c	Mon Jul  9 19:18:50 2001
+++ ./mm/vmscan.c	Wed Aug  1 19:35:28 2001
@@ -875,6 +875,8 @@
 DECLARE_WAIT_QUEUE_HEAD(kswapd_wait);
 DECLARE_WAIT_QUEUE_HEAD(kswapd_done);
 
+int disable_kswapd /* = 0 */;
+
 /*
  * The background pageout daemon, started as a kernel thread
  * from the init process. 
@@ -915,6 +917,9 @@
 	 */
 	for (;;) {
 		static long recalc = 0;
+
+		while (disable_kswapd)
+			interruptible_sleep_on_timeout(&kswapd_wait, HZ/10);
 
 		/* If needed, try to free some memory. */
 		if (inactive_shortage() || free_shortage()) 
