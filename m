Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUAJRfR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 12:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265267AbUAJRfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 12:35:16 -0500
Received: from bender.bawue.de ([193.7.176.20]:56014 "EHLO bender.bawue.de")
	by vger.kernel.org with ESMTP id S265278AbUAJRdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 12:33:16 -0500
To: Tim Cambrant <tim@cambrant.com>
Cc: Mario Vanoni <vanonim@bluewin.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-mm2: compiler warning
In-Reply-To: <20040110155626.GA20684@cambrant.com> (Tim Cambrant's message
 of "Sat, 10 Jan 2004 16:56:26 +0100")
References: <40001CEE.5050206@bluewin.ch>
	<20040110155626.GA20684@cambrant.com>
From: Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Date: Sat, 10 Jan 2004 18:31:42 +0100
Message-ID: <86r7y7pv5t.fsf@n-dimensional.de>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Reasonable Discussion,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Cambrant <tim@cambrant.com> writes:

> On Sat, Jan 10, 2004 at 04:40:30PM +0100, Mario Vanoni wrote:
>> Compiling the kernel under 2.6.1-mm2, gcc-3.3.2
>> (same messages as under 2.6.1-rc1-mm1, re-tested),
>> 
>> arch/i386/boot/setup.S: Assembler messages:
>> arch/i386/boot/setup.S:165: Warning: value 0x37ffffff truncated to 
>> 0x37ffffff
>> 

> If you've got a fix, it would surely be included in the kernel.

Hmm... let's see...

The assembler calculates in arch/i386/boot/setup.S (with the
definition of MAXMEM from include/asm-i386/page.h):

        - 0xC0000000 - 0x08000000 - 1

This obviously is a negative number which is what the assembler
warns us about.

As there are no negative memory addresses anyway, the number we really
want is the positive number

        (1 << 32) - 0xC0000000 - 0x08000000 - 1

which is the same in modulo (1 << 32) arithmetic, of course.

Original arch/i386/boot/setup.o (subtract from 0):

0000002c <ramdisk_max>:
      2c:	ff                   	(bad)  
      2d:	ff                   	(bad)  
      2e:	ff 37                	pushl  (%edi)

Patched arch/i386/boot/setup.o (subtract from (1<<32)):

0000002c <ramdisk_max>:
      2c:	ff                   	(bad)  
      2d:	ff                   	(bad)  
      2e:	ff 37                	pushl  (%edi)

This looks OK to me so far.

However, a few issues remain:

- There probably are some nasty side effects in other places
  which I haven't thought about.

- I didn't try to boot the patched kernel yet.

- As I don't know whether the C compiler might get confused about
  that, I re-used the #ifdef in include/asm-i386/page.h.
  Subtracting UL constants from (0UL) shouldn't make a difference,
  even if subtracting from 0x100000000UL might.

- __MAXMEM_ADDRSPACE_MAX should probably be defined using a
  constant from somewhere else. (Where from?)

Regards,

Uli

--- linux-2.6.1/include/asm-i386/page.h.orig	Sat Jan 10 18:01:31 2004
+++ linux-2.6.1/include/asm-i386/page.h	Sat Jan 10 18:03:48 2004
@@ -116,14 +116,16 @@
 
 #ifdef __ASSEMBLY__
 #define __PAGE_OFFSET		(0xC0000000)
+#define __MAXMEM_ADDRSPACE_MAX	(1 << 32)
 #else
 #define __PAGE_OFFSET		(0xC0000000UL)
+#define __MAXMEM_ADDRSPACE_MAX	(0UL)
 #endif
 
 
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
 #define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
-#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
+#define MAXMEM			(__MAXMEM_ADDRSPACE_MAX-__PAGE_OFFSET-__VMALLOC_RESERVE)
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
 #define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
