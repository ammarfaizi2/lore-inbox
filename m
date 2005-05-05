Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVEETmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVEETmg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVEETlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:41:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:40157 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262183AbVEETLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 15:11:10 -0400
Date: Thu, 5 May 2005 14:10:53 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
To: akpm@osdl.org
cc: jgarzik@pobox.com, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: [PATCH 5 of 12] Fix TPM driver -- large stack objects
Message-ID: <Pine.LNX.4.62.0505051330500.5303@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please apply these fixes to the Tpm driver.  I am resubmitting the entire
patch set that was orginally sent to LKML on April 27 with the changes
that were requested fixed.

On Wed, 9 Mar 2005, Jeff Garzik wrote:
> Greg KH wrote:

<snip>

> > +static ssize_t show_pubek(struct device *dev, char *buf)
> > +{
> > +	u8 data[READ_PUBEK_RESULT_SIZE];
> 
> massive obj on stack

<snip>

> 
> > +static ssize_t show_caps(struct device *dev, char *buf)
> > +{
> > +	u8 data[READ_PUBEK_RESULT_SIZE];
> 
> massive obj on stack

<snip>

The patch below containes fixes for these large stack objects.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-21 18:11:12.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c	2005-04-21 18:13:10.000000000 -0500
@@ -253,7 +253,7 @@ static const u8 readpubek[] = {
 
 ssize_t tpm_show_pubek(struct device *dev, char *buf)
 {
-	u8 data[READ_PUBEK_RESULT_SIZE];
+	u8 *data;
 	ssize_t len;
 	int i, rc;
 	char *str = buf;
@@ -263,12 +263,18 @@ ssize_t tpm_show_pubek(struct device *de
 	if (chip == NULL)
 		return -ENODEV;
 
+	data = kmalloc(READ_PUBEK_RESULT_SIZE, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
 	memcpy(data, readpubek, sizeof(readpubek));
 	memset(data + sizeof(readpubek), 0, 20);	/* zero nonce */
 
-	if ((len = tpm_transmit(chip, data, sizeof(data))) <
-	    READ_PUBEK_RESULT_SIZE)
-		return len;
+	if ((len = tpm_transmit(chip, data, READ_PUBEK_RESULT_SIZE)) <
+	    READ_PUBEK_RESULT_SIZE) {
+		rc = len;
+		goto out;
+	}
 
 	/* 
 	   ignore header 10 bytes
@@ -298,7 +304,10 @@ ssize_t tpm_show_pubek(struct device *de
 		if ((i + 1) % 16 == 0)
 			str += sprintf(str, "\n");
 	}
-	return str - buf;
+	rc = str - buf;
+out:
+	kfree(data);
+	return rc;
 }
 
 EXPORT_SYMBOL_GPL(tpm_show_pubek);
@@ -324,7 +333,7 @@ static const u8 cap_manufacturer[] = {
 
 ssize_t tpm_show_caps(struct device *dev, char *buf)
 {
-	u8 data[READ_PUBEK_RESULT_SIZE];
+	u8 data[sizeof(cap_manufacturer)];
 	ssize_t len;
 	char *str = buf;
 
