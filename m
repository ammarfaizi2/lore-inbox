Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268266AbUHKWOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268266AbUHKWOy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 18:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUHKWOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 18:14:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:24535 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268266AbUHKWOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 18:14:32 -0400
Date: Thu, 12 Aug 2004 00:14:23 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>,
       AKIYAMA Nobuyuki <akiyama.nobuyuk@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.6.8-rc4-mm1: NMI changes don't compile with SYSCTL=n
Message-ID: <20040811221423.GL26174@fs.tum.de>
References: <20040810002110.4fd8de07.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040810002110.4fd8de07.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 12:21:10AM -0700, Andrew Morton wrote:
>...
> All 529 patches:
>...
> nmi-trigger-switch-support-for-debuggingupdated.patch
>   NMI trigger switch support for debugging(updated)
>...

This causes the following compile error with CONFIG_SYSCTL=n:

<--  snip  -->

...
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.text+0x185de): In function 
`proc_unknown_nmi_panic':
: undefined reference to `unknown_nmi_panic'
arch/i386/kernel/built-in.o(.text+0x185ef): In function 
`proc_unknown_nmi_panic':
: undefined reference to `unknown_nmi_panic'
arch/i386/kernel/built-in.o(.text+0x18615): In function 
`proc_unknown_nmi_panic':
: undefined reference to `unknown_nmi_panic'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


 
The following patch fixes this issue:


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.8-rc4-mm1/arch/i386/kernel/nmi.c.old	2004-08-12 00:07:57.000000000 +0200
+++ linux-2.6.8-rc4-mm1/arch/i386/kernel/nmi.c	2004-08-12 00:09:04.000000000 +0200
@@ -534,6 +534,8 @@
 	}
 }
 
+#ifdef CONFIG_SYSCTL
+
 static int unknown_nmi_panic_callback(struct pt_regs *regs, int cpu)
 {
 	unsigned char reason = get_nmi_reason();
@@ -573,6 +575,8 @@
 	return 0;
 }
 
+#endif
+
 EXPORT_SYMBOL(nmi_active);
 EXPORT_SYMBOL(nmi_watchdog);
 EXPORT_SYMBOL(reserve_lapic_nmi);

