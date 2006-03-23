Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWCWKUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWCWKUA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 05:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932350AbWCWKUA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 05:20:00 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:63699 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932267AbWCWKT7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 05:19:59 -0500
Date: Thu, 23 Mar 2006 11:19:57 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: [patch] s390: channel path measurements fixups.
Message-ID: <20060323111957.1bbeedb6@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20060323104722.4183efbb@gondolin.boeblingen.de.ibm.com>
References: <20060322151539.GC5801@skybase.boeblingen.de.ibm.com>
	<20060322132655.79d85b61.akpm@osdl.org>
	<20060323104722.4183efbb@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch] s390: channel path measurements fixups.

- Don't inline __chsc_do_secm().
- Use direct initialization instead of struct initializers for
  chsc_header. gcc generates better code that way.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
CC: Martin Schwidefsky <schwidefsky@de.ibm.com>

 chsc.c |   44 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff -Naurp linux-2.6.16-mm1/drivers/s390/cio/chsc.c linux-2.6.16-mm1+CH/drivers/s390/cio/chsc.c
--- linux-2.6.16-mm1/drivers/s390/cio/chsc.c	2006-03-23 11:01:03.000000000 +0100
+++ linux-2.6.16-mm1+CH/drivers/s390/cio/chsc.c	2006-03-23 11:01:37.000000000 +0100
@@ -98,10 +98,8 @@ chsc_get_sch_desc_irq(struct subchannel 
 
 	ssd_area = page;
 
-	ssd_area->request = (struct chsc_header) {
-		.length = 0x0010,
-		.code   = 0x0004,
-	};
+	ssd_area->request.length = 0x0010;
+	ssd_area->request.code = 0x0004;
 
 	ssd_area->ssid = sch->schid.ssid;
 	ssd_area->f_sch = sch->schid.sch_no;
@@ -517,10 +515,8 @@ chsc_process_crw(void)
 		struct device *dev;
 		memset(sei_area, 0, sizeof(*sei_area));
 		memset(&res_data, 0, sizeof(struct res_acc_data));
-		sei_area->request = (struct chsc_header) {
-			.length = 0x0010,
-			.code   = 0x000e,
-		};
+		sei_area->request.length = 0x0010;
+		sei_area->request.code = 0x000e;
 
 		ccode = chsc(sei_area);
 		if (ccode > 0)
@@ -1018,7 +1014,7 @@ cleanup:
 }
 
 
-static inline int
+static int
 __chsc_do_secm(struct channel_subsystem *css, int enable, void *page)
 {
 	struct {
@@ -1041,10 +1037,8 @@ __chsc_do_secm(struct channel_subsystem 
 	int ret, ccode;
 
 	secm_area = page;
-	secm_area->request = (struct chsc_header) {
-		.length = 0x0050,
-		.code   = 0x0016,
-	};
+	secm_area->request.length = 0x0050;
+	secm_area->request.code = 0x0016;
 
 	secm_area->key = PAGE_DEFAULT_KEY;
 	secm_area->cub_addr1 = (u64)(unsigned long)css->cub_addr1;
@@ -1256,10 +1250,8 @@ chsc_determine_channel_path_description(
 	if (!scpd_area)
 		return -ENOMEM;
 
-	scpd_area->request = (struct chsc_header) {
-		.length = 0x0010,
-		.code   = 0x0002,
-	};
+	scpd_area->request.length = 0x0010;
+	scpd_area->request.code = 0x0002;
 
 	scpd_area->first_chpid = chpid;
 	scpd_area->last_chpid = chpid;
@@ -1355,10 +1347,8 @@ chsc_get_channel_measurement_chars(struc
 	if (!scmc_area)
 		return -ENOMEM;
 
-	scmc_area->request = (struct chsc_header) {
-		.length = 0x0010,
-		.code   = 0x0022,
-	};
+	scmc_area->request.length = 0x0010;
+	scmc_area->request.code = 0x0022;
 
 	scmc_area->first_chpid = chp->id;
 	scmc_area->last_chpid = chp->id;
@@ -1526,10 +1516,8 @@ chsc_enable_facility(int operation_code)
 	sda_area = (void *)get_zeroed_page(GFP_KERNEL|GFP_DMA);
 	if (!sda_area)
 		return -ENOMEM;
-	sda_area->request = (struct chsc_header) {
-		.length = 0x0400,
-		.code = 0x0031,
-	};
+	sda_area->request.length = 0x0400;
+	sda_area->request.code = 0x0031;
 	sda_area->operation_code = operation_code;
 
 	ret = chsc(sda_area);
@@ -1584,10 +1572,8 @@ chsc_determine_css_characteristics(void)
 		return -ENOMEM;
 	}
 
-	scsc_area->request = (struct chsc_header) {
-		.length = 0x0010,
-		.code   = 0x0010,
-	};
+	scsc_area->request.length = 0x0010;
+	scsc_area->request.code = 0x0010;
 
 	result = chsc(scsc_area);
 	if (result) {
