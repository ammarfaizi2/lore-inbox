Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbULVR6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbULVR6Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 12:58:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbULVR6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 12:58:24 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:26024 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261442AbULVR6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 12:58:20 -0500
Date: Wed, 22 Dec 2004 18:58:18 +0100
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org, linux-kernel@vger.kernel.org
Cc: marcelo.tosatti@cyclades.com, vandrove@vc.cvut.cz
Subject: [PATCH] [CAN-2004-1144] Fix int 0x80 hole in 2.4 x86-64 linux kernels
Message-ID: <20041222175818.GA3363@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Petr Vandrovec discovered an exploitable root hole on all 2.4 x86-64 kernels.
The problem occurs because the eax register on the 32bit int 0x80 syscall
handler is not properly 64bit zero extended, which can be used to overflow the 
system call table. 

The problem only occurs on 2.4 x86-64 kernels, 2.6 doesn't have this
hole because some unrelated changes in 2.5 fixed it as a side effect.

Marcelo should be releasing a new pre* kernel with this fix 
shortly, there should be also update kernel from the various
linux distributions.

It is recommended that everybody who runs a 2.4 x86-64 kernel with
shell user access updates to a kernel which has this patch applied.

Patch is for 2.4.29pre2, but should apply to pretty much any 
2.4.x x86-64 kernel.

-Andi

diff -u linux-2.4.29pre2/arch/x86_64/ia32/ia32entry.S-o linux-2.4.29pre2/arch/x86_64/ia32/ia32entry.S
--- linux-2.4.29pre2/arch/x86_64/ia32/ia32entry.S-o	2004-11-06 07:37:32.000000000 +0100
+++ linux-2.4.29pre2/arch/x86_64/ia32/ia32entry.S	2004-12-22 18:49:05.000000000 +0100
@@ -52,6 +52,7 @@
 ENTRY(ia32_syscall)
 	swapgs	
 	sti
+	movl %eax,%eax	
 	pushq %rax
 	cld
 	SAVE_ARGS
