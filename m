Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293306AbSBYD3M>; Sun, 24 Feb 2002 22:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293307AbSBYD3C>; Sun, 24 Feb 2002 22:29:02 -0500
Received: from smtp1.arnet.com.ar ([200.45.191.6]:39697 "HELO
	smtp1.arnet.com.ar") by vger.kernel.org with SMTP
	id <S293306AbSBYD2x>; Sun, 24 Feb 2002 22:28:53 -0500
Message-ID: <3C79AF21.20606@arnet.com.ar>
Date: Mon, 25 Feb 2002 00:27:30 -0300
From: Juan Erbes <jerbes@arnet.com.ar>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us, es-ar
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.5.5 compiltation bugs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building the kernel 2.5.5, with gcc 3.02, under SuSE 7.1, with kernel 
2.4.16, I got:

gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6   -DKBUILD_BASENAME=floppy  
-c -o floppy.o floppy.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6   -DKBUILD_BASENAME=rd  -c 
-o rd.o rd.c
rd.c: In function `rd_make_request':
rd.c:271: too many arguments to function
make[3]: *** [rd.o] Error 1
make[3]: Leaving directory `/usr/src/linux/drivers/block'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux/drivers/block'
make[1]: *** [_subdir_block] Error 2
make[1]: Leaving directory `/usr/src/linux/drivers'
make: *** [_dir_drivers] Error 2

without ramdisk

make[2]: Leaving directory `/usr/src/linux/arch/i386/lib'
make[1]: Leaving directory `/usr/src/linux/arch/i386/lib'
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext 
arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o 
init/version.o init/do_mounts.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o 
mm/mm.o fs/fs.o ipc/ipc.o \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a 
/usr/src/linux/arch/i386/lib/lib.a \
         drivers/acpi/acpi.o drivers/base/base.o drivers/char/char.o 
drivers/block/block.o drivers/misc/misc.o drivers/net/net.o 
drivers/media/media.o drivers/char/drm/drm.o drivers/net/fc/fc.o 
drivers/net/tokenring/tr.o drivers/atm/atm.o drivers/ide/idedriver.o 
drivers/scsi/scsidrv.o drivers/cdrom/driver.o drivers/pci/driver.o 
drivers/net/wireless/wireless_net.o drivers/pnp/pnp.o 
drivers/video/video.o \
        net/network.o \
        --end-group \
        -o vmlinux
drivers/video/video.o: In function `vesafb_init':
drivers/video/video.o(.text.init+0x151a): undefined reference to 
`bus_to_virt_not_defined_use_pci_map'
make: *** [vmlinux] Error 1


I have applied the patch, and then the kernel builds ok, but the problem 
is yet building the modules:


gcc -D__KERNEL__ -I/usr/src/linux-2.5.5/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
-march=k6 -DMODULE  -DKBUILD_BASENAME=sbpcd  -c -o sbpcd.o sbpcd.c
sbpcd.c: In function `__SBPCD_INIT':
sbpcd.c:5867: `DO_SBPCD_REQUEST' undeclared (first use in this function)
sbpcd.c:5867: (Each undeclared identifier is reported only once
sbpcd.c:5867: for each function it appears in.)
sbpcd.c:5873: `read_ahead' undeclared (first use in this function)
sbpcd.c: At top level:
sbpcd.c:4899: warning: `do_sbpcd_request' defined but not used
make[2]: *** [sbpcd.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.5.5/drivers/cdrom'
make[1]: *** [_modsubdir_cdrom] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.5/drivers'
make: *** [_mod_drivers] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/drivers'
make: *** [_mod_drivers] Error 2



patched and with gcc 3.04, and without NO_IDE_SCSI_CDROM

gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE  
-DKBUILD_BASENAME=i2o_block  -DEXPORT_SYMTAB -c i2o_block.c
i2o_block.c:43:2: #error Please convert me to Documentation/DMA-mapping.txt

configured without i2o_block

gcc -D__KERNEL__ -I/usr/src/linux-2.5/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=k6 -DMODULE -I../../scsi/ 
-DKBUILD_BASENAME=datafab
-c -o datafab.o datafab.c
datafab.c: In function `datafab_read_data':
datafab.c:259: structure has no member named `address'
datafab.c:259: structure has no member named `address'
datafab.c:268: structure has no member named `address'
datafab.c:268: structure has no member named `address'
datafab.c: In function `datafab_write_data':
datafab.c:349: structure has no member named `address'
datafab.c:349: structure has no member named `address'
datafab.c:358: structure has no member named `address'
datafab.c:358: structure has no member named `address'
make[3]: *** [datafab.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.5/drivers/usb/storage'
make[2]: *** [_modsubdir_storage] Error 2
make[2]: Leaving directory `/usr/src/linux-2.5/drivers/usb'
make[1]: *** [_modsubdir_usb] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5/drivers'
make: *** [_mod_drivers] Error 2


Thanks,
              Juan

