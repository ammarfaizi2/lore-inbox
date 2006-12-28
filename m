Return-Path: <linux-kernel-owner+w=401wt.eu-S1754806AbWL1Kjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806AbWL1Kjb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbWL1Kjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:39:31 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:60310 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbWL1Kja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:39:30 -0500
Date: Thu, 28 Dec 2006 11:39:25 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, holzheu@de.ibm.com
Subject: [S390] cio: fix stsch_reset.
Message-ID: <20061228103925.GB6270@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Holzheu <holzheu@de.ibm.com>

[S390] cio: fix stsch_reset.

Copy inline assembly of stsch and add "memory" to clobber list in order
to prevent gcc from optimizing away the checking of the global variable
"pgm_check_occured".

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2006-12-28 00:33:22.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2006-12-28 00:33:36.000000000 +0100
@@ -2,8 +2,7 @@
  *  drivers/s390/cio/cio.c
  *   S/390 common I/O routines -- low level i/o calls
  *
- *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
- *			      IBM Corporation
+ *    Copyright (C) IBM Corp. 1999,2006
  *    Author(s): Ingo Adlung (adlung@de.ibm.com)
  *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Arnd Bergmann (arndb@de.ibm.com)
@@ -881,10 +880,18 @@ static void cio_reset_pgm_check_handler(
 static int stsch_reset(struct subchannel_id schid, volatile struct schib *addr)
 {
 	int rc;
+	register struct subchannel_id reg1 asm ("1") = schid;
 
 	pgm_check_occured = 0;
 	s390_reset_pgm_handler = cio_reset_pgm_check_handler;
-	rc = stsch(schid, addr);
+
+	asm volatile(
+		"       stsch   0(%2)\n"
+		"       ipm     %0\n"
+		"       srl     %0,28"
+		: "=d" (rc)
+		: "d" (reg1), "a" (addr), "m" (*addr) : "memory", "cc");
+
 	s390_reset_pgm_handler = NULL;
 	if (pgm_check_occured)
 		return -EIO;
