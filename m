Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVA2BCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVA2BCw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 20:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbVA2BCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 20:02:52 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:38922 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S261416AbVA2BCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 20:02:50 -0500
Subject: [patch 1/1] fix syscallN() macro errno value checking for i386
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, blaisorblade@yahoo.it, dhowells@redhat.com
From: blaisorblade@yahoo.it
Date: Sat, 29 Jan 2005 02:01:43 +0100
Message-Id: <20050129010145.1C42F8C9E4@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: David Howells <dhowells@redhat.com>

The errno values which are visible for userspace are actually in the range 
-1 - -129, not until -128 (): this value was added:

#define	EKEYREJECTED	129	/* Key was rejected by service */

And this would break ucLibc (for what I heard).

This is just a quick-fix, because putting a macro inside errno.h instead of
having it copied in two places would be probably nicer.

However, I've heard by D. Howells it wasn't accepted, so this is the solution for now.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.11-paolo/include/asm-i386/unistd.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN include/asm-i386/unistd.h~fix-syscall-macro include/asm-i386/unistd.h
--- linux-2.6.11/include/asm-i386/unistd.h~fix-syscall-macro	2005-01-29 00:42:48.000000000 +0100
+++ linux-2.6.11-paolo/include/asm-i386/unistd.h	2005-01-29 00:44:51.000000000 +0100
@@ -298,12 +298,12 @@
 #define NR_syscalls 289
 
 /*
- * user-visible error numbers are in the range -1 - -128: see
- * <asm-i386/errno.h>
+ * user-visible error numbers are in the range -1 - -129: see
+ * <asm-i386/errno.h> (currently it includes <asm-generic/errno.h>)
  */
 #define __syscall_return(type, res) \
 do { \
-	if ((unsigned long)(res) >= (unsigned long)(-(128 + 1))) { \
+	if ((unsigned long)(res) >= (unsigned long)(-(129 + 1))) { \
 		errno = -(res); \
 		res = -1; \
 	} \
_
