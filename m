Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVELWUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVELWUv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 18:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVELWUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 18:20:51 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:45561 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262154AbVELWUe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 18:20:34 -0400
Date: Thu, 12 May 2005 17:20:22 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: improve output in sysfs files when the TPM fails
Message-ID: <Pine.LNX.4.62.0505121717240.11837@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the TPM is in a disabled or deactivated state the sysfs pcrs and 
pubek files will appear empty.  To remove any confusion this might cause, 
the files will instead contain the error the TPM returned (also indicative 
of what state the TPM is in and what actions might be needed to change 
that state).

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN linux-2.6.12-rc3/drivers/char/tpm/tpm.c /home/kylie/kernel/linux-2.6.12-rc3-tpmdd/drivers/char/tpm/tpm.c
--- linux-2.6.12-rc3/drivers/char/tpm/tpm.c	2005-05-12 18:03:43.000000000 -0500
+++ /home/kylie/kernel/linux-2.6.12-rc3-tpmdd/drivers/char/tpm/tpm.c	2005-05-12 17:40:26.000000000 -0500
@@ -212,8 +183,11 @@ ssize_t tpm_show_pcrs(struct device *dev
 
 	memcpy(data, cap_pcr, sizeof(cap_pcr));
 	if ((len = tpm_transmit(chip, data, sizeof(data)))
-	    < CAP_PCR_RESULT_SIZE)
-		return len;
+	    < CAP_PCR_RESULT_SIZE) {
+		str += sprintf( str, "TPM ERROR: %d\n", 
+			be32_to_cpu(*((__be32 *) (data + 6))));
+		goto out;
+	}
 
 	num_pcrs = be32_to_cpu(*((__be32 *) (data + 14)));
 
@@ -222,13 +196,17 @@ ssize_t tpm_show_pcrs(struct device *dev
 		index = cpu_to_be32(i);
 		memcpy(data + 10, &index, 4);
 		if ((len = tpm_transmit(chip, data, sizeof(data)))
-		    < READ_PCR_RESULT_SIZE)
-			return len;
+		    < READ_PCR_RESULT_SIZE){
+			str += sprintf( str, "TPM ERROR: %d\n", 
+				be32_to_cpu(*((__be32 *) (data + 6))));
+			goto out;
+		}
 		str += sprintf(str, "PCR-%02d: ", i);
 		for (j = 0; j < TPM_DIGEST_SIZE; j++)
 			str += sprintf(str, "%02X ", *(data + 10 + j));
 		str += sprintf(str, "\n");
 	}
+out:
 	return str - buf;
 }
 
@@ -262,7 +240,8 @@ ssize_t tpm_show_pubek(struct device *de
 
 	if ((len = tpm_transmit(chip, data, READ_PUBEK_RESULT_SIZE)) <
 	    READ_PUBEK_RESULT_SIZE) {
-		rc = len;
+		str += sprintf( str, "TPM ERROR: %d\n", 
+			be32_to_cpu(*((__be32 *) (data + 6))));
 		goto out;
 	}
 
@@ -294,8 +273,8 @@ ssize_t tpm_show_pubek(struct device *de
 		if ((i + 1) % 16 == 0)
 			str += sprintf(str, "\n");
 	}
-	rc = str - buf;
 out:
+	rc = str - buf;
 	kfree(data);
 	return rc;
 }
