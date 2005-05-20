Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVETNMn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVETNMn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 09:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVETNMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:12:43 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:22193 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261460AbVETNMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:12:25 -0400
Date: Fri, 20 May 2005 08:06:32 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: akpm@osdl.org, sailer@us.ibm.com, yoder1@us.ibm.com, toml@us.ibm.com,
       emilyr@us.ibm.com
Subject: [PATCH 1 of 4] ima: related TPM device driver interal kernel interface
Message-ID: <Pine.LNX.4.62.0505191657210.12334@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The IBM Integrity Measurement Architecture (IMA) is being submitted for 
inclusion by Reiner Sailer.  The IMA is a LSM that uses TPM 
functionality.  This patch provides and internal kernel interface for 
IMA and any other subsystems to access TPM functionality.  A subsystem 
first requests the chip it is trying to access with the tpm_chip_lookup 
function and then submitts TPM commands to that chip with the tpm_transmit 
function.  For security reasons IMA needs to be built into the 
kernel, in order for the TPM driver to be available during IMA 
initialization the module_init is replaced with an fs_initcall when the 
driver is built into the kernel.

This patch should apply against 2.6.12-rc4-mm2 plus the patch I submitted 
on May 16 to remove the unnecessary lpc initialization stuff.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.12-rc4/drivers/char/tpm/tpm.c.orig	2005-05-17 14:15:53.000000000 -0500
+++ linux-2.6.12-rc4/drivers/char/tpm/tpm.c	2005-05-17 14:18:56.000000000 -0500
@@ -50,15 +50,35 @@ static void user_reader_timeout(unsigned
 }
 
 /*
+ * This function should be used by other kernel subsystems attempting to use the tpm through the tpm_transmit interface.
+ * A call to this function will return the chip structure corresponding to the TPM you are looking for that can then be sent with your command to tpm_transmit.
+ * Passing 0 as the argument corresponds to /dev/tpm0 and thus the first and probably primary TPM on the system.  Passing 1 corresponds to /dev/tpm1 and the next TPM discovered.  If a TPM with the given chip_num does not exist NULL will be returned.  
+ */
+struct tpm_chip* tpm_chip_lookup(int chip_num)
+{
+
+	struct tpm_chip *pos;
+	list_for_each_entry(pos, &tpm_chip_list, list)
+		if (pos->dev_num == chip_num)
+			return pos;
+
+	return NULL;
+
+}
+
+/*
  * Internal kernel interface to transmit TPM commands
  */
-static ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
+ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
 			    size_t bufsiz)
 {
 	ssize_t rc;
 	u32 count;
 	unsigned long stop;
 
+	if ( !chip )
+		return -ENODEV;
+
 	count = be32_to_cpu(*((__be32 *) (buf + 2)));
 
 	if (count == 0)
@@ -110,6 +130,7 @@ out:
 	up(&chip->tpm_mutex);
 	return rc;
 }
+EXPORT_SYMBOL_GPL(tpm_transmit);
 
 #define TPM_DIGEST_SIZE 20
 #define CAP_PCR_RESULT_SIZE 18
--- linux-2.6.12-rc3-ima/drivers/char/tpm/tpm.h	2005-04-20 19:03:13.000000000 -0500
+++ linux-2.6.12-rc3-ima/drivers/char/tpm/tpm.h	2005-05-02 14:08:44.000000000 -0500
@@ -91,3 +91,8 @@ extern ssize_t tpm_read(struct file *, c
 extern void __devexit tpm_remove(struct pci_dev *);
 extern int tpm_pm_suspend(struct pci_dev *, pm_message_t);
 extern int tpm_pm_resume(struct pci_dev *);
+
+/* internal kernel interface */
+extern ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
+			    size_t bufsiz);
+extern struct tpm_chip *tpm_chip_lookup(int chip_num);
--- linux-2.6.12-rc3-ima/drivers/char/tpm/tpm_atmel.c	2005-04-20 19:03:13.000000000 -0500
+++ linux-2.6.12-rc3-ima/drivers/char/tpm/tpm_atmel.c	2005-05-02 14:06:35.000000000 -0500
@@ -207,7 +207,11 @@ static void __exit cleanup_atmel(void)
 	pci_unregister_driver(&atmel_pci_driver);
 }
 
+#ifdef MODULE
 module_init(init_atmel);
+#else
+fs_initcall(init_atmel);
+#endif
 module_exit(cleanup_atmel);
 
 MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
--- linux-2.6.12-rc3-ima/drivers/char/tpm/tpm_nsc.c	2005-04-20 19:03:13.000000000 -0500
+++ linux-2.6.12-rc3-ima/drivers/char/tpm/tpm_nsc.c	2005-05-02 14:09:34.000000000 -0500
@@ -364,7 +364,11 @@ static void __exit cleanup_nsc(void)
 	pci_unregister_driver(&nsc_pci_driver);
 }
 
+#ifdef MODULE
 module_init(init_nsc);
+#else
+fs_initcall(init_nsc);
+#endif
 module_exit(cleanup_nsc);
 
 MODULE_AUTHOR("Leendert van Doorn (leendert@watson.ibm.com)");
