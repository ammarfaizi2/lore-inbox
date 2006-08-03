Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932410AbWHCSJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932410AbWHCSJB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 14:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932358AbWHCSJB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 14:09:01 -0400
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:53152 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S932410AbWHCSJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 14:09:00 -0400
Date: Thu, 03 Aug 2006 20:09:07 +0200
From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: problems with e1000 and jumboframes
In-reply-to: <20060803154125.GA9745@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, olel@ans.pl
Message-id: <44D23BC3.7040707@arndnet.de>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_+S19urY23jRbIKHvsjrMKw)"
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
X-Enigmail-Version: 0.94.0.0
X-Spam-Report: * -2.8 ALL_TRUSTED Did not pass through any untrusted hosts
References: <44D1FEB7.2050703@arndnet.de> <20060803135925.GA28348@2ka.mipt.ru>
 <44D20A2F.3090005@arndnet.de> <20060803150330.GB12915@2ka.mipt.ru>
 <Pine.LNX.4.64.0608031705560.8443@bizon.gios.gov.pl>
 <20060803151631.GA14774@2ka.mipt.ru> <20060803154125.GA9745@2ka.mipt.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_+S19urY23jRbIKHvsjrMKw)
Content-type: text/plain; charset=KOI8-R
Content-transfer-encoding: 7BIT

Evgeniy Polyakov schrieb:
> On Thu, Aug 03, 2006 at 07:16:31PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
>>>> then skb_alloc adds a little
>>>> (sizeof(struct skb_shared_info)) at the end, and this ends up
>>>> in 32k request just for 9k jumbo frame.
>>> Strange, why this skb_shared_info cannon be added before first alignment? 
>>> And what about smaller frames like 1500, does this driver behave similar 
>>> (first align then add)?
>> It can be.
>> Could attached  (completely untested) patch help?
> 
> Actually this patch will not help, this new one could.
> 

I applied the attached pachted. And got this output:

> Intel(R) PRO/1000 Network Driver - bufsz 13762
> Intel(R) PRO/1000 Network Driver - bufsz 16222
> Intel(R) PRO/1000 Network Driver - bufsz 16058
> Intel(R) PRO/1000 Network Driver - bufsz 15894
> Intel(R) PRO/1000 Network Driver - bufsz 15730
> Intel(R) PRO/1000 Network Driver - bufsz 15566
> Intel(R) PRO/1000 Network Driver - bufsz 15402
> Intel(R) PRO/1000 Network Driver - bufsz 15238
> Intel(R) PRO/1000 Network Driver - bufsz 15074
> Intel(R) PRO/1000 Network Driver - bufsz 14910
> Intel(R) PRO/1000 Network Driver - bufsz 14746
> Intel(R) PRO/1000 Network Driver - bufsz 14582
> Intel(R) PRO/1000 Network Driver - bufsz 14418
> Intel(R) PRO/1000 Network Driver - bufsz 14254
> Intel(R) PRO/1000 Network Driver - bufsz 14090
> Intel(R) PRO/1000 Network Driver - bufsz 13926
> Intel(R) PRO/1000 Network Driver - bufsz 13762
> Intel(R) PRO/1000 Network Driver - bufsz 16222
> Intel(R) PRO/1000 Network Driver - bufsz 16058
> Intel(R) PRO/1000 Network Driver - bufsz 15894
> Intel(R) PRO/1000 Network Driver - bufsz 15730
> Intel(R) PRO/1000 Network Driver - bufsz 15566
> Intel(R) PRO/1000 Network Driver - bufsz 15402
> Intel(R) PRO/1000 Network Driver - bufsz 15238
> Intel(R) PRO/1000 Network Driver - bufsz 15074
> Intel(R) PRO/1000 Network Driver - bufsz 14910
> Intel(R) PRO/1000 Network Driver - bufsz 14746
> Intel(R) PRO/1000 Network Driver - bufsz 14582
> Intel(R) PRO/1000 Network Driver - bufsz 14418
> Intel(R) PRO/1000 Network Driver - bufsz 16222
> Intel(R) PRO/1000 Network Driver - bufsz 16222
> Intel(R) PRO/1000 Network Driver - bufsz 16222
> Intel(R) PRO/1000 Network Driver - bufsz 16222
> Intel(R) PRO/1000 Network Driver - bufsz 16222
> Intel(R) PRO/1000 Network Driver - bufsz 16222
> Intel(R) PRO/1000 Network Driver - bufsz 16222
> Intel(R) PRO/1000 Network Driver - bufsz 16222
> Intel(R) PRO/1000 Network Driver - bufsz 16222
> Intel(R) PRO/1000 Network Driver - bufsz 16222
> Intel(R) PRO/1000 Network Driver - bufsz 16222

I'm a bit puzzled that there are so much allocations. However the patch
seems to work. (at least not obviously breaks things for me yet)

Best regards
Arnd


--Boundary_(ID_+S19urY23jRbIKHvsjrMKw)
Content-type: text/plain; name=patch.txt
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=patch.txt

--- linux-2.6.17.6/drivers/net/e1000/e1000_main.c	2006-08-03 17:38:53.000000000 +0200
+++ linux-2.6.17.6.patched/drivers/net/e1000/e1000_main.c	2006-08-03 19:38:53.000000000 +0200
@@ -3843,9 +3843,13 @@
 	buffer_info = &rx_ring->buffer_info[i];
 
 	while (cleaned_count--) {
-		if (!(skb = buffer_info->skb))
+		if (!(skb = buffer_info->skb)) {
+			if (SKB_DATA_ALIGN(adapter->hw.max_frame_size) + sizeof(struct skb_shared_info) <= bufsz) {
+				bufsz -= sizeof(struct skb_shared_info);
+				printk(KERN_INFO "%s - bufsz %d\n",e1000_driver_string, bufsz);
+			}
 			skb = dev_alloc_skb(bufsz);
-		else {
+		} else {
 			skb_trim(skb, 0);
 			goto map_skb;
 		}

--Boundary_(ID_+S19urY23jRbIKHvsjrMKw)--
