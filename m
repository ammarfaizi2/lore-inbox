Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261499AbSJPV7Z>; Wed, 16 Oct 2002 17:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261457AbSJPV7Y>; Wed, 16 Oct 2002 17:59:24 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52157 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261499AbSJPV6q>; Wed, 16 Oct 2002 17:58:46 -0400
Date: Wed, 16 Oct 2002 19:26:55 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Johannes Ruscheinski <ruschein@mail-infomine.ucr.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre11aa1 Compile Error
In-Reply-To: <20021016214835.GA6510@mail-infomine.ucr.edu>
Message-ID: <Pine.LNX.4.44L.0210161924580.5583-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 16 Oct 2002, Johannes Ruscheinski wrote:

> make[1]: Entering directory `/usr/src/kernel/linux-2.4.20pre11aa1/arch/i386/kernel'
> gcc -D__KERNEL__ -I/usr/src/kernel/linux-2.4.20pre11aa1/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4    -nostdinc -iwithprefix include -DKBUILD_BASENAME=mpparse  -c -o mpparse.o mpparse.c
> mpparse.c:70: `dest_LowestPrio' undeclared here (not in a function)
> make[1]: *** [mpparse.o] Error 1
> make[1]: Leaving directory `/usr/src/kernel/linux-2.4.20pre11aa1/arch/i386/kernel'
>
> .config upon request.

This was caused by a mistake in a patch in 2.4.20-pre11.

The following patch should fix your problem.

diff -Nru a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
--- a/arch/i386/kernel/io_apic.c	Wed Oct 16 19:26:36 2002
+++ b/arch/i386/kernel/io_apic.c	Wed Oct 16 19:26:36 2002
@@ -40,6 +40,10 @@

 static spinlock_t ioapic_lock = SPIN_LOCK_UNLOCKED;

+unsigned int int_dest_addr_mode = APIC_DEST_LOGICAL;
+unsigned char int_delivery_mode = dest_LowestPrio;
+
+
 /*
  * # of IRQ routing registers
  */
diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Wed Oct 16 19:26:36 2002
+++ b/arch/i386/kernel/mpparse.c	Wed Oct 16 19:26:36 2002
@@ -66,8 +66,6 @@
 /* Bitmask of physically existing CPUs */
 unsigned long phys_cpu_present_map;

-unsigned int int_dest_addr_mode = APIC_DEST_LOGICAL;
-unsigned char int_delivery_mode = dest_LowestPrio;
 unsigned char esr_disable = 0;

 /*
diff -Nru a/include/asm-i386/smpboot.h b/include/asm-i386/smpboot.h
--- a/include/asm-i386/smpboot.h	Wed Oct 16 19:26:36 2002
+++ b/include/asm-i386/smpboot.h	Wed Oct 16 19:26:36 2002
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


