Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUJFBpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUJFBpV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 21:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUJFBpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 21:45:21 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:30737 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S266517AbUJFBpI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 21:45:08 -0400
Message-ID: <41634E21.6020808@vmware.com>
Date: Tue, 05 Oct 2004 18:45:05 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Riley@Williams.Name, davej@codemonkey.org.uk,
       hpa@zytor.com, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@muc.de>
Subject: [PATCH] i386/gcc bug with do_test_wp_bit 
Content-Type: multipart/mixed;
 boundary="------------030000050408050204050204"
X-OriginalArrivalTime: 06 Oct 2004 01:45:05.0239 (UTC) FILETIME=[1A695E70:01C4AB46]
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.3; VDF: 6.28.0.3; host: mailout1.vmware.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030000050408050204050204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Playing around with gcc 3.3.3, I compiled a 2.6 series kernel for i386 
and discovered it panics on boot.  The problem was gcc 3.3.3 can inline 
functions even if declared after their call sites.  This causes i386 to 
not boot, since do_test_wp_bit() must not exist in the __init section.  
Similar problems may exist in the boot code for other architectures, but 
I can't confirm that at this time.  x86_64 is not affected.

I've included a small trivial fix that is harmless for users not using 
gcc 3.3.3.  Testing: my 2.6 kernel now boots when compiled with gcc 
3.3.3 compiler.

Cheers,
Zach Amsden
zach@vmware.com

--------------030000050408050204050204
Content-Type: text/plain;
 name="i386-wp-test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-wp-test.patch"

diff -ru linux-2.6.9-rc3/arch/i386/mm/init.c linux-2.6.9-rc3-za1/arch/i386/mm/init.c
--- linux-2.6.9-rc3/arch/i386/mm/init.c	2004-10-05 18:21:03.000000000 -0700
+++ linux-2.6.9-rc3-za1/arch/i386/mm/init.c	2004-10-05 18:24:08.000000000 -0700
@@ -671,9 +671,9 @@
 
 /*
  * This function cannot be __init, since exceptions don't work in that
- * section.  Put this after the callers, so that it cannot be inlined.
+ * section.  This function must not be inlined.
  */
-static int do_test_wp_bit(void)
+__attribute__((noinline)) static int do_test_wp_bit(void)
 {
 	char tmp_reg;
 	int flag;

--------------030000050408050204050204
Content-Type: text/plain;
 name="README.i386-wp-test"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="README.i386-wp-test"

When compiling a Linux 2.6 kernel using gcc 3.3.3, gcc was able to inline the function do_test_wp_bit().  This causes i386 kernels to panic on boot, since the exception handler doesn't work properly.

The fix is straightforward - don't ever allow this function to be inlined.

Here's a disassembly to confirm the bad inline:

c02aecf1 <test_wp_bit>:
c02aecf1:       55                      push   %ebp
c02aecf2:       89 e5                   mov    %esp,%ebp
c02aecf4:       83 ec 0c                sub    $0xc,%esp
c02aecf7:       c7 04 24 0c a0 25 c0    movl   $0xc025a00c,(%esp)
c02aecfe:       e8 63 73 e6 ff          call   c0116066 <printk>
c02aed03:       c7 44 24 08 25 00 00    movl   $0x25,0x8(%esp)
c02aed0a:       00 
c02aed0b:       c7 44 24 04 00 10 10    movl   $0x101000,0x4(%esp)
c02aed12:       00 
c02aed13:       c7 04 24 12 00 00 00    movl   $0x12,(%esp)
c02aed1a:       e8 d5 11 e6 ff          call   c010fef4 <__set_fixmap>
c02aed1f:       b8 01 00 00 00          mov    $0x1,%eax
c02aed24:       8a 15 00 d0 fe ff       mov    0xfffed000,%dl
c02aed2a:       88 15 00 d0 fe ff       mov    %dl,0xfffed000

Cheers,

Zachary Amsden (zach@vmware.com)

--------------030000050408050204050204--
