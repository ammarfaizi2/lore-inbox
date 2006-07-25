Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWGYAAR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWGYAAR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 20:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWGYAAR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 20:00:17 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:30620 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S932339AbWGYAAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 20:00:15 -0400
Message-ID: <44C55F08.6060504@stanford.edu>
Date: Mon, 24 Jul 2006 17:00:08 -0700
From: Thomas Dillig <tdillig@stanford.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: softmac possible null deref [was: Complete report of Null dereference
 errors in kernel 2.6.17.1]
References: <1153782637.44c5536e013a4@webmail> <44C55F57.8040805@gentoo.org>
In-Reply-To: <44C55F57.8040805@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>
> Either I'm misunderstanding, or this is bogus.
>
> when *pkt is allocated by the various child functions (e.g. 
> ieee80211softmac_disassoc_deauth), it is always checked for NULL 
> before being used.
>
> Finally, line 453 does another NULL check, so that any failures 
> generated above are handled appropriately.
>
> What is the report trying to say?
>
> Daniel
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
Hi,

At least in 2.6.17.1, the function looks as follows:

 /* Create an rts/cts frame */
445 static u32
446 ieee80211softmac_rts_cts(struct ieee80211_hdr_2addr **pkt,
447         struct ieee80211softmac_device *mac, struct 
ieee80211softmac_network *net,
448         u32 type)
449 {
450         /* Allocate Packet */
451         (*pkt) = kmalloc(IEEE80211_2ADDR_LEN, GFP_ATOMIC);     
452         memset(*pkt, 0, IEEE80211_2ADDR_LEN); //*pkt is not checked 
for NULL
453         if((*pkt) == NULL) //*pkt is checked for NULL
454                 return 0;
455         ieee80211softmac_hdr_2addr(mac, (*pkt), type, net->bssid);
456         return IEEE80211_2ADDR_LEN;
457 }

The report is just trying to say that "*pkt" is dereferenced inside the 
call to "memset" and checked for being null one line later.

I hope this clarifies the message,
-Tom
