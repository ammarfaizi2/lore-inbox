Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWDCQmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWDCQmV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWDCQmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:42:20 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:25801 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751547AbWDCQmC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:42:02 -0400
Subject: PATCH 6/7] tpm: new 1.2 sysfs files
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>,
       Marcel Selhorst <selhorst@crypto.rub.de>
In-Reply-To: <20060331202714.GC22987@sergelap.austin.ibm.com>
References: <1143823501.2992.170.camel@localhost.localdomain>
	 <20060331202714.GC22987@sergelap.austin.ibm.com>
Content-Type: text/plain
Date: Mon, 03 Apr 2006 11:42:41 -0500
Message-Id: <1144082562.29910.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the 1.2 TPM Specification there is more useful information
available.  This information is exported to the user through sysfs
functions that the 1.2 driver will use.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm.c |  206 +++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm.h |    7 +
 2 files changed, 213 insertions(+)

--- linux-2.6.16/drivers/char/tpm/tpm.c	2006-03-30 16:58:10.715155750 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm.c	2006-03-30 16:51:48.567273000 -0600
@@ -431,17 +434,27 @@ out:
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
@@ -459,6 +472,155 @@ static const u8 tpm_cap[] = {
 	0, 0, 1, 0		/* TPM_CAP_SUB_<TYPE> */
 };
 
+void tpm_gen_interrupt(struct tpm_chip *chip)
+{
+	u8 data[30];
+	ssize_t len;
+
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_PROP;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_PROP_TIS_TIMEOUT;
+
+	if ((len = tpm_transmit(chip, data, sizeof(data)))
+	    <= TPM_ERROR_SIZE)
+		dev_dbg(chip->dev, "A TPM error (%d) occurred "
+			"attempting to determine the timeouts\n",
+			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
+}
+EXPORT_SYMBOL_GPL(tpm_gen_interrupt);
+
+void tpm_get_timeouts(struct tpm_chip *chip)
+{
+	u8 data[30];
+	ssize_t len;
+	u32 timeout;
+
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_PROP;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_PROP_TIS_TIMEOUT;
+
+	if ((len = tpm_transmit(chip, data, sizeof(data)))
+	    <= TPM_ERROR_SIZE) {
+		dev_dbg(chip->dev, "A TPM error (%d) occurred "
+			"attempting to determine the timeouts\n",
+			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
+		goto duration;
+	}
+
+	if ((len =
+	     be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_SIZE_IDX))))
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
+	if ((len = tpm_transmit(chip, data, sizeof(data)))
+	    <= TPM_ERROR_SIZE) {
+		dev_dbg(chip->dev, "A TPM error (%d) occurred "
+			"attempting to determine the durations\n",
+			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
+		return;
+	}
+
+	if ((len =
+	     be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_SIZE_IDX))))
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
+ssize_t tpm_show_state(struct device * dev, struct device_attribute * attr,
+		       char *buf)
+{
+	u8 data[35];
+	ssize_t len;
+	char *str = buf;
+
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	if (chip == NULL)
+		return -ENODEV;
+
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_FLAG;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_FLAG_PERM;
+
+	if ((len = tpm_transmit(chip, data, sizeof(data)))
+	    <= TPM_ERROR_SIZE)
+		dev_dbg(chip->dev, "A TPM error (%d) occurred "
+			"attempting to determine the permanent state\n",
+			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
+	else {
+		str +=
+		    sprintf(str, "%s\n",
+			    (data[TPM_GET_CAP_PERM_DISABLE_IDX] ==
+			     1) ? "Disabled" : "Enabled");
+		str +=
+		    sprintf(str, "%s\n",
+			    (data[TPM_GET_CAP_PERM_INACTIVE_IDX] ==
+			     1) ? "Inactive" : "Active");
+	}
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_PROP;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_PROP_OWNER;
+
+	if ((len = tpm_transmit(chip, data, sizeof(data)))
+	    <= TPM_ERROR_SIZE)
+		dev_dbg(chip->dev, "A TPM error (%d) occurred "
+			"attempting to determine the owner state\n",
+			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
+	else
+		str +=
+		    sprintf(str, "%s\n",
+			    (data[TPM_GET_CAP_RET_BOOL_1_IDX] ==
+			     1) ? "Owned" : "Unowned");
+
+	memcpy(data, tpm_cap, sizeof(tpm_cap));
+	data[TPM_CAP_IDX] = TPM_CAP_FLAG;
+	data[TPM_CAP_SUBCAP_IDX] = TPM_CAP_FLAG_VOL;
+
+	if ((len = tpm_transmit(chip, data, sizeof(data)))
+	    <= TPM_ERROR_SIZE) {
+		dev_dbg(chip->dev, "A TPM error (%d) occurred "
+			"attempting to determine the temporary state\n",
+			be32_to_cpu(*((__be32 *) (data + TPM_RET_CODE_IDX))));
+		goto out;
+	}
+
+	if (data[TPM_GET_CAP_TEMP_INACTIVE_IDX] != 0)
+		str += sprintf(str, "Deactivated for this boot\n");
+out:
+	return str - buf;
+}
+EXPORT_SYMBOL_GPL(tpm_show_state);
+
 static const u8 pcrread[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
 	0, 0, 0, 14,		/* length */
@@ -590,6 +768,7 @@ out:
 EXPORT_SYMBOL_GPL(tpm_show_pubek);
 
 #define CAP_VERSION_1_1 6
+#define CAP_VERSION_1_2 0x1A
 #define CAP_VERSION_IDX 13
 static const u8 cap_version[] = {
 	0, 193,			/* TPM_TAG_RQU_COMMAND */
@@ -651,6 +830,52 @@ out:
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
--- linux-2.6.16/drivers/char/tpm/tpm.h	2006-03-30 16:58:10.715155750 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm.h	2006-03-29 14:16:30.119053500 -0600
@@ -41,8 +41,12 @@ extern ssize_t tpm_show_pcrs(struct devi
 				char *);
 extern ssize_t tpm_show_caps(struct device *, struct device_attribute *attr,
 				char *);
+extern ssize_t tpm_show_caps_1_2(struct device *, struct device_attribute *attr,
+				char *);
 extern ssize_t tpm_store_cancel(struct device *, struct device_attribute *attr,
 				const char *, size_t);
+extern ssize_t tpm_show_state(struct device *, struct device_attribute *attr,
+				char *);
 
 struct tpm_chip;
 
@@ -62,6 +68,7 @@ struct tpm_vendor_specific {
 	u8 (*status) (struct tpm_chip *);
 	struct miscdevice miscdev;
 	struct attribute_group *attr_group;
+	u32 timeout_a, timeout_b, timeout_c, timeout_d;
 	u32 duration[3];
 };
 
@@ -100,6 +114,8 @@ static inline void tpm_write_index(int b
 	outb(value & 0xFF, base+1);
 }
 
+extern void tpm_get_timeouts(struct tpm_chip *);
+extern void tpm_gen_interrupt(struct tpm_chip *);
 extern unsigned long tpm_calc_ordinal_duration(struct tpm_chip *, u32);
 extern struct tpm_chip* tpm_register_hardware(struct device *,
 				 const struct tpm_vendor_specific *);


