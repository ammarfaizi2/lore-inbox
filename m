Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262320AbSJISaA>; Wed, 9 Oct 2002 14:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262332AbSJIS37>; Wed, 9 Oct 2002 14:29:59 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37125 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262320AbSJIS2Z>; Wed, 9 Oct 2002 14:28:25 -0400
Subject: PATCH: 3c501 for 2.5
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Wed, 9 Oct 2002 19:25:47 +0100 (BST)
Cc: jgarzik@redhat.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17zLWl-0006LL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not much here, just some tidying/checking. This driver can't alas use NAPI
in 2.5. Note however it has no panics or BUG()s so appears to meet the
carrier grade guidelines ;)

- Clarified authors so I get the mail not Donald
- Added missing MODULE_ bits
- Moved junk into 3c501.h


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/net/3c501.c linux.2.5.41-ac2/drivers/net/3c501.c
--- linux.2.5.41/drivers/net/3c501.c	2002-10-02 21:33:29.000000000 +0100
+++ linux.2.5.41-ac2/drivers/net/3c501.c	2002-10-09 18:51:11.000000000 +0100
@@ -11,12 +11,11 @@
     Do not purchase this card, even as a joke.  It's performance is horrible,
     and it breaks in many ways.
 
-    The author may be reached as becker@scyld.com, or C/O
+    The original author may be reached as becker@scyld.com, or C/O
 	Scyld Computing Corporation
 	410 Severn Ave., Suite 210
 	Annapolis MD 21403
 
-
     Fixed (again!) the missing interrupt locking on TX/RX shifting.
     		Alan Cox <Alan.Cox@linux.org>
 
@@ -34,7 +33,16 @@
     		
     Cleaned up for 2.3.x because we broke SMP now. 
     		20000208 Alan Cox <alan@redhat.com>
+
+    Check up pass for 2.5. Nothing significant changed
+    		20021009 Alan Cox <alan@redhat.com>
     		
+   For the avoidance of doubt the "preferred form" of this code is one which
+   is in an open non patent encumbered format. Where cryptographic key signing
+   forms part of the process of creating an executable the information
+   including keys needed to generate an equivalently functional executable
+   are deemed to be part of the source code.
+
 */
 
 
@@ -88,7 +96,7 @@
  */
 
 #define DRV_NAME	"3c501"
-#define DRV_VERSION	"2001/11/17"
+#define DRV_VERSION	"2002/10/09"
 
 
 static const char version[] =
@@ -122,113 +130,21 @@
 #include <linux/skbuff.h>
 #include <linux/init.h>
 
+#include "3c501.h"
+
 /* A zero-terminated list of I/O addresses to be probed.
    The 3c501 can be at many locations, but here are the popular ones. */
 static unsigned int netcard_portlist[] __initdata = { 
 	0x280, 0x300, 0
 };
 
