Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWDETra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWDETra (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 15:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWDETra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 15:47:30 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:29855 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932078AbWDETr3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 15:47:29 -0400
Subject: Re: [PATCH 2/7] tpm: reorganize sysfs files - Updated patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: haveblue@us.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       Marcel Selhorst <selhorst@crypto.rub.de>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 14:48:17 -0500
Message-Id: <1144266498.5235.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-03 at 16:54  Dave Hansen wrote:
> On Mon, 2006-04-03 at 11:42 -0500, Kylene Jo Hall wrote: 
> >  ssize_t tpm_show_pcrs(struct device *dev, struct device_attribute *attr,
> >  		      char *buf)
> >  {
> > -	u8 data[READ_PCR_RESULT_SIZE];
> > +	u8 data[30];
>
> Is this correct?  Are you guaranteed that this data read will never,
> ever exceed 30 bytes?  Any reason it shouldn't be a variable?
It is correct.  The function is calling TPM commands that have a fixed
structure of data they return and I know that won't exceed 30 bytes in
this case.  The receive function is also smart enough to not read more
data than the buffer size it is passed.  I removed the #define size
becuase I realized I could check the return to be bigger than the error
return size thus this was the only place the #define was being used.  If
others like I can return the #define for readability.

<snip>
> 
> I know this is old code, but I see this little 
> 
> 	be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
>
> snippet at least twice.  It is also a bit hard to read.  Seems likt it
> would be a great candidate for a little helper function.
> 
> Come to think of it, that entire if() sequence appears to be repeated
> quite a few times.
>
This patch will turn this into a function.

<snip>
> > +	if ((len = tpm_transmit(chip, data, sizeof(data))) <=
> > +	    TPM_ERROR_SIZE) {
> > +		dev_dbg(chip->dev, "A TPM error (%d) occurred "
> > +			"attempting to determine the manufacturer\n",
> > +			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
> > +		return 0;
> > +	}
> 
> Since you're going through and modifying these, it might be nice to
> change them to the more normal (and readable) style of 
> 
> 
> 	len = tpm_transmit(chip, data, sizeof(data));
> 	if (len < CAP_MANUFACTURER_RESULT_SIZE)
> 		return len;
> 
> Note that that doesn't even increase the number of lines of code.
> 
The patch will fix this style issue for these calls.

> -- Dave

From: Kylene Hall <kjhall@us.ibm.com>

Many of the sysfs files were calling the TPM_GetCapability command with
different options and each command layed out in its own static const
array.  Since for 1.2 more sysfs files of this type are coming I am
generalizing the array so there can be one array and the unique parts
can be filled in just before the command is called.

This updated version of the patch addresses the code redundancy and
ugliness in the tpm_show_* functions pointed out by Dave.  It replaces
the 2/7 patch from the original set.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm.c |  147 +++++++++++++++++++++++----------------
 1 files changed, 87 insertions(+), 60 deletions(-)

--- linux-2.6.16/drivers/char/tpm/tpm.c	2006-04-03 17:15:58.815947500 -0500
+++ linux-2.6.16-43/drivers/char/tpm/tpm.c	2006-04-03 17:14:02.620685750 -0500
@@ -119,17 +119,57 @@ out:
 }
 
 #define TPM_DIGEST_SIZE 20
-#define CAP_PCR_RESULT_SIZE 18
-static const u8 cap_pcr[] = {
+#define TPM_ERROR_SIZE 10
+#define TPM_RET_CODE_IDX 6
+#define TPM_GET_CAP_RET_SIZE_IDX 10
+#define TPM_GET_CAP_RET_UINT32_1_IDX 14
+#define TPM_GET_CAP_RET_UINT32_2_IDX 18
+#define TPM_GET_CAP_RET_UINT32_3_IDX 22
+#define TPM_GET_CAP_RET_UINT32_4_IDX 26
+
+#define TPM_CAP_IDX 13
+#define TPM_CAP_SUBCAP_IDX 21
+
+enum tpm_capabilities {
+	TPM_CAP_PROP = 5,
+};
+
+enum tpm_sub_capabilities {
+	TPM_CAP_PROP_PCR = 0x1,
+	TPM_CAP_PROP_MANUFACTURER = 0x3,
+};
+
+/*
+ * This is a semi generic GetCapability command for use
+ * with the capability type TPM_CAP_PROP or TPM_CAP_FLAG
+ * and their associated sub_capabilities.
+ */
+
+static const u8 tpm_cap[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 22,		/* length */
 	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
-	0, 0, 0, 5,
-	0, 0, 0, 4,
-	0, 0, 1, 1
+	0, 0, 0, 0,		/* TPM_CAP_<TYPE> */
+	0, 0, 0, 4,		/* TPM_CAP_SUB_<TYPE> size */
+	0, 0, 1, 0		/* TPM_CAP_SUB_<TYPE> */
 };
 
-#define READ_PCR_RESULT_SIZE 30
+static ssize_t transmit_cmd(struct tpm_chip *chip, u8 *data, int len,
+			    char *desc)
+{
+	int err;
+
+	len = tpm_transmit(chip, data, len);
+	if (len <  0)
+		return len;
+	if (len == TPM_ERROR_SIZE) {
+		err = be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX)));
+		dev_dbg(chip->dev, "A TPM error (%d) occurred %s\n", err, desc);
+		return err;
+	}
+	return 0;
+}
+
 static const u8 pcrread[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 14,		/* length */
@@ -140,8 +180,8 @@ static const u8 pcrread[] = {
 ssize_t tpm_show_pcrs(struct device *dev, struct device_attribute *attr,
 		      char *buf)
 {
-	u8 data[READ_PCR_RESULT_SIZE];
-	ssize_t len;
+	u8 data[30];
+	ssize_t rc;
 	int i, j, num_pcrs;
 	__be32 index;
 	char *str = buf;
@@ -150,29 +190,24 @@ ssize_t tpm_show_pcrs(struct device *dev
 	if (chip == NULL)
 		return -ENODEV;
 
-	memcpy(data, cap_pcr, sizeof(cap_pcr));
-	if ((len = tpm_transmit(chip, data, sizeof(data)))
-	    < CAP_PCR_RESULT_SIZE) {
-		dev_dbg(chip->dev, "A TPM error (%d) occurred "
-				"attempting to determine the number of PCRS\n",
-			be32_to_cpu(*((__be32 *) (data + 6))));
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_PROP;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_PROP_PCR;
+
+	rc = transmit_cmd(chip, data, sizeof(data),
+			"attempting to determine the number of PCRS");
+	if (rc)
 		return 0;
-	}
 
 	num_pcrs = be32_to_cpu(*((__be32 *) (data + 14)));
-
 	for (i = 0; i < num_pcrs; i++) {
 		memcpy(data, pcrread, sizeof(pcrread));
 		index = cpu_to_be32(i);
 		memcpy(data + 10, &index, 4);
-		if ((len = tpm_transmit(chip, data, sizeof(data)))
-		    < READ_PCR_RESULT_SIZE){
-			dev_dbg(chip->dev, "A TPM error (%d) occurred"
-				" attempting to read PCR %d of %d\n",
-				be32_to_cpu(*((__be32 *) (data + 6))),
-				i, num_pcrs);
+		rc = transmit_cmd(chip, data, sizeof(data),
+				"attempting to read a PCR");
+		if (rc)
 			goto out;
-		}
 		str += sprintf(str, "PCR-%02d: ", i);
 		for (j = 0; j < TPM_DIGEST_SIZE; j++)
 			str += sprintf(str, "%02X ", *(data + 10 + j));
@@ -194,7 +229,7 @@ ssize_t tpm_show_pubek(struct device *de
 		       char *buf)
 {
 	u8 *data;
-	ssize_t len;
+	ssize_t err; 
 	int i, rc;
 	char *str = buf;
 
@@ -208,14 +243,10 @@ ssize_t tpm_show_pubek(struct device *de
 
 	memcpy(data, readpubek, sizeof(readpubek));
 
-	if ((len = tpm_transmit(chip, data, READ_PUBEK_RESULT_SIZE)) <
-	    READ_PUBEK_RESULT_SIZE) {
-		dev_dbg(chip->dev, "A TPM error (%d) occurred "
-				"attempting to read the PUBEK\n",
-			    be32_to_cpu(*((__be32 *) (data + 6))));
-		rc = 0;
+	err = transmit_cmd(chip, data, READ_PUBEK_RESULT_SIZE,
+			"attempting to read the PUBEK");
+	if (err)
 		goto out;
-	}
 
 	/* 
 	   ignore header 10 bytes
@@ -245,63 +276,59 @@ ssize_t tpm_show_pubek(struct device *de
 		if ((i + 1) % 16 == 0)
 			str += sprintf(str, "\n");
 	}
-	rc = str - buf;
 out:
+	rc = str - buf;
 	kfree(data);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm_show_pubek);
 
-#define CAP_VER_RESULT_SIZE 18
+#define CAP_VERSION_1_1 6
+#define CAP_VERSION_IDX 13
 static const u8 cap_version[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 18,		/* length */
 	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
-	0, 0, 0, 6,
+	0, 0, 0, 0,
 	0, 0, 0, 0
 };
 
-#define CAP_MANUFACTURER_RESULT_SIZE 18
-static const u8 cap_manufacturer[] = {
-	0, 193,			/* TPM_TAG_RQU_COMMAND */
-	0, 0, 0, 22,		/* length */
-	0, 0, 0, 101,		/* TPM_ORD_GetCapability */
-	0, 0, 0, 5,
-	0, 0, 0, 4,
-	0, 0, 1, 3
-};
-
 ssize_t tpm_show_caps(struct device *dev, struct device_attribute *attr,
 		      char *buf)
 {
-	u8 data[sizeof(cap_manufacturer)];
-	ssize_t len;
+	u8 data[30];
+	ssize_t rc;
 	char *str = buf;
 
 	struct tpm_chip *chip = dev_get_drvdata(dev);
 	if (chip == NULL)
 		return -ENODEV;
 
-	memcpy(data, cap_manufacturer, sizeof(cap_manufacturer));
-
-	if ((len = tpm_transmit(chip, data, sizeof(data))) <
-	    CAP_MANUFACTURER_RESULT_SIZE)
-		return len;
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_PROP;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_PROP_MANUFACTURER;
+
+	rc = transmit_cmd(chip, data, sizeof(data),
+			"attempting to determine the manufacturer");
+	if (rc)
+		return 0;
 
 	str += sprintf(str, "Manufacturer: 0x%x\n",
-		       be32_to_cpu(*((__be32 *) (data + 14))));
+		       be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_1_IDX))));
 
 	memcpy(data, cap_version, sizeof(cap_version));
+	data[CAP_VERSION_IDX] = CAP_VERSION_1_1;
+	rc = transmit_cmd(chip, data, sizeof(data),
+			"attempting to determine the 1.1 version");
+	if (rc)
+		goto out;
 
-	if ((len = tpm_transmit(chip, data, sizeof(data))) <
-	    CAP_VER_RESULT_SIZE)
-		return len;
-
-	str +=
-	    sprintf(str, "TCG version: %d.%d\nFirmware version: %d.%d\n",
-		    (int) data[14], (int) data[15], (int) data[16],
-		    (int) data[17]);
+	str += sprintf(str,
+		       "TCG version: %d.%d\nFirmware version: %d.%d\n",
+		       (int) data[14], (int) data[15], (int) data[16],
+		       (int) data[17]);
 
+out:
 	return str - buf;
 }
 EXPORT_SYMBOL_GPL(tpm_show_caps);


