Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272413AbRIWGUd>; Sun, 23 Sep 2001 02:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272511AbRIWGUZ>; Sun, 23 Sep 2001 02:20:25 -0400
Received: from ns1.yggdrasil.com ([209.249.10.20]:52921 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S272413AbRIWGUO>; Sun, 23 Sep 2001 02:20:14 -0400
Date: Sat, 22 Sep 2001 23:20:37 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: tigran@sco.com, linux-kernel@vger.kernel.org
Subject: PATCH: linux-2.4.10-pre14/drivers/net/tlan.c ignored pci_module_init result
Message-ID: <20010922232037.A10954@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	linux-2.4.10-pre4/drivers/net/tlan.c incorrectly used
pci_module_init instead of pci_register_module.  pci_module_init will
unregister the PCI driver if no matching hardware is found and the
driver is compiled as a module.  However, the driver may still remain
loaded is there is an EISA tlan device present.  If a PCI tlan device
were subsequently plugged in, then the module would not handle it
because the PCI driver is not registered, and the module would not
be reloaded, because the module is already loaded to handle the
EISA device.

	What should happen, is that the PCI driver should remain
registered unless the module is going to be unloaded, which is
what this patch does.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tlan.diff"

--- linux-2.4.10-pre14/drivers/net/tlan.c	Mon Jul  2 14:03:04 2001
+++ linux/drivers/net/tlan.c	Sat Sep 22 23:10:59 2001
@@ -452,7 +452,7 @@
 	
 	/* Use new style PCI probing. Now the kernel will
 	   do most of this for us */
-	pci_module_init(&tlan_driver);
+	pci_register_driver(&tlan_driver);
 
 	TLAN_DBG(TLAN_DEBUG_PROBE, "Starting EISA Probe....\n");
 	TLan_EisaProbe();
@@ -462,6 +462,7 @@
 		 tlan_have_pci, tlan_have_eisa);
 
 	if (TLanDevicesInstalled == 0) {
+		pci_unregister_driver(&tlan_driver);
 		kfree(TLanPadBuffer);
 		return -ENODEV;
 	}
@@ -643,8 +644,7 @@
 		
 static void __exit tlan_exit(void)
 {
-	if (tlan_have_pci)
-		pci_unregister_driver(&tlan_driver);
+	pci_unregister_driver(&tlan_driver);
 
 	if (tlan_have_eisa)
 		TLan_Eisa_Cleanup();

--/04w6evG8XlLl3ft--
