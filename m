Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279780AbRJ0EXR>; Sat, 27 Oct 2001 00:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279783AbRJ0EXH>; Sat, 27 Oct 2001 00:23:07 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:18583 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S279782AbRJ0EXA>; Sat, 27 Oct 2001 00:23:00 -0400
Message-Id: <m15xL0M-007qc9C@smtp.web.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: =?iso-8859-15?q?Ren=E9=20Scharfe?= <l.s.r@web.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] random.c compiler warning
Date: Sat, 27 Oct 2001 06:40:47 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Alan Cox <alan@redhat.com>, Linus Torvalds <torvalds@transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the patch below removes a compiler warning in random.c. To be exact
it's the first hunk of the patch that does it. There's a comparision
between signed and unsigned values which triggers that warning.

The rest of the patch is just there for consistency and because it just
looks better to me. Those sizeof()s were introduced in kernel 2.4.13, I
just can't imagine why. Care to explain anyone?

René



--- linux-2.4.14-pre2/drivers/char/random.c	Fri Oct 26 23:07:16 2001
+++ linux-2.4.14-pre2-rs/drivers/char/random.c	Sat Oct 27 05:34:34 2001
@@ -1246,7 +1246,7 @@
 	if (r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo.POOLBITS) {
 		int nwords = min(r->poolinfo.poolwords - r->entropy_count/32,
-				 sizeof(tmp) / 4);
+				 TMP_BUF_SIZE);
 
 		DEBUG_ENT("xfer %d from primary to %s (have %d, need %d)\n",
 			  nwords * 32,
@@ -1260,9 +1260,9 @@
 	if (r->extract_count > 1024) {
 		DEBUG_ENT("reseeding %s with %d from primary\n",
 			  r == sec_random_state ? "secondary" : "unknown",
-			  sizeof(tmp) * 8);
-		extract_entropy(random_state, tmp, sizeof(tmp), 0);
-		add_entropy_words(r, tmp, sizeof(tmp) / 4);
+			  TMP_BUF_SIZE * 32);
+		extract_entropy(random_state, tmp, TMP_BUF_SIZE * 4, 0);
+		add_entropy_words(r, tmp, TMP_BUF_SIZE);
 		r->extract_count = 0;
 	}
 }

