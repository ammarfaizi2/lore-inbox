Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314129AbSDVMHU>; Mon, 22 Apr 2002 08:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314138AbSDVMHT>; Mon, 22 Apr 2002 08:07:19 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:21940 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314129AbSDVMHO>; Mon, 22 Apr 2002 08:07:14 -0400
Date: Mon, 22 Apr 2002 17:40:22 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux@hazard.jcu.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.8 compilation fail...
Message-ID: <20020422174022.A19113@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In article <20020422100649.GA4025@hazard.jcu.cz> Jan Marek wrote:

> --VbJkn9YxBvnuCH5J
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline

> Hallo,

> I have problems with linking of kernel 2.5.8-usagi. Compilation
> ended with:

> ld -m elf_i386 -T /usr/src/usagi/kernel/linux25/arch/i386/vmlinux.lds -e
> stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o
> init/version.o init/do_mounts.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o
> mm/mm.o fs/fs.o ipc/ipc.o \
>         /usr/src/usagi/kernel/linux25/arch/i386/lib/lib.a
> /usr/src/usagi/kernel/linux25/lib/lib.a
> /usr/src/usagi/kernel/linux25/arch/i386/lib/lib.a \
>          drivers/base/base.o drivers/char/char.o drivers/block/block.o
> drivers/misc/misc.o drivers/net/net.o drivers/media/media.o
> drivers/char/agp/agp.o drivers/ide/idedriver.o drivers/cdrom/driver.o
> sound/sound.o drivers/pci/driver.o drivers/pnp/pnp.o
> drivers/video/video.o \
>         net/network.o \
>         --end-group \
>         -o vmlinux
> init/main.o: In function `start_kernel':
> init/main.o(.text.init+0x5db): undefined reference to
> `setup_per_cpu_areas'
> make: *** [vmlinux] Error 1

You can use the attached (text/plain) patch to fix this.

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="percpufix-2.5.8-2.patch"

diff -urN linux-2.5.8-base/init/main.c linux-2.5.8-percpufix/init/main.c
--- linux-2.5.8-base/init/main.c	Mon Apr 15 00:48:46 2002
+++ linux-2.5.8-percpufix/init/main.c	Wed Apr 17 14:10:39 2002
@@ -274,6 +274,18 @@
 
 #else
 
+/* Called by boot processor to activate the rest. */
+static void __init smp_init(void)
+{
+	/* Get other processors into their bootup holding patterns. */
+	smp_boot_cpus();
+
+	smp_threads_ready=1;
+	smp_commence();
+}
+
+#endif
+
 #ifdef __GENERIC_PER_CPU
 unsigned long __per_cpu_offset[NR_CPUS];
 
@@ -302,18 +314,6 @@
 }
 #endif /* !__GENERIC_PER_CPU */
 
-/* Called by boot processor to activate the rest. */
-static void __init smp_init(void)
-{
-	/* Get other processors into their bootup holding patterns. */
-	smp_boot_cpus();
-
-	smp_threads_ready=1;
-	smp_commence();
-}
-
-#endif
-
 /*
  * We need to finalize in a non-__init function or else race conditions
  * between the root thread and the init thread may cause start_kernel to

--a8Wt8u1KmwUX3Y2C--
