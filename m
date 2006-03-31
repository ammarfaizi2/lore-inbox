Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWCaPhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWCaPhU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 10:37:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWCaPhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 10:37:20 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:11150 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1751214AbWCaPhT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 10:37:19 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: [patch] avoid unaligned access when accessing poll stack
From: Jes Sorensen <jes@sgi.com>
Date: 31 Mar 2006 10:38:22 -0500
Message-ID: <yq0sloytyj5.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch 70674f95c0a2ea694d5c39f4e514f538a09be36f
  [PATCH] Optimize select/poll by putting small data sets on the stack
resulted in the poll stack being 4-byte aligned on 64-bit
architectures, causing misaligned accesses to elements in the array.

This patch fixes it by declaring the stack in terms of 'long' instead
of 'char'.

Cheers,
Jes

Force alignment of poll stack to long to avoid unaligned access on 64
bit architectures.

Signed-off-by: Jes Sorensen <jes@sgi.com>

---
 fs/select.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-2.6/fs/select.c
===================================================================
--- linux-2.6.orig/fs/select.c
+++ linux-2.6/fs/select.c
@@ -639,8 +639,10 @@
  	struct poll_list *walk;
 	struct fdtable *fdt;
 	int max_fdset;
-	/* Allocate small arguments on the stack to save memory and be faster */
-	char stack_pps[POLL_STACK_ALLOC];
+	/* Allocate small arguments on the stack to save memory and be 
+	   faster - use long to make sure the buffer is aligned properly
+	   on 64 bit archs to avoid unaligned access */
+	long stack_pps[POLL_STACK_ALLOC/sizeof(long)];
 	struct poll_list *stack_pp = NULL;
 
 	/* Do a sanity check on nfds ... */
