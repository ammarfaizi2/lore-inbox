Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273912AbRJ0Rav>; Sat, 27 Oct 2001 13:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273796AbRJ0Ral>; Sat, 27 Oct 2001 13:30:41 -0400
Received: from zero.tech9.net ([209.61.188.187]:5387 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S273565AbRJ0Rai>;
	Sat, 27 Oct 2001 13:30:38 -0400
Subject: [PATCH] Re: 2.4.14-pre3: some compilerwarnings...
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: Sven Vermeulen <sven.vermeulen@rug.ac.be>, linux-kernel@vger.kernel.org
In-Reply-To: <1004202984.3274.53.camel@phantasy>
In-Reply-To: <20011027185158.A5848@Zenith.starcenter> 
	<1004202984.3274.53.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.25.15.53 (Preview Release)
Date: 27 Oct 2001 13:30:04 -0400
Message-Id: <1004203813.3272.57.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-27 at 13:16, Robert Love wrote:
> <snip>

Hm, while we are at it, let's cleanup the MIN macros, too...might as
well just use the built-in system min.  This patch includes that cleanup
as well as the typecast fix.  Ignore the old, apply this, enjoy.

diff -urN linux-2.4.14-pre3/drivers/char/random.c linux/drivers/char/random.c
--- linux-2.4.14-pre3/drivers/char/random.c	Sat Oct 27 13:13:03 2001
+++ linux/drivers/char/random.c	Sat Oct 27 13:26:34 2001
@@ -406,10 +406,6 @@
  * 
  *****************************************************************/
 
-#ifndef MIN
-#define MIN(a,b) (((a) < (b)) ? (a) : (b))
-#endif
-
 /*
  * Unfortunately, while the GCC optimizer for the i386 understands how
  * to optimize a static rotate left of x bits, it doesn't know how to
@@ -1245,8 +1241,9 @@
 
 	if (r->entropy_count < nbytes * 8 &&
 	    r->entropy_count < r->poolinfo.POOLBITS) {
-		int nwords = min(r->poolinfo.poolwords - r->entropy_count/32,
-				 sizeof(tmp) / 4);
+		int nwords = min_t(int,
+				   r->poolinfo.poolwords - r->entropy_count/32,
+				   sizeof(tmp) / 4);
 
 		DEBUG_ENT("xfer %d from primary to %s (have %d, need %d)\n",
 			  nwords * 32,
@@ -1359,7 +1356,7 @@
 #endif
 		
 		/* Copy data to destination buffer */
-		i = MIN(nbytes, HASH_BUFFER_SIZE*sizeof(__u32)/2);
+		i = min(nbytes, HASH_BUFFER_SIZE*sizeof(__u32)/2);
 		if (flags & EXTRACT_ENTROPY_USER) {
 			i -= copy_to_user(buf, (__u8 const *)tmp, i);
 			if (!i) {
@@ -1586,7 +1583,7 @@
 	size_t		c = count;
 
 	while (c > 0) {
-		bytes = MIN(c, sizeof(buf));
+		bytes = min(c, sizeof(buf));
 
 		bytes -= copy_from_user(&buf, p, bytes);
 		if (!bytes) {


	Robert Love

