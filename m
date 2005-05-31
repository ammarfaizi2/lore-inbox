Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVE3Vxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVE3Vxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 17:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbVE3Vxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 17:53:35 -0400
Received: from vsmtp3alice.tin.it ([212.216.176.143]:28386 "EHLO
	vsmtp3alice.tin.it") by vger.kernel.org with ESMTP id S261776AbVE3VxR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 17:53:17 -0400
From: Goffredo Baroncelli <kreijack@inwind.it>
Subject: [TRIVIAL][PATCH] UDF filesystem: array '__mon_yday' declared as not static
Date: Tue, 31 May 2005 23:52:35 +0200
User-Agent: KMail/1.8
Cc: bfennema@falcon.csc.calpoly.edu
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505312352.35842.kreijack@inwind.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC' me in the reply because I'am not in the mailing list ]

Hi,

I sent already this mail to the linux_udf@hpesjro.fc.hp.com and to 
bfennema@falcon.csc.calpoly.edu, the address reported in MAINTAINER file, but 
no response was returned.

in fs/udf/udftime.c the global array '__mon_yday' are defined as not static, 
so it conflicts with the glibc one when the kernel are compiled as user mode 
linux. 

        [ghigo@therra 2.6.10]$ make linux ARCH=um
        [....]
        CC      fs/udf/udftime.o
        LD      fs/udf/udf.o
        LD      fs/udf/built-in.o
        [....]
        /usr/lib/libc.a(mktime.o)(.rodata+0x0): multiple definition of 
`__mon_yday'
        fs/built-in.o(.rodata+0x3540):fs/buffer.c:375: first defined here
        collect2: ld returned 1 exit status
        KSYM    .tmp_kallsyms1.S
        nm '.tmp_vmlinux1': No such file
        make: *** [.tmp_kallsyms1.S] Error 139

Even tough I don't understand why the error message complains about 
fs/buffer.c, I found that the problem is in fs/udf/udftime.c.


The patch below declare the array static. I checked the linux tree and I 
didn't find any reference to an array '__mon_yday' from an extern module.

diff -Naur new/fs/udf/udftime.c orig/fs/udf/udftime.c

--- new/fs/udf/udftime.c Sun Feb 20 12:18:06 2005
+++ orig/fs/udf/udftime.c Sun Feb 20 12:18:32 2005
@@ -46,7 +46,7 @@
 #endif
 
 /* How many days come before each month (0-12).  */
-const unsigned short int __mon_yday[2][13] =
+static const unsigned short int __mon_yday[2][13] =
 {
  /* Normal years.  */
  { 0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365 },

-- 
gpg key@ keyserver.linux.it: 
  Goffredo Baroncelli (ghigo) <kreijack AT inwind DOT it>
Key fingerprint = CE3C 7E01 6782 30A3 5B87  87C0 BB86 505C 6B2A CFF9



