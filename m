Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWDLVrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWDLVrO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 17:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWDLVrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 17:47:14 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:44230 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932327AbWDLVrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 17:47:13 -0400
Subject: [PATCH] tpm: msecs_to_jiffies cleanups
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
In-Reply-To: <20060412173236.GA8964@us.ibm.com>
References: <1144679848.4917.15.camel@localhost.localdomain>
	 <20060411230505.GB21210@us.ibm.com>
	 <1144862957.12054.59.camel@localhost.localdomain>
	 <20060412173236.GA8964@us.ibm.com>
Content-Type: text/plain
Date: Wed, 12 Apr 2006 16:48:03 -0500
Message-Id: <1144878483.12054.92.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-12 at 10:32 -0700, Nishanth Aravamudan wrote:
> On 12.04.2006 [12:29:17 -0500], Kylene Jo Hall wrote:
> > On Tue, 2006-04-11 at 16:05 -0700, Nishanth Aravamudan wrote:
> > > This looks like it could take the msecs_to_jiffies() conversion as well.
> > > Might as well cache it before the if/else, as both clauses use it?
> > > Really, it is just wait_event*() without the wait-queue. Well, this is
> > > at least one more consumer potentially of the poll_event*() API I had
> > > written a while back, I'll dust it off again if I have the time.
> > > 
> > Since the timeout and duration values are always used in jiffies I
> > think I'll just convert them to those values when I store them in the
> > chip struct to cut way down on the number of conversions all together.
> > Sound reasonable?
> 
> Probably, as long as they aren't exposed to userspace in any way. I
> don't think userspace should do any calculations in jiffies units.

The timeout and duration values used in the tpm driver are not exposed
to userspace.  This patch converts the storage units to jiffies with
msecs_to_jiffies.  They were always being used in jiffies so this
simplifies things removing the need for calculation all over the place.
The change necessitated a type change in the tpm_chip struct to hold
jiffies.

Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm.c     |   22 ++++++++++++++--------
 drivers/char/tpm/tpm.h     |    4 ++--
 drivers/char/tpm/tpm_tis.c |   32 ++++++++++++++++----------------
 3 files changed, 32 insertions(+), 26 deletions(-)

--- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm.h	2006-04-11 12:18:35.569996000 -0500
+++ linux-2.6.17-rc1/drivers/char/tpm/tpm.h	2006-04-12 13:58:17.558218250 -0500
@@ -77,8 +77,8 @@ struct tpm_vendor_specific {
 	struct attribute_group *attr_group;
 	struct list_head list;
 	int locality;
-	u32 timeout_a, timeout_b, timeout_c, timeout_d;
-	u32 duration[3];
+	unsigned long timeout_a, timeout_b, timeout_c, timeout_d; /* jiffies */
+	unsigned long duration[3]; /* jiffies */
 
 	wait_queue_head_t read_queue;
 	wait_queue_head_t int_queue;
--- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm.c	2006-04-12 16:36:51.868825500 -0500
+++ linux-2.6.17-rc1/drivers/char/tpm/tpm.c	2006-04-12 14:11:16.150877250 -0500
@@ -354,7 +354,7 @@ unsigned long tpm_calc_ordinal_duration(
 						   TPM_PROTECTED_ORDINAL_MASK];
 
 	if (duration_idx != TPM_UNDEFINED)
-		duration = chip->vendor.duration[duration_idx] * HZ / 1000;
+		duration = chip->vendor.duration[duration_idx];
 	if (duration <= 0)
 		return 2 * 60 * HZ;
 	else
@@ -524,19 +524,19 @@ void tpm_get_timeouts(struct tpm_chip *c
 	timeout = 
 	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_1_IDX)));
 	if (timeout)
-		chip->vendor.timeout_a = timeout;
+		chip->vendor.timeout_a = msecs_to_jiffies(timeout);
 	timeout =
 	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_2_IDX)));
 	if (timeout)
-		chip->vendor.timeout_b = timeout;
+		chip->vendor.timeout_b = msecs_to_jiffies(timeout);
 	timeout =
 	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_3_IDX)));
 	if (timeout)
-		chip->vendor.timeout_c = timeout;
+		chip->vendor.timeout_c = msecs_to_jiffies(timeout);
 	timeout =
 	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_4_IDX)));
 	if (timeout)
-		chip->vendor.timeout_d = timeout;
+		chip->vendor.timeout_d = msecs_to_jiffies(timeout);
 
 duration:
 	memcpy(data, tpm_cap, sizeof(tpm_cap));
@@ -553,11 +553,17 @@ duration:
 		return;
 
 	chip->vendor.duration[TPM_SHORT] =
