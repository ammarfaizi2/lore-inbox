Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSJ2XuP>; Tue, 29 Oct 2002 18:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262488AbSJ2XuP>; Tue, 29 Oct 2002 18:50:15 -0500
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:4245 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S262486AbSJ2XuN>; Tue, 29 Oct 2002 18:50:13 -0500
Message-ID: <3DBF2032.1040000@quark.didntduck.org>
Date: Tue, 29 Oct 2002 18:56:34 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] make x86 ptrace use init_fpu()
Content-Type: multipart/mixed;
 boundary="------------000008050903000906040507"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000008050903000906040507
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This fixes PTRACE_GETFPREGS to initilize the fpu struct correctly on 
cpus with fxsr, as well as removing redundant code.

--
				Brian Gerst

--------------000008050903000906040507
Content-Type: text/plain;
 name="ptrace-fpu-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ptrace-fpu-1"

diff -urN linux-2.5.44-bk3/arch/i386/kernel/ptrace.c linux/arch/i386/kernel/ptrace.c
--- linux-2.5.44-bk3/arch/i386/kernel/ptrace.c	Sun Sep 15 22:18:24 2002
+++ linux/arch/i386/kernel/ptrace.c	Tue Oct 29 17:04:59 2002
@@ -375,12 +375,8 @@
 			break;
 		}
 		ret = 0;
-		if ( !child->used_math ) {
-			/* Simulate an empty FPU. */
-			set_fpu_cwd(child, 0x037f);
-			set_fpu_swd(child, 0x0000);
-			set_fpu_twd(child, 0xffff);
-		}
+		if (!child->used_math)
+			init_fpu(child);
 		get_fpregs((struct user_i387_struct *)data, child);
 		break;
 	}
@@ -403,13 +399,8 @@
 			ret = -EIO;
 			break;
 		}
-		if ( !child->used_math ) {
-			/* Simulate an empty FPU. */
-			set_fpu_cwd(child, 0x037f);
-			set_fpu_swd(child, 0x0000);
-			set_fpu_twd(child, 0xffff);
-			set_fpu_mxcsr(child, 0x1f80);
-		}
+		if (!child->used_math)
+			init_fpu(child);
 		ret = get_fpxregs((struct user_fxsr_struct *)data, child);
 		break;
 	}

--------------000008050903000906040507--

