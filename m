Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315252AbSEGWrD>; Tue, 7 May 2002 18:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315251AbSEGWrC>; Tue, 7 May 2002 18:47:02 -0400
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:15828 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S315235AbSEGWq7>; Tue, 7 May 2002 18:46:59 -0400
Message-ID: <3CD858AA.5050601@didntduck.org>
Date: Tue, 07 May 2002 18:43:54 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
CC: Adrian Bunk <bunk@fs.tum.de>, Dave Jones <davej@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.5.14-dj1: misc.o: undefined reference to `__io_virt_debug'
In-Reply-To: <Pine.NEB.4.44.0205072137260.9347-100000@mimas.fachschaften.tu-muenchen.de> <278490000.1020811234@flay> <3CD84BA9.95B3E482@didntduck.org> <281270000.1020812456@flay>
Content-Type: multipart/mixed;
 boundary="------------030704010708000600000300"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030704010708000600000300
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Martin J. Bligh wrote:
>>>>Compiling misc.c with -O0 gives a better error message:
>>>>
>>>><--  snip  -->
>>>>
>>>>...
>>>>ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o
>>>>piggy.o
>>>>misc.o: In function `outb_quad':
>>>>misc.o(.text+0x289c): undefined reference to `__io_virt_debug'
>>>>make[2]: *** [bvmlinux] Error 1
>>>>make[2]: Leaving directory
>>>>`/home/bunk/linux/kernel-2.5/linux-2.5.14-modular/arch/i386/boot/compressed'
>>>
>>>Seems like you're not linking in lib/iodebug.c for some reason.
>>>
>>>outb_quad calls readb, which calls __io_virt, which calls __io_virt_debug,
>>>which is defined in iodebug.c
>>
>>It's in the boot decompression code, before any of that stuff is
>>available.  I'm working on a patch.
> 
> 
> Is this arch/i386/boot/compressed/misc.c ?
> I can't see how it would be doing outb_quad, and even if it was, it
> would be totally pointless, as xquad_portio isn't set yet ....
> 
> M.
> 

This patch fixes the compile problem, but I'm not quite convinced it's 
the best solution.  The decompressor is a completely seperate 
environment from the kernel, so including kernel headers continues to 
invite problems like this in the future.

-- 

						Brian Gerst

--------------030704010708000600000300
Content-Type: text/plain;
 name="io-boot-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="io-boot-1"

diff -urN linux-2.5.14-dj1/arch/i386/boot/compressed/misc.c linux/arch/i386/boot/compressed/misc.c
--- linux-2.5.14-dj1/arch/i386/boot/compressed/misc.c	Thu Mar  7 21:18:54 2002
+++ linux/arch/i386/boot/compressed/misc.c	Tue May  7 18:04:08 2002
@@ -124,10 +124,6 @@
 static int vidport;
 static int lines, cols;
 
-#ifdef CONFIG_MULTIQUAD
-static void *xquad_portio = NULL;
-#endif
-
 #include "../../../../lib/inflate.c"
 
 static void *malloc(int size)
@@ -202,10 +198,10 @@
 	SCREEN_INFO.orig_y = y;
 
 	pos = (x + cols * y) * 2;	/* Update cursor position */
-	outb_p(14, vidport);
-	outb_p(0xff & (pos >> 9), vidport+1);
-	outb_p(15, vidport);
-	outb_p(0xff & (pos >> 1), vidport+1);
+	outb_local(14, vidport); slow_down_io();
+	outb_local(0xff & (pos >> 9), vidport+1); slow_down_io();
+	outb_local(15, vidport); slow_down_io();
+	outb_local(0xff & (pos >> 1), vidport+1); slow_down_io();
 }
 
 static void* memset(void* s, int c, size_t n)

--------------030704010708000600000300--

