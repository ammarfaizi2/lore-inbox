Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264865AbRGIUOI>; Mon, 9 Jul 2001 16:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264872AbRGIUN7>; Mon, 9 Jul 2001 16:13:59 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:33801 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S264865AbRGIUNr>;
	Mon, 9 Jul 2001 16:13:47 -0400
Date: Mon, 9 Jul 2001 22:12:47 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: "Gary White (Network Administrator)" <admin@netpathway.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VMWare crashes
Message-ID: <20010709221247.A4040@vana.vc.cvut.cz>
In-Reply-To: <82677BD2F89@vcnet.vc.cvut.cz> <3B4A0133.D7270B6D@netpathway.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B4A0133.D7270B6D@netpathway.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2001 at 02:08:35PM -0500, Gary White (Network Administrator) wrote:
> Here are the results of ksymoops...
> 
> Code;  e1af85e1 <[vmnet]VNetHubCycleDetect+69/7c>   <=====
>    0:   8b 42 70                  mov    0x70(%edx),%eax   <=====

Thanks, meanwhile I found simillar report on VMware newsgroups, so there must be
something really real (it was with example how to reproduce it, so I received
fine oops too).

Following patch fixes oopses, at least for me. Due to some changes in tasklets
and/or in networking there is now very large quantum of skbs in flight from
one part of vmnet (packet written to /dev/vmnet*) through netif_rx to another
(packet received on eth0 interface). This trigerred 'history buffer overflow'
message, which then started cleaning history buffer. And if two CPUs started
cleaning at the same moment, one of them did kfree_skb(NULL) sooner or later...

So only increasing VNET_BRIDGE_HISTORY from 8 to 48 fixes problem, but as
I do not want oopses, rest of this patch just fixes oopses themselves. If
you'll apply patch except VNET_BRIDGE_HISTORY line, it will work, but you'll
get large stream of 'history buffer full' messages when doing TCP transfers
between guest and host. (48 is apparently enough for dual PIII/800, I did 
not tested lower values (48 is next multiple of 8 which ends on 8,
this saved one keystroke and so on...))

For those unfamiliar with patch (I'm sure there are no on linux-kernel,
but there can be some in VMware newsgroups) I put updated vmnet.tar.gz
at ftp://platan.vc.cvut.cz/pub/vmware/vmnet-204-for-2.4.6.tar.gz

					Best regards,
						Petr Vandrovec
						vandrove@vc.cvut.cz



diff -urN vmnet-only.orig/bridge.c vmnet-only/bridge.c
--- vmnet-only.orig/bridge.c	Thu Apr 26 19:59:28 2001
+++ vmnet-only/bridge.c	Mon Jul  9 21:50:36 2001
@@ -44,7 +44,7 @@
 #include "vnetInt.h"
 
 
-#define VNET_BRIDGE_HISTORY    8
+#define VNET_BRIDGE_HISTORY    48
 
 typedef struct VNetBridge VNetBridge;
 
@@ -58,6 +58,7 @@
    Bool                     savedPromisc;
    struct sk_buff          *history[VNET_BRIDGE_HISTORY];
    VNetPort                 port;
+   spinlock_t		    historyLock;
 };
 
 
@@ -130,6 +131,7 @@
       goto out;
    }
    memset(bridge, 0, sizeof *bridge);
+   spin_lock_init(&bridge->historyLock);
    memcpy(bridge->name, devName, sizeof bridge->name);
 
    /*
@@ -391,6 +393,8 @@
 	 unsigned long flags;
 	 int i;
 	 SKB_INCREF(clone);
+	 
+	 spin_lock_irqsave(&bridge->historyLock, flags);
 	 // XXX need to lock history
 	 for (i = 0; i < VNET_BRIDGE_HISTORY; i++) {
 	    if (bridge->history[i] == NULL) {
@@ -417,11 +421,15 @@
 	    for (i = 0; i < VNET_BRIDGE_HISTORY; i++) {
 	       struct sk_buff *s = bridge->history[i];
 	       bridge->history[i] = NULL;
-	       KFREE_SKB(s, FREE_WRITE);
+	       if (s) {
+	       	  spin_unlock_irqrestore(&bridge->historyLock, flags);
+		  KFREE_SKB(s, FREE_WRITE);
+		  spin_lock_irqsave(&bridge->historyLock, flags);
+	       }
 	    }
 	    bridge->history[0] = clone;
 	 }
-         
+         spin_unlock_irqrestore(&bridge->historyLock, flags);
 	 clone->dev = dev;
 	 clone->protocol = eth_type_trans(clone, dev);
 	 save_flags(flags);
@@ -773,6 +781,7 @@
 {
    VNetBridge *bridge = *(VNetBridge**)&((struct sock *)pt->data)->protinfo;
    int i;
+   unsigned long flags;
 
    if (bridge->dev == NULL) {
       LOG(3, (KERN_DEBUG "bridge-%s: received %d closed\n",
@@ -782,11 +791,13 @@
    }
 
    // XXX need to lock history
+   spin_lock_irqsave(&bridge->historyLock, flags);
    for (i = 0; i < VNET_BRIDGE_HISTORY; i++) {
       struct sk_buff *s = bridge->history[i];
       if (s != NULL &&
 	  (s == skb || SKB_IS_CLONE_OF(skb, s))) {
 	 bridge->history[i] = NULL;
+	 spin_unlock_irqrestore(&bridge->historyLock, flags);
 	 KFREE_SKB(s, FREE_WRITE);
 	 LOG(3, (KERN_DEBUG "bridge-%s: receive %d self %d\n",
 		 bridge->name, (int) skb->len, i));
@@ -795,6 +806,7 @@
 	 return 0;
       }
    }
+   spin_unlock_irqrestore(&bridge->historyLock, flags);
 
 #  if LOGLEVEL >= 4
    {
