Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbUBUFrg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 00:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbUBUFrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 00:47:35 -0500
Received: from hera.kernel.org ([63.209.29.2]:29117 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261516AbUBUFre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 00:47:34 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: BOOT_CS
Date: Sat, 21 Feb 2004 05:47:29 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c16rdh$gtk$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077342449 17333 63.209.29.3 (21 Feb 2004 05:47:29 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 21 Feb 2004 05:47:29 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone happen to know of any legitimate reason not to reload %cs in
head.S?  I think the following would be a lot cleaner, as well as a
lot safer (the jump and indirect branch aren't guaranteed to have the
proper effects, although technically neither should be required due to
the %cr0 write):

@@ -117,10 +147,7 @@
        movl %cr0,%eax
        orl $0x80000000,%eax
        movl %eax,%cr0          /* ..and set paging (PG) bit */
-       jmp 1f                  /* flush the prefetch-queue */
-1:
-       movl $1f,%eax
-       jmp *%eax               /* make sure eip is relocated */
+       ljmp $__BOOT_CS,$1f     /* Clear prefetch and normalize %eip
*/
 1:
        /* Set up the stack pointer */
        lss stack_start,%esp


I've been doing some cleanups in head.S after making the early page
tables dynamic.

	-hpa
