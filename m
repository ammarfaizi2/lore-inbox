Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751135AbWHXL2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbWHXL2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 07:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWHXL2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 07:28:39 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:50483 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751136AbWHXL2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 07:28:38 -0400
Date: Thu, 24 Aug 2006 13:28:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [patch] s390: Use simple_strtoul instead of own cmm_strtoul wrapper.
Message-ID: <20060824112836.GB7022@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Use simple_strtoul instead of own cmm_strtoul wrapper.

Fix compile warning with some configurations:

arch/s390/mm/cmm.c:58: warning: 'cmm_strtoul' defined but not used

Originally cmm_strtoul was introduced because simple_strtoul couldn't
handle strings with hexadecimal numbers that contained a capital 'X'.
Since this is no longer true cmm_strtoul can be removed.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/cmm.c |   30 +++++++-----------------------
 1 files changed, 7 insertions(+), 23 deletions(-)

diff -urpN linux-2.6/arch/s390/mm/cmm.c linux-2.6-patched/arch/s390/mm/cmm.c
--- linux-2.6/arch/s390/mm/cmm.c	2006-08-24 12:09:36.000000000 +0200
+++ linux-2.6-patched/arch/s390/mm/cmm.c	2006-08-24 12:10:50.000000000 +0200
@@ -53,22 +53,6 @@ static void cmm_timer_fn(unsigned long);
 static void cmm_set_timer(void);
 
 static long
-cmm_strtoul(const char *cp, char **endp)
-{
-	unsigned int base = 10;
-
-	if (*cp == '0') {
-		base = 8;
-		cp++;
-		if ((*cp == 'x' || *cp == 'X') && isxdigit(cp[1])) {
-			base = 16;
-			cp++;
-		}
-	}
-	return simple_strtoul(cp, endp, base);
-}
-
-static long
 cmm_alloc_pages(long pages, long *counter, struct cmm_page_array **list)
 {
 	struct cmm_page_array *pa;
@@ -276,7 +260,7 @@ cmm_pages_handler(ctl_table *ctl, int wr
 			return -EFAULT;
 		buf[sizeof(buf) - 1] = '\0';
 		cmm_skip_blanks(buf, &p);
-		pages = cmm_strtoul(p, &p);
+		pages = simple_strtoul(p, &p, 0);
 		if (ctl == &cmm_table[0])
 			cmm_set_pages(pages);
 		else
@@ -317,9 +301,9 @@ cmm_timeout_handler(ctl_table *ctl, int 
 			return -EFAULT;
 		buf[sizeof(buf) - 1] = '\0';
 		cmm_skip_blanks(buf, &p);
-		pages = cmm_strtoul(p, &p);
+		pages = simple_strtoul(p, &p, 0);
 		cmm_skip_blanks(p, &p);
-		seconds = cmm_strtoul(p, &p);
+		seconds = simple_strtoul(p, &p, 0);
 		cmm_set_timeout(pages, seconds);
 	} else {
 		len = sprintf(buf, "%ld %ld\n",
@@ -382,24 +366,24 @@ cmm_smsg_target(char *from, char *msg)
 	if (strncmp(msg, "SHRINK", 6) == 0) {
 		if (!cmm_skip_blanks(msg + 6, &msg))
 			return;
-		pages = cmm_strtoul(msg, &msg);
+		pages = simple_strtoul(msg, &msg, 0);
 		cmm_skip_blanks(msg, &msg);
 		if (*msg == '\0')
 			cmm_set_pages(pages);
 	} else if (strncmp(msg, "RELEASE", 7) == 0) {
 		if (!cmm_skip_blanks(msg + 7, &msg))
 			return;
-		pages = cmm_strtoul(msg, &msg);
+		pages = simple_strtoul(msg, &msg, 0);
 		cmm_skip_blanks(msg, &msg);
 		if (*msg == '\0')
 			cmm_add_timed_pages(pages);
 	} else if (strncmp(msg, "REUSE", 5) == 0) {
 		if (!cmm_skip_blanks(msg + 5, &msg))
 			return;
-		pages = cmm_strtoul(msg, &msg);
+		pages = simple_strtoul(msg, &msg, 0);
 		if (!cmm_skip_blanks(msg, &msg))
 			return;
-		seconds = cmm_strtoul(msg, &msg);
+		seconds = simple_strtoul(msg, &msg, 0);
 		cmm_skip_blanks(msg, &msg);
 		if (*msg == '\0')
 			cmm_set_timeout(pages, seconds);
