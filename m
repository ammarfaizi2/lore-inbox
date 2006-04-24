Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750884AbWDXPFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbWDXPFg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWDXPFf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:05:35 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:36175 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750872AbWDXPFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:05:21 -0400
Date: Mon, 24 Apr 2006 17:05:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, geraldsc@de.ibm.com
Subject: [patch 10/13] s390: segment operation error codes.
Message-ID: <20060424150521.GK15613@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Schaefer <geraldsc@de.ibm.com>

[patch 10/13] s390: segment operation error codes.

Print a warning with the z/VM error code if segment_load, segment_type
or segment_save fail to ease the problem determination.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/extmem.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/arch/s390/mm/extmem.c linux-2.6-patched/arch/s390/mm/extmem.c
--- linux-2.6/arch/s390/mm/extmem.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/extmem.c	2006-04-24 16:47:27.000000000 +0200
@@ -192,6 +192,7 @@ query_segment_type (struct dcss_segment 
 	diag_cc = dcss_diag (DCSS_SEGEXT, qin, &dummy, &vmrc);
 
 	if (diag_cc > 1) {
+		PRINT_WARN ("segment_type: diag returned error %ld\n", vmrc);
 		rc = dcss_diag_translate_rc (vmrc);
 		goto out_free;
 	}
@@ -553,7 +554,7 @@ segment_save(char *name)
 	int endpfn = 0;
 	char cmd1[160];
 	char cmd2[80];
-	int i;
+	int i, response;
 
 	if (!MACHINE_IS_VM)
 		return;
@@ -576,8 +577,20 @@ segment_save(char *name)
 			segtype_string[seg->range[i].start & 0xff]);
 	}
 	sprintf(cmd2, "SAVESEG %s", name);
-	cpcmd(cmd1, NULL, 0, NULL);
-	cpcmd(cmd2, NULL, 0, NULL);
+	response = 0;
+	cpcmd(cmd1, NULL, 0, &response);
+	if (response) {
+		PRINT_ERR("segment_save: DEFSEG failed with response code %i\n",
+			  response);
+		goto out;
+	}
+	cpcmd(cmd2, NULL, 0, &response);
+	if (response) {
+		PRINT_ERR("segment_save: SAVESEG failed with response code %i\n",
+			  response);
+		goto out;
+	}
+out:
 	spin_unlock(&dcss_lock);
 }
 
