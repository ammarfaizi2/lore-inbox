Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129211AbRBST23>; Mon, 19 Feb 2001 14:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129322AbRBST2T>; Mon, 19 Feb 2001 14:28:19 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:29358 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129134AbRBST2O>; Mon, 19 Feb 2001 14:28:14 -0500
Date: Mon, 19 Feb 2001 14:28:09 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: alan@redhat.com
Subject: [PATCH] change awe_wave initialization to match 2.2 better
Message-ID: <20010219142809.E5296@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, alan@redhat.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The awe_wave driver in 2.2 looked at the common I/O ports for
the card if no parameters were specified. The 2.4 driver currently
does an ISAPnP probe, but doesn't fall back to the previous probing
behavior, which means that users with working module configurations
will have theirs broken on upgrade.

The attached fixes it to fall back to 2.2-style behavior if no
parameters are specified; if 'isapnp=1' is specified, it does
not try to look for cards if the ISAPnP probe fails.

Bill

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.1-awe-isapnp.patch"

--- linux/drivers/sound/awe_wave.c.foo	Mon Feb 19 14:05:47 2001
+++ linux/drivers/sound/awe_wave.c	Mon Feb 19 14:06:51 2001
@@ -206,7 +206,7 @@
 int io = AWE_DEFAULT_BASE_ADDR; /* Emu8000 base address */
 int memsize = AWE_DEFAULT_MEM_SIZE; /* memory size in Kbytes */
 #if defined CONFIG_ISAPNP || defined CONFIG_ISAPNP_MODULE
-static int isapnp = 1;
+static int isapnp = -1;
 #else
 static int isapnp = 0;
 #endif
@@ -4838,10 +4838,12 @@
 	if (isapnp) {
 		if (awe_probe_isapnp(&io) < 0) {
 			printk(KERN_ERR "AWE32: No ISAPnP cards found\n");
-			return 0;
+			if (isapnp != -1)
+			  return 0;
+		} else {
+			setup_ports(io, 0, 0);
+			return 1;
 		}
-		setup_ports(io, 0, 0);
-		return 1;
 	}
 #endif /* isapnp */
 

--ReaqsoxgOBHFXBhH--
