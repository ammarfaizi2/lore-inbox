Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWEJKW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWEJKW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWEJKW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:22:26 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:21711 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964873AbWEJKWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:22:25 -0400
Date: Wed, 10 May 2006 15:48:41 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       jlan@engr.sgi.com
Subject: [PATCH][delayacct] un-inline delayacct_end(), remove initialization of ts (was Re: [Patch 1/8] Setup)
Message-ID: <20060510101841.GC29432@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <20060502061255.GL13962@in.ibm.com> <20060508142322.71e88a54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508142322.71e88a54.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 02:23:22PM -0700, Andrew Morton wrote:
> Balbir Singh <balbir@in.ibm.com> wrote:
> >
> > +static inline void delayacct_end(struct timespec *start, struct timespec *end,
> > +				u64 *total, u32 *count)
> > +{
> > +	struct timespec ts = {0, 0};
> > +	s64 ns;
> > +
> > +	do_posix_clock_monotonic_gettime(end);
> > +	timespec_sub(&ts, start, end);
> > +	ns = timespec_to_ns(&ts);
> > +	if (ns < 0)
> > +		return;
> > +
> > +	spin_lock(&current->delays->lock);
> > +	*total += ns;
> > +	(*count)++;
> > +	spin_unlock(&current->delays->lock);
> > +}
> 
> - too large to be inlined
> 
> - The initialisation of `ts' is unneeded (maybe it generated a bogus
>   warning, but it won't do that if you switch timespec_sub to
>   return-by-value)

Hi, Andrew,

Here is an update to un-inline delayacct_end() and remove the initialization
of ts to 0.

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs


Changelog
1. Remove inlining of delayacct_end(), the function is too big to be inlined
2. Remove initialization of ts. 


Signed-off-by: Balbir Singh <balbir@in.ibm.com>
---

 kernel/delayacct.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -puN kernel/delayacct.c~remove-initialization-of-ts-and-inline kernel/delayacct.c
--- linux-2.6.17-rc3/kernel/delayacct.c~remove-initialization-of-ts-and-inline	2006-05-10 14:11:21.000000000 +0530
+++ linux-2.6.17-rc3-balbir/kernel/delayacct.c	2006-05-10 14:11:57.000000000 +0530
@@ -67,10 +67,10 @@ static inline void delayacct_start(struc
  * its timestamps (@start, @end), accumalator (@total) and @count
  */
 
-static inline void delayacct_end(struct timespec *start, struct timespec *end,
+static void delayacct_end(struct timespec *start, struct timespec *end,
 				u64 *total, u32 *count)
 {
-	struct timespec ts = {0, 0};
+	struct timespec ts;
 	s64 ns;
 
 	do_posix_clock_monotonic_gettime(end);
_
