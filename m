Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131709AbQLLPKU>; Tue, 12 Dec 2000 10:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131890AbQLLPKK>; Tue, 12 Dec 2000 10:10:10 -0500
Received: from ronispc.Chem.McGill.CA ([132.206.205.91]:31748 "EHLO
	ronispc.chem.mcgill.ca") by vger.kernel.org with ESMTP
	id <S131886AbQLLPKF>; Tue, 12 Dec 2000 10:10:05 -0500
Date: Tue, 12 Dec 2000 09:39:31 -0500
Message-Id: <200012121439.eBCEdVo25972@ronispc.chem.mcgill.ca>
From: root <ronis@ronispc.chem.mcgill.ca>
To: linux-kernel@vger.kernel.org
Subject: Build failure in 2.2.18
Reply-to: ronis@onsager.chem.mcgill.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've just patched and reconfigured to 2.2.18 (from 2.2.17 on an
i686-linux-gnu[2.2]).  make bzImage fails with:

 
make[1]: Leaving directory `/usr/src/linux-2.2.18/arch/i386/lib'
cc -D__KERNEL__ -I/usr/src/linux/include -E -C -P -I/usr/src/linux/include -imacros /usr/src/linux/include/asm-i386/page_offset.h -Ui386 arch/i386/vmlinux.lds.S >arch/i386/vmlinux.lds
ld -m elf_i386 -T /usr/src/linux/arch/i386/vmlinux.lds -e stext arch/i386/kernel/head.o arch/i386/kernel/init_task.o init/main.o init/version.o \
        --start-group \
        arch/i386/kernel/kernel.o arch/i386/mm/mm.o kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o \
        fs/filesystems.a \
        net/network.a \
        drivers/block/block.a drivers/char/char.o drivers/misc/misc.a drivers/net/net.a drivers/cdrom/cdrom.a drivers/pci/pci.a drivers/pnp/pnp.a drivers/video/video.a \
        /usr/src/linux/arch/i386/lib/lib.a /usr/src/linux/lib/lib.a /usr/src/linux/arch/i386/lib/lib.a \
        --end-group \
        -o vmlinux
ld:/usr/src/linux/arch/i386/vmlinux.lds:73: parse error
make: *** [vmlinux] Error 1 

I've appended vmlinux.lds below.


David

P.S.  I don't subscribe to this list, so please CC me directly.
------------------------------------------------------------------------------
/* ld script to make i386 Linux kernel
 * Written by Martin Mares <mj@atrey.karlin.mff.cuni.cz>;
 */
OUTPUT_FORMAT
             (
              "elf32-i386"
                          , "elf32-i386", "elf32-i386")
OUTPUT_ARCH(i386)
ENTRY(_start)
SECTIONS
{
  . = 0xC0000000 + 0x100000;
  _text = .; /* Text and read-only data */
  .text : {
        *(.text)
        *(.fixup)
        *(.gnu.warning)
        } = 0x9090
  .text.lock : { *(.text.lock) } /* out-of-line lock text */
  .rodata : { *(.rodata) }
  .kstrtab : { *(.kstrtab) }
  .
    = ALIGN(16); /* Exception table */
  __start___ex_table = .;
  __ex_table : { *(__ex_table) }
  __stop___ex_table = .;
  __start___ksymtab
                    = .; /* Kernel symbol table */
  __ksymtab : { *(__ksymtab) }
  __stop___ksymtab = .;
  _etext
         = .; /* End of text section */
  .
   data : { /* Data */
        *(.data)
        CONSTRUCTORS
        }
  _edata
         = .; /* End of data section */
  .
    = ALIGN(8192); /* init_task */
  .data.init_task : { *(.data.init_task) }
  .
    = ALIGN(4096); /* Init code and data */
  __init_begin = .;
  .text.init : { *(.text.init) }
  .data.init : { *(.data.init) }
  . = ALIGN(16); /* __setup() commandline parameters */
  __setup_start = .;
  .setup.init : { *(.setup.init) }
  __setup_end = .;
  __initcall_start = .; /* the init functions to be called */
  .initcall.init : { *(.initcall.init) }
  __initcall_end = .;
  . = ALIGN(4096);
  __init_end = .;
  .
    =
      ALIGN(32);
  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
  .
    = ALIGN(4096);
  .data.page_aligned : { *(.data.idt) }
  __bss_start
              =
                .; /* BSS */
  .bss : {
        *(.bss)
        }
  _end = . ;
  /* Stabs debugging sections.  */
  .
   stab 0 : { *(.stab) }
  .stabstr 0 : { *(.stabstr) }
  .stab.excl 0 : { *(.stab.excl) }
  .stab.exclstr 0 : { *(.stab.exclstr) }
  .stab.index 0 : { *(.stab.index) }
  .stab.indexstr 0 : { *(.stab.indexstr) }
  .comment 0 : { *(.comment) }
}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
