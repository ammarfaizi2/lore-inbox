Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130021AbQLTBB3>; Tue, 19 Dec 2000 20:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130380AbQLTBBT>; Tue, 19 Dec 2000 20:01:19 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:25084 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S130021AbQLTBBH>; Tue, 19 Dec 2000 20:01:07 -0500
Date: Tue, 19 Dec 2000 20:39:26 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Russell Nelson <nelson@crynwr.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.2 - cs89x0 - unchecked kmalloc
Message-ID: <20001219203926.M764@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Russell Nelson <nelson@crynwr.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please consider applying


                        - Arnaldo

--- linux-2.2.19-2/drivers/net/cs89x0.c	Mon Aug  9 16:05:05 1999
+++ linux-2.2.19-2.acme/drivers/net/cs89x0.c	Tue Dec 19 20:25:12 2000
@@ -27,6 +27,8 @@
                     : is running from all accounts.
                     
   Alan Cox          : Removed 1.2 support, added 2.1 extra counters.
+
+  Arnaldo Melo	    : release resources on failure in cs89x0_probe1
 */
 
 static char *version =
@@ -249,13 +251,17 @@
 	struct net_local *lp;
 	static unsigned version_printed = 0;
 	int i;
+	char priv_alloced_here = 0;
 	unsigned rev_type = 0;
 	int eeprom_buff[CHKSUM_LEN];
 
 	/* Initialize the device structure. */
 	if (dev->priv == NULL) {
 		dev->priv = kmalloc(sizeof(struct net_local), GFP_KERNEL);
+		if (!dev->priv)
+			return -ENOMEM;
                 memset(dev->priv, 0, sizeof(struct net_local));
+		priv_alloced_here = 1;
         }
 	lp = (struct net_local *)dev->priv;
 
@@ -265,12 +271,12 @@
 	if (ioaddr & 1) {
 		ioaddr &= ~1;
 		if ((inw(ioaddr + ADD_PORT) & ADD_MASK) != ADD_SIG)
-			return ENODEV;
+			goto err;
 		outw(PP_ChipID, ioaddr + ADD_PORT);
 	}
 
 	if (inw(ioaddr + DATA_PORT) != CHIP_EISA_ID_SIG)
-		return ENODEV;
+		goto err;
 
 	/* Fill in the 'dev' fields. */
 	dev->base_addr = ioaddr;
@@ -388,6 +394,11 @@
 
 	printk("\n");
 	return 0;
+err:	if (priv_alloced_here) {
+		kfree(dev->priv);
+		dev->priv = NULL;
+	}
+	return -ENODEV;
 }
 
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
