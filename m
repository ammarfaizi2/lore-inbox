Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSHGBFT>; Tue, 6 Aug 2002 21:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSHGBFT>; Tue, 6 Aug 2002 21:05:19 -0400
Received: from jalon.able.es ([212.97.163.2]:10973 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316235AbSHGBFS>;
	Tue, 6 Aug 2002 21:05:18 -0400
Date: Wed, 7 Aug 2002 03:08:14 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.20-pre1
Message-ID: <20020807010814.GA11603@werewolf.able.es>
References: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.44.0208051938380.6811-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Tue, Aug 06, 2002 at 00:40:56 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.08.06 Marcelo Tosatti wrote:
>
>So here goes -pre1, with a big -ac and x86-64 merges, plus other smaller
>stuff.
>

Something is missing in the network merge:

werewolf:/usr/src/linux# grep -r netif_receive_skb *
drivers/net/tg3.c:                      netif_receive_skb(skb);
Binary file drivers/net/e1000/e1000_main.o matches
Binary file drivers/net/e1000/e1000.o matches
include/linux/if_vlan.h:        //return (polling ? netif_receive_skb(skb) : netif_rx(skb));

So I had to:

--- linux/include/linux/if_vlan.h.orig	2002-08-07 02:57:36.000000000 +0200
+++ linux/include/linux/if_vlan.h	2002-08-07 02:58:07.000000000 +0200
@@ -183,7 +183,8 @@
 		break;
 	};
 
-	return (polling ? netif_receive_skb(skb) : netif_rx(skb));
+	//return (polling ? netif_receive_skb(skb) : netif_rx(skb));
+	return netif_rx(skb);
 }
 
 static inline int vlan_hwaccel_rx(struct sk_buff *skb,

To make e1000 build. But tg3 uses n_r_skb directly, so it is not useful for
that.

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-jam0, Mandrake Linux 9.0 (Cooker) for i586
gcc (GCC) 3.2 (Mandrake Linux 9.0 3.2-0.2mdk)
