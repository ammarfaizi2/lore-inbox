Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130685AbRAWPYo>; Tue, 23 Jan 2001 10:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130869AbRAWPYe>; Tue, 23 Jan 2001 10:24:34 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:21778 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S130685AbRAWPYY>;
	Tue, 23 Jan 2001 10:24:24 -0500
Message-ID: <3A6DA1F7.9169C3BD@mandrakesoft.com>
Date: Tue, 23 Jan 2001 10:23:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bart Dorsey <echo@thebucket.org>
CC: linux-kernel@vger.kernel.org, mid@auk.cx, phillim@amtrak.com,
        alan@redhat.com, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Re: Problem with Madge Tokenring (abyss.o) in 2.4.1-pre10
In-Reply-To: <Pine.LNX.4.21.0101230832550.25107-100000@www>
Content-Type: multipart/mixed;
 boundary="------------C870A6A1C9162BB41A2EFEFF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C870A6A1C9162BB41A2EFEFF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Bart Dorsey wrote:
> I constantly get this message on the console while using a Madge Smart
> 16/4 PCI Mk2 (Abyss) token ring card.
> 
> kernel: Warning: kfree_skb on hard IRQ d08cfea9

The attached patch, against 2.4.1-pre10, should fix things.  tms380tr,
the base module that abyss driver uses, needed to be updated to use
special IRQ versions of the dev_kfree_skb function.

Linus (and others), the patch also adds a missing dev->last_rx
assignment (which records the time of last packet reception).

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
--------------C870A6A1C9162BB41A2EFEFF
Content-Type: text/plain; charset=us-ascii;
 name="tms380tr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tms380tr.patch"

Index: linux_2_4/drivers/net/tokenring/tms380tr.c
diff -u linux_2_4/drivers/net/tokenring/tms380tr.c:1.1.1.3 linux_2_4/drivers/net/tokenring/tms380tr.c:1.1.1.3.76.2
--- linux_2_4/drivers/net/tokenring/tms380tr.c:1.1.1.3	Sun Oct 22 14:56:23 2000
+++ linux_2_4/drivers/net/tokenring/tms380tr.c	Tue Jan 23 07:19:16 2001
@@ -1977,7 +1977,7 @@
 
 		printk(KERN_INFO "Cancel tx (%08lXh).\n", (unsigned long)tpl);
 
-		dev_kfree_skb(tpl->Skb);
+		dev_kfree_skb_any(tpl->Skb);
 	}
 
 	for(;;)
@@ -1986,7 +1986,7 @@
 		if(skb == NULL)
 			break;
 		tp->QueueSkb++;
-		dev_kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 	}
 
 	return;
@@ -2053,7 +2053,7 @@
 		}
 
 		tp->MacStat.tx_packets++;
-		dev_kfree_skb(tpl->Skb);
+		dev_kfree_skb_irq(tpl->Skb);
 		tpl->BusyFlag = 0;	/* "free" TPL */
 	}
 
@@ -2127,7 +2127,7 @@
 				printk(KERN_INFO "%s: Received my own frame\n",
 					dev->name);
 				if(rpl->Skb != NULL)
-					dev_kfree_skb(rpl->Skb);
+					dev_kfree_skb_irq(rpl->Skb);
 			}
 			else
 #endif
@@ -2171,13 +2171,14 @@
 					skb_trim(skb,Length);
 					skb->protocol = tr_type_trans(skb,dev);
 					netif_rx(skb);
+					dev->last_rx = jiffies;
 				}
 			}
 		}
 		else	/* Invalid frame */
 		{
 			if(rpl->Skb != NULL)
-				dev_kfree_skb(rpl->Skb);
+				dev_kfree_skb_irq(rpl->Skb);
 
 			/* Skip list. */
 			if(rpl->Status & RX_START_FRAME)

--------------C870A6A1C9162BB41A2EFEFF--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
