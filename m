Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132604AbQLHVbo>; Fri, 8 Dec 2000 16:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132950AbQLHVbf>; Fri, 8 Dec 2000 16:31:35 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:57197
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132604AbQLHVbE>; Fri, 8 Dec 2000 16:31:04 -0500
Date: Fri, 8 Dec 2000 22:00:30 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: dagb@brattli.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove warning from drivers/net/irda/w83977af_ir.c
Message-ID: <20001208220030.K599@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes a 'defined but not used' warning go
away when compiling drivers/net/irda/w83977af_ir.c without
modular support (kernel 240t12p7). It also removes some unneeded
zero initializations.


--- linux-240-t12-pre7-clean/drivers/net/irda/w83977af_ir.c	Wed Nov 22 22:41:40 2000
+++ linux/drivers/net/irda/w83977af_ir.c	Fri Dec  8 21:57:06 2000
@@ -77,20 +77,23 @@
 
 static unsigned int io[] = { 0x180, ~0, ~0, ~0 };
 #ifdef CONFIG_ARCH_NETWINDER             /* Adjust to NetWinder differences */
-static unsigned int irq[] = { 6, 0, 0, 0 };
+static unsigned int irq[4] = { 6, };
 #else
-static unsigned int irq[] = { 11, 0, 0, 0 };
+static unsigned int irq[4] = { 11, };
 #endif
-static unsigned int dma[] = { 1, 0, 0, 0 };
+static unsigned int dma[4] = { 1, };
 static unsigned int efbase[] = { W977_EFIO_BASE, W977_EFIO2_BASE };
 static unsigned int efio = W977_EFIO_BASE;
 
-static struct w83977af_ir *dev_self[] = { NULL, NULL, NULL, NULL};
+static struct w83977af_ir *dev_self[];
 
 /* Some prototypes */
+#ifdef MODULE
+static int  w83977af_close(struct w83977af_ir *self);
+#endif
+
 static int  w83977af_open(int i, unsigned int iobase, unsigned int irq, 
                           unsigned int dma);
-static int  w83977af_close(struct w83977af_ir *self);
 static int  w83977af_probe(int iobase, int irq, int dma);
 static int  w83977af_dma_receive(struct w83977af_ir *self); 
 static int  w83977af_dma_receive_complete(struct w83977af_ir *self);
@@ -147,6 +150,56 @@
 			w83977af_close(dev_self[i]);
 	}
 }
+
+/*
+ * Function w83977af_close (self)
+ *
+ *    Close driver instance
+ *
+ */
+static int w83977af_close(struct w83977af_ir *self)
+{
+	int iobase;
+
+	IRDA_DEBUG(0, __FUNCTION__ "()\n");
+
+        iobase = self->io.fir_base;
+
+#ifdef CONFIG_USE_W977_PNP
+	/* enter PnP configuration mode */
+	w977_efm_enter(efio);
+
+	w977_select_device(W977_DEVICE_IR, efio);
+
+	/* Deactivate device */
+	w977_write_reg(0x30, 0x00, efio);
+
+	w977_efm_exit(efio);
+#endif /* CONFIG_USE_W977_PNP */
+
+	/* Remove netdevice */
+	if (self->netdev) {
+		rtnl_lock();
+		unregister_netdevice(self->netdev);
+		rtnl_unlock();
+	}
+
+	/* Release the PORT that this driver is using */
+	IRDA_DEBUG(0 , __FUNCTION__ "(), Releasing Region %03x\n", 
+	      self->io.fir_base);
+	release_region(self->io.fir_base, self->io.fir_ext);
+
+	if (self->tx_buff.head)
+		kfree(self->tx_buff.head);
+	
+	if (self->rx_buff.head)
+		kfree(self->rx_buff.head);
+
+	kfree(self);
+
+	return 0;
+}
+
 #endif /* MODULE */
 
 /*
@@ -263,55 +316,6 @@
 	}
 	MESSAGE("IrDA: Registered device %s\n", dev->name);
 	
-	return 0;
-}
-
-/*
- * Function w83977af_close (self)
- *
- *    Close driver instance
- *
- */
-static int w83977af_close(struct w83977af_ir *self)
-{
-	int iobase;
-
-	IRDA_DEBUG(0, __FUNCTION__ "()\n");
-
-        iobase = self->io.fir_base;
-
-#ifdef CONFIG_USE_W977_PNP
-	/* enter PnP configuration mode */
-	w977_efm_enter(efio);
-
-	w977_select_device(W977_DEVICE_IR, efio);
-
-	/* Deactivate device */
-	w977_write_reg(0x30, 0x00, efio);
-
-	w977_efm_exit(efio);
-#endif /* CONFIG_USE_W977_PNP */
-
-	/* Remove netdevice */
-	if (self->netdev) {
-		rtnl_lock();
-		unregister_netdevice(self->netdev);
-		rtnl_unlock();
-	}
-
-	/* Release the PORT that this driver is using */
-	IRDA_DEBUG(0 , __FUNCTION__ "(), Releasing Region %03x\n", 
-	      self->io.fir_base);
-	release_region(self->io.fir_base, self->io.fir_ext);
-
-	if (self->tx_buff.head)
-		kfree(self->tx_buff.head);
-	
-	if (self->rx_buff.head)
-		kfree(self->rx_buff.head);
-
-	kfree(self);
-
 	return 0;
 }
 
 


-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

A chicken and an egg are lying in bed. The chicken is smoking a
cigarette with a satisfied smile on it's face and the egg is frowning
and looking a bit pissed off. The egg mutters, to no-one in particular,
"Well, I guess we answered THAT question..."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
