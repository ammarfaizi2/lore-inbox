Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314034AbSDQCrR>; Tue, 16 Apr 2002 22:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314035AbSDQCrQ>; Tue, 16 Apr 2002 22:47:16 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:59126 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S314034AbSDQCrP>;
	Tue, 16 Apr 2002 22:47:15 -0400
Date: Tue, 16 Apr 2002 22:47:07 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Frank Davis <fdavis@si.rr.com>
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Message-ID: <20020417024707.GA24105@www.kroptech.com>
In-Reply-To: <Pine.LNX.4.33.0204152216590.18109-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2002 at 10:19:24PM -0400, Frank Davis wrote:
> Hello all,
>   While a 'make bzImage', I received the following compile error:
> Regards,
> Frank
> 
> smpboot.c:1008: parse error before `0'
> smpboot.c: In function `smp_boot_cpus':
> smpboot.c:1023: invalid lvalue in assignment
> make[1]: *** [smpboot.o] Error 1
> make[1]: Leaving directory `/usr/src/linux/arch/i386/kernel'
> make: *** [_dir_arch/i386/kernel] Error 2

There's an optimization in io.h for !CONFIG_MULTIQUAD which doesn't seem to have been
carried through all the way...

The following patch seems logical, but I'm no expert. In particular, I'm not sure
if the ioremapping bit ever needs to be run when !CONFIG_MULTIQUAD...

--Adam

--- linux-2.5.8-dj1-virgin/arch/i386/kernel/smpboot.c	Tue Apr 16 16:21:24 2002
+++ linux-2.5.8-dj1+smpboot-fix/arch/i386/kernel/smpboot.c	Tue Apr 16 21:12:13 2002
@@ -1004,8 +1004,11 @@
 extern int prof_counter[NR_CPUS];
 
 static int boot_cpu_logical_apicid;
+
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
+#ifdef CONFIG_MULTIQUAD
 void *xquad_portio = NULL;
+#endif
 
 int cpu_sibling_map[NR_CPUS] __cacheline_aligned;
 
@@ -1013,6 +1016,7 @@
 {
 	int apicid, cpu, bit;
 
+#ifdef CONFIG_MULTIQUAD
         if (clustered_apic_mode && (numnodes > 1)) {
                 printk("Remapping cross-quad port I/O for %d quads\n",
 			numnodes);
@@ -1022,6 +1026,7 @@
                 xquad_portio = ioremap (XQUAD_PORTIO_BASE, 
 			numnodes * XQUAD_PORTIO_LEN);
         }
+#endif
 
 #ifdef CONFIG_MTRR
 	/*  Must be done before other processors booted  */

