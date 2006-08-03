Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWHCPQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWHCPQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWHCPQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:16:45 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:31945 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932570AbWHCPQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:16:44 -0400
Date: Thu, 3 Aug 2006 19:16:31 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Krzysztof Oledzki <olel@ans.pl>
Cc: Arnd Hannemann <arnd@arndnet.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
Message-ID: <20060803151631.GA14774@2ka.mipt.ru>
References: <44D1FEB7.2050703@arndnet.de> <20060803135925.GA28348@2ka.mipt.ru> <44D20A2F.3090005@arndnet.de> <20060803150330.GB12915@2ka.mipt.ru> <Pine.LNX.4.64.0608031705560.8443@bizon.gios.gov.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0608031705560.8443@bizon.gios.gov.pl>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 03 Aug 2006 19:16:33 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 05:08:51PM +0200, Krzysztof Oledzki (olel@ans.pl) wrote:
> >>Why? After your explanation that makes sense for me. The driver needs
> >>one contiguous chunk for those 9k packet buffer and thus requests a
> >>3-order page of 16k. Or do i still do not understand this?
> >
> >Correct, except that it wants 32k.
> >e1000 logic is following:
> >align frame size to power-of-two,
> 16K?

Yep.

> >then skb_alloc adds a little
> >(sizeof(struct skb_shared_info)) at the end, and this ends up
> >in 32k request just for 9k jumbo frame.
> 
> Strange, why this skb_shared_info cannon be added before first alignment? 
> And what about smaller frames like 1500, does this driver behave similar 
> (first align then add)?

It can be.
Could attached  (completely untested) patch help?

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index da62db8..cf6506d 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -3132,6 +3132,8 @@ #define MAX_STD_JUMBO_FRAME_SIZE 9234
 	 * larger slab size
 	 * i.e. RXBUFFER_2048 --> size-4096 slab */
 
+	max_frame += sizeof(struct skb_shared_info);
+
 	if (max_frame <= E1000_RXBUFFER_256)
 		adapter->rx_buffer_len = E1000_RXBUFFER_256;
 	else if (max_frame <= E1000_RXBUFFER_512)
@@ -3146,6 +3148,8 @@ #define MAX_STD_JUMBO_FRAME_SIZE 9234
 		adapter->rx_buffer_len = E1000_RXBUFFER_8192;
 	else if (max_frame <= E1000_RXBUFFER_16384)
 		adapter->rx_buffer_len = E1000_RXBUFFER_16384;
+	
+	max_frame -= sizeof(struct skb_shared_info);
 
 	/* adjust allocation if LPE protects us, and we aren't using SBP */
 	if (!adapter->hw.tbi_compatibility_on &&

> Best regards,
> 
> 				Krzysztof Olędzki


-- 
	Evgeniy Polyakov
