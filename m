Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261905AbSJEBRi>; Fri, 4 Oct 2002 21:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261910AbSJEBRh>; Fri, 4 Oct 2002 21:17:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20707 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261905AbSJEBRf>;
	Fri, 4 Oct 2002 21:17:35 -0400
Date: Fri, 04 Oct 2002 18:15:37 -0700 (PDT)
Message-Id: <20021004.181537.104336257.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org
Subject: Re: tg3 and Netgear GA302T x 2 locks machine
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0210051117240.23965-100000@blackbird.intercode.com.au>
References: <20021004.142428.101875902.davem@redhat.com>
	<Mutt.LNX.4.44.0210051117240.23965-100000@blackbird.intercode.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Sat, 5 Oct 2002 11:20:06 +1000 (EST)

   On Fri, 4 Oct 2002, David S. Miller wrote:
   
   > You reported the other week problems with two Acenic's in
   > this same machine right?  The second Acenic wouldn't even probe
   > properly.  And the two Acenic's were identical.
   
   FWIW, my GA302T seems fine with the kernel he originally reported 
   (2.4.20-pre8).

Yes but are you running parallel pktgen streams on two
tg3's? :-)

Ben, by chance, does reverting the patch below cure your problems?

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.670   -> 1.671  
#	   drivers/net/tg3.c	1.35    -> 1.36   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/17	davem@nuts.ninka.net	1.671
# [TIGON3]: Optimize NAPI irq masking a bit.
# --------------------------------------------
#
diff -Nru a/drivers/net/tg3.c b/drivers/net/tg3.c
--- a/drivers/net/tg3.c	Fri Oct  4 18:18:26 2002
+++ b/drivers/net/tg3.c	Fri Oct  4 18:18:26 2002
@@ -234,9 +234,23 @@
 		tw32(GRC_LOCAL_CTRL,
 		     tp->grc_local_ctrl | GRC_LCLCTRL_SETINT);
 	}
-#if 0
 	tr32(MAILBOX_INTERRUPT_0 + TG3_64BIT_REG_LOW);
-#endif
+}
+
+static inline void tg3_mask_ints(struct tg3 *tp)
+{
+	tw32(TG3PCI_MISC_HOST_CTRL,
+	     (tp->misc_host_ctrl | MISC_HOST_CTRL_MASK_PCI_INT));
+}
+
+static inline void tg3_unmask_ints(struct tg3 *tp)
+{
+	tw32(TG3PCI_MISC_HOST_CTRL,
+	     (tp->misc_host_ctrl & ~MISC_HOST_CTRL_MASK_PCI_INT));
+	if (tp->hw_status->status & SD_STATUS_UPDATED) {
+		tw32(GRC_LOCAL_CTRL,
+		     tp->grc_local_ctrl | GRC_LCLCTRL_SETINT);
+	}
 }
 
 static void tg3_switch_clocks(struct tg3 *tp)
@@ -2093,7 +2107,7 @@
 
 	if (done) {
 		netif_rx_complete(netdev);
-		tg3_enable_ints(tp);
+		tg3_unmask_ints(tp);
 	}
 
 	spin_unlock_irq(&tp->lock);
@@ -2120,11 +2134,10 @@
 		return;
 
 	if (netif_rx_schedule_prep(dev)) {
-		/* NOTE: This write is posted by the readback of
+		/* NOTE: These writes are posted by the readback of
 		 *       the mailbox register done by our caller.
 		 */
-		tw32(TG3PCI_MISC_HOST_CTRL,
-		     (tp->misc_host_ctrl | MISC_HOST_CTRL_MASK_PCI_INT));
+		tg3_mask_ints(tp);
 		__netif_rx_schedule(dev);
 	} else {
 		printk(KERN_ERR PFX "%s: Error, poll already scheduled\n",

