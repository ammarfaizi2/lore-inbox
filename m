Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267917AbRHASeY>; Wed, 1 Aug 2001 14:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267916AbRHASeO>; Wed, 1 Aug 2001 14:34:14 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:12811 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267915AbRHASeF>; Wed, 1 Aug 2001 14:34:05 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Mike Black" <mblack@csihq.com>, <tridge@valinux.com>,
        <marcelo@conectiva.com.br>
Subject: Re: 2.4.8preX VM problems
Date: Wed, 1 Aug 2001 20:39:22 +0200
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>, <riel@conectiva.com.br>,
        "Andrew Morton" <andrewm@uow.edu.au>
In-Reply-To: <Pine.LNX.4.21.0108010504160.9379-100000@freak.distro.conectiva> <20010801105419.8F078424A@lists.samba.org> <020001c11a80$43297110$e1de11cc@csihq.com>
In-Reply-To: <020001c11a80$43297110$e1de11cc@csihq.com>
MIME-Version: 1.0
Message-Id: <01080120392200.00933@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 August 2001 13:51, Mike Black wrote:
> I have come to the opinion that kswapd needs to be a little smarter
> -- if it doesn't find anything to swap shouldn't it go to sleep a
> little longer before trying again?  That way it could gracefully
> degrade itself when it's not making any progress.
>
> In my testing (on a dual 1Ghz/2G machine) the machine "locks up" for
> long periods of time while kswapd runs around trying to do it's
> thing. If I could disable kswapd I would just to test this.

Your wish is my command.  This patch provides a crude-but-effective 
method of disabling kswapd, using:

  echo 1 >/proc/sys/kernel/disable_kswapd

I tested this with dbench and found it runs about half as fast, but 
runs.  This is reassuring because kswapd is supposed to be doing 
something useful.

To apply:

  cd /usr/src/your.2.4.7.tree
  patch -p0 <this.patch

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
 	KERN_IEEE_EMULATION_WARNINGS=50, /* int: unimplemented ieee 
instructions */
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


