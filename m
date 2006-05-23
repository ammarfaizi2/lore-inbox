Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWEWDLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWEWDLJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 23:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWEWDLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 23:11:09 -0400
Received: from mail.gmx.de ([213.165.64.20]:62081 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751260AbWEWDLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 23:11:08 -0400
X-Authenticated: #31060655
Message-ID: <44727CE4.3090307@gmx.net>
Date: Tue, 23 May 2006 05:09:24 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060316 SUSE/1.0-27 SeaMonkey/1.0
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Consoldidate arch/{i386,x86_64}/boot/compressed/misc.c
References: <4471FD34.8050202@gmx.net> <200605222028.32934.ak@suse.de> <44720BD2.7060809@gmx.net> <200605230219.56068.ak@suse.de>
In-Reply-To: <200605230219.56068.ak@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Monday 22 May 2006 21:06, Carl-Daniel Hailfinger wrote:
>> Andi Kleen wrote:
>>
>>>> Would a series of incremental patches to consolidate these two
>>>> subtrees get accepted?
>>>>     
>>> Yes.
>>>
>>> I have some plans to change the 64bit boot up though - the uncompression
>>> should already run as 64bit - but that shouldnt' affect these files.
>>>   
>> Clean up arch/{i386,x86_64}/boot/compressed/misc.c a bit to reduce their
>> differences. Should have zero effect on code generation.
> 
> Applied.

Thanks!

Could you have a look at the remaining differences and tell me what else
can be nuked?
* For the CONFIG_X86_NUMAQ stuff there were some patches flying around,
  but it seems they never got applied.
* The hand-coded stack is probably a bootloader thing, but I don't yet
  understand why it's only in i386.
* The "uncompressing" messages differ. Any reason for that?
* The list of includes differs. Probably related to NUMAQ and stack.
* decompress_kernel is asmlinkage only on i386.

--- linux-2.6.17-rc4/arch/i386/boot/compressed/misc.c   2006-05-22 20:56:09.000000000 +0200
+++ linux-2.6.17-rc4/arch/x86_64/boot/compressed/misc.c 2006-05-22 20:56:30.000000000 +0200
@@ -9,8 +9,6 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */

-#include <linux/linkage.h>
-#include <linux/vmalloc.h>
 #include <linux/screen_info.h>
 #include <asm/io.h>
 #include <asm/page.h>
@@ -116,10 +114,6 @@
 static int vidport;
 static int lines, cols;

-#ifdef CONFIG_X86_NUMAQ
-static void * xquad_portio = NULL;
-#endif
-
 #include "../../../../lib/inflate.c"

 static void *malloc(int size)
@@ -287,15 +281,6 @@
        while(1);       /* Halt */
 }

-#define STACK_SIZE (4096)
-
-long user_stack [STACK_SIZE];
-
-struct {
-       long * a;
-       short b;
-       } stack_start = { & user_stack [STACK_SIZE] , __BOOT_DS };
-
 static void setup_normal_output_buffer(void)
 {
 #ifdef STANDARD_MEMORY_BIOS_CALL
@@ -346,7 +331,7 @@
        }
 }

-asmlinkage int decompress_kernel(struct moveparams *mv, void *rmode)
+int decompress_kernel(struct moveparams *mv, void *rmode)
 {
        real_mode = rmode;

@@ -365,9 +350,9 @@
        else setup_output_buffer_if_we_run_high(mv);

        makecrc();
-       putstr("Uncompressing Linux... ");
+       putstr(".\nDecompressing Linux...");
        gunzip();
-       putstr("Ok, booting the kernel.\n");
+       putstr("done.\nBooting the kernel.\n");
        if (high_loaded) close_output_buffer_if_we_run_high(mv);
        return high_loaded;
 }


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
