Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbTH1U1E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 16:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264289AbTH1U1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 16:27:03 -0400
Received: from fw.osdl.org ([65.172.181.6]:16826 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264286AbTH1U00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 16:26:26 -0400
Date: Thu, 28 Aug 2003 13:10:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christopher Swingley <cswingle@iarc.uaf.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4: Unable to handle kernel NULL pointer dereference
Message-Id: <20030828131019.69a9f3b9.akpm@osdl.org>
In-Reply-To: <20030828153448.GA1001@iarc.uaf.edu>
References: <20030828153448.GA1001@iarc.uaf.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Swingley <cswingle@iarc.uaf.edu> wrote:
>
> kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
> ...
> kernel: EIP is at find_inode_fast+0x1a/0x60
> ...
> model name	: AMD Athlon(tm) XP 1800+
> ...

You've been bitten by the athlon-prefetch(0)-goes-oops problem.

Nobody seems to be working this, so I'll be sending the below in to Linus.

--- 25/include/asm-i386/processor.h~disable-athlon-prefetch	2003-08-23 13:48:16.000000000 -0700
+++ 25-akpm/include/asm-i386/processor.h	2003-08-23 13:48:16.000000000 -0700
@@ -578,6 +578,8 @@ static inline void rep_nop(void)
 #define ARCH_HAS_PREFETCH
 extern inline void prefetch(const void *x)
 {
+	if (cpu_data[0].x86_vendor == X86_VENDOR_AMD)
+		return;
 	alternative_input(ASM_NOP4,
 			  "prefetchnta (%1)",
 			  X86_FEATURE_XMM,

_

