Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261526AbVCRJWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbVCRJWd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVCRJWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:22:33 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:35090 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261526AbVCRJW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:22:28 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] reduce inlined x86 memcpy by 2 bytes
Date: Fri, 18 Mar 2005 11:21:42 +0200
User-Agent: KMail/1.5.4
Cc: Matt Mackall <mpm@selenic.com>, vital@ilport.com.ua
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_m2pOCir3LZ3oBPb"
Message-Id: <200503181121.42809.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_m2pOCir3LZ3oBPb
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This memcpy() is 2 bytes shorter than one currently in mainline
and it have one branch less. It is also 3-4% faster in microbenchmarks
on small blocks if block size is multiple of 4. Mainline is slower
because it has to branch twice per memcpy, both mispredicted
(but branch prediction hides that in microbenchmark).

Last remaining branch can be dropped too, but then we execute second
'rep movsb' always, even if blocksize%4==0. This is slower than mainline
because 'rep movsb' is microcoded. I wonder, tho, whether 'branchlessness'
wins over this in real world use (not in bench).

I think blocksize%4==0 happens more than 25% of the time.

This is how many 'allyesconfig' vmlinux gains on branchless memcpy():

# size vmlinux.org vmlinux.memcpy
   text    data     bss     dec     hex filename
18178950        6293427 1808916 26281293        191054d vmlinux.org
18165160        6293427 1808916 26267503        190cf6f vmlinux.memcpy

# echo $(( (18178950-18165160) ))
13790 <============= bytes saved on allyesconfig

# echo $(( (18178950-18165160)/4 ))
3447 <============= memcpy() callsites optimized

Attached patch (with one branch) would save 6.5k instead of 13k.

Patch is run tested.
--
vda

--Boundary-00=_m2pOCir3LZ3oBPb
Content-Type: text/x-diff;
  charset="koi8-r";
  name="string.memcpy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="string.memcpy.diff"

--- linux-2.6.11.src/include/asm-i386/string.h.orig	Thu Mar  3 09:31:08 2005
+++ linux-2.6.11.src/include/asm-i386/string.h	Fri Mar 18 10:55:51 2005
@@ -198,15 +198,13 @@ static inline void * __memcpy(void * to,
 int d0, d1, d2;
 __asm__ __volatile__(
 	"rep ; movsl\n\t"
-	"testb $2,%b4\n\t"
-	"je 1f\n\t"
-	"movsw\n"
-	"1:\ttestb $1,%b4\n\t"
-	"je 2f\n\t"
-	"movsb\n"
-	"2:"
+	"movl %4,%%ecx\n\t"
+	"andl $3,%%ecx\n\t"
+	"jz 1f\n\t"	/* pay 2 byte penalty for a chance to skip microcoded rep */
+	"rep ; movsb\n\t"
+	"1:"
 	: "=&c" (d0), "=&D" (d1), "=&S" (d2)
-	:"0" (n/4), "q" (n),"1" ((long) to),"2" ((long) from)
+	: "0" (n/4), "g" (n), "1" ((long) to), "2" ((long) from)
 	: "memory");
 return (to);
 }

--Boundary-00=_m2pOCir3LZ3oBPb--

