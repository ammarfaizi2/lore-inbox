Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264426AbUEMTMV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbUEMTMV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 15:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbUEMTMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 15:12:21 -0400
Received: from fw.osdl.org ([65.172.181.6]:6844 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264426AbUEMTMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 15:12:18 -0400
Date: Thu, 13 May 2004 12:11:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Wagland <paul@wagland.net>
Cc: wli@holomorphy.com, greg@kroah.com, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com, mingo@elte.hu, netdev@oss.sgi.com,
       davidel@xmailserver.org, Valdis.Kletnieks@vt.edu
Subject: Re: MSEC_TO_JIFFIES is messed up...
Message-Id: <20040513121141.37f32035.akpm@osdl.org>
In-Reply-To: <61D92BA6-A504-11D8-BD91-000A95CD704C@wagland.net>
References: <40A26FFA.4030701@pobox.com>
	<20040512193349.GA14936@elte.hu>
	<200405121947.i4CJlJm5029666@turing-police.cc.vt.edu>
	<Pine.LNX.4.58.0405121255170.11950@bigblue.dev.mdolabs.com>
	<200405122007.i4CK7GPQ020444@turing-police.cc.vt.edu>
	<20040512202807.GA16849@elte.hu>
	<20040512203500.GA17999@elte.hu>
	<20040512205028.GA18806@elte.hu>
	<20040512140729.476ace9e.akpm@osdl.org>
	<20040512211748.GB20800@elte.hu>
	<20040512221823.GK1397@holomorphy.com>
	<61D92BA6-A504-11D8-BD91-000A95CD704C@wagland.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Wagland <paul@wagland.net> wrote:
>
> > -#if HZ == 1000
>  > -# define JIFFIES_TO_MSECS(x)	(x)
>  > -# define MSECS_TO_JIFFIES(x)	(x)
>  > -#elif HZ == 100
>  > -# define JIFFIES_TO_MSECS(x)	((x) * 10)
>  > -# define MSECS_TO_JIFFIES(x)	(((x) + 9) / 10)
>  > +#if HZ <= 1000 && !(1000 % HZ)
>  > +# define JIFFIES_TO_MSECS(j)	((1000/HZ)*(j))
>  > +# define MSECS_TO_JIFFIES(m)	(((m) + (1000/HZ) - 1)/(1000/HZ))
>  > +#elif HZ > 1000 && !(HZ % 1000)
>  > +# define JIFFIES_TO_MSECS(j)	(((j) + (HZ/1000) - 1)/(HZ/1000))
>  > +# define MSECS_TO_JIFFIES(m)	((m)*(HZ/1000))
>  >  #else
>  >  # define JIFFIES_TO_MSECS(x)	(((x) * 1000) / HZ)
>  >  # define MSECS_TO_JIFFIES(x)	(((x) * HZ + 999) / 1000)
> 
>  Also, can we keep the same parameter name across all of the macros?

Fair enough.

--- 25/include/linux/time.h~MSEC_TO_JIFFIES-fixups-tidy	2004-05-13 12:09:27.463273344 -0700
+++ 25-akpm/include/linux/time.h	2004-05-13 12:09:41.300169816 -0700
@@ -191,8 +191,8 @@ struct timezone {
 # define JIFFIES_TO_MSECS(j)	(((j) + (HZ/1000) - 1)/(HZ/1000))
 # define MSECS_TO_JIFFIES(m)	((m)*(HZ/1000))
 #else
-# define JIFFIES_TO_MSECS(x)	(((x) * 1000) / HZ)
-# define MSECS_TO_JIFFIES(x)	(((x) * HZ + 999) / 1000)
+# define JIFFIES_TO_MSECS(j)	(((j) * 1000) / HZ)
+# define MSECS_TO_JIFFIES(m)	(((m) * HZ + 999) / 1000)
 #endif
 
 /*

>  This changes behaviour when HZ==(z)000
> 
>  JIFFIES_TO_MSECS  goes from
>  ((x) * 1000) / (z)000  to (((x) + (z) - 1)/(z))
> 
>  i.e. for x=1, z=2 this goes from ((1)*1000)/2000)=0 to (((1)+(2)-1)/2)=1

hm, so you're saying that we now round 0.5 up to 1 rather than down to zero?

>  However, MSECS_TO_JIFFIES remains the same going from
>  (((x) * (z)000 + 999) / 1000) to ((x)*(z))
> 
>  I.e. they basically reduce down to the same thing (modulo overflows)
> 
>  All of the other permuations look correct to me...
