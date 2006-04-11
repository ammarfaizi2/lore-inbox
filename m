Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751077AbWDKVEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWDKVEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 17:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWDKVEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 17:04:13 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:8663 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751012AbWDKVEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 17:04:11 -0400
Subject: Re: [PATCH] tpm: sysfs function buffer size fix
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
In-Reply-To: <200604112245.02443.ioe-lkml@rameria.de>
References: <1144679825.4917.10.camel@localhost.localdomain>
	 <20060411111834.587e4461.akpm@osdl.org>
	 <1144786558.12054.14.camel@localhost.localdomain>
	 <200604112245.02443.ioe-lkml@rameria.de>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 16:05:02 -0500
Message-Id: <1144789502.12054.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-11 at 22:45 +0200, Ingo Oeser wrote:
> Once in ALL CAPS and once in lower case?
> Sure about these?
Just found this one myself.  Here is the fix.

This patch will determine the size of the buffer in the sysfs functions
based on the size of the command structure(s), such as tpm_cap, and the
known amount of data the command will return.  The receive functions are
smart enough not to overflow the buffer should the command response
change.

Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

--- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm.c	2006-04-11 14:56:13.311776750 -0500
+++ linux-2.6.17-rc1/drivers/char/tpm/tpm.c	2006-04-11 15:03:29.427032250 -0500
@@ -490,7 +490,7 @@ static ssize_t transmit_cmd(struct tpm_c
 
 void tpm_gen_interrupt(struct tpm_chip *chip)
 {
-	u8 data[30];
+	u8 data[max(ARRAY_SIZE(tpm_cap), 30)];
 	ssize_t rc;
 
 	memcpy(data, tpm_cap, sizeof(tpm_cap));
@@ -504,7 +504,7 @@ EXPORT_SYMBOL_GPL(tpm_gen_interrupt);
 
 void tpm_get_timeouts(struct tpm_chip *chip)
 {
-	u8 data[30];
+	u8 data[max(ARRAY_SIZE(tpm_cap), 30)];
 	ssize_t rc;
 	u32 timeout;
 
@@ -564,7 +564,6 @@ EXPORT_SYMBOL_GPL(tpm_get_timeouts);
 
 void tpm_continue_selftest(struct tpm_chip *chip)
 {
-
 	u8 data[] = {
 		0, 193,			/* TPM_TAG_RQU_COMMAND */
 		0, 0, 0, 10,		/* length */
@@ -578,7 +577,7 @@ EXPORT_SYMBOL_GPL(tpm_continue_selftest)
 ssize_t tpm_show_enabled(struct device * dev, struct device_attribute * attr,
 			char *buf)
 {
-	u8 data[35];
+	u8 data[max(ARRAY_SIZE(tpm_cap), 30)];
 	ssize_t rc;
 
 	struct tpm_chip *chip = dev_get_drvdata(dev);
@@ -600,7 +599,7 @@ EXPORT_SYMBOL_GPL(tpm_show_enabled);
 ssize_t tpm_show_active(struct device * dev, struct device_attribute * attr,
 			char *buf)
 {
-	u8 data[35];
+	u8 data[max(ARRAY_SIZE(tpm_cap), 35)];
 	ssize_t rc;
 
 	struct tpm_chip *chip = dev_get_drvdata(dev);
@@ -673,7 +672,7 @@ static const u8 pcrread[] = {
 ssize_t tpm_show_pcrs(struct device *dev, struct device_attribute *attr,
 		      char *buf)
 {
-	u8 data[30];
+	u8 data[max(max(ARRAY_SIZE(tpm_cap), ARRAY_SIZE(pcrread)), 30)];
 	ssize_t rc;
 	int i, j, num_pcrs;
 	__be32 index;
@@ -790,7 +789,7 @@ static const u8 cap_version[] = {
 ssize_t tpm_show_caps(struct device *dev, struct device_attribute *attr,
 		      char *buf)
 {
-	u8 data[30];
+	u8 data[max(max(ARRAY_SIZE(tpm_cap), ARRAY_SIZE(cap_version)), 30)];
 	ssize_t rc;
 	char *str = buf;
 
@@ -830,7 +829,7 @@ EXPORT_SYMBOL_GPL(tpm_show_caps);
 ssize_t tpm_show_caps_1_2(struct device * dev,
 			  struct device_attribute * attr, char *buf)
 {
-	u8 data[30];
+	u8 data[max(max(ARRAY_SIZE(tpm_cap), ARRAY_SIZE(cap_version)), 30)];
 	ssize_t len;
 	char *str = buf;
 


