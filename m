Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136019AbRAHXuu>; Mon, 8 Jan 2001 18:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129805AbRAHXul>; Mon, 8 Jan 2001 18:50:41 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:43003 "HELO
	brinquedo.distro.conectiva") by vger.kernel.org with SMTP
	id <S136019AbRAHXu2>; Mon, 8 Jan 2001 18:50:28 -0500
Date: Mon, 8 Jan 2001 20:02:31 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] bmac.c: restore_flags on failure
Message-ID: <20010108200231.C17087@conectiva.com.br>
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

	I haven't found Randy Gobbel's e-mail, please apply.

- Arnaldo

--- linux-2.4.0-ac3/drivers/net/bmac.c	Tue Dec 19 11:24:51 2000
+++ linux-2.4.0-ac3.acme/drivers/net/bmac.c	Mon Jan  8 19:55:30 2001
@@ -6,6 +6,8 @@
  *
  * May 1999, Al Viro: proper release of /proc/net/bmac entry, switched to
  * dynamic procfs inode.
+ * Jan 2001, Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ * 		restore_flags on failure in bmac_reset_and_enable
  */
 #include <linux/config.h>
 #include <linux/module.h>
@@ -1227,9 +1229,9 @@
 	bmac_reset_chip(dev);
 	if (enable) {
 		if (!bmac_init_tx_ring(bp) || !bmac_init_rx_ring(bp))
-			return 0;
+			goto out;
 		if (!bmac_init_chip(dev))
-			return 0;
+			goto out;
 		bmac_start_chip(dev);
 		bmwrite(dev, INTDISABLE, EnableNormal);
 		bp->reset_and_enabled = 1;
@@ -1247,6 +1249,8 @@
 	}
 	restore_flags(flags);
 	return 1;
+out:	restore_flags(flags);
+	return 0;
 }
 
 static int __init bmac_probe(void)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
