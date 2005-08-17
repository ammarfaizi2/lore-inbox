Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbVHQVRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbVHQVRO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 17:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbVHQVRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 17:17:13 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:30479 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751257AbVHQVRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 17:17:12 -0400
Date: Wed, 17 Aug 2005 16:49:59 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@vger.kernel.org, linux-tr@linuxtr.net, mikep@linuxtr.net
Cc: jgarzik@pobox.com, davem@davemloft.net, fubar@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: [patch 2.6.13-rc6] net/802/tr: use interrupt-safe locking
Message-ID: <20050817204959.GA20186@tuxdriver.com>
Mail-Followup-To: netdev@vger.kernel.org, linux-tr@linuxtr.net,
	mikep@linuxtr.net, jgarzik@pobox.com, davem@davemloft.net,
	fubar@us.ibm.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change operations on rif_lock from spin_{un}lock_bh to
spin_{un}lock_irq{save,restore} equivalents.  Some of the
rif_lock critical sections are called from interrupt context via
tr_type_trans->tr_add_rif_info.  The TR NIC drivers call tr_type_trans
from their packet receive handlers.

Signed-off-by: Jay Vosburg <foobar@us.ibm.com>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
It is my understanding that this same patch has been submitted multiple
times in the past.  Some of those submissions were around a year ago,
but it does not seem to have been committed.

FWIW, this patch is currently being carried in the Fedora and RHEL
kernels.  It certainly looks like it is necessary to me.  Can we get
some movement on this?

 net/802/tr.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/802/tr.c b/net/802/tr.c
--- a/net/802/tr.c
+++ b/net/802/tr.c
@@ -251,10 +251,11 @@ void tr_source_route(struct sk_buff *skb
 	unsigned int hash;
 	struct rif_cache *entry;
 	unsigned char *olddata;
+	unsigned long flags;
 	static const unsigned char mcast_func_addr[] 
 		= {0xC0,0x00,0x00,0x04,0x00,0x00};
 	
-	spin_lock_bh(&rif_lock);
+	spin_lock_irqsave(&rif_lock, flags);
 
 	/*
 	 *	Broadcasts are single route as stated in RFC 1042 
@@ -323,7 +324,7 @@ printk("source routing for %02X:%02X:%02
 	else 
 		slack = 18 - ((ntohs(trh->rcf) & TR_RCF_LEN_MASK)>>8);
 	olddata = skb->data;
-	spin_unlock_bh(&rif_lock);
+	spin_unlock_irqrestore(&rif_lock, flags);
 
 	skb_pull(skb, slack);
 	memmove(skb->data, olddata, sizeof(struct trh_hdr) - slack);
@@ -337,10 +338,11 @@ printk("source routing for %02X:%02X:%02
 static void tr_add_rif_info(struct trh_hdr *trh, struct net_device *dev)
 {
 	unsigned int hash, rii_p = 0;
+	unsigned long flags;
 	struct rif_cache *entry;
 
 
-	spin_lock_bh(&rif_lock);
+	spin_lock_irqsave(&rif_lock, flags);
 	
 	/*
 	 *	Firstly see if the entry exists
@@ -378,7 +380,7 @@ printk("adding rif_entry: addr:%02X:%02X
 		if(!entry) 
 		{
 			printk(KERN_DEBUG "tr.c: Couldn't malloc rif cache entry !\n");
-			spin_unlock_bh(&rif_lock);
+			spin_unlock_irqrestore(&rif_lock, flags);
 			return;
 		}
 
@@ -420,7 +422,7 @@ printk("updating rif_entry: addr:%02X:%0
 		    }                                         
            	entry->last_used=jiffies;               
 	}
-	spin_unlock_bh(&rif_lock);
+	spin_unlock_irqrestore(&rif_lock, flags);
 }
 
 /*
@@ -430,9 +432,9 @@ printk("updating rif_entry: addr:%02X:%0
 static void rif_check_expire(unsigned long dummy) 
 {
 	int i;
-	unsigned long next_interval = jiffies + sysctl_tr_rif_timeout/2;
+	unsigned long flags, next_interval = jiffies + sysctl_tr_rif_timeout/2;
 
-	spin_lock_bh(&rif_lock);
+	spin_lock_irqsave(&rif_lock, flags);
 	
 	for(i =0; i < RIF_TABLE_SIZE; i++) {
 		struct rif_cache *entry, **pentry;
@@ -454,7 +456,7 @@ static void rif_check_expire(unsigned lo
 		}
 	}
 	
-	spin_unlock_bh(&rif_lock);
+	spin_unlock_irqrestore(&rif_lock, flags);
 
 	mod_timer(&rif_timer, next_interval);
 
@@ -485,7 +487,7 @@ static struct rif_cache *rif_get_idx(lof
 
 static void *rif_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	spin_lock_bh(&rif_lock);
+	spin_lock_irq(&rif_lock);
 
 	return *pos ? rif_get_idx(*pos - 1) : SEQ_START_TOKEN;
 }
@@ -516,7 +518,7 @@ static void *rif_seq_next(struct seq_fil
 
 static void rif_seq_stop(struct seq_file *seq, void *v)
 {
-	spin_unlock_bh(&rif_lock);
+	spin_unlock_irq(&rif_lock);
 }
 
 static int rif_seq_show(struct seq_file *seq, void *v)
