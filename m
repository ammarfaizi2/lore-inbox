Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbUKVCsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUKVCsY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 21:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbUKVCsY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 21:48:24 -0500
Received: from koto.vergenet.net ([210.128.90.7]:31421 "HELO koto.vergenet.net")
	by vger.kernel.org with SMTP id S261846AbUKVCsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 21:48:19 -0500
Date: Mon, 22 Nov 2004 11:48:05 +0900
From: Horms <horms@verge.net.au>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: janitor@sternwelten.at, netdev@oss.sgi.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
Subject: Re: [PATCH] Add ssleep_interruptible()
Message-ID: <20041122024804.GD4146@verge.net.au>
Mail-Followup-To: Nishanth Aravamudan <nacc@us.ibm.com>,
	janitor@sternwelten.at, netdev@oss.sgi.com, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
References: <E1CO1vc-00022t-N2@sputnik> <20041101200749.GF1730@us.ibm.com> <20041117013059.GA4218@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117013059.GA4218@us.ibm.com>
X-Cluestick: seven
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 05:30:59PM -0800, Nishanth Aravamudan wrote:
> On Mon, Nov 01, 2004 at 12:07:49PM -0800, Nishanth Aravamudan wrote:
> > Description: Adds ssleep_interruptible() to allow longer delays to occur
> > in TASK_INTERRUPTIBLE, similarly to ssleep(). To be consistent with
> > msleep_interruptible(), ssleep_interruptible() returns the remaining time
> > left in the delay in terms of seconds. This required dividing the return
> > value of msleep_interruptible() by 1000, thus a cast to (unsigned long)
> > to prevent any floating point issues.
> > 
> > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > 
> > --- 2.6.10-rc1-vanilla/include/linux/delay.h	2004-10-30 
> > 15:34:03.000000000 -0700
> > +++ 2.6.10-rc1/include/linux/delay.h	2004-11-01 12:06:11.000000000 -0800
> > @@ -46,4 +46,9 @@ static inline void ssleep(unsigned int s
> > 	msleep(seconds * 1000);
> > }
> > 
> > +static inline unsigned long ssleep_interruptible(unsigned int seconds)
> > +{
> > +	return (unsigned long)(msleep_interruptible(seconds * 1000) / 1000);
> > +}
> > +
> > #endif /* defined(_LINUX_DELAY_H) */
> 
> After a discussion on IRC, I believe it is pretty clear that this
> function has serious issues. Mainly, that if I request a delay of 1
> second, but msleep_interruptible() returns after 1 millisecond, then
> ssleep_interruptible() will return 0, claiming the entire delay was
> used (due to rounding).
> 
> Perhaps we should just be satisfied with milliseconds being the grossest
> (in contrast to fine) measure of time, at least in terms of
> interruptible delays. ssleep() is unaffected by this problem, of course.
> 
> Please revert this patch, if applied, as well as any of the other
> patches I sent using ssleep_interruptible() [only a handful].

Would making sure that the time slept was always rounded up to
the nearest second resolve this problem. I believe that rounding
up is a common approach to resolving this type of problem when
changing clock resolution.

I am thinking of something like this.

===== include/linux/delay.h 1.6 vs edited =====
--- 1.6/include/linux/delay.h	2004-09-03 18:08:32 +09:00
+++ edited/include/linux/delay.h	2004-11-22 11:47:03 +09:00
@@ -46,4 +46,10 @@ static inline void ssleep(unsigned int s
 	msleep(seconds * 1000);
 }
 
+static inline unsigned long ssleep_interruptible(unsigned int seconds)
+{
+	return (unsigned long)((msleep_interruptible(seconds * 1000) + 999) / 
+			1000);
+}
+
 #endif /* defined(_LINUX_DELAY_H) */

-- 
Horms
