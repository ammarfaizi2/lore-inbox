Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWDJOgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWDJOgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 10:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWDJOgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 10:36:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:62661 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751184AbWDJOgf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 10:36:35 -0400
Subject: [PATCH 5/7] tpm: command duration update
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Mon, 10 Apr 2006 09:37:16 -0500
Message-Id: <1144679836.4917.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With the TPM 1.2 Specification, each command is classified as short,
medium or long and the chip tells you the maximum amount of time for a
response to each class of command.  This patch provides and array of the
classifications and a function to determine how long the response should
be waited for.  Also, it uses that information in the command processing
to determine how long to poll for.  The function is exported so the 1.2
driver can use the functionality to determine how long to wait for a
DataAvailable interrupt if interrupts are being used.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
drivers/char/tpm/tpm.c |  313 ++++++++++++++++++++++++++++++++++++++-
drivers/char/tpm/tpm.h |    2
2 files changed, 312 insertions(+), 3 deletions(-)

--- linux-2.6.16/drivers/char/tpm/tpm.c	2006-03-30 12:27:02.858478250 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm.c	2006-03-29 14:17:14.421822250 -0600
@@ -35,10 +35,290 @@ enum tpm_const {
 	TPM_NUM_MASK_ENTRIES = TPM_NUM_DEVICES / (8 * sizeof(int))
 };
 
+enum tpm_duration {
+	TPM_SHORT = 0,
+	TPM_MEDIUM = 1,
+	TPM_LONG = 2,
+	TPM_UNDEFINED,
+};
+
+#define TPM_MAX_ORDINAL 243
+#define TPM_MAX_PROTECTED_ORDINAL 12
+#define TPM_PROTECTED_ORDINAL_MASK 0xFF
+
 static LIST_HEAD(tpm_chip_list);
 static DEFINE_SPINLOCK(driver_lock);
 static int dev_mask[TPM_NUM_MASK_ENTRIES];
 
