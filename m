Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbSL3CHM>; Sun, 29 Dec 2002 21:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265894AbSL3CHL>; Sun, 29 Dec 2002 21:07:11 -0500
Received: from msg.vodafone.pt ([212.18.167.162]:5763 "EHLO msg.vodafone.pt")
	by vger.kernel.org with ESMTP id <S265890AbSL3CG6>;
	Sun, 29 Dec 2002 21:06:58 -0500
Date: Sun, 29 Dec 2002 22:29:10 +0000
From: "Paulo Andre'" <fscked@netvisao.pt>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.53 : drivers/net/wan/sdla.c locking fixes
Message-Id: <20021229222910.1eba9bea.fscked@netvisao.pt>
Organization: Orion Enterprises
X-Mailer: Sylpheed version 0.8.6claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2002 02:14:34.0006 (UTC) FILETIME=[31D34B60:01C2AFA9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the sdla.c wan driver use spinlocks instead of the deprecated
save_flags/cli/restore_flags.

Please review.

---

--- sdla.c.orig	2002-12-29 20:35:44.000000000 +0000
+++ sdla.c	2002-12-29 20:38:33.000000000 +0000
@@ -51,6 +51,7 @@
 #include <linux/if_arp.h>
 #include <linux/if_frad.h>
 #include <linux/sdla.h>
+#include <linux/spinlock.h>
 
 #include <asm/system.h>
 #include <asm/bitops.h>
@@ -58,6 +59,8 @@
 #include <asm/dma.h>
 #include <asm/uaccess.h>
 
+static spinlock_t sdla_lock = SPIN_LOCK_UNLOCKED;
+
 static const char* version = "SDLA driver v0.30, 12 Sep 1996,
mike.mclagan@linux.org"; 
 static const char* devname = "sdla";
@@ -92,12 +95,11 @@
 		bytes = offset + len > SDLA_WINDOW_SIZE ? SDLA_WINDOW_SIZE - offset :
len; 		base = (void *) (dev->mem_start + offset);
 
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&sdla_lock, flags);
 		SDLA_WINDOW(dev, addr);
 		memcpy(temp, base, bytes);
-		restore_flags(flags);
-
+		spin_unlock_irqrestore(&sdla_lock, flags);
+		
 		addr += bytes;
 		temp += bytes;
 		len  -= bytes;
@@ -116,11 +118,10 @@
 		offset = addr & SDLA_ADDR_MASK;
 		bytes = offset + len > SDLA_WINDOW_SIZE ? SDLA_WINDOW_SIZE - offset :
len; 		base = (void *) (dev->mem_start + offset);
-		save_flags(flags);
-		cli();
+		spin_lock_irqsave(&sdla_lock, flags);
 		SDLA_WINDOW(dev, addr);
 		memcpy(base, temp, bytes);
-		restore_flags(flags);
+		spin_unlock_irqrestore(&sdla_lock, flags);
 		addr += bytes;
 		temp += bytes;
 		len  -= bytes;
@@ -138,8 +139,7 @@
 	bytes = SDLA_WINDOW_SIZE;
 	base = (void *) dev->mem_start;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&sdla_lock, flags);
 	while(len)
 	{
 		SDLA_WINDOW(dev, addr);
@@ -148,7 +148,7 @@
 		addr += bytes;
 		len  -= bytes;
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&sdla_lock, flags);
 }
 
 static char sdla_byte(struct net_device *dev, int addr)
@@ -158,12 +158,11 @@
 
 	temp = (void *) (dev->mem_start + (addr & SDLA_ADDR_MASK));
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&sdla_lock, flags);
 	SDLA_WINDOW(dev, addr);
 	byte = *temp;
-	restore_flags(flags);
-
+	spin_unlock_irqrestore(&sdla_lock, flags);
+	
 	return(byte);
 }
 
@@ -423,8 +422,7 @@
 	ret = 0;
 	len = 0;
 	jiffs = jiffies + HZ;  /* 1 second is plenty */
-	save_flags(pflags);
-	cli();
+	spin_lock_irqsave(&sdla_lock, pflags);
 	SDLA_WINDOW(dev, window);
 	cmd_buf->cmd = cmd;
 	cmd_buf->dlci = dlci;
@@ -436,7 +434,7 @@
 	cmd_buf->length = inlen;
 
 	cmd_buf->opp_flag = 1;
-	restore_flags(pflags);
+	spin_unlock_irqrestore(&sdla_lock, pflags);
 
 	waiting = 1;
 	len = 0;
@@ -444,18 +442,16 @@
 	{
 		if (waiting++ % 3) 
 		{
-			save_flags(pflags);
-			cli();
+			spin_lock_irqsave(&sdla_lock, pflags);
 			SDLA_WINDOW(dev, window);
 			waiting = ((volatile int)(cmd_buf->opp_flag));
-			restore_flags(pflags);
+			spin_unlock_irqrestore(&sdla_lock, pflags);
 		}
 	}
 	
 	if (!waiting)
 	{
-		save_flags(pflags);
-		cli();
+		spin_lock_irqsave(&sdla_lock, pflags);
 		SDLA_WINDOW(dev, window);
 		ret = cmd_buf->retval;
 		len = cmd_buf->length;
@@ -471,7 +467,7 @@
 		if (ret)
 			memcpy(&status, cmd_buf->data, len > sizeof(status) ?
sizeof(status) : len); 
-		restore_flags(pflags);
+		spin_unlock_irqrestore(&sdla_lock, pflags);
 	}
 	else
 		ret = SDLA_RET_TIMEOUT;
@@ -688,14 +684,13 @@
 				ret = sdla_cmd(dev, SDLA_INFORMATION_WRITE, *(short
*)(skb->dev->dev_addr), 0, NULL, skb->len, &addr, &size); 				if (ret
== SDLA_RET_OK) 				{
-					save_flags(flags); 
-					cli();
+					spin_lock_irqsave(&sdla_lock, flags);
 					SDLA_WINDOW(dev, addr);
 					pbuf = (void *)(((int) dev->mem_start) + (addr &
SDLA_ADDR_MASK)); 						sdla_write(dev, pbuf->buf_addr,
skb->data, skb->len); 						SDLA_WINDOW(dev, addr);
 					pbuf->opp_flag = 1;
-					restore_flags(flags);
+					spin_unlock_irqrestore(&sdla_lock, flags);
 				}
 				break;
 		}
@@ -753,8 +748,7 @@
 	pbufi = NULL;
 	pbuf = NULL;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&sdla_lock, flags);
 
 	switch (flp->type)
 	{
@@ -853,7 +847,7 @@
 		(*dlp->receive)(skb, master);
 	}
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&sdla_lock, flags);
 }
 
 static void sdla_isr(int irq, void *dev_id, struct pt_regs * regs)
