Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266434AbTCCQJ4>; Mon, 3 Mar 2003 11:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbTCCQJ4>; Mon, 3 Mar 2003 11:09:56 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39442 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266434AbTCCQJz>;
	Mon, 3 Mar 2003 11:09:55 -0500
Date: Mon, 3 Mar 2003 16:20:22 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Trivial Kernel Patches <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Stack usage in random.c
Message-ID: <20030303162022.I7301@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik whined about how much stack space was being used by
extract_entropy().  So I went and looked and reclaimed 352 bytes of stack.
Damn SHA ...

It's actually worse (better?) than that -- xfer_secondary_pool() can call
extract_entropy() again, so I may have saved over 700 bytes of stack
usage here.  It's safe for xfer_secondary_pool() to share its parent's
tmp because it hasn't been used at this point.

--- linux-2.5.63/drivers/char/random.c	2003-02-24 13:05:06.000000000 -0600
+++ linux-2.5.63-random/drivers/char/random.c	2003-03-03 08:05:24.000000000 -0600
@@ -1228,10 +1228,8 @@
  * at which point we do a "catastrophic reseeding".
  */
 static inline void xfer_secondary_pool(struct entropy_store *r,
-				       size_t nbytes)
+				       size_t nbytes, __u32 *tmp)
 {
-	__u32	tmp[TMP_BUF_SIZE];
-
 	if (r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo.POOLBITS) {
 		int nwords = min_t(int,
@@ -1284,7 +1282,7 @@
 		r->entropy_count = r->poolinfo.POOLBITS;
 
 	if (flags & EXTRACT_ENTROPY_SECONDARY)
-		xfer_secondary_pool(r, nbytes);
+		xfer_secondary_pool(r, nbytes, tmp);
 
 	DEBUG_ENT("%s has %d bits, want %d bits\n",
 		  r == sec_random_state ? "secondary" :

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
