Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264065AbUDNMM0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 08:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264071AbUDNMM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 08:12:26 -0400
Received: from [139.30.44.16] ([139.30.44.16]:63664 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S264065AbUDNMMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 08:12:14 -0400
Date: Wed, 14 Apr 2004 14:10:01 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: john stultz <johnstul@us.ibm.com>
cc: george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       David Ford <david+powerix@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
In-Reply-To: <1081895880.4705.57.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.53.0404141353450.21779@gockel.physik3.uni-rostock.de>
References: <403C014F.2040504@blue-labs.org>  <1077674048.10393.369.camel@cube>
  <403C2E56.2060503@blue-labs.org>  <1077679677.10393.431.camel@cube> 
 <403CCD3A.7080200@mvista.com>  <1077725042.8084.482.camel@cube> 
 <403D0F63.3050101@mvista.com>  <1077760348.2857.129.camel@cog.beaverton.ibm.com>
  <403E7BEE.9040203@mvista.com>  <1077837016.2857.171.camel@cog.beaverton.ibm.com>
  <403E8D5B.9040707@mvista.com> <1081895880.4705.57.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> diff -Nru a/include/linux/times.h b/include/linux/times.h
> --- a/include/linux/times.h	Tue Apr 13 15:00:25 2004
> +++ b/include/linux/times.h	Tue Apr 13 15:00:25 2004
> @@ -7,7 +7,12 @@
>  #include <asm/param.h>
>  
>  #if (HZ % USER_HZ)==0
> -# define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
> +static inline long jiffies_to_clock_t(long x)
> +{
> +	u64 tmp = (u64)x * TICK_NSEC;
> +	x = do_div(tmp, (NSEC_PER_SEC / USER_HZ));
> +	return (long)tmp;
> +}
>  #else
>  # define jiffies_to_clock_t(x) ((clock_t) jiffies_64_to_clock_t((u64) x))
>  #endif

Excuse me for barging in lately and innocently, but I find this patch
hard to comprehend:
 - shouldn't a foo_to_clock_t() function return a clock?
 - the x = seems superfluous
 - the #if is not a shortcut anymore, so why keep it?
Shouldn't this patch be more like the following
(completely untested)?

Tim


diff -urp --exclude-from dontdiff linux-2.6.5/include/linux/times.h linux-2.6.5-jfix1/include/linux/times.h
--- linux-2.6.5/include/linux/times.h	2004-02-04 04:43:09.000000000 +0100
+++ linux-2.6.5-jfix1/include/linux/times.h	2004-04-14 13:48:57.000000000 +0200
@@ -6,11 +6,16 @@
 #include <asm/types.h>
 #include <asm/param.h>
 
-#if (HZ % USER_HZ)==0
-# define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
-#else
-# define jiffies_to_clock_t(x) ((clock_t) jiffies_64_to_clock_t((u64) x))
-#endif
+static inline clock_t jiffies_to_clock_t(long x)
+{
+#if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
+	return x / (HZ / USER_HZ);
+#else
+	u64 tmp = (u64)x * TICK_NSEC;
+	do_div(tmp, (NSEC_PER_SEC / USER_HZ));
+	return (long)tmp;
+#endif
+}
 
 static inline unsigned long clock_t_to_jiffies(unsigned long x)
 {
