Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261238AbSJPRei>; Wed, 16 Oct 2002 13:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261277AbSJPRei>; Wed, 16 Oct 2002 13:34:38 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:49629 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261238AbSJPReg>;
	Wed, 16 Oct 2002 13:34:36 -0400
Subject: Re: Linux 2.4.20-pre11 - UP compile fails
From: john stultz <johnstul@us.ibm.com>
To: Eran Mann <emann@mrv.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3DAD3A68.4090200@mrv.com>
References: <Pine.LNX.4.44L.0210152109360.31342-100000@freak.distro.conectiva> 
	<3DAD3A68.4090200@mrv.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 16 Oct 2002 10:40:17 -0700
Message-Id: <1034790019.10380.14.camel@laptop.cornchips.homelinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-16 at 03:07, Eran Mann wrote:
> 2.4.20-pre11 compile with CONFIG_X86_LOCAL_APIC but without 
> CONFIG_X86_IO_APIC fails in mpparse.c:
[snip] 
> The offending line is:
> mpparse.c:70:unsigned char int_delivery_mode = dest_LowestPrio;
> 
> This fails because mpparse.c compile depends on CONFIG_X86_LOCAL_APIC 
> while dest_LowestPrio definition in include/asm-i386/io_apic.h depends 
> on CONFIG_X86_IO_APIC.

wow. Good catch! Sorry about that, obviously my fault. 

Fix attached. 

thanks
-john

===== arch/i386/kernel/io_apic.c 1.18 vs edited =====
--- 1.18/arch/i386/kernel/io_apic.c	Thu Oct 10 13:13:57 2002
+++ edited/arch/i386/kernel/io_apic.c	Wed Oct 16 10:19:39 2002
@@ -40,6 +40,10 @@
 
 static spinlock_t ioapic_lock = SPIN_LOCK_UNLOCKED;
 
+unsigned int int_dest_addr_mode = APIC_DEST_LOGICAL;
+unsigned char int_delivery_mode = dest_LowestPrio;
+
+
 /*
  * # of IRQ routing registers
  */
===== arch/i386/kernel/mpparse.c 1.10 vs edited =====
--- 1.10/arch/i386/kernel/mpparse.c	Thu Oct 10 13:13:57 2002
+++ edited/arch/i386/kernel/mpparse.c	Wed Oct 16 10:19:50 2002
@@ -66,8 +66,6 @@
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;
 
-unsigned int int_dest_addr_mode = APIC_DEST_LOGICAL;
-unsigned char int_delivery_mode = dest_LowestPrio;
 unsigned char esr_disable = 0;
 
 /*
===== include/asm-i386/smpboot.h 1.2 vs edited =====
--- 1.2/include/asm-i386/smpboot.h	Thu Oct 10 13:13:57 2002
+++ edited/include/asm-i386/smpboot.h	Wed Oct 16 10:36:44 2002
@@ -26,16 +26,20 @@
 	}
 	return cpu_online_map;
 }
+#ifdef CONFIG_X86_IO_APIC
 extern unsigned char int_delivery_mode;
 extern unsigned int int_dest_addr_mode;
 #define	INT_DEST_ADDR_MODE (int_dest_addr_mode)
 #define	INT_DELIVERY_MODE (int_delivery_mode)
-#else
+#endif /* CONFIG_X86_IO_APIC */
+#else /* CONFIG_X86_LOCAL_APIC */
 #define esr_disable (0)
 #define target_cpus() (0x01)
+#ifdef CONFIG_X86_IO_APIC
 #define INT_DEST_ADDR_MODE (APIC_DEST_LOGICAL)	/* logical delivery */
 #define INT_DELIVERY_MODE (dest_LowestPrio)
-#endif
+#endif /* CONFIG_X86_IO_APIC */
+#endif /* CONFIG_X86_LOCAL_APIC */
 
 #define TRAMPOLINE_LOW phys_to_virt((clustered_apic_mode == CLUSTERED_APIC_NUMAQ)?0x8:0x467)
 #define TRAMPOLINE_HIGH phys_to_virt((clustered_apic_mode == CLUSTERED_APIC_NUMAQ)?0xa:0x469)

