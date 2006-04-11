Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWDKUPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWDKUPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbWDKUPN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:15:13 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:15813 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751378AbWDKUPL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:15:11 -0400
Subject: [PATCH] tpm: update to use wait_event calls
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
In-Reply-To: <20060410150324.4dd55994.akpm@osdl.org>
References: <1144679848.4917.15.camel@localhost.localdomain>
	 <20060410150324.4dd55994.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 11 Apr 2006 15:15:59 -0500
Message-Id: <1144786559.12054.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-10 at 15:03 -0700, Andrew Morton wrote:
> 
> > +		interruptible_sleep_on_timeout(&chip->vendor.int_queue,
> > +					       HZ *
> > +					       chip->vendor.timeout_a /
> > +					       1000);
> >
> > ...
> >
> > +		interruptible_sleep_on_timeout(queue, HZ * timeout / 1000);
> 
> Please don't use the sleep_on functions.  They are racy unless (iirc) both
> the waker and wakee are holding lock_kernel().  If the race hits, we miss a
> wakeup.
> 
> These should be converted to the not-racy wait_event_interruptible().

Changed in this patch.

Use wait_event_interruptible_timeout in place of
interruptible_sleep_on_timeout due to its racy nature.

Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm_tis.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

--- linux-2.6.17-rc1/drivers/char/tpm/tpm_tis.c	2006-04-11 12:18:35.573996500 -0500
+++ linux-2.6.16-44/drivers/char/tpm/tpm_tis.c	2006-04-11 14:00:04.341229250 -0500
@@ -95,10 +95,10 @@ static int request_locality(struct tpm_c
 		 chip->vendor.iobase + TPM_ACCESS(l));
 
 	if (chip->vendor.irq) {
-		interruptible_sleep_on_timeout(&chip->vendor.int_queue,
-					       HZ *
-					       chip->vendor.timeout_a /
-					       1000);
+		wait_event_interruptible_timeout(chip->vendor.int_queue,
+						 (check_locality(chip, l) >= 0),
+						 HZ * chip->vendor.timeout_a /
+						 1000);
 		if (check_locality(chip, l) >= 0)
 			return l;
 
@@ -150,7 +150,7 @@ static int get_burstcount(struct tpm_chi
 }
 
 static int wait_for_stat(struct tpm_chip *chip, u8 mask, u32 timeout,
-			 wait_queue_head_t * queue)
+			 wait_queue_head_t *queue)
 {
 	unsigned long stop;
 	u8 status;
@@ -161,7 +161,10 @@ static int wait_for_stat(struct tpm_chip
 		return 0;
 
 	if (chip->vendor.irq) {
-		interruptible_sleep_on_timeout(queue, HZ * timeout / 1000);
+		wait_event_interruptible_timeout(*queue,
+						 ((tpm_tis_status(chip) &
+						   mask) == mask),
+						 HZ * timeout / 1000);
 		status = tpm_tis_status(chip);
 		if ((status & mask) == mask)
 			return 0;


