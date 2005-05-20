Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVETCUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVETCUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 22:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVETCUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 22:20:40 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:30200 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261314AbVETCUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 22:20:24 -0400
Message-ID: <428D4966.20506@acm.org>
Date: Thu, 19 May 2005 21:20:22 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fixes for IPMI use of timers
References: <428D2181.2080106@acm.org> <1116546667.23807.0.camel@mindpipe>
In-Reply-To: <1116546667.23807.0.camel@mindpipe>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------050504040502030708060803"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050504040502030708060803
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Lee Revell wrote:

>On Thu, 2005-05-19 at 18:30 -0500, Corey Minyard wrote:
>  
>
>>                /* We already have irqsave on, so no need for it
>>                    here. */
>>-               read_lock(&xtime_lock);
>>+               read_lock_irqsave(&xtime_lock, flags); 
>>    
>>
>
>The comment is now wrong.
>
>Lee
>  
>
I know I deleted that at least once.  Oh well, here it is with the 
comment removed.

Thanks.

-Corey



--------------050504040502030708060803
Content-Type: text/x-patch;
 name="ipmi_hrt_fixes.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipmi_hrt_fixes.diff"

Fix some problems with the high-res timer support.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.12-rc4/drivers/char/ipmi/ipmi_si_intf.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux-2.6.12-rc4/drivers/char/ipmi/ipmi_si_intf.c
@@ -767,12 +767,11 @@
 		   immediately, anyway.  So we only process if we
 		   actually delete the timer. */
 
-		/* We already have irqsave on, so no need for it
-                   here. */
-		read_lock(&xtime_lock);
+		read_lock_irqsave(&xtime_lock, flags);
 		jiffies_now = jiffies;
 		smi_info->si_timer.expires = jiffies_now;
 		smi_info->si_timer.sub_expires = get_arch_cycles(jiffies_now);
+		read_unlock_irqrestore(&xtime_lock, flags);
 
 		add_usec_to_timer(&smi_info->si_timer, SI_SHORT_TIMEOUT_USEC);
 
@@ -830,11 +829,11 @@
 		smi_info->short_timeouts++;
 		spin_unlock_irqrestore(&smi_info->count_lock, flags);
 #if defined(CONFIG_HIGH_RES_TIMERS)
-		read_lock(&xtime_lock);
+		read_lock_irqsave(&xtime_lock, flags);
                 smi_info->si_timer.expires = jiffies;
                 smi_info->si_timer.sub_expires
                         = get_arch_cycles(smi_info->si_timer.expires);
-                read_unlock(&xtime_lock);
+		read_unlock_irqrestore(&xtime_lock, flags);
 		add_usec_to_timer(&smi_info->si_timer, SI_SHORT_TIMEOUT_USEC);
 #else
 		smi_info->si_timer.expires = jiffies + 1;

--------------050504040502030708060803--
