Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVFNPM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVFNPM6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 11:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVFNPL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 11:11:27 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:43235 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261164AbVFNPAb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 11:00:31 -0400
Subject: Re: [PATCH] tpm: improve output in sysfs files when the TPM fails
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050513223003.4f9dc539.akpm@osdl.org>
References: <Pine.LNX.4.62.0505121717240.11837@localhost.localdomain>
	 <20050512225541.GA29958@kroah.com>
	 <Pine.LNX.4.62.0505131422350.13489@localhost.localdomain>
	 <20050513223003.4f9dc539.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 14 Jun 2005 10:00:26 -0500
Message-Id: <1118761226.6602.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 22:30 -0700, Andrew Morton wrote:
> Will this change permit unprivileged users to create large amounts of
> syslog output?  If so, this is considered poor form.
> 
> IOW: please confirm that the relevant sysfs files are root-read-only?
> 
Since after reconsideration this is more debug output than an error (the
TPM is operating correctly given the current state) I have changed the
statements to dbg rather than err.  Is this sufficient?  Also this patch
corrects a memory leak if the error path is taken in the tpm_show_pubek
function.

Thanks,
Kylie Hall

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.12-rc6-mm1/drivers/char/tpm/tpm.c.orig	2005-06-14 09:14:37.000000000 -0500
+++ linux-2.6.12-rc6-mm1/drivers/char/tpm/tpm.c	2005-06-14 09:24:23.000000000 -0500
@@ -147,7 +147,7 @@ ssize_t tpm_show_pcrs(struct device *dev
 	memcpy(data, cap_pcr, sizeof(cap_pcr));
 	if ((len = tpm_transmit(chip, data, sizeof(data)))
 	    < CAP_PCR_RESULT_SIZE) {
-		dev_err(&chip->pci_dev->dev, "A TPM error (%d) occurred "
+		dev_dbg(&chip->pci_dev->dev, "A TPM error (%d) occurred "
 				"attempting to determine the number of PCRS\n",
 			be32_to_cpu(*((__be32 *) (data + 6))));
 		return 0;
@@ -161,7 +161,7 @@ ssize_t tpm_show_pcrs(struct device *dev
 		memcpy(data + 10, &index, 4);
 		if ((len = tpm_transmit(chip, data, sizeof(data)))
 		    < READ_PCR_RESULT_SIZE){
-			dev_err(&chip->pci_dev->dev, "A TPM error (%d) occurred"
+			dev_dbg(&chip->pci_dev->dev, "A TPM error (%d) occurred"
 				" attempting to read PCR %d of %d\n",
 				be32_to_cpu(*((__be32 *) (data + 6))), i, num_pcrs);
 			goto out;
@@ -205,10 +205,11 @@ ssize_t tpm_show_pubek(struct device *de
 
 	if ((len = tpm_transmit(chip, data, READ_PUBEK_RESULT_SIZE)) <
 	    READ_PUBEK_RESULT_SIZE) {
-		dev_err(&chip->pci_dev->dev, "A TPM error (%d) occurred "
+		dev_dbg(&chip->pci_dev->dev, "A TPM error (%d) occurred "
 				"attempting to read the PUBEK\n",
 			    be32_to_cpu(*((__be32 *) (data + 6))));
-		return 0;
+		rc = 0;
+		goto out;
 	}
 
 	/* 
@@ -240,6 +241,7 @@ ssize_t tpm_show_pubek(struct device *de
 			str += sprintf(str, "\n");
 	}
 	rc = str - buf;
+out:
 	kfree(data);
 	return rc;
 }


