Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266166AbTGIWAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 18:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266168AbTGIWAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 18:00:38 -0400
Received: from kiuru.kpnet.fi ([193.184.122.21]:62102 "EHLO kiuru.kpnet.fi")
	by vger.kernel.org with ESMTP id S266166AbTGIWAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 18:00:08 -0400
Subject: Re: Build problem introduced in 2.4.22-pre3 -> 2.4.22-pre3-ac1
	(+config+analysis)
From: Midian <midian@ihme.org>
To: Bas Mevissen <bas@basmevissen.nl>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <200307092329.06003.bas@basmevissen.nl>
References: <200307092329.06003.bas@basmevissen.nl>
Content-Type: multipart/mixed; boundary="=-IQa7VSKRVb6Lf+TddPgp"
Message-Id: <1057788858.3986.12.camel@midux>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 10 Jul 2003 01:14:18 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IQa7VSKRVb6Lf+TddPgp
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8bit

On Thu, 2003-07-10 at 00:36, Bas Mevissen wrote:
> Hi Alan, all,
> 
> The attached .config fails to build on 2.4.22-pre3-ac1, but builds (and 
> runs) fine on 2.4.22-pre3. The build error (during linkage) is:
> 
> (make bzImage)
> 
> ld -m elf_i386 -T /usr/src/linux-2.4.22-pre3-ac1/arch/i386/vmlinux.lds -e 
> stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
> init/version.o init/do_mounts.o \
>         --start-group \
>         arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o 
> fs/fs.o ipc/ipc.o \
>          drivers/acpi/acpi.o drivers/cpufreq/cpufreq.o drivers/char/char.o 
> drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
> drivers/char/drm/drm.o
> drivers/ide/idedriver.o drivers/cdrom/driver.o drivers/pci/driver.o 
> drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o 
> drivers/pnp/pnp.o drivers/video/video.o drivers/media/media.o \
>         net/network.o \
>         /usr/src/linux-2.4.22-pre3-ac1/arch/i386/lib/lib.a 
> /usr/src/linux-2.4.22-pre3-ac1/lib/lib.a 
> /usr/src/linux-2.4.22-pre3-ac1/arch/i386/lib/lib.a \
>         --end-group \
>         -o vmlinux
> arch/i386/kernel/kernel.o(.text.init+0x7dae): In function 
> `setup_ioapic_ids_from_mpc':
> : undefined reference to `xapic_support'
> arch/i386/kernel/kernel.o(.text.init+0x7fe5): In function 
> `setup_ioapic_ids_from_mpc':
> : undefined reference to `xapic_support'
> make: *** [vmlinux] Error 1
> 
> The symbol xapic_support is defined in arch/i386/kernel/io_apic.c as
> "extern unsigned int xapic_support;"
> But it is declared nowhere. Note that the symbol is new in -ac1. 
> 
> >From comparing the pre3 and pre3-ac1 versions of io_apic.c, I conclude that 
> this is some unfinished work and not a typo. What probably is missing is some 
> change to another file that should decare (and set) xapic_support.
> 
> Sorry for not being able to submit a patch, but I hope my analyses helps.
> 
> Regards,
> 
> Bas.
> (Dell Inspiron 8500 with 2.4.22-pre3)
> 
> (Note: I'm not on the list, so please always CC me)
> 

Hello Bas,
there is two ways to fix this, you can use the the patch by Steven Cole
(I'll attach it).
Or then you untar the 2.4.21 to another dir and download 2.4.21-ac4
patch and patch the new kernel that you just untarred, and then you copy
$2.4.21-ac4kerneldir/arch/i386/kernel/mpparse.c to
$2.4.22-pre3-ac1kerneldir/arch/i386/kernel/mpparse.c, then it compiles
right. Good luck!

Regards
-- 
Markus Hästbacka <midian@ihme.org>


--=-IQa7VSKRVb6Lf+TddPgp
Content-Disposition: attachment; filename=patch
Content-Type: text/plain; name=patch; charset=iso-8859-15
Content-Transfer-Encoding: 7bit

--- linux-2.4.22-pre3-ac1/arch/i386/kernel/io_apic.c.orig       Mon Jul  7 11:06:36 2003
+++ linux-2.4.22-pre3-ac1/arch/i386/kernel/io_apic.c    Mon Jul  7 11:25:07 2003
@@ -44,7 +44,6 @@
 
 unsigned int int_dest_addr_mode = APIC_DEST_LOGICAL;
 unsigned char int_delivery_mode = dest_LowestPrio;
-extern unsigned int xapic_support;
 
 /*
  * # of IRQ routing registers
@@ -1208,8 +1207,7 @@
                
                old_id = mp_ioapics[apic].mpc_apicid;
 
-               if (!xapic_support && 
-                   (mp_ioapics[apic].mpc_apicid >= apic_broadcast_id)) {
+               if ((mp_ioapics[apic].mpc_apicid >= apic_broadcast_id)) {
                        printk(KERN_ERR "BIOS bug, IO-APIC#%d ID is %d in the MPC 
table!...\n",
                                apic, mp_ioapics[apic].mpc_apicid);
                        printk(KERN_ERR "... fixing up to %d. (tell your hw vendor)\n",
@@ -1223,8 +1221,7 @@
                 * 'stuck on smp_invalidate_needed IPI wait' messages.
                 * I/O APIC IDs no longer have any meaning for xAPICs and SAPICs.
                 */
-               if (!xapic_support &&
-                   (clustered_apic_mode != CLUSTERED_APIC_XAPIC) &&
+               if ((clustered_apic_mode != CLUSTERED_APIC_XAPIC) &&
                    (phys_id_present_map & (1 << mp_ioapics[apic].mpc_apicid))) {
                        printk(KERN_ERR "BIOS bug, IO-APIC#%d ID %d is already used!...\n",
                                apic, mp_ioapics[apic].mpc_apicid);

--=-IQa7VSKRVb6Lf+TddPgp--

