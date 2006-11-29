Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967673AbWK2U52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967673AbWK2U52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 15:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967674AbWK2U52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 15:57:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59306 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967673AbWK2U51 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 15:57:27 -0500
Date: Wed, 29 Nov 2006 12:57:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] compile fix on x86 without X86_LOCAL_APIC (was
 2.6.19-rc6-mm2)
Message-Id: <20061129125715.256bfd7e.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611291222240.28502@twin.jikos.cz>
References: <20061128020246.47e481eb.akpm@osdl.org>
	<Pine.LNX.4.64.0611291222240.28502@twin.jikos.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 13:42:28 +0100 (CET)
Jiri Kosina <jkosina@suse.cz> wrote:

> On Tue, 28 Nov 2006, Andrew Morton wrote:
> 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/
> 
> When i386 kernel is compiled without CONFIG_X86_LOCAL_APIC, this happens:
> 
> In file included from arch/i386/kernel/traps.c:51:
> include/asm/nmi.h:46:1: warning: "trigger_all_cpu_backtrace" redefined
> In file included from arch/i386/kernel/traps.c:32:
> include/linux/nmi.h:25:1: warning: this is the location of the previous definition
> In file included from arch/i386/kernel/traps.c:51:
> include/asm/nmi.h:46:1: warning: "trigger_all_cpu_backtrace" redefined
> In file included from arch/i386/kernel/traps.c:32:
> include/linux/nmi.h:25:1: warning: this is the location of the previous definition
> 
> This is because x86_64-mm-all-cpu-backtrace.patch makes 
> trigger_all_cpu_backtrace to be defined twice in such case. This fixes it.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 

bleargh, what a mess.

> 
>  include/asm-i386/nmi.h   |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
> diff --git a/include/asm-i386/nmi.h b/include/asm-i386/nmi.h
> index 571a32c..02a3f7f 100644
> --- a/include/asm-i386/nmi.h
> +++ b/include/asm-i386/nmi.h
> @@ -42,7 +42,9 @@ extern int proc_nmi_enabled(struct ctl_t
>  			void __user *, size_t *, loff_t *);
>  extern int unknown_nmi_panic;
>  
> +#ifdef ARCH_HAS_NMI_WATCHDOG
>  void __trigger_all_cpu_backtrace(void);
>  #define trigger_all_cpu_backtrace() __trigger_all_cpu_backtrace()
> +#endif
>  
>  #endif /* ASM_NMI_H */

Thanks.  I think really the culprit is include/asm-i386/nmi.h: it's trying
to define and declare NMI-related things in a kernel which won't do NMIs.

This passes simple testing.  I'll beat on it a bit more.


--- a/include/asm-i386/nmi.h~fix-x86_64-mm-all-cpu-backtrace
+++ a/include/asm-i386/nmi.h
@@ -5,7 +5,9 @@
 #define ASM_NMI_H
 
 #include <linux/pm.h>
+#include <asm/irq.h>
 
+#ifdef ARCH_HAS_NMI_WATCHDOG
 /**
  * do_nmi_callback
  *
@@ -45,4 +47,5 @@ extern int unknown_nmi_panic;
 void __trigger_all_cpu_backtrace(void);
 #define trigger_all_cpu_backtrace() __trigger_all_cpu_backtrace()
 
-#endif /* ASM_NMI_H */
+#endif	/* ARCH_HAS_NMI_WATCHDOG */
+#endif	/* ASM_NMI_H */
_

