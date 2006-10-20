Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946825AbWJTC1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946825AbWJTC1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 22:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946834AbWJTC1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 22:27:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45982 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946825AbWJTC1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 22:27:17 -0400
Date: Thu, 19 Oct 2006 19:23:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ipw2100-admin@linux.intel.com, Zhu Yi <yi.zhu@intel.com>,
       "John W. Linville" <linville@tuxdriver.com>
Subject: Re: ipw2200: "ieee80211: Info elem: parse failed"
Message-Id: <20061019192350.13209920.akpm@osdl.org>
In-Reply-To: <453742AE.3010201@gmail.com>
References: <453742AE.3010201@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 11:17:34 +0200
Jiri Slaby <jirislaby@gmail.com> wrote:

> Hi,
> 
> since 2.6.19-rc1 I'm getting these messages from ipw2200 driver:
> ieee80211: Info elem: parse failed: info_element->len + 2 > left : 
> info_element->len+2=8 left=2, id=128.
> 
> The driver says:
> ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.4km
> ipw2200: Copyright(c) 2003-2006 Intel Corporation
> ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 3
> PCI: setting IRQ 3 as level-triggered
> ACPI: PCI Interrupt 0000:02:07.0[A] -> Link [LNKC] -> GSI 3 (level, low) -> IRQ 3
> ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
> ACPI: PCI Interrupt 0000:00:13.2[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ 10
> 
> and works, but the message is annoying, since the driver prints it again and 
> again. What could be wrong?
> 

I suspect it was always failing.  But the failure message has been changed
so that it actually comes out.



commit f09fc44d8c25f22c4d985bb93857338ed02feac6
Author: Zhu Yi <yi.zhu@intel.com>
Date:   Mon Aug 21 11:34:19 2006 +0800

    [PATCH] ieee80211: Workaround malformed 802.11 frames from AP
    
    Stop processing further but return success when we receive a malformed
    packet from the AP. We need this patch to workaround some AP bugs. For
    example, the beacon frames from the Orinoco AP1000 contains an IE (value
    = 128) with length equals to 8 but the actual frame length is only 7.
    
    Signed-off-by: Zhu Yi <yi.zhu@intel.com>
    Signed-off-by: John W. Linville <linville@tuxdriver.com>

diff --git a/net/ieee80211/ieee80211_rx.c b/net/ieee80211/ieee80211_rx.c
index d60358d..7707041 100644
--- a/net/ieee80211/ieee80211_rx.c
+++ b/net/ieee80211/ieee80211_rx.c
@@ -1078,13 +1078,16 @@ #endif
 
 	while (length >= sizeof(*info_element)) {
 		if (sizeof(*info_element) + info_element->len > length) {
-			IEEE80211_DEBUG_MGMT("Info elem: parse failed: "
-					     "info_element->len + 2 > left : "
-					     "info_element->len+2=%zd left=%d, id=%d.\n",
-					     info_element->len +
-					     sizeof(*info_element),
-					     length, info_element->id);
-			return 1;
+			IEEE80211_ERROR("Info elem: parse failed: "
+					"info_element->len + 2 > left : "
+					"info_element->len+2=%zd left=%d, id=%d.\n",
+					info_element->len +
+					sizeof(*info_element),
+					length, info_element->id);
+			/* We stop processing but don't return an error here
+			 * because some misbehaviour APs break this rule. ie.
+			 * Orinoco AP1000. */
+			break;
 		}
 
 		switch (info_element->id) {

