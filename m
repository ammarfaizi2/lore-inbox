Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264422AbUEIXWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264422AbUEIXWc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 19:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUEIXWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 19:22:32 -0400
Received: from ozlabs.org ([203.10.76.45]:18393 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264422AbUEIXW3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 19:22:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16542.48455.327467.744190@cargo.ozlabs.ibm.com>
Date: Mon, 10 May 2004 09:22:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org, akpm@osdl.org
Cc: olh@suse.de, benh@kernel.crashing.org, anton@samba.org,
       linux-kernel@vger.kernel.org, rth@twiddle.net, sjmunroe@us.ibm.com
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that we are not handling the TABDLY bits of the termios
c_oflag field correctly on PPC, PPC64 and Alpha.  These three
architectures have a value for XTABS that is different from the TAB3
value.  POSIX specifies that setting the TABDLY field to TAB3 should
result in tabs being expanded to spaces.  In n_tty.c:opost() we check
for O_TABDLY(tty) == XTABS, which is fine on most architectures
because they have XTABS == TAB3.

I think the right thing to do is just to change the definition of
XTABS to be the same as TAB3 on these architectures.  The patch below
does this for PPC and PPC64 (and I suggest the Alpha maintainer should
do the same).  At the moment, applications using either the XTABS or
TAB3 values won't get the expected behaviour.  With this patch, apps
that use TAB3 will get the expected behaviour.  Apps that use XTABS
will need to be recompiled (but note that the POSIX-specified name to
use is TAB3 not XTABS).

Please apply.

Paul.

diff -urN linux-2.5/include/asm-ppc/termbits.h pmac-2.5/include/asm-ppc/termbits.h
--- linux-2.5/include/asm-ppc/termbits.h	2004-02-25 18:39:39.000000000 +1100
+++ pmac-2.5/include/asm-ppc/termbits.h	2004-05-10 08:50:02.279916200 +1000
@@ -81,6 +81,7 @@
 #define   TAB1	00002000
 #define   TAB2	00004000
 #define   TAB3	00006000
+#define   XTABS	00006000	/* required by POSIX to == TAB3 */
 #define CRDLY	00030000
 #define   CR0	00000000
 #define   CR1	00010000
@@ -95,7 +96,6 @@
 #define VTDLY	00200000
 #define   VT0	00000000
 #define   VT1	00200000
-#define XTABS	01000000 /* Hmm.. Linux/i386 considers this part of TABDLY.. */
 
 /* c_cflag bit meaning */
 #define CBAUD	0000377
diff -urN linux-2.5/include/asm-ppc64/termbits.h pmac-2.5/include/asm-ppc64/termbits.h
--- linux-2.5/include/asm-ppc64/termbits.h	2004-02-25 18:39:39.000000000 +1100
+++ pmac-2.5/include/asm-ppc64/termbits.h	2004-05-10 08:50:14.852001624 +1000
@@ -89,6 +89,7 @@
 #define   TAB1	00002000
 #define   TAB2	00004000
 #define   TAB3	00006000
+#define   XTABS	00006000	/* required by POSIX to == TAB3 */
 #define CRDLY	00030000
 #define   CR0	00000000
 #define   CR1	00010000
@@ -103,7 +104,6 @@
 #define VTDLY	00200000
 #define   VT0	00000000
 #define   VT1	00200000
-#define XTABS	01000000 /* Hmm.. Linux/i386 considers this part of TABDLY.. */
 
 /* c_cflag bit meaning */
 #define CBAUD	0000377
