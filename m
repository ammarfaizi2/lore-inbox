Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268360AbUHXVyT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268360AbUHXVyT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268359AbUHXVwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:52:13 -0400
Received: from holomorphy.com ([207.189.100.168]:32902 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268360AbUHXVtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:49:02 -0400
Date: Tue, 24 Aug 2004 14:48:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm4
Message-ID: <20040824214853.GA2793@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, reiserfs-dev@namesys.com,
	linux-kernel@vger.kernel.org
References: <20040822013402.5917b991.akpm@osdl.org> <20040824205621.GU2793@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040824205621.GU2793@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 01:56:21PM -0700, William Lee Irwin III wrote:
> __builtin_return_address() with non-constant arguments is unsupported on
> various architectures.
> fs/reiser4/context.c: In function `get_context_ok':
> fs/reiser4/context.c:88: warning: unsupported arg to `__builtin_return_address'
> fs/reiser4/context.c:89: warning: unsupported arg to `__builtin_return_address'

s/non-constant/nonzero/

Anyway, get_context_ok() appears to be nowhere used in the reiser4 bits
in -mm. Hans, any chance you could filter out some of the non-portable
debug code in the -mm snapshots? Especially the bits not called in -mm.


-- wli

Index: mm4-2.6.8.1/fs/reiser4/context.c
===================================================================
--- mm4-2.6.8.1.orig/fs/reiser4/context.c	2004-08-23 16:11:19.000000000 -0700
+++ mm4-2.6.8.1/fs/reiser4/context.c	2004-08-24 14:39:29.257714400 -0700
@@ -59,58 +59,6 @@
 /* REISER4_DEBUG_CONTEXTS */
 #endif
 
-struct {
-	void *task;
-	void *context;
-	void *path[16];
-} context_ok;
-
-
-
-reiser4_internal void get_context_ok(reiser4_context *ctx)
-{
-	int i;
-	void *addr = NULL, *frame = NULL;
-
-#define CTX_FRAME(nr)						\
-	case (nr):						\
-		addr  = __builtin_return_address((nr));	 	\
-                frame = __builtin_frame_address(nr);		\
-		break
-
-	memset(&context_ok, 0, sizeof(context_ok));
-
-	context_ok.task = current;
-	context_ok.context = ctx;
-	for (i = 0; i < 16; i ++) {
-		switch(i) {
-			CTX_FRAME(0);
-			CTX_FRAME(1);
-			CTX_FRAME(2);
-			CTX_FRAME(3);
-			CTX_FRAME(4);
-			CTX_FRAME(5);
-			CTX_FRAME(6);
-			CTX_FRAME(7);
-			CTX_FRAME(8);
-			CTX_FRAME(9);
-			CTX_FRAME(10);
-			CTX_FRAME(11);
-			CTX_FRAME(12);
-			CTX_FRAME(13);
-			CTX_FRAME(14);
-			CTX_FRAME(15);
-		default:
-			impossible("", "");
-		}
-		if (frame > (void *)ctx)
-			break;
-		context_ok.path[i] = addr;
-	}
-#undef CTX_FRAME
-}
-
-
 /* initialise context and bind it to the current thread
 
    This function should be called at the beginning of reiser4 part of
Index: mm4-2.6.8.1/fs/reiser4/context.h
===================================================================
--- mm4-2.6.8.1.orig/fs/reiser4/context.h	2004-08-23 16:11:19.000000000 -0700
+++ mm4-2.6.8.1/fs/reiser4/context.h	2004-08-24 14:40:11.708260936 -0700
@@ -205,10 +205,6 @@
 
 extern int is_in_reiser4_context(void);
 
-/* return context associated with given thread */
-
-void get_context_ok(reiser4_context *);
-
 /*
  * return reiser4_context for the thread @tsk
  */
