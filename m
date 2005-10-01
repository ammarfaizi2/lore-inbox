Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVJARqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVJARqP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 13:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVJARqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 13:46:15 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:51462 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750705AbVJARqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 13:46:14 -0400
Date: Sat, 1 Oct 2005 19:39:47 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Andrew Morton <akpm@osdl.org>
Cc: davidel@xmailserver.org, nacc@us.ibm.com, nish.aravamudan@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.14-rc2-mm1: fixes for overflow msec_to_jiffies()
Message-ID: <20051001173946.GA26174@alpha.home.local>
References: <20050924040534.GB18716@alpha.home.local> <29495f1d05092321447417503@mail.gmail.com> <20050924061500.GA24628@alpha.home.local> <20050924171928.GF3950@us.ibm.com> <Pine.LNX.4.63.0509241120380.31327@localhost.localdomain> <20050924193839.GB26197@alpha.home.local> <20050924194418.GC26197@alpha.home.local> <20050929024312.2f3a9e80.akpm@osdl.org> <20050929194155.GB16171@alpha.home.local> <20050929125207.52c6a1b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050929125207.52c6a1b8.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Thu, Sep 29, 2005 at 12:52:07PM -0700, Andrew Morton wrote:
> > On Thu, Sep 29, 2005 at 02:43:12AM -0700, Andrew Morton wrote:
> > > Willy Tarreau <willy@w.ods.org> wrote:
> > > >
> > > > +#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
> > > >  +#  define MAX_MSEC_OFFSET \
> > > >  +	(ULONG_MAX - (MSEC_PER_SEC / HZ) + 1)
> > > 
> > > That generates numbers which don't fit into unsigned ints, yielding vast
> > > numbers of
> > > 
> > > include/linux/jiffies.h: In function `msecs_to_jiffies':
> > > include/linux/jiffies.h:310: warning: comparison is always false due to limited range of data type
> > > include/linux/jiffies.h: In function `usecs_to_jiffies':
> > > include/linux/jiffies.h:323: warning: comparison is always false due to limited range of data type
> > > 
> 
> This was a ppc64 build, gcc-3.3.3, CONFIG_HZ=250
> 
> Look a the value which MAX_MSEC_OFFSET will take (it's 2^63 minus a bit). 
> Comparing that to an unsigned int will generate the always-true or
> always-false warning.

OK, this was not trivial because gcc is smart enough to detect that even
after a cast, the comparison is still always false. So I had to cut the
comparison in two parts : one which tests whether we need to compare, and
one which does the test on the unsigned int part if necessary. It has shut
the warnings on my alpha (HZ=1024) and on my ultrasparc (HZ=250). I've
noticed that the code in previous patch could still overflow in the cases
where a multiply was used first, because the common type was still int. My
test case in user-space used MSEC_PER_SEC = 1000UL so it did not happen.
I've fixed this too.

I've also checked the code produced on x86 (because alpha code is unreadable
to me), and it resumes to this :

  - HZ=1000 : no code generated
  - HZ=250  : comparison, add, right shift
  - HZ=100  : comparison, add, divide
  - HZ=1024 : comparison, left shift, add, mul, right shift

I tried to compile on ppc64, but unfortunately, the kernel does not build
there because sizeof(long) == 4 ! I guess this is because gcc's target is
powerpc-linux-gnu. I'm trying to recompile it with powerpc64-linux-gnu.
Could you send me the output of gcc -v on your ppc64, please ?

I've also added missing parenthesis in the #defines which might have caused
trouble to external users of MAX_?SEC_OFFSET (none at the moment).

Here's the new patch, I've build everything on 2.6.14-rc2-mm1 but verified
that this code was not touched in -mm2 and the patch still applies.

Could you please retest it on your ppc64 and apply it if you're OK with it ?

Thanks,
Willy



Signed-off-by: Willy Tarreau <willy@w.ods.org>

--- linux-2.6.14-rc2-mm1/include/linux/jiffies.h	Thu Sep 29 23:04:49 2005
+++ linux-2.6.14-rc2-mm1-jiffies2/include/linux/jiffies.h	Sat Oct  1 19:12:13 2005
@@ -246,6 +246,37 @@
 
 #endif
 
+
+/*
+ * We define MAX_MSEC_OFFSET and MAX_USEC_OFFSET as maximal values that can be
+ * accepted by msecs_to_jiffies() and usec_to_jiffies() respectively, without
+ * risking a multiply overflow. Those functions return MAX_JIFFY_OFFSET for
+ * arguments above those values.
+ */
+
+#if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
+#  define MAX_MSEC_OFFSET \
+	(ULONG_MAX - (MSEC_PER_SEC / HZ) + 1)
+#elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
+#  define MAX_MSEC_OFFSET \
+	(ULONG_MAX / (HZ / MSEC_PER_SEC))
+#else
+#  define MAX_MSEC_OFFSET \
+	((ULONG_MAX - (MSEC_PER_SEC - 1)) / HZ)
+#endif
+
+#if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
+#  define MAX_USEC_OFFSET \
+	(ULONG_MAX - (USEC_PER_SEC / HZ) + 1)
+#elif HZ > USEC_PER_SEC && !(HZ % USEC_PER_SEC)
+#  define MAX_USEC_OFFSET \
+	(ULONG_MAX / (HZ / USEC_PER_SEC))
+#else
+#  define MAX_USEC_OFFSET \
+	((ULONG_MAX - (USEC_PER_SEC - 1)) / HZ)
+#endif
+
+
 /*
  * Convert jiffies to milliseconds and back.
  *
@@ -276,27 +307,29 @@
 
 static inline unsigned long msecs_to_jiffies(const unsigned int m)
 {
-	if (m > jiffies_to_msecs(MAX_JIFFY_OFFSET))
+	if (MAX_MSEC_OFFSET < UINT_MAX && m > (unsigned int)MAX_MSEC_OFFSET)
 		return MAX_JIFFY_OFFSET;
 #if HZ <= MSEC_PER_SEC && !(MSEC_PER_SEC % HZ)
-	return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
+	return ((unsigned long)m + (MSEC_PER_SEC / HZ) - 1) /
+		(MSEC_PER_SEC / HZ);
 #elif HZ > MSEC_PER_SEC && !(HZ % MSEC_PER_SEC)
-	return m * (HZ / MSEC_PER_SEC);
+	return (unsigned long)m * (HZ / MSEC_PER_SEC);
 #else
-	return (m * HZ + MSEC_PER_SEC - 1) / MSEC_PER_SEC;
+	return ((unsigned long)m * HZ + MSEC_PER_SEC - 1) / MSEC_PER_SEC;
 #endif
 }
 
 static inline unsigned long usecs_to_jiffies(const unsigned int u)
 {
-	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
+	if (MAX_USEC_OFFSET < UINT_MAX && u > (unsigned int)MAX_USEC_OFFSET)
 		return MAX_JIFFY_OFFSET;
 #if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
-	return (u + (USEC_PER_SEC / HZ) - 1) / (USEC_PER_SEC / HZ);
+	return ((unsigned long)u + (USEC_PER_SEC / HZ) - 1) /
+		(USEC_PER_SEC / HZ);
 #elif HZ > USEC_PER_SEC && !(HZ % USEC_PER_SEC)
-	return u * (HZ / USEC_PER_SEC);
+	return (unsigned long)u * (HZ / USEC_PER_SEC);
 #else
-	return (u * HZ + USEC_PER_SEC - 1) / USEC_PER_SEC;
+	return ((unsigned long)u * HZ + USEC_PER_SEC - 1) / USEC_PER_SEC;
 #endif
 }
 

