Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314295AbSEBJfQ>; Thu, 2 May 2002 05:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314303AbSEBJfQ>; Thu, 2 May 2002 05:35:16 -0400
Received: from rose.man.poznan.pl ([150.254.173.3]:58365 "EHLO
	rose.man.poznan.pl") by vger.kernel.org with ESMTP
	id <S314295AbSEBJfO>; Thu, 2 May 2002 05:35:14 -0400
Date: Thu, 2 May 2002 11:34:59 +0200 (MET DST)
From: Michal Schulz <mschulz@rose.man.poznan.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: executing kernel from ROM [was: romfx XIP patch]
In-Reply-To: <E172hE1-0000fL-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.20.0205021100550.28887-100000@rose.man.poznan.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 May 2002, Alan Cox wrote:

> > Flash-ROM. Because the machine doesn't have too much memory, I have fixed
> > 2.2.18 kernel, so that it keeps all unwritable sections if ROM and that's
> > the place where they're executed for. Thanks to that I have spared about
> > 500KB of memory.
> 
> (I'd be interested in these patches too)

Well, for the kernel executing from ROM it's not a patch indeed. It is
pretty much code changed in the head.S and nearby. What I did is as
follows:

1. I have found out that what sections are readed only. There were .text,
.text.lock, .kstrtab, exception table and kernel symbol table. At first it
was strange for me that .rodata is written, but it happens because there
are some structures generated on the fly (like registering to
procfs) which are placed by gcc in .rodata (just like strings passed to
printk directly) but accessed by eg. procfs. So I had to move .rodata to
writable area.
2. I have edited /arch/i386/vmlinux.lds.S. Before read-only area I have
added . = PAGE_OFFSET_RAW + 0x3e81000; where 0x3e81000 is the address
where kernel starts in ROM. At the end of .text section, just after _etext
there is . = PAGE_OFFSET_RAW + 0x100000;. After it the .rodata section was
moved.
3. Now the build process creates vmlinux in main directory with is almost
ready-to-use by me. The two sections - read only and writable are
extracted from it by

# objcopy -O binary -j .text -j .text.lock -j __ex_table -j __ksymtab -j
.kstrtab vmlinux vmlinux.code.bin

# objcopy -O binary -R .text -R .text.lock -R __ex_table -R __ksymtab -R
.kstrtab vmlinux vmlinux.data.bin

4. I have written a bootstrap code which do following things:
  a) simulate setup.S behaviour so I can pass parameters to my kernel and
     change root devices
  b) copies writable section from rom to memory at address 0x100000.
  c) creates proper GDT section and small temporary stack
  d) redirects IRQ interrupts to 0x20-0x30 area used by kernel
  e) jumps to the kernel (same address as in vmlinux.lds.S)

5. The files are linked with ld:

# ld -m elf_i386 -r -o linux.code.o -b binary vmlinux.code.bin -b
elf32-i386 -T link.code.lnk

# ld -m elf_i386 -r -o linux.data.o -b binary vmlinux.data.bin -b
elf32-i386 -T link.data.lnk

# gcc -c -O2 bootup.c

# ld -e start -Ttext=0x3E80000 -Tdata=0x3e81000 -o kernel bootup.o
linux.code.o linux.data.o

# objcopy -O binary kernel 3E80000.lnx

the link rules are:

# cat link.code.lnk 
SECTIONS {
    .data :
    {
        *(.data)
    }
}

# cat link.data.lnk 
SECTIONS {

    .data :
    {
        input_data = .;
        *(.data)
        input_data_end = .;

        input_len = .;
        LONG(input_data_end - input_data)
    }
}

6. At this moment I have kernel image named 3E80000.lnx which is stored in
ROM. The only thing left was changing /arch/i386/kernel/head.S. I had to
add one page more to swapper_pg_dir so that after turning on the MMU, the
code area would be seen. For my kernel placed at 0x3e80000 I have had to
add access for 4MB page 0x03c00000. So did I. I have just copied pg0 and
fixed the pte's in it with:

        movl $0x106000,%edi /* here my pg_3c0 is! */
        movl $0x3c00000,%esi
        movl $1024,%ecx
1:      addl %esi,(%edi)
        addl $4,%edi
        subl $1,%ecx
        jne 1b

then I had to update swapper_pg_dir by

        movl $0x106007,%esi
        movl $0x101000,%edi
        movl %esi,0x03c(%edi)
        movl %esi,0xc3c(%edi)

That's all. Now it is safe to do well known:

        movl $0x101000,%eax
        movl %eax,%cr3          /* set the page table pointer.. */
        movl %cr0,%eax
        orl $0x80000000,%eax
        movl %eax,%cr0          /* ..and set paging (PG) bit */

and the rest stayed unchanged (well, almost. Since I am using i386EX with
special hardware I have removed stuff like testing cpu version, cpu speed
and so on). The kernel should work nicely. And the great result is:

Memory: 2276k/2560k available (0k kernel code, 152k reserved, 112k data,
20k init)

taken from my machine booting :-)

with best regards,

-- 
Michal Schulz


