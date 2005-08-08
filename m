Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbVHHNF2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbVHHNF2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 09:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbVHHNF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 09:05:28 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:386 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750857AbVHHNF1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 09:05:27 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.13-rc6] Fix handling in parport_pc init code
Date: Mon, 8 Aug 2005 15:05:15 +0200
User-Agent: KMail/1.8.1
Cc: linux-parport@lists.infradead.org, Phil Blundell <philb@gnu.org>,
       Tim Waugh <tim@cyberelk.demon.co.uk>, Jose Renau <renau@acm.org>,
       David Campbell <campbell@torque.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508081505.17664@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

parport_pc_find_ports():

	r = pci_register_driver (&parport_pc_pci_driver);
	if (r)
		return r;

The only caller of parport_pc_find_ports() is parport_pc_init(), which has:

		count += parport_pc_find_ports (irqval[0], dmaval[0]);

	return 0;

This assignment is totally useless as count is local and never used again. Bad 
thing is that module_init succeeds but something really bad had happened to 
pci_register_driver() before (e.g. ENOMEM or something).

Also module_init does not fail if pnp_register_driver() fails. And the return 
code of pnp_register_driver() can never be >0, if there are initial matches 0 
is returned.

Why is parport_pc_find_isa_ports() marked as ((unused)) when it is used by 
asm/parport.h? Shouldn't this be ((used)) to tell the compiler that this static 
function has references to it that he might not see? I left this the way it is 
if there is some magic I missed.

The return code of this function is of no interest, I did not touch it for now 
because I don't wanted to change all the header files, I just changed it to 
always return 0.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.13-rc3/drivers/parport/parport_pc.c	2005-07-13 06:46:46.000000000 +0200
+++ linux-2.6.13-rc6/drivers/parport/parport_pc.c	2005-08-08 14:59:50.000000000 +0200
@@ -3096,16 +3096,11 @@ static struct pnp_driver parport_pc_pnp_
 static int __devinit __attribute__((unused))
 parport_pc_find_isa_ports (int autoirq, int autodma)
 {
-	int count = 0;
+	parport_pc_probe_port(0x3bc, 0x7bc, autoirq, autodma, NULL);
+	parport_pc_probe_port(0x378, 0x778, autoirq, autodma, NULL);
+	parport_pc_probe_port(0x278, 0x678, autoirq, autodma, NULL);
 
-	if (parport_pc_probe_port(0x3bc, 0x7bc, autoirq, autodma, NULL))
-		count++;
-	if (parport_pc_probe_port(0x378, 0x778, autoirq, autodma, NULL))
-		count++;
-	if (parport_pc_probe_port(0x278, 0x678, autoirq, autodma, NULL))
-		count++;
-
-	return count;
+	return 0;
 }
 
 /* This function is called by parport_pc_init if the user didn't
@@ -3120,7 +3115,7 @@ parport_pc_find_isa_ports (int autoirq, 
  */
 static int __init parport_pc_find_ports (int autoirq, int autodma)
 {
-	int count = 0, r;
+	int r;
 
 #ifdef CONFIG_PARPORT_PC_SUPERIO
 	detect_and_report_winbond ();
@@ -3128,27 +3123,26 @@ static int __init parport_pc_find_ports 
 #endif
 
 	/* Onboard SuperIO chipsets that show themselves on the PCI bus. */
-	count += parport_pc_init_superio (autoirq, autodma);
-
 	/* PnP ports, skip detection if SuperIO already found them */
-	if (!count) {
+	if (!parport_pc_init_superio(autoirq, autodma)) {
 		r = pnp_register_driver (&parport_pc_pnp_driver);
-		if (r >= 0) {
+		if (!r) {
 			pnp_registered_parport = 1;
-			count += r;
-		}
+		} else
+			return r;
 	}
 
 	/* ISA ports and whatever (see asm/parport.h). */
-	count += parport_pc_find_nonpci_ports (autoirq, autodma);
+	parport_pc_find_nonpci_ports(autoirq, autodma);
 
 	r = pci_register_driver (&parport_pc_pci_driver);
-	if (r)
+	if (r) {
+		pnp_unregister_driver(&parport_pc_pnp_driver);
 		return r;
+	}
 	pci_registered_parport = 1;
-	count += 1;
 
-	return count;
+	return 0;
 }
 
 /*
@@ -3373,8 +3367,6 @@ __setup("parport_init_mode=",parport_ini
 
 static int __init parport_pc_init(void)
 {
-	int count = 0;
-
 	if (parse_parport_params())
 		return -EINVAL;
 
@@ -3387,14 +3379,12 @@ static int __init parport_pc_init(void)
 				break;
 			if ((io_hi[i]) == PARPORT_IOHI_AUTO)
 			       io_hi[i] = 0x400 + io[i];
-			if (parport_pc_probe_port(io[i], io_hi[i],
-						  irqval[i], dmaval[i], NULL))
-				count++;
+			parport_pc_probe_port(io[i], io_hi[i],
+					irqval[i], dmaval[i], NULL);
 		}
+		return 0;
 	} else
-		count += parport_pc_find_ports (irqval[0], dmaval[0]);
-
-	return 0;
+		return parport_pc_find_ports(irqval[0], dmaval[0]);
 }
 
 static void __exit parport_pc_exit(void)
