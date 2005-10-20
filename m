Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbVJTVCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbVJTVCg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 17:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932540AbVJTVCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 17:02:36 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:51078 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S932536AbVJTVCf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 17:02:35 -0400
From: "Jiri Slaby" <xslaby@fi.muni.cz>
Date: Thu, 20 Oct 2005 23:02:26 +0200
In-reply-to: <4357CA5D.9060507@ens-lyon.fr>
To: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: Wifi oddness [Was: Re: 2.6.14-rc4-mm1]
References: <20051016154108.25735ee3.akpm@osdl.org> <20051019184935.E8C0B22AEB2@anxur.fi.muni.cz> <20051019184935.E8C0B22AEB2@anxur.fi.muni.cz>
Message-Id: <20051020210224.B9D4A22AEB2@anxur.fi.muni.cz>
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: xslaby@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Buisse wrote:
>Jiri Slaby wrote:
>>>I've been having problems with ipw2200 oopsing at modprobe since
>>>2.6.14-rc2-mm1 (sorry for not reporting before). I use the ipw2200
>>>included in the kernel.
>> 
>> 
>> Can you apply this and tell me what are the numbers?
>
>Hi,
>
>I tested with -rc4 and the problem did not appear.
>As for your patch, it just says ---THIS: 0,0 before oopsing.
>
>Hope it helps.
Yes, it really does.

The problem is in git-netdev-all.patch. Somebody rewrote the function:

diff --git a/net/ieee80211/ieee80211_wx.c b/net/ieee80211/ieee80211_wx.c
--- a/net/ieee80211/ieee80211_wx.c
+++ b/net/ieee80211/ieee80211_wx.c
@@ -1,6 +1,6 @@
 /******************************************************************************
 
-  Copyright(c) 2004 Intel Corporation. All rights reserved.
+  Copyright(c) 2004-2005 Intel Corporation. All rights reserved.
 
   Portions of this file are based on the WEP enablement code provided by the
   Host AP project hostap-drivers v0.1.3
@@ -32,6 +32,7 @@
 
 #include <linux/kmod.h>
 #include <linux/module.h>
+#include <linux/jiffies.h>
 
 #include <net/ieee80211.h>
 #include <linux/wireless.h>
@@ -140,18 +141,38 @@ static inline char *ipw2100_translate_sc
 		start = iwe_stream_add_point(start, stop, &iwe, custom);
 
 	/* Add quality statistics */
-	/* TODO: Fix these values... */
 	iwe.cmd = IWEVQUAL;
-	iwe.u.qual.qual = network->stats.signal;
-	iwe.u.qual.level = network->stats.rssi;
-	iwe.u.qual.noise = network->stats.noise;
-	iwe.u.qual.updated = network->stats.mask & IEEE80211_STATMASK_WEMASK;
-	if (!(network->stats.mask & IEEE80211_STATMASK_RSSI))
-		iwe.u.qual.updated |= IW_QUAL_LEVEL_INVALID;
-	if (!(network->stats.mask & IEEE80211_STATMASK_NOISE))
+	iwe.u.qual.updated = IW_QUAL_QUAL_UPDATED | IW_QUAL_LEVEL_UPDATED |
+	    IW_QUAL_NOISE_UPDATED;
+
+	if (!(network->stats.mask & IEEE80211_STATMASK_RSSI)) {
+		iwe.u.qual.updated |= IW_QUAL_QUAL_INVALID |
+		    IW_QUAL_LEVEL_INVALID;
+		iwe.u.qual.qual = 0;
+		iwe.u.qual.level = 0;
+	} else {
+		iwe.u.qual.level = network->stats.rssi;
+		iwe.u.qual.qual =
+		    (100 *
+		     (ieee->perfect_rssi - ieee->worst_rssi) *
+		     (ieee->perfect_rssi - ieee->worst_rssi) -
+		     (ieee->perfect_rssi - network->stats.rssi) *
+		     (15 * (ieee->perfect_rssi - ieee->worst_rssi) +
+		      62 * (ieee->perfect_rssi - network->stats.rssi))) /
+		    ((ieee->perfect_rssi - ieee->worst_rssi) *
+		     (ieee->perfect_rssi - ieee->worst_rssi));
But here is a problem ieee->perfect_rssi and ieee->worst_rssi is 0 and 0, as
you mentioned -- division by zero...

It seems, that it is pulled from your tree, Jeff. Any ideas?

thanks,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
B67499670407CE62ACC8 22A032CC55C339D47A7E
