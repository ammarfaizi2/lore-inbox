Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUJXWsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUJXWsl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 18:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUJXWsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 18:48:40 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:23746 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261605AbUJXWsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 18:48:37 -0400
Message-ID: <417C2619.7060808@free.fr>
Date: Mon, 25 Oct 2004 00:00:57 +0200
From: Remi Colinet <remi.colinet@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-mm1 : compile error & question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'am getting this error when compiling 2.6.9-mm1 :

 KSYM    .tmp_kallsyms3.S
 AS      .tmp_kallsyms3.o
 LD      vmlinux
 SYSMAP  System.map
 SYSMAP  .tmp_System.map
 AS      arch/i386/boot/setup.o
 LD      arch/i386/boot/setup
 AS      arch/i386/boot/compressed/head.o
 CC      arch/i386/boot/compressed/misc.o
 OBJCOPY arch/i386/boot/compressed/vmlinux.bin
BFD: Warning: Writing section `.bss' to huge (ie negative) file offset 
0xc05c6000.
objcopy: arch/i386/boot/compressed/vmlinux.bin: File truncated
make[2]: *** [arch/i386/boot/compressed/vmlinux.bin] Error 1
make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2
make: *** [bzImage] Error 2
[root@tigre01 im]# objdump -h ./vmlinux

./vmlinux:     file format elf32-i386

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
 0 .text         0037d80e  c0100000  00100000  00001000  2**12         
<-- something wrong here for LMA used to be 0xc010 000
                 CONTENTS, ALLOC, LOAD, READONLY, CODE
 1 __ex_table    000013b8  c047d810  0047d810  0037e810  2**2
                 CONTENTS, ALLOC, LOAD, READONLY, DATA
 2 .rodata       000a8309  c047ebe0  0047ebe0  0037fbe0  2**5
                 CONTENTS, ALLOC, LOAD, READONLY, DATA
...

23 .exit.text    00001a5b  c06ab430  006ab430  005ac430  2**4
                 CONTENTS, ALLOC, LOAD, READONLY, CODE
24 .init.ramfs   00000086  c06ad000  006ad000  005ae000  2**0
                 CONTENTS, ALLOC, LOAD, READONLY, DATA
25 .data.percpu  00018938  c06ad100  006ad100  005ae100  2**7
                 CONTENTS, ALLOC, LOAD, DATA
26 .bss          0006dfa0  c06c6000  c06c6000  005c7000  2**12     <-- 
somthing wrong with LMA for .bss.
                 CONTENTS, ALLOC, LOAD, DATA
27 .comment      0000c36f  00000000  00000000  00634fa0  2**0
                 CONTENTS, READONLY
28 .debug_line   0021497b  00000000  00000000  0064130f  2**0
...

This is very strange. The .text LMA of the vmlinux file is at 0x__0__010 
0000 whereas, it used to be at  0x__c__010 0000.  But then, the .bss LMA 
of the vmlinux file suddenly jump at 0x__c__06c 6000 instead of 
0x__0__06c 6000 which would have seemed more natural -0).  What can 
cause this offset? I have look for the .bss section content. It contains 
.bss data and .bss.page_aligned. The later seems to be the root of the 
.bss LMA offset.  .bss.page_aligned contains then empty_zero_page and 
the  swapper_pg_dir.

I finally succeded to compile the kernel, using  the following 
OBJCOPYFLAGS in arch/i386/Makefile.

OBJCOPYFLAGS    := -O binary --change-section-lma .bss-0xc0000000 -R 
.note -R .comment -S

I haven't yet tried to boot it.

Any idea to fix this objcopy error otherwise?
Why is the .text LMA set at 0x0010 0000 instead of 0xc010 0000 as it 
used to be?

Thanks
Remi
