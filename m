Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265288AbUF1Xf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265288AbUF1Xf5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 19:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265293AbUF1Xf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 19:35:57 -0400
Received: from sweetums.bluetronic.net ([24.199.150.42]:11702 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S265288AbUF1Xfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 19:35:55 -0400
Date: Mon, 28 Jun 2004 19:29:43 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetronic.net>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: __setup()'s not processed in bk-current
In-Reply-To: <Pine.GSO.4.33.0406281523340.25702-100000@sweetums.bluetronic.net>
Message-ID: <Pine.GSO.4.33.0406281838260.25702-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jun 2004, Ricky Beam wrote:
>The linked kernel *looks* correct (x86_64 here):
>Contents of section .init.data:
> ffffffff8058d000 6e6f736d 70006d61 78637075 733d0070  nosmp.maxcpus=.p
>
>Contents of section .init.setup:
> ffffffff80593510 00d05880 ffffffff 60125780 ffffffff  ..X.....`.W.....
> ffffffff80593520 00000000 00000000 00000000 00000000  ................
> ffffffff80593530 06d05880 ffffffff 70125780 ffffffff  ..X.....p.W.....
> ffffffff80593540 00000000 00000000 00000000 00000000  ................
>
>Do I smell some bad pointer math?  Yeap:
>DEBUG: sizeof(obs_kernel_param): 24 (0x18)

Ahh.  Not bad pointer math.  Bad kernel source :-)  The compiler is not
aware of the packing/alignment of the .init.setup section until link
time which is too late.  The .init.setup section is ALIGN(16)'d for
almost all archs.  (h8300 is 4 bytes.)

There may be other instances like this that'll eventually bite us in the
ass.

(A) Fix... at least for x86_64.

===== include/linux/init.h 1.33 vs edited =====
--- 1.33/include/linux/init.h   2004-06-27 03:19:38 -04:00
+++ edited/include/linux/init.h 2004-06-28 18:39:37 -04:00
@@ -107,11 +107,12 @@
        static initcall_t __initcall_##fn \
        __attribute_used__ __attribute__((__section__(".security_initcall.init"))) = fn

+/* FIXME: not all arch's are aligned on a 16byte boundry */
 struct obs_kernel_param {
        const char *str;
        int (*setup_func)(char *);
        int early;
-};
+} __attribute__((aligned(16)));

 /* Only for really core code.  See moduleparam.h for the normal way. */
 #define __setup_param(str, unique_id, fn, early)                       \

===== arch/x86_64/kernel/vmlinux.lds.S 1.23 vs edited =====
--- 1.23/arch/x86_64/kernel/vmlinux.lds.S       2004-05-30 07:33:25 -04:00
+++ edited/arch/x86_64/kernel/vmlinux.lds.S     2004-06-28 19:20:20 -04:00
@@ -87,7 +87,7 @@
        _einittext = .;
   }
   .init.data : { *(.init.data) }
-  . = ALIGN(16);
+  . = ALIGN(32);
   __setup_start = .;
   .init.setup : { *(.init.setup) }
   __setup_end = .;

(don't ask me why __setup_start is landing 16b less than it should)

--Ricky


