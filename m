Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWKBArK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWKBArK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 19:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752363AbWKBArK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 19:47:10 -0500
Received: from ozlabs.org ([203.10.76.45]:8881 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1752362AbWKBArG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 19:47:06 -0500
Subject: Re: [PATCH 2/7] paravirtualization: Patch inline replacements for
	common paravirt operations.
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061101152715.f1f94d5c.akpm@osdl.org>
References: <20061029024504.760769000@sous-sol.org>
	 <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de>
	 <1162178936.9802.34.camel@localhost.localdomain>
	 <20061030231132.GA98768@muc.de>
	 <1162376827.23462.5.camel@localhost.localdomain>
	 <1162376894.23462.7.camel@localhost.localdomain>
	 <20061101152715.f1f94d5c.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 11:47:04 +1100
Message-Id: <1162428424.6848.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 15:27 -0800, Andrew Morton wrote:
> On Wed, 01 Nov 2006 21:28:13 +1100
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> > +#ifdef CONFIG_DEBUG_KERNEL
> > +		/* Deliberately clobber regs using "not %reg" to find bugs. */
> 
> That would be considered to be abusive of CONFIG_DEBUG_KERNEL.  A
> CONFIG_DEBUG_PARAVIRT which depends on CONFIG_DEBUG_KERNEL would be more
> harmonious.

I wasn't sure.  Making a config option for what is a one-liner seemed
overkill.

==

Don't abuse CONFIG_DEBUG_KERNEL, add CONFIG_DEBUG_PARAVIRT.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff -r 2707c89d72f0 arch/i386/Kconfig.debug
--- a/arch/i386/Kconfig.debug	Thu Nov 02 10:14:50 2006 +1100
+++ b/arch/i386/Kconfig.debug	Thu Nov 02 11:41:20 2006 +1100
@@ -87,4 +87,14 @@ config DOUBLEFAULT
           option saves about 4k and might cause you much additional grey
           hair.
 
+config DEBUG_PARAVIRT
+	bool "Enable some paravirtualization debugging"
+	default y
+	depends on PARAVIRT && DEBUG_KERNEL
+	help
+	  Currently deliberately clobbers regs which are allowed to be
+	  clobbered in inlined paravirt hooks, even in native mode.
+	  If turning this off solves a problem, then DISABLE_INTERRUPTS() or
+	  ENABLE_INTERRUPTS() is lying about what registers can be clobbered.
+
 endmenu
diff -r 2707c89d72f0 arch/i386/kernel/alternative.c
--- a/arch/i386/kernel/alternative.c	Thu Nov 02 10:14:50 2006 +1100
+++ b/arch/i386/kernel/alternative.c	Thu Nov 02 11:36:54 2006 +1100
@@ -359,7 +359,7 @@ void apply_paravirt(struct paravirt_patc
 
 		used = paravirt_ops.patch(p->instrtype, p->clobbers, p->instr,
 					  p->len);
-#ifdef CONFIG_DEBUG_KERNEL
+#ifdef CONFIG_DEBUG_PARAVIRT
 		/* Deliberately clobber regs using "not %reg" to find bugs. */
 		for (i = 0; i < 3; i++) {
 			if (p->len - used >= 2 && (p->clobbers & (1 << i))) {


