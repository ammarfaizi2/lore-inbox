Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRCLA2r>; Sun, 11 Mar 2001 19:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129306AbRCLA2h>; Sun, 11 Mar 2001 19:28:37 -0500
Received: from platan.vc.cvut.cz ([147.32.240.81]:48657 "EHLO
	platan.vc.cvut.cz") by vger.kernel.org with ESMTP
	id <S129300AbRCLA2c>; Sun, 11 Mar 2001 19:28:32 -0500
Date: Mon, 12 Mar 2001 01:27:38 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: ajschrotenboer@lycosmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: VMware 2.0.3 & Kernel 2.4.2-ac17
Message-ID: <20010312012738.A8012@platan.vc.cvut.cz>
In-Reply-To: <20010312011044.F1530@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010312011044.F1530@ppc.vc.cvut.cz>; from vandrove@vc.cvut.cz on Mon, Mar 12, 2001 at 01:10:44AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While compiling the vmnet module, there is a warning
> 
> make: Entering directory `/tmp/vmware-config2/vmnet-only'
> bridge.c: In function `VNetBridgeReceiveFromDev':
> bridge.c:788: warning: implicit declaration of function `skb_datarefp'
> 
> and while inserting the module
> 
> /tmp/vmware-config2/vmnet.o: unresolved symbol skb_datarefp
> 
> I have traced this back to 2.4.2-ac4 by looking for where this function 
> was removed.

Try this patch. I believe that there are no other needed changes
in vmnet code, but as I do not have any scatter-gather checksumming
hardware around, I'm not 100% sure. But up to now nobody complained 
about getting 'xxx invoked with paged skb', so I believe that rest
of code is correct.
 
diff -u vmnet-only.dist/vnetInt.h vmnet-only/vnetInt.h
--- vmnet-only.dist/vnetInt.h	Thu Nov  2 02:40:20 2000
+++ vmnet-only/vnetInt.h	Mon Mar 12 01:12:00 2001
@@ -16,9 +16,15 @@
 #  define KFREE_SKB(skb, type)		kfree_skb(skb)
 #  define DEV_KFREE_SKB(skb, type)	dev_kfree_skb(skb)
 #  define SKB_INCREF(skb)		atomic_inc(&(skb)->users)
-#  define SKB_IS_CLONE_OF(clone, skb)	( \
-      skb_datarefp(clone) == skb_datarefp(skb) \
-   )
+#  ifdef skb_shinfo
+#    define SKB_IS_CLONE_OF(clone, skb)	( \
+        skb_shinfo(clone) == skb_shinfo(skb) \
+     )
+#  else
+#    define SKB_IS_CLONE_OF(clone, skb)	( \
+        skb_datarefp(clone) == skb_datarefp(skb) \
+     )
+#  endif
 #  define SK_ALLOC(pri)			sk_alloc(0, pri, 1)
 #  define DEV_QUEUE_XMIT(skb, dev, pri)	( \
       (skb)->dev = (dev), \

> yes, technically this probably is OT, and properly belong on the VMware 
> list, but I can't access their nntp server.

Is problem on your side or on VMware side? If on VMware one, I'd like to
know (private pls.).
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz

