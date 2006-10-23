Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWJWTsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWJWTsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 15:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWJWTs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 15:48:28 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:24736 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965000AbWJWTr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 15:47:57 -0400
Date: Mon, 23 Oct 2006 15:44:03 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: [PATCH 11/11] i386: Extend bzImage protocol for relocatable protected mode kernel
Message-ID: <20061023194403.GL13263@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061023192456.GA13263@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061023192456.GA13263@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Extend bzImage protocol to enable bootloaders to load a completely
  relocatable bzImage. Now protected mode component of kernel is also 
  relocatable and a boot-loader can load the protected mode component
  at a differnt physical address than 1MB. (If kernel was built with
  CONFIG_RELOCATABLE)

o Kexec can make use of it to load this kernel at a different physical
  address to capture kernel crash dumps. 

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 Documentation/i386/boot.txt |    4 ++++
 arch/i386/boot/setup.S      |   13 ++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff -puN arch/i386/boot/setup.S~extend-bzImage-protocol-for-relocatable-protected-mode-kernel arch/i386/boot/setup.S
--- linux-2.6.19-rc2-git7-reloc/arch/i386/boot/setup.S~extend-bzImage-protocol-for-relocatable-protected-mode-kernel	2006-10-23 15:09:28.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/arch/i386/boot/setup.S	2006-10-23 15:09:28.000000000 -0400
@@ -81,7 +81,7 @@ start:
 # This is the setup header, and it must start at %cs:2 (old 0x9020:2)
 
 		.ascii	"HdrS"		# header signature
-		.word	0x0204		# header version number (>= 0x0105)
+		.word	0x0205		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
 start_sys_seg:	.word	SYSSEG
@@ -160,6 +160,17 @@ ramdisk_max:	.long (-__PAGE_OFFSET-(512 
 					# The highest safe address for
 					# the contents of an initrd
 
+kernel_alignment:  .long CONFIG_PHYSICAL_ALIGN 	#physical addr alignment
+						#required for protected mode
+						#kernel
+#ifdef CONFIG_RELOCATABLE
+relocatable_kernel:    .byte 1
+#else
+relocatable_kernel:    .byte 0
+#endif
+pad2:			.byte 0
+pad3:			.word 0
+
 trampoline:	call	start_of_setup
 		.align 16
 					# The offset at this point is 0x240
diff -puN Documentation/i386/boot.txt~extend-bzImage-protocol-for-relocatable-protected-mode-kernel Documentation/i386/boot.txt
--- linux-2.6.19-rc2-git7-reloc/Documentation/i386/boot.txt~extend-bzImage-protocol-for-relocatable-protected-mode-kernel	2006-10-23 15:09:28.000000000 -0400
+++ linux-2.6.19-rc2-git7-reloc-root/Documentation/i386/boot.txt	2006-10-23 15:09:28.000000000 -0400
@@ -35,6 +35,8 @@ Protocol 2.03:	(Kernel 2.4.18-pre1) Expl
 		initrd address available to the bootloader.
 
 Protocol 2.04:	(Kernel 2.6.14) Extend the syssize field to four bytes.
+Protocol 2.05:	(Kernel 2.6.20) Make protected mode kernel relocatable.
+		Introduce relocatable_kernel and kernel_alignment fields.
 
 
 **** MEMORY LAYOUT
@@ -129,6 +131,8 @@ Offset	Proto	Name		Meaning
 0226/2	N/A	pad1		Unused
 0228/4	2.02+	cmd_line_ptr	32-bit pointer to the kernel command line
 022C/4	2.03+	initrd_addr_max	Highest legal initrd address
+0230/4	2.04+	kernel_alignment Physical addr alignment required for kernel
+0234/1	2.04+	relocatable_kernel Whether kernel is relocatable or not
 
 (1) For backwards compatibility, if the setup_sects field contains 0, the
     real value is 4.
_
