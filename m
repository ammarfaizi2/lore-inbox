Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266522AbUA2XhF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 18:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266523AbUA2XhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 18:37:05 -0500
Received: from yue.hongo.wide.ad.jp ([203.178.135.30]:19987 "EHLO
	yue.hongo.wide.ad.jp") by vger.kernel.org with ESMTP
	id S266522AbUA2XhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 18:37:01 -0500
Date: Fri, 30 Jan 2004 08:37:43 +0900 (JST)
Message-Id: <20040130.083743.20740540.yoshfuji@linux-ipv6.org>
To: kas@informatics.muni.cz
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, yoshfuji@linux-ipv6.org
Subject: Re: Patch: IPv6/AMD64: bug in net/ipv6/ndisc.c
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20040129221538.J24747@fi.muni.cz>
References: <20040129221538.J24747@fi.muni.cz>
Organization: USAGI Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20040129221538.J24747@fi.muni.cz> (at Thu, 29 Jan 2004 22:15:38 +0100), Jan Kasprzak <kas@informatics.muni.cz> says:

> while compiling the kernel (2.6.1) I have spotted the following warning:
> 
> net/ipv6/ndisc.c: In function `ndisc_router_discovery':
> net/ipv6/ndisc.c:1113: warning: comparison is always true due to limited range of data type
:

> The corresponding lines are these:
> 
>                 __u32 rtime = ntohl(ra_msg->retrans_timer);
>                                                                                 
> Here --->       if (rtime && rtime/1000 < (MAX_SCHEDULE_TIMEOUT/HZ)) {
>                         rtime = (rtime*HZ)/1000;
>                         if (rtime < HZ/10)
>                                 rtime = HZ/10;
>                         in6_dev->nd_parms->retrans_time = rtime;
>                 }
:

> The MAX_SCHEDULE_TIMEOUT is #defined to LONG_MAX in include/linux/sched.h,
> which is 2^63-1 or so on AMD64. I propose the following fix:
:

+#define MAX_SCHEDULE_TIMEOUT_32 (MAX_SCHEDULE_TIMEOUT/HZ > (1U<<31) ? \
+	(1U<<31) : MAX_SCHEDULE_TIMEOUT/HZ)

Well,... ok for now.

For long term solution, I think it is better to store timing variables 
in "unsinged long" type instead of int. 
I think there's several places to be fixed.
We'll need proc_doulongvec_jiffies(), proc_doulongvec_userhz_jiffies().

--yoshfuji
