Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262258AbUCOFTC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 00:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbUCOFTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 00:19:01 -0500
Received: from cpe-024-033-224-91.neo.rr.com ([24.33.224.91]:46977 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id S262258AbUCOFS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 00:18:58 -0500
Date: Mon, 15 Mar 2004 00:15:19 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Updates for 2.6.4-mm2
Message-ID: <20040315001519.GC5972@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040315000615.GA5972@neo.rr.com> <20040315001029.GB5972@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315001029.GB5972@neo.rr.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ISAPNP] Fix Device Detection Issue

Some isapnp devices were not getting detected as a result of a bug in the isapnp 
driver.  It was not following the specifications and calculating a checksum when
it was not reliable.  This problem was originally discovered by Paul L. Rogers
<rogerspl@datasync.com>.  He made an initial patch.  This release has some small 
modifications, including a check to see if we run out of CSNs.

--- a/drivers/pnp/isapnp/core.c	2004-03-11 02:55:28.000000000 +0000
+++ b/drivers/pnp/isapnp/core.c	2004-03-14 21:55:12.000000000 +0000
@@ -99,6 +99,7 @@
 static unsigned char isapnp_checksum_value;
 static DECLARE_MUTEX(isapnp_cfg_mutex);
 static int isapnp_detected;
+static int isapnp_csn_count;

 /* some prototypes */
 
@@ -371,11 +372,14 @@
 			break;
 		}
 	      __next:
+		if (csn == 255)
+			break;
 		checksum = 0x6a;
 		chksum = 0x00;
 		bit = 0x00;
 	}
 	isapnp_wait();
+	isapnp_csn_count = csn;
 	return csn;
 }
 
@@ -880,7 +884,7 @@
 
 	isapnp_wait();
 	isapnp_key();
-	for (csn = 1; csn <= 10; csn++) {
+	for (csn = 1; csn <= isapnp_csn_count; csn++) {
 		isapnp_wake(csn);
 		isapnp_peek(header, 9);
 		checksum = isapnp_checksum(header);
@@ -890,12 +894,6 @@
 			header[4], header[5], header[6], header[7], header[8]);
 		printk(KERN_DEBUG "checksum = 0x%x\n", checksum);
 #endif
-		/* Don't be strict on the checksum, here !
-                   e.g. 'SCM SwapBox Plug and Play' has header[8]==0 (should be: b7)*/
-		if (header[8] == 0)
-			;
-		else if (checksum == 0x00 || checksum != header[8])	/* not valid CSN */
-			continue;
 		if ((card = isapnp_alloc(sizeof(struct pnp_card))) == NULL)
 			continue;

@@ -932,7 +930,7 @@

 int isapnp_cfg_begin(int csn, int logdev)
 {
-	if (csn < 1 || csn > 10 || logdev > 10)
+	if (csn < 1 || csn > isapnp_csn_count || logdev > 10)
 		return -EINVAL;
 	MOD_INC_USE_COUNT;
 	down(&isapnp_cfg_mutex);
