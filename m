Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268006AbTCFLLn>; Thu, 6 Mar 2003 06:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268012AbTCFLLn>; Thu, 6 Mar 2003 06:11:43 -0500
Received: from packet.digeo.com ([12.110.80.53]:26593 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268006AbTCFLLm>;
	Thu, 6 Mar 2003 06:11:42 -0500
Date: Thu, 6 Mar 2003 03:22:08 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] work around gcc-3.x inlining bugs
Message-Id: <20030306032208.03f1b5e2.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2003 11:22:08.0731 (UTC) FILETIME=[A007FAB0:01C2E3D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch:

--- 25/include/linux/compiler.h~gcc3-inline-fix	2003-03-06 03:02:43.000000000 -0800
+++ 25-akpm/include/linux/compiler.h	2003-03-06 03:11:42.000000000 -0800
@@ -1,6 +1,11 @@
 #ifndef __LINUX_COMPILER_H
 #define __LINUX_COMPILER_H
 
+#if __GNUC__ >= 3
+#define inline __inline__ __attribute__((always_inline))
+#define __inline__ __inline__ __attribute__((always_inline))
+#endif
+
 /* Somewhere in the middle of the GCC 2.96 development cycle, we implemented
    a mechanism by which the user can annotate likely branch directions and
    expect the blocks to be reordered appropriately.  Define __builtin_expect


shrinks my 3.2.1-compiled kernel text by about 64 kbytes:

   text    data     bss     dec     hex filename
3316138  574844  726816 4617798  467646 vmlinux-before
3249255  555436  727204 4531895  4526b7 vmlinux-after

mnm:/tmp> nm vmlinux-before|grep __constant_c_and_count_memset | wc
    233     699    9553
mnm:/tmp> nm vmlinux-after|grep __constant_c_and_count_memset | wc
     13      39     533

Can anyone see a problem with it?

