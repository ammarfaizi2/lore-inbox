Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWDETrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWDETrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 15:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWDETrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 15:47:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:44974 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751338AbWDETrg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 15:47:36 -0400
Subject: Re: PATCH 6/7] tpm: new 1.2 sysfs files - Updated patch
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: greg@kroah.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       Marcel Selhorst <selhorst@crypto.rub.de>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 14:48:24 -0500
Message-Id: <1144266504.5235.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Apr 03, 2006 at 21:47:25 Greg KH wrote:
<snip>
> > +EXPORT_SYMBOL_GPL(tpm_show_state);
> 
> That is more than one value per file.  Please make unique files for the
> different capabilities.  As it stands the file doesn't make too much
> sense for someone reading it and not understanding that each line is a
> different portion of the state.
> 
> thanks,
> 
> greg k-h
tpm_show_state removed in this patch in favor of separate files.

From: Kylene Hall <kjhall@us.ibm.com>

Many of the sysfs files were calling the TPM_GetCapability command with
different options and each command layed out in its own static const
array.  Since for 1.2 more sysfs files of this type are coming I am
generalizing the array so there can be one array and the unique parts
can be filled in just before the command is called.

This updated version of the patch breaks the multi-value sysfs file into
separate files pointed out by Greg.  It also addresses the code
redundancy and ugliness in the tpm_show_* functions pointed out on
another patch by Dave Hansen.  It replaces the 6/7 patch from the
original set.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm.c |  219 +++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm.h |   13 ++
 2 files changed, 232 insertions(+)

--- linux-2.6.16/drivers/char/tpm/tpm.c	2006-04-04 13:33:22.031062750 -0500
+++ linux-2.6.16-44/drivers/char/tpm/tpm.c	2006-04-04 13:29:09.019250500 -0500
@@ -431,17 +431,27 @@ out:
 #define TPM_GET_CAP_RET_UINT32_2_IDX 18
 #define TPM_GET_CAP_RET_UINT32_3_IDX 22
 #define TPM_GET_CAP_RET_UINT32_4_IDX 26
