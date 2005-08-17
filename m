Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751257AbVHQVsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVHQVsa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 17:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVHQVsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 17:48:30 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:56256 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751242AbVHQVs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 17:48:29 -0400
Message-Id: <200508172148.j7HLmPAt005857@death.nxdomain.ibm.com>
To: netdev@vger.kernel.org, linux-tr@linuxtr.net, mikep@linuxtr.net,
       jgarzik@pobox.com, davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-rc6] net/802/tr: use interrupt-safe locking 
In-Reply-To: Message from "John W. Linville" <linville@tuxdriver.com> 
   of "Wed, 17 Aug 2005 16:49:59 EDT." <20050817204959.GA20186@tuxdriver.com> 
X-Mailer: MH-E 7.83; nmh 1.0.4; GNU Emacs 21.4.2
Date: Wed, 17 Aug 2005 14:48:25 -0700
From: Jay Vosburgh <fubar@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John W. Linville <linville@tuxdriver.com> wrote:

>Change operations on rif_lock from spin_{un}lock_bh to
>spin_{un}lock_irq{save,restore} equivalents.  Some of the
>rif_lock critical sections are called from interrupt context via
>tr_type_trans->tr_add_rif_info.  The TR NIC drivers call tr_type_trans
>from their packet receive handlers.
>
>Signed-off-by: Jay Vosburg <foobar@us.ibm.com>

	Pretty close.

Signed-off-by: Jay Vosburgh <fubar@us.ibm.com>

>It is my understanding that this same patch has been submitted multiple
>times in the past.  Some of those submissions were around a year ago,
>but it does not seem to have been committed.
	
	I believe that I originally wrote and posted this patch in the
appended message; I recall posting it a few times in various places.

>FWIW, this patch is currently being carried in the Fedora and RHEL
>kernels.  It certainly looks like it is necessary to me.  Can we get
>some movement on this?

	It's in the SuSE kernel as well.

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com


To: Paul Mackerras <paulus@samba.org>
Cc: linux-tr@linuxtr.net, netdev@oss.sgi.com
Subject: Re: spin_lock_bh() called in irq handler 
Date: Wed, 28 Apr 2004 10:55:33 -0700
From: Jay Vosburgh <fubar@us.ibm.com>


>I had a look and found that all of the token-ring drivers call
>tr_type_trans() at interrupt level.  That seems perfectly reasonable
>to me.  To fix the bug, it seems to me that there are two options:
>either move the tr_add_rif_info() call elsewhere (but I have no idea
>where) or else use spin_lock_irqsave instead of spin_lock_bh.
>
>Which is the more appropriate fix?

	I'm guessing spin_lock_irqsave; would the following be
appropriate?  I'm not absolutely sure about using spin_(un)lock_irq in
rif_seq_start/stop, but it'd be complicated to deal with the flags in
that case.

	I've built this and given it some basic testing, but not really
hammered on it.  The system doesn't panic when I cat /proc/net/tr_rif,
which is a good sign.

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com


diff -urN linux-2.6.5-orig/net/802/tr.c linux-2.6.5/net/802/tr.c
--- linux-2.6.5-orig/net/802/tr.c	2004-04-28 10:02:12.000000000 -0700
+++ linux-2.6.5/net/802/tr.c	2004-04-28 10:15:47.000000000 -0700
@@ -250,10 +250,11 @@
 	unsigned int hash;
 	struct rif_cache_s *entry;
 	unsigned char *olddata;
+	unsigned long flags;
 	static const unsigned char mcast_func_addr[] 
 		= {0xC0,0x00,0x00,0x04,0x00,0x00};
 	
-	spin_lock_bh(&rif_lock);
+	spin_lock_irqsave(&rif_lock, flags);
 
 	/*
 	 *	Broadcasts are single route as stated in RFC 1042 
@@ -322,7 +323,7 @@
 	else 
 		slack = 18 - ((ntohs(trh->rcf) & TR_RCF_LEN_MASK)>>8);
 	olddata = skb->data;
-	spin_unlock_bh(&rif_lock);
+	spin_unlock_irqrestore(&rif_lock, flags);
 
 	skb_pull(skb, slack);
 	memmove(skb->data, olddata, sizeof(struct trh_hdr) - slack);
@@ -336,10 +337,11 @@
 static void tr_add_rif_info(struct trh_hdr *trh, struct net_device *dev)
 {
 	unsigned int hash, rii_p = 0;
+	unsigned long flags;
 	struct rif_cache_s *entry;
 
 
-	spin_lock_bh(&rif_lock);
+	spin_lock_irqsave(&rif_lock, flags);
 	
 	/*
 	 *	Firstly see if the entry exists
@@ -377,7 +379,7 @@
 		if(!entry) 
 		{
 			printk(KERN_DEBUG "tr.c: Couldn't malloc rif cache entry !\n");
-			spin_unlock_bh(&rif_lock);
+			spin_unlock_irqrestore(&rif_lock, flags);
 			return;
 		}
 
@@ -419,7 +421,7 @@
 		    }                                         
            	entry->last_used=jiffies;               
 	}
-	spin_unlock_bh(&rif_lock);
+	spin_unlock_irqrestore(&rif_lock, flags);
 }
 
 /*
@@ -429,9 +431,9 @@
 static void rif_check_expire(unsigned long dummy) 
 {
 	int i;
-	unsigned long next_interval = jiffies + sysctl_tr_rif_timeout/2;
+	unsigned long flags, next_interval = jiffies + sysctl_tr_rif_timeout/2;
 
-	spin_lock_bh(&rif_lock);
+	spin_lock_irqsave(&rif_lock, flags);
 	
 	for(i =0; i < RIF_TABLE_SIZE; i++) {
 		struct rif_cache_s *entry, **pentry;
@@ -453,7 +455,7 @@
 		}
 	}
 	
-	spin_unlock_bh(&rif_lock);
+	spin_unlock_irqrestore(&rif_lock, flags);
 
 	mod_timer(&rif_timer, next_interval);
 
@@ -484,7 +486,7 @@
 
 static void *rif_seq_start(struct seq_file *seq, loff_t *pos)
 {
-	spin_lock_bh(&rif_lock);
+	spin_lock_irq(&rif_lock);
 
 	return *pos ? rif_get_idx(*pos - 1) : SEQ_START_TOKEN;
 }
@@ -515,7 +517,7 @@
 
 static void rif_seq_stop(struct seq_file *seq, void *v)
 {
-	spin_unlock_bh(&rif_lock);
+	spin_unlock_irq(&rif_lock);
 }
 
 static int rif_seq_show(struct seq_file *seq, void *v)




	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com

