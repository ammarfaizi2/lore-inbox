Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbVKPMTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbVKPMTF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 07:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbVKPMTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 07:19:05 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:22229 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1030298AbVKPMTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 07:19:04 -0500
Date: Wed, 16 Nov 2005 14:18:48 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Zilvinas Valinskas <zilvinas@gemtek.lt>
cc: Zhu Yi <yi.zhu@intel.com>, Andrew Morton <akpm@osdl.org>,
       Alexandre Buisse <alexandre.buisse@ens-lyon.fr>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, jketreno@linux.intel.com
Subject: Re: Linuv 2.6.15-rc1
In-Reply-To: <20051116114052.GA14042@gemtek.lt>
Message-ID: <Pine.LNX.4.58.0511161415010.4402@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org> <4378980C.7060901@ens-lyon.fr>
 <20051114162942.5b163558.akpm@osdl.org> <20051115100519.GA5567@gemtek.lt>
 <20051115115657.GA30489@gemtek.lt> <84144f020511150451l6ef30420g5a83a147c61f34a8@mail.gmail.com>
 <20051115140023.GB9910@gemtek.lt> <1132120145.18679.12.camel@debian.sh.intel.com>
 <20051116094551.GA23140@gemtek.lt> <20051116114052.GA14042@gemtek.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zilvinas,

On Wed, 16 Nov 2005, Zilvinas Valinskas wrote:
> I just have noticed there are messages logged on Nov 3rd ... Doh! Please
> see the latest logged message :
> 
> http://www.gemtek.lt/~zilvinas/dumps/trace.2 

The patch I sent to you won't fix the above error. Please try this patch 
instead. I think the driver is in a middle of a reset when 
wpa_supplicant() causes ipw_request_direct_scan() to trigger.

			Pekka

Index: 2.6/drivers/net/wireless/ipw2200.c
===================================================================
--- 2.6.orig/drivers/net/wireless/ipw2200.c
+++ 2.6/drivers/net/wireless/ipw2200.c
@@ -8926,6 +8926,10 @@ static int ipw_request_direct_scan(struc
 	struct ipw_scan_request_ext scan;
 	int err = 0, scan_type;
 
+	if (!(priv->status & STATUS_INIT) ||
+	    (priv->status & STATUS_EXIT_PENDING))
+		return 0;
+
 	down(&priv->sem);
 
 	if (priv->status & STATUS_RF_KILL_MASK) {
