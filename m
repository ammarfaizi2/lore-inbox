Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273295AbRIWGCl>; Sun, 23 Sep 2001 02:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273298AbRIWGCb>; Sun, 23 Sep 2001 02:02:31 -0400
Received: from ns1.yggdrasil.com ([209.249.10.20]:8889 "EHLO ns1.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S273295AbRIWGCT>;
	Sun, 23 Sep 2001 02:02:19 -0400
Date: Sat, 22 Sep 2001 23:02:37 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com, alan.cox@linux.org,
        zab@zabbo.net
Subject: PATCH: linux-2.4.10-pre14/drivers/sound/maestro.c ignored pci_module_init results
Message-ID: <20010922230237.A10872@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	The initialization routine in
linux-2.4.10-pre14/drivers/sound/maestro.c ignores the return value
from pci_module_init, and allows module initialization to succeed
even if pci_module_init failed.  pci_module_init fails and unloads
the driver if the caller is a module and there is no matching hardware.
Because maestro.c ignored this failure, loading maestro.o on a system
where the corresponding alsa driver was already loaded or on a system
without matchin hardware would result in a kernel null pointer dereference
in pci_unregister_driver when the module is unloaded or when one
attempts to reboot the system (i.e., when the module attempt to
unregister a PCI driver that is not registered).

	This bug is also present in drivers/net/tlan.c and
drivers/net/irda/toshoboe.c.  I will send patches for them shortly.

	Here is the patch for maestro.c.  Please apply.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="maestro.diff"

--- linux-2.4.10-pre14/drivers/sound/maestro.c	Sun Aug 12 10:51:42 2001
+++ linux/drivers/sound/maestro.c	Sat Sep 22 22:42:48 2001
@@ -3602,7 +3602,12 @@
 
 int __init init_maestro(void)
 {
-	pci_module_init(&maestro_pci_driver);
+	int rc;
+
+	rc = pci_module_init(&maestro_pci_driver);
+	if (rc < 0)
+		return rc;
+
 	if (register_reboot_notifier(&maestro_nb))
 		printk(KERN_WARNING "maestro: reboot notifier registration failed; may not reboot properly.\n");
 #ifdef MODULE

--M9NhX3UHpAaciwkO--
