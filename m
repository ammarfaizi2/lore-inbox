Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVCaNHu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVCaNHu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 08:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVCaNHu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 08:07:50 -0500
Received: from ZIVLNX17.UNI-MUENSTER.DE ([128.176.188.79]:63370 "EHLO
	ZIVLNX17.uni-muenster.de") by vger.kernel.org with ESMTP
	id S261431AbVCaNFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 08:05:48 -0500
From: Borislav Petkov <petkov@uni-muenster.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1-mm3
Date: Thu, 31 Mar 2005 15:05:48 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050325002154.335c6b0b.akpm@osdl.org> <200503251746.10458.petkov@uni-muenster.de>
In-Reply-To: <200503251746.10458.petkov@uni-muenster.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503311505.48590.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 March 2005 17:46, Borislav Petkov wrote:
> Hi Andrew,
>
> mm3 still not booting on my machine. Boot option 'nmi_watchdog=2' (my cpu
> is a dual core pentium 4 HT, 2.60 GHz) gets me a bit further in the boot
> process but it blocks there too.
>
> [output retyped from screen]:
> kernel: [    4.109241] PM: Checking swsusp image.
> kernel: [    4.109244] PM: Resume from disk failed.
> kernel: [    4.112220] VFS: Mounted root (ext2 filesystem) readonly.
> kernel: [    4.112465] Freeing unused kernel memory: 188k freed
> kernel: [    4.142002] logips2pp: Detected unknown logitech mouse model 1
> kernel: [    4.274620] input: PS/2 Logitech Mouse on isa0060/serio1
> <--- [point of previous blocks without boot option 'nmi_watchdog=2']--->
> INIT: version 2.86 booting
> Mounting a tmpfs over /dev... done.
> Creating initial device nodes... done.
> Setting parameters of disc: (none).
> Activating swap.
> kernel: [   10.712648] Adding 976744k swap on /dev/hda2. Priority:-1
> extents:1 Checking root file system...
> fsck 1.36 (05-Feb-2005)
> /: clean, 127290/1831424 files, 898566/3662056 blocks
> [EOF]

Hi Andrew,

i finally got to run kdb within mm3 and I got a bit further but am not sure 
whether I'm debugging in the right direction:

After booting with "kdb=early" I found out that the kernel blocks with the 
partial message:

kmem_cache_create: Early error in slab task_struct
kernel BUG at mm/slab.c:1215
invalid operand: 0000 [#1]
PREEMPT SMP

and here all dies. After singlestepping through the code, I found out that 
start_kernel calls at offset 0x14d fork_init, which calls at offset 0x39 
kmem_cache_create. kmem_cache_create performs some initial checks: 

   1205     /*
   1206      * Sanity checks... these are all serious usage bugs.
   1207      */
   1208     if ((!name) ||
   1209         in_interrupt() ||
   1210         (size < BYTES_PER_WORD) ||
   1211         (size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
   1212         (dtor && !ctor)) {
   1213             printk(KERN_ERR "%s: Early error in slab %s\n",
   1214                     __FUNCTION__, name);
   1215             BUG();
   1216         }

And after singlestepping a little bit more, I found out that the 
in_interrupt() check returns true and printk is executed. Here's the 
disassembled code:

00000b10 <kmem_cache_create>:
kmem_cache_create():
mm/slab.c:1201
     b10:   55                      push   %ebp
     b11:   89 e5                   mov    %esp,%ebp
     b13:   57                      push   %edi
     b14:   56                      push   %esi
     b15:   53                      push   %ebx
     b16:   83 ec 3c                sub    $0x3c,%esp
mm/slab.c:1208
     b19:   8b 55 08                mov    0x8(%ebp),%edx
     b1c:   85 d2                   test   %edx,%edx
     b1e:   0f 84 01 08 00 00       je     1325 <kmem_cache_create+0x815>
include/asm/thread_info.h:91
     b24:   b8 00 f0 ff ff          mov    $0xfffff000,%eax
     b29:   21 e0                   and    %esp,%eax
include/asm/thread_info.h:89
     b2b:   f7 40 14 00 ff ff 0f    testl  $0xfffff00,0x14(%eax)
     b32:   0f 85 ed 07 00 00       jne    1325 <kmem_cache_create+0x815> <--- 

this jump here executes and line 0x1325 is:

mm/slab.c:1213
    1325:   c7 04 24 40 02 00 00    movl   $0x240,(%esp)
    132c:   8b 45 08                mov    0x8(%ebp),%eax
    132f:   89 44 24 08             mov    %eax,0x8(%esp)
    1333:   b8 0d 00 00 00          mov    $0xd,%eax
    1338:   89 44 24 04             mov    %eax,0x4(%esp)
    133c:   e8 fc ff ff ff          call   133d <kmem_cache_create+0x82d>
mm/slab.c:1215
    1341:   0f 0b                   ud2a
    1343:   bf 04 00 00 00          mov    $0x4,%edi
    1348:   00 e9                   add    %ch,%cl
    134a:   13 f8                   adc    %eax,%edi
    134c:   ff                      (bad)
    134d:   ff c7                   inc    %edi

and BUG() is called.

Any suggestions or corrections will be greatly appreciated.

Regards,
Boris.