-
-/*
- *	Index to functions.
- */
-
-int el1_probe(struct net_device *dev);
-static int  el1_probe1(struct net_device *dev, int ioaddr);
-static int  el_open(struct net_device *dev);
-static void el_timeout(struct net_device *dev);
-static int  el_start_xmit(struct sk_buff *skb, struct net_device *dev);
-static void el_interrupt(int irq, void *dev_id, struct pt_regs *regs);
-static void el_receive(struct net_device *dev);
-static void el_reset(struct net_device *dev);
-static int  el1_close(struct net_device *dev);
-static struct net_device_stats *el1_get_stats(struct net_device *dev);
-static void set_multicast_list(struct net_device *dev);
-static int netdev_ioctl (struct net_device *dev, struct ifreq *rq, int cmd);
-
-#define EL1_IO_EXTENT	16
-
-#ifndef EL_DEBUG
-#define EL_DEBUG  0	/* use 0 for production, 1 for devel., >2 for debug */
-#endif			/* Anything above 5 is wordy death! */
-#define debug el_debug
-static int el_debug = EL_DEBUG;
-
-/*
- *	Board-specific info in dev->priv.
- */
-
-struct net_local
-{
-	struct net_device_stats stats;
-	int		tx_pkt_start;	/* The length of the current Tx packet. */
-	int		collisions;	/* Tx collisions this packet */
-	int		loading;	/* Spot buffer load collisions */
-	int		txing;		/* True if card is in TX mode */
-	spinlock_t	lock;		/* Serializing lock */
-};
-
-
-#define RX_STATUS (ioaddr + 0x06)
-#define RX_CMD	  RX_STATUS
-#define TX_STATUS (ioaddr + 0x07)
-#define TX_CMD	  TX_STATUS
-#define GP_LOW 	  (ioaddr + 0x08)
-#define GP_HIGH   (ioaddr + 0x09)
-#define RX_BUF_CLR (ioaddr + 0x0A)
-#define RX_LOW	  (ioaddr + 0x0A)
-#define RX_HIGH   (ioaddr + 0x0B)
-#define SAPROM	  (ioaddr + 0x0C)
-#define AX_STATUS (ioaddr + 0x0E)
-#define AX_CMD	  AX_STATUS
-#define DATAPORT  (ioaddr + 0x0F)
-#define TX_RDY 0x08		/* In TX_STATUS */
-
-#define EL1_DATAPTR	0x08
-#define EL1_RXPTR	0x0A
-#define EL1_SAPROM	0x0C
-#define EL1_DATAPORT 	0x0f
-
-/*
- *	Writes to the ax command register.
- */
-
-#define AX_OFF	0x00			/* Irq off, buffer access on */
-#define AX_SYS  0x40			/* Load the buffer */
-#define AX_XMIT 0x44			/* Transmit a packet */
-#define AX_RX	0x48			/* Receive a packet */
-#define AX_LOOP	0x0C			/* Loopback mode */
-#define AX_RESET 0x80
-
-/*
- *	Normal receive mode written to RX_STATUS.  We must intr on short packets
- *	to avoid bogus rx lockups.
- */
-
-#define RX_NORM 0xA8		/* 0x68 == all addrs, 0xA8 only to me. */
-#define RX_PROM 0x68		/* Senior Prom, uhmm promiscuous mode. */
-#define RX_MULT 0xE8		/* Accept multicast packets. */
-#define TX_NORM 0x0A		/* Interrupt on everything that might hang the chip */
-
-/*
- *	TX_STATUS register.
- */
-
-#define TX_COLLISION 0x02
-#define TX_16COLLISIONS 0x04
-#define TX_READY 0x08
-
-#define RX_RUNT 0x08
-#define RX_MISSED 0x01		/* Missed a packet due to 3c501 braindamage. */
-#define RX_GOOD	0x30		/* Good packet 0x20, or simple overflow 0x10. */
-
 
 /*
  *	The boilerplate probe code.
  */
 
 /**
- * el1_probe:
+ * el1_probe:		-	probe for a 3c501
  * @dev: The device structure passed in to probe. 
  *
  * This can be called from two places. The network layer will probe using
@@ -556,7 +472,6 @@
 	while(1);
 
 }
-
 
 /**
  * el_interrupt:
@@ -1072,12 +987,8 @@
 }
 
 #endif /* MODULE */
+
+MODULE_AUTHOR("Donald Becker, Alan Cox");
+MODULE_DESCRIPTION("Support for the ancient 3Com 3c501 ethernet card");
 MODULE_LICENSE("GPL");
 
