Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964813AbWHCPlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964813AbWHCPlj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 11:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWHCPlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 11:41:39 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:38111 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S964809AbWHCPlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 11:41:37 -0400
Date: Thu, 3 Aug 2006 19:41:26 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Krzysztof Oledzki <olel@ans.pl>
Cc: Arnd Hannemann <arnd@arndnet.de>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: problems with e1000 and jumboframes
Message-ID: <20060803154125.GA9745@2ka.mipt.ru>
References: <44D1FEB7.2050703@arndnet.de> <20060803135925.GA28348@2ka.mipt.ru> <44D20A2F.3090005@arndnet.de> <20060803150330.GB12915@2ka.mipt.ru> <Pine.LNX.4.64.0608031705560.8443@bizon.gios.gov.pl> <20060803151631.GA14774@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060803151631.GA14774@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Thu, 03 Aug 2006 19:41:27 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2006 at 07:16:31PM +0400, Evgeniy Polyakov (johnpol@2ka.mipt.ru) wrote:
> > >then skb_alloc adds a little
> > >(sizeof(struct skb_shared_info)) at the end, and this ends up
> > >in 32k request just for 9k jumbo frame.
> > 
> > Strange, why this skb_shared_info cannon be added before first alignment? 
> > And what about smaller frames like 1500, does this driver behave similar 
> > (first align then add)?
> 
> It can be.
> Could attached  (completely untested) patch help?

Actually this patch will not help, this new one could.

diff --git a/drivers/net/e1000/e1000_main.c b/drivers/net/e1000/e1000_main.c
index da62db8..1514628 100644
--- a/drivers/net/e1000/e1000_main.c
+++ b/drivers/net/e1000/e1000_main.c
@@ -3978,9 +3978,11 @@ e1000_alloc_rx_buffers(struct e1000_adap
 	buffer_info = &rx_ring->buffer_info[i];
 
 	while (cleaned_count--) {
-		if (!(skb = buffer_info->skb))
+		if (!(skb = buffer_info->skb)) {
+			if (SKB_DATA_ALIGN(adapter->hw.max_frame_size) + sizeof(struct skb_shared_info) <= bufsz)
+				bufsz -= sizeof(struct skb_shared_info);
 			skb = dev_alloc_skb(bufsz);
-		else {
+		} else {
 			skb_trim(skb, 0);
 			goto map_skb;
 		}

-- 
	Evgeniy Polyakov
