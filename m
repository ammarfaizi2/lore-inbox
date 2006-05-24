Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932638AbWEXHQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932638AbWEXHQx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 03:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbWEXHQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 03:16:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:5846 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932633AbWEXHQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 03:16:52 -0400
Message-ID: <44740855.4090409@suse.de>
Date: Wed, 24 May 2006 09:16:37 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060411)
MIME-Version: 1.0
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Matt Ayres <matta@tektonic.net>, Patrick McHardy <kaber@trash.net>,
       James Morris <jmorris@namei.org>,
       "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: Panic in ipt_do_table with 2.6.16.13-xen
References: <4468BE70.7030802@tektonic.net>	<4468D613.20309@trash.net>	<44691669.4080903@tektonic.net>	<Pine.LNX.4.64.0605152331140.10964@d.namei>	<4469D84F.8080709@tektonic.net>	<Pine.LNX.4.64.0605161127030.16379@d.namei>	<446D0A0D.5090608@tektonic.net>	<Pine.LNX.4.64.0605182002330.6528@d.namei>	<446D0E6D.2080600@tektonic.net> <446D151D.6030307@tektonic.net>	<4470A6CD.5010501@trash.net> <4471CB54.401@tektonic.net>	<4471CE19.5070802@trash.net> <bf76eefc5234d32440c822acd2879a8a@cl.cam.ac.uk> <44737D53.9050006@tektonic.net> <5e589307bfef58553bfda1d7ab47f9f3@cl.cam.ac.uk>
In-Reply-To: <5e589307bfef58553bfda1d7ab47f9f3@cl.cam.ac.uk>
Content-Type: multipart/mixed;
 boundary="------------080109030209000408000801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080109030209000408000801
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

>> As the concerned user, what does this mean to me?  It will only affect
>> SMP systems?  It is a bug in Xen or netfilter?
> 
> Probably a Xen bug, but if so then it's basically a memory corruption.

Might also be a netfilter bug which is simply triggered by the way how
xen manages the memory.  Due to ballooning you can have holes in memory,
so out-of-range access may fault with xen whereas it will go unnoticed
with normal kernels.

One such beast is in bridging netfilter code, additionally it triggers
with certain ethernet cards only, patch below.  Pinned down last week ;)

cheers,

  Gerd

--------------080109030209000408000801
Content-Type: text/plain;
 name="nf_bridge-header-size"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nf_bridge-header-size"

Subject: nf_bridge: ethernet header is 14 not 16 bytes
From: jbeulich@novell.com
Acked-by: kraxel@suse.de
References: 150410

The bridge netfilter code saves two more bytes that it should.
In most cases it doesn't hurt because many drivers use NET_IP_ALIGN
to make the IP header aligned, so there are two extra bytes head room
available.

Some drivers don't do that though (sky2 for example), so copying
accesses data outside the skbuff data allocation.  On xen kernels
this can kill the machine with a page fault due to the way how
skbuffs are allocated and the memory is managed.

Index: linux-2.6.16/include/linux/netfilter_bridge.h
===================================================================
--- linux-2.6.16.orig/include/linux/netfilter_bridge.h
+++ linux-2.6.16/include/linux/netfilter_bridge.h
@@ -73,14 +73,14 @@ void nf_bridge_maybe_copy_header(struct 
 			memcpy(skb->data - 18, skb->nf_bridge->data, 18);
 			skb_push(skb, 4);
 		} else
-			memcpy(skb->data - 16, skb->nf_bridge->data, 16);
+			memcpy(skb->data - 14, skb->nf_bridge->data, 14);
 	}
 }
 
 static inline
 void nf_bridge_save_header(struct sk_buff *skb)
 {
-        int header_size = 16;
+        int header_size = 14;
 
 	if (skb->protocol == __constant_htons(ETH_P_8021Q))
 		header_size = 18;

--------------080109030209000408000801--
