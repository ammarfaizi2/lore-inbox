Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161058AbVIBVcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161058AbVIBVcj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 17:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161055AbVIBVcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 17:32:39 -0400
Received: from terminus.zytor.com ([209.128.68.124]:43672 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161058AbVIBVci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 17:32:38 -0400
Message-ID: <4318C3F6.6000004@zytor.com>
Date: Fri, 02 Sep 2005 14:28:22 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Frank Sorenson <frank@tuxrocks.com>
Subject: [PATCH] Make the bzImage format self-terminating
References: <4318BD50.5050507@zytor.com>
In-Reply-To: <4318BD50.5050507@zytor.com>
Content-Type: multipart/mixed;
 boundary="------------000707090806060301020108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000707090806060301020108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I'm proposing the attached patch to replace Frank Sorenson's 
i386-buildc-write-out-larger-system-size-to-bootsector patch currently 
in -mm.  The goal (presumably) is to make the bzImage format 
self-terminating.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------000707090806060301020108
Content-Type: text/x-patch;
 name="i386-x86_64-extend-syssize.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="i386-x86_64-extend-syssize.patch"

diff --git a/Documentation/i386/boot.txt b/Documentation/i386/boot.txt
--- a/Documentation/i386/boot.txt
+++ b/Documentation/i386/boot.txt
@@ -2,7 +2,7 @@
 		     ----------------------------
 
 		    H. Peter Anvin <hpa@zytor.com>
-			Last update 2002-01-01
+			Last update 2005-09-02
 
 On the i386 platform, the Linux kernel uses a rather complicated boot
 convention.  This has evolved partially due to historical aspects, as
@@ -34,6 +34,8 @@ Protocol 2.02:	(Kernel 2.4.0-test3-pre3)
 Protocol 2.03:	(Kernel 2.4.18-pre1) Explicitly makes the highest possible
 		initrd address available to the bootloader.
 
+Protocol 2.04:	(Kernel 2.6.14) Extend the syssize field to four bytes.
+
 
 **** MEMORY LAYOUT
 
@@ -103,10 +105,9 @@ The header looks like:
 Offset	Proto	Name		Meaning
 /Size
 
-01F1/1	ALL	setup_sects	The size of the setup in sectors
+01F1/1	ALL(1	setup_sects	The size of the setup in sectors
 01F2/2	ALL	root_flags	If set, the root is mounted readonly
-01F4/2	ALL	syssize		DO NOT USE - for bootsect.S use only
-01F6/2	ALL	swap_dev	DO NOT USE - obsolete
+01F4/4	2.04+(2	syssize		The size of the 32-bit code in 16-byte paras
 01F8/2	ALL	ram_size	DO NOT USE - for bootsect.S use only
 01FA/2	ALL	vid_mode	Video mode control
 01FC/2	ALL	root_dev	Default root device number
@@ -129,8 +130,12 @@ Offset	Proto	Name		Meaning
 0228/4	2.02+	cmd_line_ptr	32-bit pointer to the kernel command line
 022C/4	2.03+	initrd_addr_max	Highest legal initrd address
 
-For backwards compatibility, if the setup_sects field contains 0, the
-real value is 4.
+(1) For backwards compatibility, if the setup_sects field contains 0, the
+    real value is 4.
+
+(2) For boot protocol prior to 2.04, the upper two bytes of the syssize
+    field are unusable, which means the size of a bzImage kernel
+    cannot be determined.
 
 If the "HdrS" (0x53726448) magic number is not found at offset 0x202,
 the boot protocol version is "old".  Loading an old kernel, the
@@ -230,12 +235,16 @@ loader to communicate with the kernel.  
 relevant to the boot loader itself, see "special command line options"
 below.
 
-The kernel command line is a null-terminated string up to 255
-characters long, plus the final null.
+The kernel command line is a null-terminated string currently up to
+255 characters long, plus the final null.  A string that is too long
+will be automatically truncated by the kernel, a boot loader may allow
+a longer command line to be passed to permit future kernels to extend
+this limit.
 
 If the boot protocol version is 2.02 or later, the address of the
 kernel command line is given by the header field cmd_line_ptr (see
-above.)
+above.)  This address can be anywhere between the end of the setup
+heap and 0xA0000.
 
 If the protocol version is *not* 2.02 or higher, the kernel
 command line is entered using the following protocol:
@@ -255,7 +264,7 @@ command line is entered using the follow
 **** SAMPLE BOOT CONFIGURATION
 
 As a sample configuration, assume the following layout of the real
-mode segment:
+mode segment (this is a typical, and recommended layout):
 
 	0x0000-0x7FFF	Real mode kernel
 	0x8000-0x8FFF	Stack and heap
@@ -312,9 +321,9 @@ Such a boot loader should enter the foll
 
 **** LOADING THE REST OF THE KERNEL
 
-The non-real-mode kernel starts at offset (setup_sects+1)*512 in the
-kernel file (again, if setup_sects == 0 the real value is 4.)  It
-should be loaded at address 0x10000 for Image/zImage kernels and
+The 32-bit (non-real-mode) kernel starts at offset (setup_sects+1)*512
+in the kernel file (again, if setup_sects == 0 the real value is 4.)
+It should be loaded at address 0x10000 for Image/zImage kernels and
 0x100000 for bzImage kernels.
 
 The kernel is a bzImage kernel if the protocol >= 2.00 and the 0x01
diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
--- a/arch/i386/boot/setup.S
+++ b/arch/i386/boot/setup.S
@@ -82,7 +82,7 @@ start:
 # This is the setup header, and it must start at %cs:2 (old 0x9020:2)
 
 		.ascii	"HdrS"		# header signature
-		.word	0x0203		# header version number (>= 0x0105)
+		.word	0x0204		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
 start_sys_seg:	.word	SYSSEG
diff --git a/arch/i386/boot/tools/build.c b/arch/i386/boot/tools/build.c
--- a/arch/i386/boot/tools/build.c
+++ b/arch/i386/boot/tools/build.c
@@ -177,7 +177,9 @@ int main(int argc, char ** argv)
 		die("Output: seek failed");
 	buf[0] = (sys_size & 0xff);
 	buf[1] = ((sys_size >> 8) & 0xff);
-	if (write(1, buf, 2) != 2)
+	buf[2] = ((sys_size >> 16) & 0xff);
+	buf[3] = ((sys_size >> 24) & 0xff);
+	if (write(1, buf, 4) != 4)
 		die("Write of image length failed");
 
 	return 0;					    /* Everything is OK */
diff --git a/arch/x86_64/boot/setup.S b/arch/x86_64/boot/setup.S
--- a/arch/x86_64/boot/setup.S
+++ b/arch/x86_64/boot/setup.S
@@ -81,7 +81,7 @@ start:
 # This is the setup header, and it must start at %cs:2 (old 0x9020:2)
 
 		.ascii	"HdrS"		# header signature
-		.word	0x0203		# header version number (>= 0x0105)
+		.word	0x0204		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
 start_sys_seg:	.word	SYSSEG
diff --git a/arch/x86_64/boot/tools/build.c b/arch/x86_64/boot/tools/build.c
--- a/arch/x86_64/boot/tools/build.c
+++ b/arch/x86_64/boot/tools/build.c
@@ -178,7 +178,9 @@ int main(int argc, char ** argv)
 		die("Output: seek failed");
 	buf[0] = (sys_size & 0xff);
 	buf[1] = ((sys_size >> 8) & 0xff);
-	if (write(1, buf, 2) != 2)
+	buf[2] = ((sys_size >> 16) & 0xff);
+	buf[3] = ((sys_size >> 24) & 0xff);
+	if (write(1, buf, 4) != 4)
 		die("Write of image length failed");
 
 	return 0;					    /* Everything is OK */

--------------000707090806060301020108--
