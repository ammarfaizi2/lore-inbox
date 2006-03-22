Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWCVP0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWCVP0P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWCVP0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:26:14 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:3252 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751314AbWCVP0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:26:12 -0500
Date: Wed, 22 Mar 2006 16:26:39 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, edrossma@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 22/24] s390: CEX2A crt message length.
Message-ID: <20060322152639.GV5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Rossman <edrossma@us.ibm.com>

[patch 22/24] s390: CEX2A crt message length.

Undetected edge case for CRT messages to CEX2A caused length to be too short,
thus truncating the message. The solution was to check a different variable
which actually determines which key type is being used.
Increament version number in z90main.c to correct level of 1.3.3, fix
copyright year and add comment about bitlength limit of CEX2A.

Signed-off-by: Eric Rossman <edrossma@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/z90hardware.c |   10 +++++++++-
 drivers/s390/crypto/z90main.c     |    5 +++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/crypto/z90hardware.c linux-2.6-patched/drivers/s390/crypto/z90hardware.c
--- linux-2.6/drivers/s390/crypto/z90hardware.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90hardware.c	2006-03-22 14:36:39.000000000 +0100
@@ -2214,7 +2214,7 @@ ICACRT_msg_to_type50CRT_msg(struct ica_r
 		long_len = 128;
 	}
 
-	tmp_size = ((mod_len <= 128) ? TYPE50_CRB1_LEN : TYPE50_CRB2_LEN) +
+	tmp_size = ((long_len <= 64) ? TYPE50_CRB1_LEN : TYPE50_CRB2_LEN) +
 		    CALLER_HEADER;
 
 	memset(z90cMsg_p, 0, tmp_size);
@@ -2479,8 +2479,16 @@ convert_response(unsigned char *response
 
 	if (reply_code)
 		switch (reply_code) {
+		case REP82_ERROR_MACHINE_FAILURE:
+			if (errh_p->type == TYPE82_RSP_CODE)
+				PRINTKW("Machine check failure\n");
+			else
+				PRINTKW("Module failure\n");
+			return REC_HARDWAR_ERR;
 		case REP82_ERROR_OPERAND_INVALID:
+			return REC_OPERAND_INV;
 		case REP88_ERROR_MESSAGE_MALFORMD:
+			PRINTKW("Message malformed\n");
 			return REC_OPERAND_INV;
 		case REP82_ERROR_OPERAND_SIZE:
 			return REC_OPERAND_SIZE;
diff -urpN linux-2.6/drivers/s390/crypto/z90main.c linux-2.6-patched/drivers/s390/crypto/z90main.c
--- linux-2.6/drivers/s390/crypto/z90main.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/z90main.c	2006-03-22 14:36:39.000000000 +0100
@@ -1,9 +1,9 @@
 /*
  *  linux/drivers/s390/crypto/z90main.c
  *
- *  z90crypt 1.3.2
+ *  z90crypt 1.3.3
  *
- *  Copyright (C)  2001, 2004 IBM Corporation
+ *  Copyright (C)  2001, 2005 IBM Corporation
  *  Author(s): Robert Burroughs (burrough@us.ibm.com)
  *             Eric Rossman (edrossma@us.ibm.com)
  *
@@ -991,6 +991,7 @@ remove_device(struct device *device_p)
  * PCIXCC_MCL2   512-2048     ----- (applying any GA LIC will make an MCL3 card)
  * PCIXCC_MCL3   -----        128-2048
  * CEX2C         512-2048     128-2048
+ * CEX2A          ??-2048     same (the lower limit is less than 128 bit...)
  *
  * ext_bitlens (extended bitlengths) is a global, since you should not apply an
  * MCL to just one card in a machine. We assume, at first, that all cards have
