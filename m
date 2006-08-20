Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWHTBbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWHTBbT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 21:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWHTBbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 21:31:19 -0400
Received: from 1wt.eu ([62.212.114.60]:40464 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751051AbWHTBbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 21:31:18 -0400
Date: Sun, 20 Aug 2006 03:31:09 +0200
From: Willy Tarreau <w@1wt.eu>
To: Mikael Pettersson <mikpe@it.uu.se>
Cc: ak@suse.de, linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [PATCH 2.4.34-pre1] fix x86_64 etc build failure due to memchr change
Message-ID: <20060820013109.GF27115@1wt.eu>
References: <200608192219.k7JMJ6DQ012098@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608192219.k7JMJ6DQ012098@harpo.it.uu.se>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2006 at 12:19:06AM +0200, Mikael Pettersson wrote:
> 2.4.34-pre1 doesn't build on x86_64:
> 
> kernel/kernel.o(__ksymtab+0x1c10): multiple definition of `__ksymtab_memchr'
> arch/x86_64/kernel/kernel.o(__ksymtab+0x3f0): first defined here
> kernel/kernel.o(.kstrtab+0x3960): multiple definition of `__kstrtab_memchr'
> arch/x86_64/kernel/kernel.o(.kstrtab+0x5fd): first defined here
> ld: Warning: size of symbol `__kstrtab_memchr' changed from 7 in arch/x86_64/kernel/kernel.o to 17 in kernel/kernel.o
> make: *** [vmlinux] Error 1
> 
> This is because the 'export memchr() which is used by smbfs and lp driver'
> change in 2.4.34-pre1 added an EXPORT_SYMBOL of memchr to kernel/ksyms.c
> without also removing the existing one in arch/x86_64/kernel/x8664_ksyms.c.
> Alpha, ARM, ppc32, and SH also have EXPORTs of memchr so they probably
> also broke.
> 
> This patch removes the EXPORTs of memchr under arch/, which fixes x86_64
> and should fix the other architectures as well.

OK Mikael,

I have fixed sparc and sparc64 instead, and it's OK now without having to
export memchr() in kernel/ksyms.c. So the fix is shorter and more logical.
It brings non-sparc architectures to their state before my wrong fix. However,
sparc needs to export memchr() for smbfs and lp.


diff --git a/arch/sparc/kernel/sparc_ksyms.c b/arch/sparc/kernel/sparc_ksyms.c
index 1c08204..f5058fe 100644
--- a/arch/sparc/kernel/sparc_ksyms.c
+++ b/arch/sparc/kernel/sparc_ksyms.c
@@ -297,6 +297,7 @@ EXPORT_SYMBOL_NOVERS(memcmp);
 EXPORT_SYMBOL_NOVERS(memcpy);
 EXPORT_SYMBOL_NOVERS(memset);
 EXPORT_SYMBOL_NOVERS(memmove);
+EXPORT_SYMBOL_NOVERS(memchr);
 EXPORT_SYMBOL_NOVERS(__ashrdi3);
 EXPORT_SYMBOL_NOVERS(__ashldi3);
 EXPORT_SYMBOL_NOVERS(__lshrdi3);
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index 0f1f31f..40accab 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -359,6 +359,7 @@ EXPORT_SYMBOL_NOVERS(__ret_efault);
 /* No version information on these, as gcc produces such symbols. */
 EXPORT_SYMBOL_NOVERS(memcmp);
 EXPORT_SYMBOL_NOVERS(memcpy);
+EXPORT_SYMBOL_NOVERS(memchr);
 EXPORT_SYMBOL_NOVERS(memset);
 EXPORT_SYMBOL_NOVERS(memmove);
 
diff --git a/kernel/ksyms.c b/kernel/ksyms.c
index 73ad3e9..d1e66c7 100644
--- a/kernel/ksyms.c
+++ b/kernel/ksyms.c
@@ -579,7 +579,6 @@ EXPORT_SYMBOL(get_write_access);
 EXPORT_SYMBOL(strnicmp);
 EXPORT_SYMBOL(strspn);
 EXPORT_SYMBOL(strsep);
-EXPORT_SYMBOL(memchr);
 
 #ifdef CONFIG_CRC32
 EXPORT_SYMBOL(crc32_le);

Cheers,
Willy

