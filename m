Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262526AbSJBSOY>; Wed, 2 Oct 2002 14:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262527AbSJBSOY>; Wed, 2 Oct 2002 14:14:24 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:64736 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262526AbSJBSOW>;
	Wed, 2 Oct 2002 14:14:22 -0400
Message-ID: <3D9B37E3.4090903@us.ibm.com>
Date: Wed, 02 Oct 2002 11:16:03 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: [patch][rfc] xquad_portio cleanup 2.5.40
References: <3D98DFA0.6020908@us.ibm.com> <20021001152148.GA126@suse.de> 	<3D9A173B.1010205@us.ibm.com> <1033519383.20103.36.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/mixed;
 boundary="------------050303000303000707000107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050303000303000707000107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus,
	I believe Alan cleared up the only objection to this small patch.  Please 
apply.

Changelog:
	Cleans up a bit of a hack to get compressed (gziped) kernels booting on 
NUMA-Q.  Resulting code is more readable and understandable.

Cheers!

-Matt

Alan Cox wrote:
> On Tue, 2002-10-01 at 22:44, Matthew Dobson wrote:
> 
>>>STANDALONE seems to be a very namespace-polluting choice of define.
>>>MULTIQUAD_STANDALONE, MQ_STANDALONE... anything would be better imo.
>>
>>The #define is most definitely *not* NUMA/Multiquad specific.  In this
>>particular instance, it is guarding Multiquad specific code...  The 
>>STANDALONE option (please clarify if I'm wrong, Alan) is for code that 
>>is compiled along with the kernel, with the kernel headers, etc, but is 
>>not acually part of the kernel proper.
> 
> 
> Indeed
> 
> Its set by the boot loader code that wants to also use inb/outb etc but
> not get the kernel magic wonders of numa-q and other evil abuses of PC
> iomapping 


--------------050303000303000707000107
Content-Type: text/plain;
 name="xquad_fixup-2540.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xquad_fixup-2540.patch"

diff -Nur linux-2.5.31-vanilla/arch/i386/boot/compressed/misc.c linux-2.5.31-xquad/arch/i386/boot/compressed/misc.c
--- linux-2.5.31-vanilla/arch/i386/boot/compressed/misc.c	Sat Aug 10 18:41:40 2002
+++ linux-2.5.31-xquad/arch/i386/boot/compressed/misc.c	Thu Aug 15 14:28:33 2002
@@ -9,6 +9,8 @@
  * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
  */
 
+#define STANDALONE
+
 #include <linux/linkage.h>
 #include <linux/vmalloc.h>
 #include <linux/tty.h>
@@ -120,10 +122,6 @@
 static int vidport;
 static int lines, cols;
 
-#ifdef CONFIG_MULTIQUAD
-static void * xquad_portio = NULL;
-#endif
-
 #include "../../../../lib/inflate.c"
 
 static void *malloc(int size)
diff -Nur linux-2.5.31-vanilla/include/asm-i386/io.h linux-2.5.31-xquad/include/asm-i386/io.h
--- linux-2.5.31-vanilla/include/asm-i386/io.h	Sat Aug 10 18:41:28 2002
+++ linux-2.5.31-xquad/include/asm-i386/io.h	Thu Aug 15 15:17:31 2002
@@ -298,7 +298,11 @@
 #endif
 
 #ifdef CONFIG_MULTIQUAD
-extern void *xquad_portio;    /* Where the IO area was mapped */
+ #ifdef STANDALONE
+  #define xquad_portio 0
+ #else /* !STANDALONE */
+  extern void *xquad_portio;    /* Where the IO area was mapped */
+ #endif /* STANDALONE */
 #endif /* CONFIG_MULTIQUAD */
 
 /*

--------------050303000303000707000107--

