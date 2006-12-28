Return-Path: <linux-kernel-owner+w=401wt.eu-S1754809AbWL1KkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbWL1KkH (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754810AbWL1KkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:40:06 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:60328 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809AbWL1KkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:40:04 -0500
Date: Thu, 28 Dec 2006 11:39:59 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Please pull git390 'for-linus' branch
Message-ID: <20061228103959.GC6270@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 drivers/s390/char/monwriter.c |    2 +-
 drivers/s390/cio/cio.c        |   13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

Melissa Howland (1):
      [S390] Change max. buffer size for monwriter device.

Michael Holzheu (1):
      [S390] cio: fix stsch_reset.

diff --git a/drivers/s390/char/monwriter.c b/drivers/s390/char/monwriter.c
index b9b0fc3..cdb24f5 100644
--- a/drivers/s390/char/monwriter.c
+++ b/drivers/s390/char/monwriter.c
@@ -23,7 +23,7 @@
 #include <asm/appldata.h>
 #include <asm/monwriter.h>
 
-#define MONWRITE_MAX_DATALEN	4024
+#define MONWRITE_MAX_DATALEN	4010
 
 static int mon_max_bufs = 255;
 static int mon_buf_count;
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 3a403f1..b471ac4 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
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
@@ -881,10 +880,18 @@ static void cio_reset_pgm_check_handler(void)
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
