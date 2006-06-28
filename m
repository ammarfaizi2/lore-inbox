Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751527AbWF1U5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbWF1U5L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 16:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWF1U5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 16:57:11 -0400
Received: from mother.pmc-sierra.com ([216.241.224.12]:49139 "HELO
	mother.pmc-sierra.bc.ca") by vger.kernel.org with SMTP
	id S1751527AbWF1U5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 16:57:10 -0400
Subject: IS_ERR Threshold Value
From: Erik Frederiksen <erik_frederiksen@pmc-sierra.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: PMC-Sierra
Message-Id: <1151528227.3904.1110.camel@girvin.pmc-sierra.bc.ca>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Date: Wed, 28 Jun 2006 14:57:07 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


from include/asm-mips/errno.h
#define EDQUOT      1133    /* Quota exceeded */

I noticed that the errno value for EDQUOT on MIPS is considerably larger
than all others.  This can lead to a situation where functions using
ERR_PTR() to return error codes in pointers cannot return this error
code without IS_ERR() thinking that the pointer is valid.  In my case,
it caused an alignment exception in the XFS open call when quota has
been exceeded in the linux-mips 2.6.14 kernel.  I think that the XFS
code has changed enough that this bug isn't in newer versions, though I
haven't done a thorough investigation.  

I've supplied a patch that addresses this situation by changing the
threshold used by IS_ERR if EMAXERRNO is defined and greater than 1000. 
Perhaps permanently raising the threshold value to something >1133 is
sufficient.

Looking forward to your feedback.  

Erik Frederiksen
Firmware Design Engineer Co-op
PMC-Sierra Saskatoon




diff -Nau [ab]/include/linux/err.h
--- a/include/linux/err.h       2005-10-30 13:14:22.000000000 -0600
+++ b/include/linux/err.h       2006-06-28 10:38:43.000000000 -0600
@@ -12,8 +12,23 @@
  *
  * This should be a per-architecture thing, to allow different
  * error and pointer decisions.
+ *
+ * Updated by Erik Frederiksen (erik_frederiksen@pmc-sierra.com)
+ * errno values on MIPS go up to 1133 for EDQUOT.  The threshold
+ * is adjusted so that returning large errnos in a pointer
+ * does not result in a valid pointer according to IS_ERR.
  */
-#define IS_ERR_VALUE(x) unlikely((x) > (unsigned long)-1000L)
+
+#define ERR_PTR_THRESHOLD 1000
+#define IS_ERR_VALUE(x) \
+       unlikely((x) > (unsigned long)-(long)ERR_PTR_THRESHOLD )
+#ifdef EMAXERRNO
+# if EMAXERRNO >= ERR_PTR_THRESHOLD
+#  undef IS_ERR_VALUE
+#  define IS_ERR_VALUE(x) \
+       unlikely((x) >= (unsigned long)-(long)EMAXERRNO )
+# endif
+#endif
  
 static inline void *ERR_PTR(long error)
 {


