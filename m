Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281217AbRKEQfV>; Mon, 5 Nov 2001 11:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281223AbRKEQfL>; Mon, 5 Nov 2001 11:35:11 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:55286 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S281217AbRKEQfA>;
	Mon, 5 Nov 2001 11:35:00 -0500
Date: Sat, 3 Nov 2001 13:03:38 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] clarify timer macros for jiffies wrap
Message-ID: <20011103130338.A9732@lynx.no>
Mail-Followup-To: torvalds@transmeta.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, Alan,
I don't know if you were following the 64-bit jiffies thread, but it came
out that initializing jiffies to a pre-wrap state causes system instability,
partly caused by failure to handle jiffies wrap properly.

I started checking a bunch of code for improper timer wrap handling and
thought I would add this patch to clarify the usage of the time_defore()
and time_after() macros so that it is clearer how to use them.  I always
have to sit down and think about how to use these macros, so we may
as well make it clear in the comment.  I expanded the time_before{_eq}
definitions as it makes it easier to see which one to use when existing
code to use one of the macros.

I also put a pointer to these macros at the jiffies definition, so people
are more likely to use them.

I will be sending patches for fixing up jiffies comparisons separately.
As the comment at the time_{before,after} macros says, I'm changing all
comparisons of jiffies values to use these macros (even if they are
correctly done) so that (a) it insulates driver code if we change to a
64-bit jiffies value, and (b) makes people more aware that they should
always use these macros when dealing with jiffies.

Cheers, Andreas
=========================================================================
--- linux/include/linux/timer.h.orig	Thu Oct 25 10:02:34 2001
+++ linux/include/linux/timer.h	Sat Nov  3 12:38:01 2001
@@ -53,20 +53,23 @@
 }
 
 /*
- *	These inlines deal with timer wrapping correctly. You are 
- *	strongly encouraged to use them
+ * These inlines deal with timer wrapping correctly. You are
+ * strongly encouraged to use them:
  *	1. Because people otherwise forget
  *	2. Because if the timer wrap changes in future you wont have to
  *	   alter your driver code.
  *
+ * The macros are most commonly used in the form (unknown) after (known),
+ * or (unknown) before (known), where "unknown" is usually "jiffies".
+ *
  * Do this with "<0" and ">=0" to only test the sign of the result. A
  * good compiler would generate better code (and a really good compiler
  * wouldn't care). Gcc is currently neither.
  */
-#define time_after(a,b)		((long)(b) - (long)(a) < 0)
-#define time_before(a,b)	time_after(b,a)
+#define time_after(unknown,known)	((long)(known) - (long)(unknown) < 0)
+#define time_before(unknown,known)	((long)(unknown) - (long)(known) < 0)
 
-#define time_after_eq(a,b)	((long)(a) - (long)(b) >= 0)
-#define time_before_eq(a,b)	time_after_eq(b,a)
+#define time_after_eq(unknown,known)	((long)(unknown) - (long)(known) >= 0)
+#define time_before_eq(unknown,known)	((long)(known) - (long)(unknown) >= 0)
 
 #endif
--- linux/kernel/timer.c.orig	Thu Oct 25 02:09:35 2001
+++ linux/kernel/timer.c	Sat Nov  3 12:50:41 2001
@@ -65,6 +65,10 @@
 
 extern int do_setitimer(int, struct itimerval *, struct itimerval *);
 
+/*
+ * Use the time_before{_eq}() and time_after{_eq}() macros when comparing
+ * two jiffies values to correctly handle timer wrap.  See timer.h.
+ */
 unsigned long volatile jiffies;
 
 unsigned int * prof_buffer;
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

