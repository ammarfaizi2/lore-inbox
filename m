Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWDKWbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWDKWbr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 18:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWDKWbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 18:31:47 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:11405 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751176AbWDKWbq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 18:31:46 -0400
Subject: [PATCH] tpm: use wait_event return code and msecs_to_jiffies
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Ingo Oeser <ioe-lkml@rameria.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
In-Reply-To: <29495f1d0604111331t7741e6b2g994c234585a59af0@mail.gmail.com>
References: <1144679848.4917.15.camel@localhost.localdomain>
	 <20060410150324.4dd55994.akpm@osdl.org>
	 <1144786559.12054.15.camel@localhost.localdomain>
	 <29495f1d0604111331t7741e6b2g994c234585a59af0@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 17:32:36 -0500
Message-Id: <1144794756.12054.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-11 at 13:31 -0700, Nish Aravamudan wrote:
> Rather than check the condition you slept on right away, couldn't you
> just store the return value of wait_event_interruptible_timeout()? If
> it's positive, the condition should be true, if it's negative, then
> you got a signal, if it's 0, then you timed out. Same would go for the
> other change.

On Tue, 2006-04-11 at 22:40 +0200, Ingo Oeser wrote:
> what about using msecs_to_jiffies(chip->vendor.timeout_a) for this?

Great ideas, patch included below.

Update the usage of wait_event calls to utilize the return code and
msecs_to_jiffies.

Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm_tis.c |   28 +++++++++++++++++-----------
 1 files changed, 17 insertions(+), 11 deletions(-)

--- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm_tis.c	2006-04-11 17:36:08.247422750 -0500
+++ linux-2.6.17-rc1/drivers/char/tpm/tpm_tis.c	2006-04-11 17:26:24.134918000 -0500
@@ -87,6 +87,7 @@ static void release_locality(struct tpm_
 static int request_locality(struct tpm_chip *chip, int l)
 {
 	unsigned long stop;
+	long rc;
 
 	if (check_locality(chip, l) >= 0)
 		return l;
@@ -95,11 +96,14 @@ static int request_locality(struct tpm_c
 		 chip->vendor.iobase + TPM_ACCESS(l));
 
 	if (chip->vendor.irq) {
-		wait_event_interruptible_timeout(chip->vendor.int_queue,
-						 (check_locality(chip, l) >= 0),
-						 HZ * chip->vendor.timeout_a /
-						 1000);
-		if (check_locality(chip, l) >= 0)
+		rc = wait_event_interruptible_timeout(chip->vendor.
+						      int_queue,
+						      (check_locality
+						       (chip, l) >= 0),
+						      msecs_to_jiffies
+						      (chip->vendor.
+						       timeout_a));
+		if (rc > 0)
 			return l;
 
 	} else {
@@ -153,6 +157,7 @@ static int wait_for_stat(struct tpm_chip
 			 wait_queue_head_t *queue)
 {
 	unsigned long stop;
+	long rc;
 	u8 status;
 
 	/* check current status */
@@ -161,12 +166,13 @@ static int wait_for_stat(struct tpm_chip
 		return 0;
 
 	if (chip->vendor.irq) {
-		wait_event_interruptible_timeout(*queue,
-						 ((tpm_tis_status(chip) &
-						   mask) == mask),
-						 HZ * timeout / 1000);
-		status = tpm_tis_status(chip);
-		if ((status & mask) == mask)
+		rc = wait_event_interruptible_timeout(*queue,
+						      ((tpm_tis_status
+							(chip) & mask) ==
+						       mask),
+						      msecs_to_jiffies
+						      (timeout));
+		if (rc > 0)
 			return 0;
 	} else {
 		stop = jiffies + (HZ * timeout / 1000);