-
-/*
- * Local variables:
- *  compile-command: "gcc -D__KERNEL__ -Wall -Wstrict-prototypes -O6 -fomit-frame-pointer  -m486 -c -o 3c501.o 3c501.c"
- *  kept-new-versions: 5
- * End:
- */
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.2.5.41/drivers/net/3c501.h linux.2.5.41-ac2/drivers/net/3c501.h
--- linux.2.5.41/drivers/net/3c501.h	1970-01-01 01:00:00.000000000 +0100
+++ linux.2.5.41-ac2/drivers/net/3c501.h	2002-10-09 18:48:40.000000000 +0100
@@ -0,0 +1,94 @@
+
+/*
+ *	Index to functions.
+ */
+
+int el1_probe(struct net_device *dev);
+static int  el1_probe1(struct net_device *dev, int ioaddr);
+static int  el_open(struct net_device *dev);
+static void el_timeout(struct net_device *dev);
+static int  el_start_xmit(struct sk_buff *skb, struct net_device *dev);
+static void el_interrupt(int irq, void *dev_id, struct pt_regs *regs);
+static void el_receive(struct net_device *dev);
+static void el_reset(struct net_device *dev);
+static int  el1_close(struct net_device *dev);
+static struct net_device_stats *el1_get_stats(struct net_device *dev);
+static void set_multicast_list(struct net_device *dev);
+static int netdev_ioctl (struct net_device *dev, struct ifreq *rq, int cmd);
+
+#define EL1_IO_EXTENT	16
+
+#ifndef EL_DEBUG
+#define EL_DEBUG  0	/* use 0 for production, 1 for devel., >2 for debug */
+#endif			/* Anything above 5 is wordy death! */
+#define debug el_debug
+static int el_debug = EL_DEBUG;
+
+/*
+ *	Board-specific info in dev->priv.
+ */
+
+struct net_local
+{
+	struct net_device_stats stats;
+	int		tx_pkt_start;	/* The length of the current Tx packet. */
+	int		collisions;	/* Tx collisions this packet */
+	int		loading;	/* Spot buffer load collisions */
+	int		txing;		/* True if card is in TX mode */
+	spinlock_t	lock;		/* Serializing lock */
+};
+
+
+#define RX_STATUS (ioaddr + 0x06)
+#define RX_CMD	  RX_STATUS
+#define TX_STATUS (ioaddr + 0x07)
+#define TX_CMD	  TX_STATUS
+#define GP_LOW 	  (ioaddr + 0x08)
+#define GP_HIGH   (ioaddr + 0x09)
+#define RX_BUF_CLR (ioaddr + 0x0A)
+#define RX_LOW	  (ioaddr + 0x0A)
+#define RX_HIGH   (ioaddr + 0x0B)
+#define SAPROM	  (ioaddr + 0x0C)
+#define AX_STATUS (ioaddr + 0x0E)
+#define AX_CMD	  AX_STATUS
+#define DATAPORT  (ioaddr + 0x0F)
+#define TX_RDY 0x08		/* In TX_STATUS */
+
+#define EL1_DATAPTR	0x08
+#define EL1_RXPTR	0x0A
+#define EL1_SAPROM	0x0C
+#define EL1_DATAPORT 	0x0f
+
+/*
+ *	Writes to the ax command register.
+ */
+
+#define AX_OFF	0x00			/* Irq off, buffer access on */
+#define AX_SYS  0x40			/* Load the buffer */
+#define AX_XMIT 0x44			/* Transmit a packet */
+#define AX_RX	0x48			/* Receive a packet */
+#define AX_LOOP	0x0C			/* Loopback mode */
+#define AX_RESET 0x80
+
+/*
+ *	Normal receive mode written to RX_STATUS.  We must intr on short packets
+ *	to avoid bogus rx lockups.
+ */
+
+#define RX_NORM 0xA8		/* 0x68 == all addrs, 0xA8 only to me. */
+#define RX_PROM 0x68		/* Senior Prom, uhmm promiscuous mode. */
+#define RX_MULT 0xE8		/* Accept multicast packets. */
+#define TX_NORM 0x0A		/* Interrupt on everything that might hang the chip */
+
+/*
+ *	TX_STATUS register.
+ */
+
+#define TX_COLLISION 0x02
+#define TX_16COLLISIONS 0x04
+#define TX_READY 0x08
+
+#define RX_RUNT 0x08
+#define RX_MISSED 0x01		/* Missed a packet due to 3c501 braindamage. */
+#define RX_GOOD	0x30		/* Good packet 0x20, or simple overflow 0x10. */
+


