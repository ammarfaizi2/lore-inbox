Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVFORbL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVFORbL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 13:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFORbL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 13:31:11 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:5826 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261240AbVFORar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 13:30:47 -0400
Subject: Re: [PATCH] 1 of 5 IMA: necessary tpm changes
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Reiner Sailer <sailer@us.ibm.com>,
       serue@us.ibm.com
In-Reply-To: <1118845007.7037.24.camel@localhost.localdomain>
References: <1118845007.7037.24.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 15 Jun 2005 12:30:27 -0500
Message-Id: <1118856627.7037.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 09:16 -0500, Kylene Jo Hall wrote:
> This patch applies against linux-2.6.12-rc6-mm1 and provides the
> internal kernel interface for use by IMA or anything else in the kernel
> which would like to use TPM commands.  It also moves the TPM driver up
> in the initialization process to accomodate the early initialization
> requirements of IMA.

This patch adds the lock that was missing in the tpm_chip_lookup
function the previous patch.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.12-rc4/drivers/char/tpm/tpm.c.orig	2005-05-17 14:15:53.000000000 -0500
+++ linux-2.6.12-rc4/drivers/char/tpm/tpm.c	2005-05-17 14:18:56.000000000 -0500
@@ -50,15 +50,40 @@ static void user_reader_timeout(unsigned
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
+
+	spin_lock(&driver_lock);
+	list_for_each_entry(pos, &tpm_chip_list, list)
+		if (pos->dev_num == chip_num) {
+			spin_unlock(&driver_lock);
+			return pos;
+		}
+
+	spin_unlock(&driver_lock);
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


