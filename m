Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262891AbVG2XgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262891AbVG2XgN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 19:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbVG2Xd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 19:33:57 -0400
Received: from smtp-4.llnl.gov ([128.115.41.84]:39339 "EHLO smtp-4.llnl.gov")
	by vger.kernel.org with ESMTP id S262891AbVG2Xc1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 19:32:27 -0400
From: Dave Peterson <dsp@llnl.gov>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix bug in x86_64 csum_partial_copy_generic()
Date: Fri, 29 Jul 2005 16:32:19 -0700
User-Agent: KMail/1.5.3
Cc: ak@suse.de
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507291632.19555.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was observing reproducible crashes on the "movw %bx,(%rsi)" instruction
below while a process in a recvfrom() system call was copying packet data
to user space.  The patch below fixes the exception table and causes the
crash to no longer reproduce.  Please apply.

Thanks,
Dave Peterson
<dsp@llnl.gov> <dave_peterson@pobox.com>

diff -urNp -X dontdiff linux-2.6.12.3/arch/x86_64/lib/csum-copy.S linux-2.6.12.3-bugfix/arch/x86_64/lib/csum-copy.S
--- linux-2.6.12.3/arch/x86_64/lib/csum-copy.S	2005-07-15 14:18:57.000000000 -0700
+++ linux-2.6.12.3-bugfix/arch/x86_64/lib/csum-copy.S	2005-07-29 16:06:47.000000000 -0700
@@ -188,8 +188,8 @@ csum_partial_copy_generic:
 	source
 	movw (%rdi),%bx
 	adcl %ebx,%eax
-	dest
 	decl %ecx
+	dest
 	movw %bx,(%rsi)
 	leaq 2(%rdi),%rdi
 	leaq 2(%rsi),%rsi
