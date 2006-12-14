Return-Path: <linux-kernel-owner+w=401wt.eu-S1751938AbWLNBY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938AbWLNBY2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751935AbWLNBY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:24:28 -0500
Received: from web50103.mail.yahoo.com ([206.190.38.31]:40140 "HELO
	web50103.mail.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751938AbWLNBY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:24:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=MP6DC7HQ98aKZkiVG26wcpaSeB/ty6Qjud93QWfIp+5QzbqiH7M83DPBIeNRJ5J25FC1ua+FCDIVzYrRN4gSL1XJRQ9u1m03ezmoWCEHxSJoGcgobWcFm9DOvXMFM6F1gVyNEmMvlNhURF9JyWEDuO1cG/LZym9OS9XEfSrXtr8=;
X-YMail-OSG: 7nXrwSEVM1kweMaKJbB64VooKdDIfYYxTIpxEICa
Date: Wed, 13 Dec 2006 17:17:45 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 1/3] EDAC: Fix in e752x mc driver
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <701304.80899.qm@web50103.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Chan <mikechan@google.com>

Diff against 2.6.19

This fix/change returns the offset into the page for
the ce/ue error, instead of just 0. The e752x dram controller reads
34:6 of the
linear address with the error.

Mike Chan

Signed-off-by: Mike Chan <mikechan@google.com>
Signed-off-by: doug thompson <norsk5@xmission.com>

---

 e752x_edac.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

Index: linux-2.6.19/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.19.orig/drivers/edac/e752x_edac.c
+++ linux-2.6.19/drivers/edac/e752x_edac.c
@@ -285,8 +285,9 @@ static void do_process_ce(struct mem_ctl
 	if (!pvt->map_type)
 		row = 7 - row;
 
-	edac_mc_handle_ce(mci, page, 0, sec1_syndrome, row, channel,
-		"e752x CE");
+	/* e752x mc reads 34:6 of the DRAM linear address */
+	edac_mc_handle_ce(mci, page, offset_in_page(sec1_add << 4),
+			sec1_syndrome, row, channel, "e752x CE");
 }
 
 static inline void process_ce(struct mem_ctl_info *mci, u16 error_one,
@@ -319,8 +320,10 @@ static void do_process_ue(struct mem_ctl
 			((block_page >> 1) & 3) :
 			edac_mc_find_csrow_by_page(mci, block_page);
 
-		edac_mc_handle_ue(mci, block_page, 0, row,
-			"e752x UE from Read");
+		/* e752x mc reads 34:6 of the DRAM linear address */
+		edac_mc_handle_ue(mci, block_page,
+					offset_in_page(error_2b << 4),
+					row, "e752x UE from Read");
 	}
 	if (error_one & 0x0404) {
 		error_2b = scrb_add;
@@ -333,8 +336,10 @@ static void do_process_ue(struct mem_ctl
 			((block_page >> 1) & 3) :
 			edac_mc_find_csrow_by_page(mci, block_page);
 
-		edac_mc_handle_ue(mci, block_page, 0, row,
-				"e752x UE from Scruber");
+		/* e752x mc reads 34:6 of the DRAM linear address */
+		edac_mc_handle_ue(mci, block_page,
+					offset_in_page(error_2b << 4),
+					row, "e752x UE from Scruber");
 	}
 }

