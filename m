Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbTAJUSN>; Fri, 10 Jan 2003 15:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbTAJUSN>; Fri, 10 Jan 2003 15:18:13 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:10213 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S266347AbTAJUSK>; Fri, 10 Jan 2003 15:18:10 -0500
Date: Fri, 10 Jan 2003 21:26:49 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: kai.germaschewski@gmx.de, Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.5: Link errors are shown in the wrong files
Message-ID: <20030110202649.GP6626@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm doing regular compile tests with 2.4 and 2.5 kernels to catch and 
either fix or report compile errors.

Since several revisions 2.5 has the _very_ annoying behavior of showing 
link errors in the wrong files. This makes finding the cause of the 
problems harder.

As an example look at the following link error in 2.4.21-pre3-ac2:

<--  snip  -->

...
ld -m elf_i386 -T 
/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/arch/i386/vmlinux.
lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o 
init/main.o init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o \
         drivers/acpi/acpi.o drivers/parport/driver.o 
drivers/char/char.o drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
drivers/char/agp/agp.o drivers/char/drm/drm.o drivers/net/fc/fc.o 
drivers/net/appletalk/appletalk.o drivers/net/tokenring/tr.o drivers/net/wan/wan.o 
drivers/net/arcnet/arcnetdrv.o drivers/atm/atm.o drivers/ide/idedriver.o drivers/scsi/scsidrv.o 
drivers/message/fusion/fusion.o drivers/ieee1394/ieee1394drv.o drivers/cdrom/driver.o 
drivers/sound/sounddrivers.o drivers/pci/driver.o drivers/mtd/mtdlink.o 
drivers/pcmcia/pcmcia.o
 drivers/net/pcmcia/pcmcia_net.o drivers/net/wireless/wireless_net.o 
drivers/char/pcmcia/pcmcia_char.o drivers/pnp/pnp.o drivers/video/video.o 
drivers/block/paride/paride.a drivers/net/hamradio/hamradio.o drivers/usb/usbdrv.o 
drivers/media/media.o drivers/input/inputdrv.o drivers/message/i2o/i2o.o 
drivers/net/irda/irda.o drivers/i2c/i2c.o drivers/telephony/telephony.o drivers/md/mddev.o 
drivers/bluetooth/bluetooth.o drivers/hotplug/vmlinux-obj.o 
drivers/isdn/vmlinux-obj.o arch/i386/math-emu/math.o \
        net/network.o \
        /home/bunk/linux/kernel-2.4/linux-2.4.20-ac/arch/i386/lib/lib.a 
/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/lib/lib.a 
/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
drivers/char/char.o(.text.init+0xa0bc): In function `siolx_init':
: undefined reference to `local symbols in discarded section .text.exit'
drivers/atm/atm.o(.text.init+0x21): In function `idt77252_exit':
/home/bunk/linux/kernel-2.4/linux-2.4.20-ac/drivers/atm/idt77252.c: 
undefined reference to `ia_detect'
make: *** [vmlinux] Error 1

<--  snip  -->


With these error messages it's easy to identify the problems.

Compare this to the following output in 2.5.55:


<--  snip  -->

...
        ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o 
--start-group  usr/built-in.o  arch/i386/kernel/built-in.o  
arch/i386/mm/built-in.o  arch/i386/mach-default/built-in.o  
kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  
security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  
drivers/built-in.o  sound/built-in.o  arch/i386/math-emu/built-in.o  
arch/i386/pci/built-in.o  arch/i386/oprofile/built-in.o  net/built-in.o 
--end-group  -o .tmp_vmlinux1
drivers/built-in.o(.text+0x17daa9): In function `lanai_module_init':
/home/bunk/linux/kernel-2.5/linux-2.5.55/drivers/atm/lanai.c: undefined 
reference to `__udivdi3'
drivers/built-in.o(.text+0x17e6ab):/home/bunk/linux/kernel-2.5/linux-2.5.55/drivers/atm/lanai.c: 
undefined reference to `__udivdi3'
drivers/built-in.o(.text+0x17f73a):/home/bunk/linux/kernel-2.5/linux-2.5.55/drivers/atm/lanai.c: 
undefined reference to `__udivdi3'
drivers/built-in.o(.text+0x1810bf):/home/bunk/linux/kernel-2.5/linux-2.5.55/drivers/atm/lanai.c: 
undefined reference to `__udivdi3'
drivers/built-in.o(.text+0x183125):/home/bunk/linux/kernel-2.5/linux-2.5.55/drivers/atm/lanai.c: 
undefined reference to `__udivdi3'
drivers/built-in.o(.text+0x1ac9e5):/home/bunk/linux/kernel-2.5/linux-2.5.55/drivers/atm/lanai.c: 
undefined reference to `awc_work'
drivers/built-in.o(.text+0x23747a):/home/bunk/linux/kernel-2.5/linux-2.5.55/drivers/atm/lanai.c: 
undefined reference to `__bad_udelay'
drivers/built-in.o(.init.text+0x44c7): In function 
`nicstar_module_exit':
/home/bunk/linux/kernel-2.5/linux-2.5.55/drivers/atm/nicstar.c:408: 
undefined reference to `mxser_init'
drivers/built-in.o(.init.text+0x518fc): In function `lanai_module_init':
/home/bunk/linux/kernel-2.5/linux-2.5.55/drivers/atm/lanai.c: undefined 
reference to `_ebss'
drivers/built-in.o(.init.text+0x51901):/home/bunk/linux/kernel-2.5/linux-2.5.55/drivers/atm/lanai.c: 
undefined reference to `_ebss'
drivers/built-in.o(.init.text+0x5191b):/home/bunk/linux/kernel-2.5/linux-2.5.55/drivers/atm/lanai.c: 
undefined reference to `_ebss'
drivers/built-in.o(.data+0x73154):/home/bunk/linux/kernel-2.5/linux-2.5.55/drivers/atm/lanai.c: 
undefined reference to `local symbols in discarded section .exit.text'
make: *** [.tmp_vmlinux1] Error 1

<--  snip   -->


The references to drivers/atm/lanai.c are complete nonsense, e.g. the 
cause for the awc_work problem is in drivers/net/aironet4500* .

I'm using the gcc 2.95 and binutils 2.13.90.0.16 from Debian unstable.


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

