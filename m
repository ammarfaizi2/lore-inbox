Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964892AbWEJKUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964892AbWEJKUO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWEJKUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:20:14 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:20197 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S964892AbWEJKUM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:20:12 -0400
Date: Wed, 10 May 2006 15:46:22 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH][delayacct] Fix the timespec_sub() interface (was Re: [Patch 1/8] Setup)
Message-ID: <20060510101622.GB29432@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061255.GL13962@in.ibm.com> <20060508141713.60c9d33e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508141713.60c9d33e.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 02:17:13PM -0700, Andrew Morton wrote:
> Balbir Singh <balbir@in.ibm.com> wrote:
> >
> >  /*
> > + * sub = end - start, in normalized form
> > + */
> > +static inline void timespec_sub(struct timespec *start, struct timespec *end,
> > +				struct timespec *sub)
> > +{
> > +	set_normalized_timespec(sub, end->tv_sec - start->tv_sec,
> > +				end->tv_nsec - start->tv_nsec);
> > +}
> 
> The interface might not be right here.
> 
> - I think "lhs" and "rhs" would be better names than "start" and "end". 
>   After all, we don't _know_ that the caller is using the two times as a
>   start and an end.  The caller might be taking the difference between two
>   differences, for example.
> 
> - The existing timespec and timeval funtions tend to do return-by-value. 
>   So this would become
> 
> 	static inline struct timespec timespec_sub(struct timespec lhs,
> 							struct timespec rhs)
> 
>   (and given that it's inlined, the added overhead of passing the
>   arguments by value will be zero)
> 
> - If we don't want to do that then at least let's get the arguments in a
>   sane order:
> 
> 	static inline void timespec_sub(struct timespec *result,
> 				struct timespec lhs, struct timespec rhs)
> 

Hi, Andrew,

Please find the updated patch, which changes the interface of timespec_sub()
as suggested in the review comments

Changelog

1. Change the interface of timespec_sub() to return by value and rename
   the arguments. Use lhs,rhs instead of end,start

Changes under consideration

1. Migrate to the ktime interface (Thomas Gleixner)

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs


Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/linux/time.h |   12 +++++++-----
 kernel/delayacct.c   |    2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff -puN include/linux/time.h~timespec-sub-return-by-value include/linux/time.h
--- linux-2.6.17-rc3/include/linux/time.h~timespec-sub-return-by-value	2006-05-10 12:03:11.000000000 +0530
+++ linux-2.6.17-rc3-balbir/include/linux/time.h	2006-05-10 12:26:44.000000000 +0530
@@ -68,13 +68,15 @@ extern unsigned long mktime(const unsign
 extern void set_normalized_timespec(struct timespec *ts, time_t sec, long nsec);
 
 /*
- * sub = end - start, in normalized form
+ * sub = lhs - rhs, in normalized form
  */
-static inline void timespec_sub(struct timespec *start, struct timespec *end,
-				struct timespec *sub)
+static inline struct timespec timespec_sub(struct timespec *lhs,
+						struct timespec *rhs)
 {
-	set_normalized_timespec(sub, end->tv_sec - start->tv_sec,
-				end->tv_nsec - start->tv_nsec);
+	struct timespec ts_delta;
+	set_normalized_timespec(&ts_delta, lhs->tv_sec - rhs->tv_sec,
+				lhs->tv_nsec - rhs->tv_nsec);
+	return ts_delta;
 }
 
 /*
diff -puN kernel/delayacct.c~timespec-sub-return-by-value kernel/delayacct.c
--- linux-2.6.17-rc3/kernel/delayacct.c~timespec-sub-return-by-value	2006-05-10 12:03:38.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/delayacct.c	2006-05-10 14:29:28.000000000 +0530
@@ -74,7 +74,7 @@ static inline void delayacct_end(struct 
 	s64 ns;
 
 	do_posix_clock_monotonic_gettime(end);
-	timespec_sub(&ts, start, end);
+	ts = timespec_sub(end, start);
 	ns = timespec_to_ns(&ts);
 	if (ns < 0)
 		return;
_