+#define TPM_GET_CAP_PERM_DISABLE_IDX 16
+#define TPM_GET_CAP_PERM_INACTIVE_IDX 18
+#define TPM_GET_CAP_RET_BOOL_1_IDX 14
+#define TPM_GET_CAP_TEMP_INACTIVE_IDX 16
 
 #define TPM_CAP_IDX 13
 #define TPM_CAP_SUBCAP_IDX 21
 
 enum tpm_capabilities {
+	TPM_CAP_FLAG = 4,
 	TPM_CAP_PROP = 5,
 };
 
 enum tpm_sub_capabilities {
 	TPM_CAP_PROP_PCR = 0x1,
 	TPM_CAP_PROP_MANUFACTURER = 0x3,
+	TPM_CAP_FLAG_PERM = 0x8,
+	TPM_CAP_FLAG_VOL = 0x9,
+	TPM_CAP_PROP_OWNER = 0x11,
+	TPM_CAP_PROP_TIS_TIMEOUT = 0x15,
+	TPM_CAP_PROP_TIS_DURATION = 0x20,
 };
 
 /*
@@ -475,6 +485,168 @@ static ssize_t transmit_cmd(struct tpm_c
 	return 0;
 }
 
+void tpm_gen_interrupt(struct tpm_chip *chip)
+{
+	u8 data[30];
+	ssize_t rc;
+
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_PROP;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_PROP_TIS_TIMEOUT;
+
+	rc = transmit_cmd(chip, data, sizeof(data),
+			"attempting to determine the timeouts");
+}
+EXPORT_SYMBOL_GPL(tpm_gen_interrupt);
+
+void tpm_get_timeouts(struct tpm_chip *chip)
+{
+	u8 data[30];
+	ssize_t rc;
+	u32 timeout;
+
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_PROP;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_PROP_TIS_TIMEOUT;
+
+	rc = transmit_cmd(chip, data, sizeof(data),
+			"attempting to determine the timeouts");
+	if (rc)
+		goto duration;
+
+	if (be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_SIZE_IDX)))
+	    != 4 * sizeof(u32))
+		goto duration;
+
+	/* Don't overwrite default if value is 0 */
+	timeout = 
+	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_1_IDX)));
+	if (timeout)
+		chip->vendor.timeout_a = timeout;
+	timeout =
+	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_2_IDX)));
+	if (timeout)
+		chip->vendor.timeout_b = timeout;
+	timeout =
+	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_3_IDX)));
+	if (timeout)
+		chip->vendor.timeout_c = timeout;
+	timeout =
+	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_4_IDX)));
+	if (timeout)
+		chip->vendor.timeout_d = timeout;
+
+duration:
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_PROP;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_PROP_TIS_DURATION;
+
+	rc = transmit_cmd(chip, data, sizeof(data),
+			"attempting to determine the durations");
+	if (rc)
+		return;
+
+	if (be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_SIZE_IDX)))
+	    != 3 * sizeof(u32))
+		return;
+
+	chip->vendor.duration[TPM_SHORT] =
+	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_1_IDX)));
+	chip->vendor.duration[TPM_MEDIUM] =
+	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_2_IDX)));
+	chip->vendor.duration[TPM_LONG] =
+	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_3_IDX)));
+}
+EXPORT_SYMBOL_GPL(tpm_get_timeouts);
+
+ssize_t tpm_show_enabled(struct device * dev, struct device_attribute * attr,
+			char *buf)
+{
+	u8 data[35];
+	ssize_t rc;
+
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	if (chip == NULL)
+		return -ENODEV;
+
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_FLAG;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_FLAG_PERM;
+
+	rc = transmit_cmd(chip, data, sizeof(data),
+			"attemtping to determine the permanent state");
+	if (rc)
+		return 0;
+	return sprintf(buf, "%d\n", !data[TPM_GET_CAP_PERM_DISABLE_IDX]);
+}
+EXPORT_SYMBOL_GPL(tpm_show_enabled);
+
+ssize_t tpm_show_active(struct device * dev, struct device_attribute * attr,
+			char *buf)
+{
+	u8 data[35];
+	ssize_t rc;
+
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	if (chip == NULL)
+		return -ENODEV;
+
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_FLAG;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_FLAG_PERM;
+
+	rc = transmit_cmd(chip, data, sizeof(data),
+			"attemtping to determine the permanent state");
+	if (rc)
+		return 0;
+	return sprintf(buf, "%d\n", !data[TPM_GET_CAP_PERM_INACTIVE_IDX]);
+}
+EXPORT_SYMBOL_GPL(tpm_show_active);
+
+ssize_t tpm_show_owned(struct device * dev, struct device_attribute * attr,
+			char *buf)
+{
+	u8 data[sizeof(tpm_cap)];
+	ssize_t rc;
+
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	if (chip == NULL)
+		return -ENODEV;
+
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_PROP;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_PROP_OWNER;
+
+	rc = transmit_cmd(chip, data, sizeof(data),
+			"attempting to determine the owner state");
+	if (rc)
+		return 0;
+	return sprintf(buf, "%d\n", data[TPM_GET_CAP_RET_BOOL_1_IDX]);
+}
+EXPORT_SYMBOL_GPL(tpm_show_owned);
+
+ssize_t tpm_show_temp_deactivated(struct device * dev, 
+				struct device_attribute * attr, char *buf)
+{
+	u8 data[sizeof(tpm_cap)];
+	ssize_t rc;
+
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	if (chip == NULL)
+		return -ENODEV;
+
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_FLAG;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_FLAG_VOL;
+
+	rc = transmit_cmd(chip, data, sizeof(data),
+			"attempting to determine the temporary state");
+	if (rc)
+		return 0;
+	return sprintf(buf, "%d\n", data[TPM_GET_CAP_TEMP_INACTIVE_IDX]);
+}
+EXPORT_SYMBOL_GPL(tpm_show_temp_deactivated);
+			
 static const u8 pcrread[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 14,		/* length */
@@ -589,6 +761,7 @@ out:
 EXPORT_SYMBOL_GPL(tpm_show_pubek);
 
 #define CAP_VERSION_1_1 6
+#define CAP_VERSION_1_2 0x1A
 #define CAP_VERSION_IDX 13
 static const u8 cap_version[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
@@ -638,6 +811,52 @@ out:
 }
 EXPORT_SYMBOL_GPL(tpm_show_caps);
 
+ssize_t tpm_show_caps_1_2(struct device * dev,
+			  struct device_attribute * attr, char *buf)
+{
+	u8 data[30];
+	ssize_t len;
+	char *str = buf;
+
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	if (chip == NULL)
+		return -ENODEV;
+
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_PROP;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_PROP_MANUFACTURER;
+
+	if ((len = tpm_transmit(chip, data, sizeof(data))) <=
+	    TPM_ERROR_SIZE) {
+		dev_dbg(chip->dev, "A TPM error (%d) occurred "
+			"attempting to determine the manufacturer\n",
+			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
+		return 0;
+	}
+
+	str += sprintf(str, "Manufacturer: 0x%x\n",
+		       be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_1_IDX))));
+
+	memcpy(data, cap_version, sizeof(cap_version));
+	data[CAP_VERSION_IDX] = CAP_VERSION_1_2;
+
+	if ((len = tpm_transmit(chip, data, sizeof(data))) <=
+	    TPM_ERROR_SIZE) {
+		dev_err(chip->dev, "A TPM error (%d) occurred "
+			"attempting to determine the 1.2 version\n",
+			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
+		goto out;
+	}
+	str += sprintf(str,
+		       "TCG version: %d.%d\nFirmware version: %d.%d\n",
+		       (int) data[16], (int) data[17], (int) data[18],
+		       (int) data[19]);
+
+out:
+	return str - buf;
+}
+EXPORT_SYMBOL_GPL(tpm_show_caps_1_2);
+
 ssize_t tpm_store_cancel(struct device *dev, struct device_attribute *attr,
 			const char *buf, size_t count)
 {
--- linux-2.6.16/drivers/char/tpm/tpm.h	2006-04-04 13:33:22.031062750 -0500
+++ linux-2.6.16-44/drivers/char/tpm/tpm.h	2006-04-04 13:09:14.328587000 -0500
@@ -41,8 +41,18 @@ extern ssize_t tpm_show_pcrs(struct devi
 				char *);
 extern ssize_t tpm_show_caps(struct device *, struct device_attribute *attr,
 				char *);
+extern ssize_t tpm_show_caps_1_2(struct device *, struct device_attribute *attr,
+				char *);
 extern ssize_t tpm_store_cancel(struct device *, struct device_attribute *attr,
 				const char *, size_t);
+extern ssize_t tpm_show_enabled(struct device *, struct device_attribute *attr,
+				char *);
+extern ssize_t tpm_show_active(struct device *, struct device_attribute *attr,
+				char *);
+extern ssize_t tpm_show_owned(struct device *, struct device_attribute *attr,
+				char *);
+extern ssize_t tpm_show_temp_deactivated(struct device *,
+					 struct device_attribute *attr, char *);
 
 struct tpm_chip;
 
@@ -62,6 +72,7 @@ struct tpm_vendor_specific {
 	u8 (*status) (struct tpm_chip *);
 	struct miscdevice miscdev;
 	struct attribute_group *attr_group;
+	u32 timeout_a, timeout_b, timeout_c, timeout_d;
 	u32 duration[3];
 };
 
@@ -100,6 +111,8 @@ static inline void tpm_write_index(int b
 	outb(value & 0xFF, base+1);
 }
 
+extern void tpm_get_timeouts(struct tpm_chip *);
+extern void tpm_gen_interrupt(struct tpm_chip *);
 extern unsigned long tpm_calc_ordinal_duration(struct tpm_chip *, u32);
 extern struct tpm_chip* tpm_register_hardware(struct device *,
 				 const struct tpm_vendor_specific *);


