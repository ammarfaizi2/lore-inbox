Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLXAjz>; Sat, 23 Dec 2000 19:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129737AbQLXAjp>; Sat, 23 Dec 2000 19:39:45 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:25842 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S129458AbQLXAji>; Sat, 23 Dec 2000 19:39:38 -0500
Date: Sat, 23 Dec 2000 20:18:35 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.2: cs89x0, fix more kmallocs unchecked
Message-ID: <20001223201835.D6355@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
	
	I talked with Russell in private and this patch fixes some issues
with the previous one, included in 2.2.19-pre3, and it also checks for
another kmalloc result in init_module.

	Another question, by what I saw the HAVE_DEVLIST thing is not used
anymore (dunno if it ever was used), should we get rid of it in this and in
some other old drivers?

- Arnaldo

--- linux-2.2.19-3/drivers/net/cs89x0.c	Sat Dec 23 18:13:25 2000
+++ linux-2.2.19-3.acme/drivers/net/cs89x0.c	Sat Dec 23 20:08:24 2000
@@ -28,11 +28,12 @@
                     
   Alan Cox          : Removed 1.2 support, added 2.1 extra counters.
 
-  Arnaldo Melo	    : release resources on failure in cs89x0_probe1
+  Arnaldo Melo	    : release resources on failure in cs89x0_probe1 and
+  		      init_module
 */
 
 static char *version =
-"cs89x0.c:v1.03 11/26/96 Russell Nelson <nelson@crynwr.com>\n";
+"cs89x0.c:v1.04 11/26/96 Russell Nelson <nelson@crynwr.com>\n";
 
 /* ======================= configure the driver here ======================= */
 
@@ -251,7 +252,6 @@
 	struct net_local *lp;
 	static unsigned version_printed = 0;
 	int i;
-	char priv_alloced_here = 0;
 	unsigned rev_type = 0;
 	int eeprom_buff[CHKSUM_LEN];
 
@@ -261,7 +261,6 @@
 		if (!dev->priv)
 			return -ENOMEM;
                 memset(dev->priv, 0, sizeof(struct net_local));
-		priv_alloced_here = 1;
         }
 	lp = (struct net_local *)dev->priv;
 
@@ -394,10 +393,8 @@
 
 	printk("\n");
 	return 0;
-err:	if (priv_alloced_here) {
-		kfree(dev->priv);
-		dev->priv = NULL;
-	}
+err:	kfree(dev->priv);
+	dev->priv = NULL;
 	return -ENODEV;
 }
 
@@ -1053,6 +1050,7 @@
 init_module(void)
 {
 	struct net_local *lp;
+	int ret;
 
 	net_debug = debug;
         dev_cs89x0.name = namespace;
@@ -1060,6 +1058,8 @@
 	dev_cs89x0.base_addr = io;
         dev_cs89x0.init = cs89x0_probe;
         dev_cs89x0.priv = kmalloc(sizeof(struct net_local), GFP_KERNEL);
+	if (!dev_cs89x0.priv)
+		return -ENOMEM;
 	memset(dev_cs89x0.priv, 0, sizeof(struct net_local));
 	lp = (struct net_local *)dev_cs89x0.priv;
 
@@ -1076,16 +1076,21 @@
         if (duplex==-1)
 		lp->auto_neg_cnf = AUTO_NEG_ENABLE;
 
+	ret = -EPERM;
         if (io == 0)  {
                 printk(KERN_NOTICE "cs89x0.c: Module autoprobing not allowed.\n");
                 printk(KERN_NOTICE "cs89x0.c: Append io=0xNNN\n");
-                return -EPERM;
+		goto err;
         }
+	ret = -ENXIO;
         if (register_netdev(&dev_cs89x0) != 0) {
                 printk(KERN_WARNING "cs89x0.c: No card found at 0x%x\n", io);
-                return -ENXIO;
+		goto err;
         }
 	return 0;
+err:	kfree(dev_cs89x0.priv);
+	dev_cs89x0.priv = NULL;
+	return ret;
 }
 
 void
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
