Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVEFEB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVEFEB5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 00:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262199AbVEFEB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 00:01:57 -0400
Received: from ozlabs.org ([203.10.76.45]:7127 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262195AbVEFEBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 00:01:55 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17018.58526.779356.782923@cargo.ozlabs.ibm.com>
Date: Fri, 6 May 2005 13:29:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, torvalds@osdl.org
CC: apw@us.ibm.com, anton@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ppc64: fix prom.c compile warning
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code in unflatten_device_tree knows that get_property is written to
only return with lenp equal to 1 when also returning a valid pointer.
The gcc 3.3.3 compiler is not able to prove this to itself, so it warns
about a possible uninitialized pointer dereference:

 .../arch/ppc64/kernel/prom.c: In function `unflatten_device_tree':
 .../arch/ppc64/kernel/prom.c:828:
 warning: `p' might be used uninitialized in this function

Unless it is desired to rework the interaction between the two
functions, this will keep the existing behavior but quiet the compiler.

Signed-off-by: Amos Waterland <apw@us.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff -urN linux-2.6/arch/ppc64/kernel/prom.c test/arch/ppc64/kernel/prom.c
--- linux-2.6/arch/ppc64/kernel/prom.c	2005-05-02 08:29:36.000000000 +1000
+++ test/arch/ppc64/kernel/prom.c	2005-05-06 13:27:29.000000000 +1000
@@ -834,7 +834,7 @@
 {
 	unsigned long start, mem, size;
 	struct device_node **allnextp = &allnodes;
-	char *p;
+	char *p = NULL;
 	int l = 0;
 
 	DBG(" -> unflatten_device_tree()\n");