+/*
+ * Array with one entry per ordinal defining the maximum amount
+ * of time the chip could take to return the result.  The ordinal 
+ * designation of short, medium or long is defined in a table in 
+ * TCG Specification TPM Main Part 2 TPM Structures Section 17. The 
+ * values of the SHORT, MEDIUM, and LONG durations are retrieved 
+ * from the chip during initialization with a call to tpm_get_timeouts.
+ */
+static const u8 tpm_protected_ordinal_duration[TPM_MAX_PROTECTED_ORDINAL] = {
+	TPM_UNDEFINED,		/* 0 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 5 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 10 */
+	TPM_SHORT,
+};
+
+static const u8 tpm_ordinal_duration[TPM_MAX_ORDINAL] = {
+	TPM_UNDEFINED,		/* 0 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 5 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 10 */
+	TPM_SHORT,
+	TPM_MEDIUM,
+	TPM_LONG,
+	TPM_LONG,
+	TPM_MEDIUM,		/* 15 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_MEDIUM,
+	TPM_LONG,
+	TPM_SHORT,		/* 20 */
+	TPM_SHORT,
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_SHORT,		/* 25 */
+	TPM_SHORT,
+	TPM_MEDIUM,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_MEDIUM,		/* 30 */
+	TPM_LONG,
+	TPM_MEDIUM,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,		/* 35 */
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_MEDIUM,		/* 40 */
+	TPM_LONG,
+	TPM_MEDIUM,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,		/* 45 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_LONG,
+	TPM_MEDIUM,		/* 50 */
+	TPM_MEDIUM,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 55 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_MEDIUM,		/* 60 */
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_MEDIUM,		/* 65 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 70 */
+	TPM_SHORT,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 75 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_LONG,		/* 80 */
+	TPM_UNDEFINED,
+	TPM_MEDIUM,
+	TPM_LONG,
+	TPM_SHORT,
+	TPM_UNDEFINED,		/* 85 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 90 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_UNDEFINED,		/* 95 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_MEDIUM,		/* 100 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 105 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 110 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,		/* 115 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_LONG,		/* 120 */
+	TPM_LONG,
+	TPM_MEDIUM,
+	TPM_UNDEFINED,
+	TPM_SHORT,
+	TPM_SHORT,		/* 125 */
+	TPM_SHORT,
+	TPM_LONG,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,		/* 130 */
+	TPM_MEDIUM,
+	TPM_UNDEFINED,
+	TPM_SHORT,
+	TPM_MEDIUM,
+	TPM_UNDEFINED,		/* 135 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 140 */
+	TPM_SHORT,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 145 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 150 */
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_UNDEFINED,		/* 155 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 160 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 165 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_LONG,		/* 170 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 175 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_MEDIUM,		/* 180 */
+	TPM_SHORT,
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_MEDIUM,		/* 185 */
+	TPM_SHORT,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 190 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 195 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 200 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,
+	TPM_SHORT,		/* 205 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_MEDIUM,		/* 210 */
+	TPM_UNDEFINED,
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_MEDIUM,
+	TPM_UNDEFINED,		/* 215 */
+	TPM_MEDIUM,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,
+	TPM_SHORT,		/* 220 */
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_SHORT,
+	TPM_UNDEFINED,		/* 225 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 230 */
+	TPM_LONG,
+	TPM_MEDIUM,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,		/* 235 */
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_UNDEFINED,
+	TPM_SHORT,		/* 240 */
+	TPM_UNDEFINED,
+	TPM_MEDIUM,
+};
+
 static void user_reader_timeout(unsigned long ptr)
 {
 	struct tpm_chip *chip = (struct tpm_chip *) ptr;
@@ -57,17 +337,44 @@ static void timeout_work(void *ptr)
 }
 
 /*
+ * Returns max number of jiffies to wait
+ */
+unsigned long tpm_calc_ordinal_duration(struct tpm_chip *chip,
+					   u32 ordinal)
+{
+
+	int duration_idx = TPM_UNDEFINED;
+	int duration = 0;
+
+	if (ordinal < TPM_MAX_ORDINAL)
+		duration_idx = tpm_ordinal_duration[ordinal];
+	else if ((ordinal & TPM_PROTECTED_ORDINAL_MASK) <
+		 TPM_MAX_PROTECTED_ORDINAL)
+		duration_idx =
+		    tpm_protected_ordinal_duration[ordinal &
+						   TPM_PROTECTED_ORDINAL_MASK];
+
+	if (duration_idx != TPM_UNDEFINED)
+		duration = chip->vendor.duration[duration_idx] * HZ / 1000;
+	if (duration <= 0)
+		return 2 * 60 * HZ;
+	else
+		return duration;
+}
+EXPORT_SYMBOL_GPL(tpm_calc_ordinal_duration);
+
+/*
  * Internal kernel interface to transmit TPM commands
  */
 static ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
 			    size_t bufsiz)
 {
 	ssize_t rc;
-	u32 count;
+	u32 count, ordinal;
 	unsigned long stop;
 
 	count = be32_to_cpu(*((__be32 *) (buf + 2)));
-
+	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
 	if (count == 0)
 		return -ENODATA;
 	if (count > bufsiz) {
@@ -78,7 +385,7 @@ static ssize_t tpm_transmit(struct tpm_c
 		goto out;
 	}
 
-	stop = jiffies + 2 * 60 * HZ;
+	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
 	do {
 		u8 status = chip->vendor.status(chip);
 		if ((status & chip->vendor.req_complete_mask) ==
--- linux-2.6.16/drivers/char/tpm/tpm.h	2006-03-30 16:43:45.933110250 -0600
+++ linux-2.6.16-rc1-tpm/drivers/char/tpm/tpm.h	2006-03-29 14:16:30.119053500 -0600
@@ -62,6 +68,7 @@ struct tpm_vendor_specific {
 	u8 (*status) (struct tpm_chip *);
 	struct miscdevice miscdev;
 	struct attribute_group *attr_group;
+	u32 duration[3];
 };
 
 struct tpm_chip {
@@ -99,6 +114,7 @@ static inline void tpm_write_index(int b
 	outb(value & 0xFF, base+1);
 }
 
+extern unsigned long tpm_calc_ordinal_duration(struct tpm_chip *, u32);
 extern struct tpm_chip* tpm_register_hardware(struct device *,
 				 const struct tpm_vendor_specific *);
 extern int tpm_open(struct inode *, struct file *);


