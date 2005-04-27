Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVD0WWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVD0WWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 18:22:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVD0WVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 18:21:41 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:23481 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262057AbVD0WTG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 18:19:06 -0400
Date: Wed, 27 Apr 2005 17:18:52 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@jo.austin.ibm.com
To: Alexey Dobriyan <adobriyan@mail.ru>
cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 9 of 12] Fix TPM driver -- remove unnecessary __force
In-Reply-To: <200503102304.54927.adobriyan@mail.ru>
Message-ID: <Pine.LNX.4.61.0504271642100.3929@jo.austin.ibm.com>
References: <1110415321526@kroah.com> <200503102304.54927.adobriyan@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2005, Alexey Dobriyan wrote:
> On Thursday 10 March 2005 02:42, Greg KH wrote:
> 
> > [PATCH] Add TPM hardware enablement driver
> 
> > +static ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
> > +			    size_t bufsiz)
> > +{
> 
> > +	u32 count;
> > +	__be32 *native_size;
> > +
> > +	native_size = (__force __be32 *) (buf + 2);
> > +	count = be32_to_cpu(*native_size);
> 
> __force in a driver?
> 
> 	count = be32_to_cpup((__be32 *) (buf + 2));
> 
> should be enough. Once done you can remove "native_size".
> 
> > +static int tpm_atml_recv(struct tpm_chip *chip, u8 * buf, size_t count)
> > +{
> 
> > +	u32 size;
> 
> > +	__be32 *native_size;
> 
> > +	/* size of the data received */
> > +	native_size = (__force __be32 *) (hdr + 2);
> > +	size = be32_to_cpu(*native_size);
> 
> > +static int tpm_nsc_recv(struct tpm_chip *chip, u8 * buf, size_t count)
> > +{
> 
> > +	u32 size;
> > +	__be32 *native_size;
> 
> > +	native_size = (__force __be32 *) (buf + 2);
> > +	size = be32_to_cpu(*native_size);
> 
> Same story.
> 
> 	Alexey
> 
> 

The patch below removes the unnecessary use of __force.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN --exclude='*.orig' linux-2.6.12-rc2/drivers/char/tpm/tpm.c linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-20 17:42:04.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c	2005-04-20 17:49:06.000000000 -0500
@@ -142,11 +142,9 @@ static ssize_t tpm_transmit(struct tpm_c
 {
 	ssize_t len;
 	u32 count;
-	__be32 *native_size;
 	unsigned long stop;
 
-	native_size = (__force __be32 *) (buf + 2);
-	count = be32_to_cpu(*native_size);
+	count = be32_to_cpu(*((__be32 *) (buf + 2)));
 
 	if (count == 0)
 		return -ENODATA;
@@ -213,7 +211,8 @@ static ssize_t show_pcrs(struct device *
 {
 	u8 data[READ_PCR_RESULT_SIZE];
 	ssize_t len;
-	int i, j, index, num_pcrs;
+	int i, j, num_pcrs;
+	__be32 index;
 	char *str = buf;
 
 	struct tpm_chip *chip =
@@ -226,7 +225,7 @@ static ssize_t show_pcrs(struct device *
 	    < CAP_PCR_RESULT_SIZE)
 		return len;
 
-	num_pcrs = be32_to_cpu(*((__force __be32 *) (data + 14)));
+	num_pcrs = be32_to_cpu(*((__be32 *) (data + 14)));
 
 	for (i = 0; i < num_pcrs; i++) {
 		memcpy(data, pcrread, sizeof(pcrread));
@@ -256,8 +255,7 @@ static ssize_t show_pubek(struct device 
 {
 	u8 data[READ_PUBEK_RESULT_SIZE];
 	ssize_t len;
-	__be32 *native_val;
-	int i;
+	int i, rc;
 	char *str = buf;
 
 	struct tpm_chip *chip =
@@ -283,8 +281,6 @@ static ssize_t show_pubek(struct device 
 	   ignore checksum 20 bytes
 	 */
 
-	native_val = (__force __be32 *) (data + 34);
-
 	str +=
 	    sprintf(str,
 		    "Algorithm: %02X %02X %02X %02X\nEncscheme: %02X %02X\n"
@@ -295,8 +291,7 @@ static ssize_t show_pubek(struct device 
 		    data[15], data[16], data[17], data[22], data[23],
 		    data[24], data[25], data[26], data[27], data[28],
 		    data[29], data[30], data[31], data[32], data[33],
-		    be32_to_cpu(*native_val)
-	    );
+		    be32_to_cpu(*((__be32 *) (data + 32))));
 
 	for (i = 0; i < 256; i++) {
 		str += sprintf(str, "%02X ", data[i + 39]);
@@ -345,7 +340,7 @@ static ssize_t show_caps(struct device *
 		return len;
 
 	str += sprintf(str, "Manufacturer: 0x%x\n",
-		       be32_to_cpu(*(data + 14)));
+		       be32_to_cpu(*((__be32 *) (data + 14))));
 
 	memcpy(data, cap_version, sizeof(cap_version));