-	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_1_IDX)));
+	    msecs_to_jiffies(be32_to_cpu
+			     (*((__be32 *) (data +
+					    TPM_GET_CAP_RET_UINT32_1_IDX))));
 	chip->vendor.duration[TPM_MEDIUM] =
-	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_2_IDX)));
+	    msecs_to_jiffies(be32_to_cpu
+			     (*((__be32 *) (data +
+					    TPM_GET_CAP_RET_UINT32_2_IDX))));
 	chip->vendor.duration[TPM_LONG] =
-	    be32_to_cpu(*((__be32 *) (data + TPM_GET_CAP_RET_UINT32_3_IDX)));
+	    msecs_to_jiffies(be32_to_cpu
+			     (*((__be32 *) (data +
+					    TPM_GET_CAP_RET_UINT32_3_IDX))));
 }
 EXPORT_SYMBOL_GPL(tpm_get_timeouts);
 
--- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm_tis.c	2006-04-12 11:45:37.288732500 -0500
+++ linux-2.6.17-rc1/drivers/char/tpm/tpm_tis.c	2006-04-12 14:49:13.033173500 -0500
@@ -51,6 +51,11 @@ enum tis_int_flags {
 	TPM_INTF_DATA_AVAIL_INT = 0x001,
 };
 
+enum tis_defaults {
+	TIS_SHORT_TIMEOUT = 750, /* ms */
+	TIS_LONG_TIMEOUT = 2000, /* 2 sec */
+};
+
 #define	TPM_ACCESS(l)			(0x0000 | ((l) << 12))
 #define	TPM_INT_ENABLE(l)		(0x0008 | ((l) << 12))
 #define	TPM_INT_VECTOR(l)		(0x000C | ((l) << 12))
@@ -96,19 +103,16 @@ static int request_locality(struct tpm_c
 		 chip->vendor.iobase + TPM_ACCESS(l));
 
 	if (chip->vendor.irq) {
-		rc = wait_event_interruptible_timeout(chip->vendor.
-						      int_queue,
+		rc = wait_event_interruptible_timeout(chip->vendor.int_queue,
 						      (check_locality
 						       (chip, l) >= 0),
-						      msecs_to_jiffies
-						      (chip->vendor.
-						       timeout_a));
+						      chip->vendor.timeout_a);
 		if (rc > 0)
 			return l;
 
 	} else {
 		/* wait for burstcount */
-		stop = jiffies + (HZ * chip->vendor.timeout_a / 1000);
+		stop = jiffies + chip->vendor.timeout_a;
 		do {
 			if (check_locality(chip, l) >= 0)
 				return l;
@@ -139,7 +143,7 @@ static int get_burstcount(struct tpm_chi
 
 	/* wait for burstcount */
 	/* which timeout value, spec has 2 answers (c & d) */
-	stop = jiffies + (HZ * chip->vendor.timeout_d / 1000);
+	stop = jiffies + chip->vendor.timeout_d;
 	do {
 		burstcnt = ioread8(chip->vendor.iobase +
 				   TPM_STS(chip->vendor.locality) + 1);
@@ -153,7 +157,7 @@ static int get_burstcount(struct tpm_chi
 	return -EBUSY;
 }
 
-static int wait_for_stat(struct tpm_chip *chip, u8 mask, u32 timeout,
+static int wait_for_stat(struct tpm_chip *chip, u8 mask, unsigned long timeout,
 			 wait_queue_head_t *queue)
 {
 	unsigned long stop;
@@ -169,13 +173,11 @@ static int wait_for_stat(struct tpm_chip
 		rc = wait_event_interruptible_timeout(*queue,
 						      ((tpm_tis_status
 							(chip) & mask) ==
-						       mask),
-						      msecs_to_jiffies
-						      (timeout));
+						       mask), timeout);
 		if (rc > 0)
 			return 0;
 	} else {
-		stop = jiffies + (HZ * timeout / 1000);
+		stop = jiffies + timeout;
 		do {
 			msleep(TPM_TIMEOUT);
 			status = tpm_tis_status(chip);
@@ -453,10 +460,10 @@ static int __devinit tpm_tis_pnp_init(st
 	}
 
 	/* Default timeouts */
-	chip->vendor.timeout_a = 750;	/* ms */
-	chip->vendor.timeout_b = 2000;	/* 2 sec */
-	chip->vendor.timeout_c = 750;	/* ms */
-	chip->vendor.timeout_d = 750;	/* ms */
+	chip->vendor.timeout_a = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
+	chip->vendor.timeout_b = msecs_to_jiffies(TIS_LONG_TIMEOUT);
+	chip->vendor.timeout_c = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
+	chip->vendor.timeout_d = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
 
 	dev_info(&pnp_dev->dev,
 		 "1.2 TPM (device-id 0x%X, rev-id %d)\n",



