Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315437AbSHGPMq>; Wed, 7 Aug 2002 11:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSHGPMq>; Wed, 7 Aug 2002 11:12:46 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:5641 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315437AbSHGPMo>; Wed, 7 Aug 2002 11:12:44 -0400
Date: Wed, 7 Aug 2002 17:15:08 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: list linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <laughing@shared-source.org>
Subject: Re: 2.4.20-pre1-ac1: apm.c non SMP compile error
Message-ID: <20020807151508.GA6127@louise.pinerecords.com>
References: <3D511AD8.3C7CF2A7@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D511AD8.3C7CF2A7@eyal.emu.id.au>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 64 days, 6:34
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> apm_save_cpus() is defined without parameters for non-SMP, breaks
> compile.
> 
> --
> Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
> --- linux/arch/i386/kernel/apm.c.orig	Wed Aug  7 22:59:06 2002
> +++ linux/arch/i386/kernel/apm.c	Wed Aug  7 22:56:55 2002
> @@ -524,7 +524,7 @@
>   *	No CPU lockdown needed on a uniprocessor
>   */
>   
> -#define apm_save_cpus	0
> +#define apm_save_cpus()	0
>  #define apm_restore_cpus(x)
>  
>  #endif

or alternatively the following, which for the cost of a couple ifdefs
also removes the unused variable 'cpus' on UP:

diff -urN linux-2.4.20-pre1-ac1/arch/i386/kernel/apm.c linux-2.4.20-pre1-ac1.n/arch/i386/kernel/apm.c
--- linux-2.4.20-pre1-ac1/arch/i386/kernel/apm.c	2002-08-07 17:11:09.000000000 +0200
+++ linux-2.4.20-pre1-ac1.n/arch/i386/kernel/apm.c	2002-08-07 17:08:10.000000000 +0200
@@ -496,9 +496,9 @@
 }
 
 /*
- * Lock APM functionality to physical CPU 0
+ * Lock APM functionality to physical CPU 0 in SMP kernels
  */
- 
+
 #ifdef CONFIG_SMP
 
 static unsigned long apm_save_cpus(void)
@@ -518,15 +518,6 @@
 	set_cpus_allowed(current, mask);
 }
 
-#else
-
-/*
- *	No CPU lockdown needed on a uniprocessor
- */
- 
-#define apm_save_cpus	0
-#define apm_restore_cpus(x)
-
 #endif
 
 /*
@@ -602,8 +593,10 @@
 {
 	APM_DECL_SEGS
 	unsigned long	flags;
+#ifdef CONFIG_SMP
 	unsigned long cpus = apm_save_cpus();
-	
+#endif
+
 	__save_flags(flags);
 	APM_DO_CLI;
 	APM_DO_SAVE_SEGS;
@@ -625,9 +618,11 @@
 		: "memory", "cc");
 	APM_DO_RESTORE_SEGS;
 	__restore_flags(flags);
-	
+
+#ifdef CONFIG_SMP
 	apm_restore_cpus(cpus);
-	
+#endif
+
 	return *eax & 0xff;
 }
 
@@ -651,8 +646,10 @@
 	APM_DECL_SEGS
 	unsigned long	flags;
 
+#ifdef CONFIG_SMP
 	unsigned long cpus = apm_save_cpus();
-	
+#endif
+
 	__save_flags(flags);
 	APM_DO_CLI;
 	APM_DO_SAVE_SEGS;
@@ -679,8 +676,10 @@
 	APM_DO_RESTORE_SEGS;
 	__restore_flags(flags);
 
+#ifdef CONFIG_SMP
 	apm_restore_cpus(cpus);
-	
+#endif
+
 	return error;
 }
 
@@ -935,7 +934,9 @@
 	 */
 	if (apm_info.realmode_power_off)
 	{
+#ifdef CONFIG_SMP
 		apm_save_cpus();
+#endif
 		machine_real_restart(po_bios_call, sizeof(po_bios_call));
 		/* Never returns */
 	}
