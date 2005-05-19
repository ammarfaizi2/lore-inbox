Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVESXeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVESXeY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVESXdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:33:09 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:19585 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261318AbVESXaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 19:30:15 -0400
Message-ID: <428D2181.2080106@acm.org>
Date: Thu, 19 May 2005 18:30:09 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fixes for IPMI use of timers
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------070309000602010401020509"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070309000602010401020509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------070309000602010401020509
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
@@ -769,10 +769,11 @@
 
 		/* We already have irqsave on, so no need for it
                    here. */
-		read_lock(&xtime_lock);
+		read_lock_irqsave(&xtime_lock, flags);
 		jiffies_now = jiffies;
 		smi_info->si_timer.expires = jiffies_now;
 		smi_info->si_timer.sub_expires = get_arch_cycles(jiffies_now);
+		read_unlock_irqrestore(&xtime_lock, flags);
 
 		add_usec_to_timer(&smi_info->si_timer, SI_SHORT_TIMEOUT_USEC);
 
@@ -830,11 +831,11 @@
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

--------------070309000602010401020509--
