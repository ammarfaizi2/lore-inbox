Return-Path: <linux-kernel-owner+w=401wt.eu-S932478AbXAGKna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbXAGKna (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 05:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbXAGKna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 05:43:30 -0500
Received: from mtagate6.de.ibm.com ([195.212.29.155]:35993 "EHLO
	mtagate6.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478AbXAGKn3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 05:43:29 -0500
Date: Sun, 7 Jan 2007 11:43:26 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] cio: use barrier() in stsch_reset.
Message-ID: <20070107104326.GB14724@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] cio: use barrier() in stsch_reset.

Use barrier() in stsch_reset() instead of duplicating the stsch()
inline assembly and adding "memory" to the clobberlist.
Pointed out by Chuck Ebbert.

Real fix would be to add a fixup section to the stsch() and extend the
basic program check handler so it searches the exception tables in case
of a program check.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/cio.c linux-2.6-patched/drivers/s390/cio/cio.c
--- linux-2.6/drivers/s390/cio/cio.c	2007-01-06 15:20:12.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/cio.c	2007-01-06 15:20:31.000000000 +0100
@@ -880,19 +880,15 @@ static void cio_reset_pgm_check_handler(
 static int stsch_reset(struct subchannel_id schid, volatile struct schib *addr)
 {
 	int rc;
-	register struct subchannel_id reg1 asm ("1") = schid;
 
 	pgm_check_occured = 0;
 	s390_reset_pgm_handler = cio_reset_pgm_check_handler;
+	rc = stsch(schid, addr);
+	s390_reset_pgm_handler = NULL;
 
-	asm volatile(
-		"       stsch   0(%2)\n"
-		"       ipm     %0\n"
-		"       srl     %0,28"
-		: "=d" (rc)
-		: "d" (reg1), "a" (addr), "m" (*addr) : "memory", "cc");
+	/* The program check handler could have changed pgm_check_occured */
+	barrier();
 
-	s390_reset_pgm_handler = NULL;
 	if (pgm_check_occured)
 		return -EIO;
 	else
