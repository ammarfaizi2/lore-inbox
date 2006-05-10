Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750910AbWEJLCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbWEJLCm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 07:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWEJLCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 07:02:42 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:61421 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750910AbWEJLCl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 07:02:41 -0400
Date: Wed, 10 May 2006 16:28:56 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com, tglx@linutronix.de
Subject: Re: [PATCH][delayacct] Fix the timespec_sub() interface (was Re: [Patch 1/8] Setup)
Message-ID: <20060510105856.GH29432@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061255.GL13962@in.ibm.com> <20060508141713.60c9d33e.akpm@osdl.org> <20060510101622.GB29432@in.ibm.com> <20060510032449.2872a8ba.akpm@osdl.org> <20060510102716.GG29432@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510102716.GG29432@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2006 at 03:57:16PM +0530, Balbir Singh wrote:
> On Wed, May 10, 2006 at 03:24:49AM -0700, Andrew Morton wrote:
> > Balbir Singh <balbir@in.ibm.com> wrote:
> > >
> > > Please find the updated patch, which changes the interface of timespec_sub()
> > > as suggested in the review comments
> > > 
> > > ...
> > >
> > >  /*
> > > - * sub = end - start, in normalized form
> > > + * sub = lhs - rhs, in normalized form
> > >   */
> > > -static inline void timespec_sub(struct timespec *start, struct timespec *end,
> > > -				struct timespec *sub)
> > > +static inline struct timespec timespec_sub(struct timespec *lhs,
> > > +						struct timespec *rhs)
> > >  {
> > 
> > I'd have thought that it would be more consistent and a saner interface to
> > use pass-by-value:
> > 
> > static inline struct timespec timespec_sub(struct timespec lhs,
> > 						struct timespec rhs)
> > 
> > It should generate the same code.
> > 
> > I mentioned this last time - did you choose to not do this for some reason,
> > or did it just slip past?
> 
> Sorry, that definitely slip past.
> 
> I'll send another update
>
Hi, Andrew,

Here is another attempt to do fix the interface.

	Thanks for the review,
	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs



Changelog

1. Change the interface of timespec_sub() to return by value and rename
   the arguments. Use lhs,rhs instead of end,start.
2. Pass the arguments by value

Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 include/linux/time.h |   12 +++++++-----
 kernel/delayacct.c   |    2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff -puN include/linux/time.h~timespec-sub-return-by-value include/linux/time.h
--- linux-2.6.17-rc3/include/linux/time.h~timespec-sub-return-by-value	2006-05-10 15:58:19.000000000 +0530
+++ linux-2.6.17-rc3-balbir/include/linux/time.h	2006-05-10 15:59:48.000000000 +0530
@@ -68,13 +68,15 @@ extern unsigned long mktime(const unsign
 extern void set_normalized_timespec(struct timespec *ts, time_t sec, long nsec);
 
 /*
- * sub = end - start, in normalized form
+ * sub = lhs - rhs, in normalized form
  */
-static inline void timespec_sub(struct timespec *start, struct timespec *end,
-				struct timespec *sub)
+static inline struct timespec timespec_sub(struct timespec lhs,
+						struct timespec rhs)
 {
-	set_normalized_timespec(sub, end->tv_sec - start->tv_sec,
-				end->tv_nsec - start->tv_nsec);
+	struct timespec ts_delta;
+	set_normalized_timespec(&ts_delta, lhs.tv_sec - rhs.tv_sec,
+				lhs.tv_nsec - rhs.tv_nsec);
+	return ts_delta;
 }
 
 /*
diff -puN kernel/delayacct.c~timespec-sub-return-by-value kernel/delayacct.c
--- linux-2.6.17-rc3/kernel/delayacct.c~timespec-sub-return-by-value	2006-05-10 15:58:19.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/delayacct.c	2006-05-10 16:00:30.000000000 +0530
@@ -74,7 +74,7 @@ static inline void delayacct_end(struct 
 	s64 ns;
 
 	do_posix_clock_monotonic_gettime(end);
-	timespec_sub(&ts, start, end);
+	ts = timespec_sub(*end, *start);
 	ns = timespec_to_ns(&ts);
 	if (ns < 0)
 		return;
_
