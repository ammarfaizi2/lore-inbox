Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWBCUca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWBCUca (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWBCUca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:32:30 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:58011 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751159AbWBCUc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:32:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:mime-version:to:subject:content-type;
        b=uetaMSw5BOSRYfVg/KoNRCAhsLxJdDRbj2c2+DUxRvWsZNOn0SjYU1+cy/7WGcFKsObUS3asEhlSbRJkDnDhntmTiRSjneR/koDQlonzS0XdKzZqEAaKYlVtg3vu9vDoQ0rjez+RG9mkOqgURv0LYWZyEVENoYOt/pVQHQgFknY=
Message-ID: <43E3BDDD.6000402@gmail.com>
Date: Fri, 03 Feb 2006 22:32:29 +0200
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060112)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256 limit - Resubmit
Content-Type: multipart/mixed;
 boundary="------------060901050604060605090504"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060901050604060605090504
Content-Type: text/plain; charset=ISO-8859-8-I; format=flowed
Content-Transfer-Encoding: 7bit


Extending the kernel parameters to a size of 1024 on boot
protocol >=2.02 for i386 and x86_64 architectures.

Signed-off-by: Alon Bar-Lev <alon.barlev@gmail.com>

---

Hello,

This patch was submitted a long ago, but did not find its 
way into the kernel, but was not rejected as well.

Current implementation allows the kernel to receive up to 
255 characters from the bootloader.

In current environment, the command-line is used in order to
specify many values, including suspend/resume, module
arguments, splash, initramfs and more.

255 characters are not enough anymore.

Please consider to merge.

If any of you think that this should be applied for other
architectures, please reply.

Current architectures that have 256 limit are:
alpha, cris, i386, m64k, mips, sh, sh64, sparc, sparc64,
x86_64, xtensa

Current architectures that have 512 values are:
frv(512), h8300(512), ia64(512), m32r(512), m68knommu(512),
mips(512), powerpc(512), v850(512)

Current architectures that are OK:
arm(1024), arm26(1024), parisc(1024)

Current strange ones:
s390(896) - I guess IBM has a good reason for this constant...

Best Regards,
Alon Bar-Lev


--------------060901050604060605090504
Content-Type: text/plain;
 name="linux-2.6.16-rc2-command-line.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.16-rc2-command-line.diff"

diff -urNp linux-2.6.16-rc2/Documentation/i386/boot.txt linux-2.6.16-rc2.new/Documentation/i386/boot.txt
--- linux-2.6.16-rc2/Documentation/i386/boot.txt	2006-01-03 05:21:10.000000000 +0200
+++ linux-2.6.16-rc2.new/Documentation/i386/boot.txt	2006-02-03 21:32:03.000000000 +0200
@@ -235,11 +235,8 @@ loader to communicate with the kernel.  
 relevant to the boot loader itself, see "special command line options"
 below.
 
-The kernel command line is a null-terminated string currently up to
-255 characters long, plus the final null.  A string that is too long
-will be automatically truncated by the kernel, a boot loader may allow
-a longer command line to be passed to permit future kernels to extend
-this limit.
+The kernel command line is a null-terminated string. A string that is too
+long will be automatically truncated by the kernel.
 
 If the boot protocol version is 2.02 or later, the address of the
 kernel command line is given by the header field cmd_line_ptr (see
@@ -260,6 +257,9 @@ command line is entered using the follow
 	covered by setup_move_size, so you may need to adjust this
 	field.
 
+	The kernel command line *must* be 256 bytes including the
+	final null.
+
 
 **** SAMPLE BOOT CONFIGURATION
 
diff -urNp linux-2.6.16-rc2/include/asm-i386/param.h linux-2.6.16-rc2.new/include/asm-i386/param.h
--- linux-2.6.16-rc2/include/asm-i386/param.h	2006-01-03 05:21:10.000000000 +0200
+++ linux-2.6.16-rc2.new/include/asm-i386/param.h	2006-02-03 21:23:21.000000000 +0200
@@ -19,6 +19,6 @@
 #endif
 
 #define MAXHOSTNAMELEN	64	/* max length of hostname */
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE 1024
 
 #endif
diff -urNp linux-2.6.16-rc2/include/asm-i386/setup.h linux-2.6.16-rc2.new/include/asm-i386/setup.h
--- linux-2.6.16-rc2/include/asm-i386/setup.h	2006-01-03 05:21:10.000000000 +0200
+++ linux-2.6.16-rc2.new/include/asm-i386/setup.h	2006-02-03 21:19:44.000000000 +0200
@@ -17,7 +17,7 @@
 #define MAX_NONPAE_PFN	(1 << 20)
 
 #define PARAM_SIZE 4096
-#define COMMAND_LINE_SIZE 256
+#define COMMAND_LINE_SIZE 1024
 
 #define OLD_CL_MAGIC_ADDR	0x90020
 #define OLD_CL_MAGIC		0xA33F
diff -urNp linux-2.6.16-rc2/include/asm-x86_64/setup.h linux-2.6.16-rc2.new/include/asm-x86_64/setup.h
--- linux-2.6.16-rc2/include/asm-x86_64/setup.h	2006-01-03 05:21:10.000000000 +0200
+++ linux-2.6.16-rc2.new/include/asm-x86_64/setup.h	2006-02-03 21:20:40.000000000 +0200
@@ -1,6 +1,6 @@
 #ifndef _x8664_SETUP_H
 #define _x8664_SETUP_H
 
-#define COMMAND_LINE_SIZE	256
+#define COMMAND_LINE_SIZE	1024
 
 #endif

--------------060901050604060605090504--
