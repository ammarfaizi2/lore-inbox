Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274908AbTHPTZg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 15:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274909AbTHPTZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 15:25:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:60859 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274908AbTHPTZf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 15:25:35 -0400
Date: Sat, 16 Aug 2003 12:26:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Marco d'Itri" <md@Linux.IT>
Cc: linux-kernel@vger.kernel.org
Subject: Re: an oops in 2.6-test2 (oops)
Message-Id: <20030816122640.69650c65.akpm@osdl.org>
In-Reply-To: <20030816112719.GA1073@wonderland.linux.it>
References: <20030816112719.GA1073@wonderland.linux.it>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marco d'Itri" <md@Linux.IT> wrote:
>
> I've got another one yesterday:
> 
> ...
> 
> Aug 16 07:26:51 wonderland kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
> ...
> Code;  c015c80a <find_inode_fast+1a/60>   <=====
>    0:   0f 18 02                  prefetchnta (%edx)   <=====

And you'll continue to get them until someone does something about it. 
Discussion seemed to die off on this problem.

Until it is sorted, something like this is needed.


diff -puN include/asm-i386/processor.h~disble-athlon-prefetch include/asm-i386/processor.h
--- 25/include/asm-i386/processor.h~disble-athlon-prefetch	2003-08-16 12:22:32.000000000 -0700
+++ 25-akpm/include/asm-i386/processor.h	2003-08-16 12:23:29.000000000 -0700
@@ -568,6 +568,8 @@ static inline void rep_nop(void)
 #define ARCH_HAS_PREFETCH
 extern inline void prefetch(const void *x)
 {
+	if (current_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return;
 	alternative_input(ASM_NOP4,
 			  "prefetchnta (%1)",
 			  X86_FEATURE_XMM,

_

