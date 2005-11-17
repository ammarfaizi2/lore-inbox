Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVKQNSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVKQNSa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVKQNSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:18:30 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:58535 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750807AbVKQNS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:18:29 -0500
Date: Thu, 17 Nov 2005 18:48:26 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Cc: ak@suse.de, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/10] kdump: i386 save ss esp bug fix
Message-ID: <20051117131825.GE3981@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20051117131339.GD3981@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117131339.GD3981@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




o This patch fixes a minor bug based on Andi Kleen's suggestion. asm's can't
  be broken in this particular case, hence merging them.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.15-rc1-1M-dynamic-root/arch/i386/kernel/crash.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN arch/i386/kernel/crash.c~kexec-i386-ss-esp-bug-fix arch/i386/kernel/crash.c
--- linux-2.6.15-rc1-1M-dynamic/arch/i386/kernel/crash.c~kexec-i386-ss-esp-bug-fix	2005-11-15 12:29:53.000000000 +0530
+++ linux-2.6.15-rc1-1M-dynamic-root/arch/i386/kernel/crash.c	2005-11-15 14:01:21.000000000 +0530
@@ -108,8 +108,10 @@ static void crash_setup_regs(struct pt_r
 {
 	memcpy(newregs, oldregs, sizeof(*newregs));
 	newregs->esp = (unsigned long)&(oldregs->esp);
-	__asm__ __volatile__("xorl %eax, %eax;");
-	__asm__ __volatile__ ("movw %%ss, %%ax;" :"=a"(newregs->xss));
+	__asm__ __volatile__(
+			"xorl %%eax, %%eax\n\t"
+			"movw %%ss, %%ax\n\t"
+			:"=a"(newregs->xss));
 }
 
 /* We may have saved_regs from where the error came from
_
