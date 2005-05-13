Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVEMTjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVEMTjw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVEMTh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:37:59 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:44501 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262515AbVEMT0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:26:12 -0400
Date: Fri, 13 May 2005 14:25:55 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
To: Greg KH <greg@kroah.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: improve output in sysfs files when the TPM fails
In-Reply-To: <20050512225541.GA29958@kroah.com>
Message-ID: <Pine.LNX.4.62.0505131422350.13489@localhost.localdomain>
References: <Pine.LNX.4.62.0505121717240.11837@localhost.localdomain>
 <20050512225541.GA29958@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2005, Greg KH wrote:
> On Thu, May 12, 2005 at 05:20:22PM -0500, Kylene Hall wrote:
> > When the TPM is in a disabled or deactivated state the sysfs pcrs and 
> > pubek files will appear empty.  To remove any confusion this might cause, 
> > the files will instead contain the error the TPM returned (also indicative 
> > of what state the TPM is in and what actions might be needed to change 
> > that state).
> 
> No, sysfs files are not error logs.  Please use the standard system wide
> error log for this (syslog).
> 
> Why not just change the mode of the sysfs file instead, or delete it
> entirely in this case?

Ok, instead of putting error information in the sysfs file this new patch 
will put an error entry in syslog.  The sysfs files can't easily be 
removed in these cases as the driver does not know this information and it 
can be changed by commands sent to the TPM from userspace.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN linux-2.6.12-rc3/drivers/char/tpm/tpm.c /home/kylie/kernel/linux-2.6.12-rc3-tpmdd/drivers/char/tpm/tpm.c
--- linux-2.6.12-rc3/drivers/char/tpm/tpm.c	2005-05-12 18:03:43.000000000 -0500
+++ /home/kylie/kernel/linux-2.6.12-rc3-tpmdd/drivers/char/tpm/tpm.c	2005-05-13 13:43:52.000000000 -0500
@@ -212,8 +183,11 @@ ssize_t tpm_show_pcrs(struct device *dev
 
 	memcpy(data, cap_pcr, sizeof(cap_pcr));
 	if ((len = tpm_transmit(chip, data, sizeof(data)))
-	    < CAP_PCR_RESULT_SIZE)
-		return len;
+	    < CAP_PCR_RESULT_SIZE) {
+		dev_err(&chip->pci_dev->dev, "A TPM error (%d) occurred attempting to determine the number of PCRS\n", 
+			be32_to_cpu(*((__be32 *) (data + 6))));
+		return 0;
+	}
 
 	num_pcrs = be32_to_cpu(*((__be32 *) (data + 14)));
 
@@ -222,13 +196,17 @@ ssize_t tpm_show_pcrs(struct device *dev
 		index = cpu_to_be32(i);
 		memcpy(data + 10, &index, 4);
 		if ((len = tpm_transmit(chip, data, sizeof(data)))
-		    < READ_PCR_RESULT_SIZE)
-			return len;
+		    < READ_PCR_RESULT_SIZE){
+			dev_err(&chip->pci_dev->dev, "A TPM error (%d) occurred attempting to read PCR %d of %d\n", 
+				be32_to_cpu(*((__be32 *) (data + 6))), i, num_pcrs);
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
 
@@ -262,8 +240,9 @@ ssize_t tpm_show_pubek(struct device *de
 
 	if ((len = tpm_transmit(chip, data, READ_PUBEK_RESULT_SIZE)) <
 	    READ_PUBEK_RESULT_SIZE) {
-		rc = len;
-		goto out;
+		dev_err(&chip->pci_dev->dev, "A TPM error (%d) occurred attempting to read the PUBEK\n", 
+			    be32_to_cpu(*((__be32 *) (data + 6))));
+		return 0;
 	}
 
 	/* 
@@ -295,7 +274,6 @@ ssize_t tpm_show_pubek(struct device *de
 			str += sprintf(str, "\n");
 	}
 	rc = str - buf;
-out:
 	kfree(data);
 	return rc;
 }
