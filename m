Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162195AbWKPCRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162195AbWKPCRN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 21:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162197AbWKPCRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 21:17:13 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:10730 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1162195AbWKPCRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 21:17:12 -0500
Message-ID: <455BCA05.8000007@lwfinger.net>
Date: Wed, 15 Nov 2006 20:16:37 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Miles Lane <miles.lane@gmail.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Andrew Morton <akpm@osdl.org>
CC: Bcm43xx-dev@lists.berlios.de, Michael Buesch <mb@bu3sch.de>,
       LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Subject: Re: 2.6.19-rc5-mm2 -- bcm43xx busted (backing out the bcm43xx patches
 fixes it)
References: <a44ae5cd0611141521pd342109jaae9e27aca3d2200@mail.gmail.com> <200611152116.30734.rjw@sisk.pl>
In-Reply-To: <200611152116.30734.rjw@sisk.pl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki wrote:
> On Wednesday, 15 November 2006 00:21, Miles Lane wrote:
>> Hello,
>>
>> The last three MM kernels have fail to give me a working bcm43xx driver.
>> The odd thing is that dmesg output seems to indicate that the driver
>> is working okay.  NetworkManager doesn't see the driver, though.
>> "iwlist scan" fails to find any access points, too.  iwconfig shows
>> "Access Point: invalid".
> 
> I can confirm the symptoms, I see them too on my test boxes.
> 
>> I tried backing out the following patches, and it fixes the problem:
>>
>> drivers/net/wireless/bcm43xx/bcm43xx.h
>> drivers/net/wireless/bcm43xx/bcm43xx_main.c
>> drivers/net/wireless/bcm43xx/bcm43xx_power.c
>> drivers/net/wireless/bcm43xx/bcm43xx_wx.c
>>> drivers/net/wireless/bcm43xx/bcm43xx_xmit.c 

The missing patch is shown below. This patch was entitled "[PATCH] bcm43xx: Readd dropped
assignment" and submitted to wireless-2.6 by Daniel Drake on 10/17/06, but it seems to have fallen
through the cracks. It is a fix to a patch entitled "[PATCH] ieee80211: Move IV/ICV stripping into
ieee80211_rx" also submitted by Daniel Drake on 9/26/2006.

NOTE to maintainers: This problem affects BOTH wireless-2.6 and 2.6.19-rcX-mmY. At present, the
"Move IV/ICV" patch has not been incorporated into 2.6.19-rcX and it is OK.

Larry


In the patch sent by Daniel Drake under the title "[PATCH] ieee80211: Move
IV/ICV stripping into ieee80211_rx", a needed line was accidentally removed.
As my current copy of wireless-2.6.git does not contain this line, I am
(re)submitting a patch to restore that line.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---

Index: wireless-2.6/drivers/net/wireless/bcm43xx/bcm43xx_xmit.c
===================================================================
--- wireless-2.6.orig/drivers/net/wireless/bcm43xx/bcm43xx_xmit.c
+++ wireless-2.6/drivers/net/wireless/bcm43xx/bcm43xx_xmit.c
@@ -543,6 +543,7 @@ int bcm43xx_rx(struct bcm43xx_private *b
  		break;
  	}

+	frame_ctl = le16_to_cpu(wlhdr->frame_ctl);
  	switch (WLAN_FC_GET_TYPE(frame_ctl)) {
  	case IEEE80211_FTYPE_MGMT:
  		ieee80211_rx_mgt(bcm->ieee, wlhdr, &stats);

