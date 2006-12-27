Return-Path: <linux-kernel-owner+w=401wt.eu-S932724AbWL0Lur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbWL0Lur (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 06:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbWL0Luq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 06:50:46 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:36173 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932724AbWL0Lup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 06:50:45 -0500
Date: Wed, 27 Dec 2006 17:20:13 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Magnus Damm <magnus@valinux.co.jp>
Subject: [PATCH 1/4] i386: Restore CONFIG_PHYSICAL_START option
Message-ID: <20061227115013.GA22606@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o Relocatable bzImage support had got rid of CONFIG_PHYSICAL_START option
  thinking that now this option is not required as people can build a
  second kernel as relocatable and load it anywhere. So need of compiling
  the kernel for a custom address was gone. But Magnus uses vmlinux images
  for second kernel in Xen environment and he wants to continue to use
  it.

o Restoring the CONFIG_PHYSICAL_START option for the time being. I think
  down the line we can get rid of it. 

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/Kconfig       |   41 +++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/boot.h |    3 ++-
 2 files changed, 43 insertions(+), 1 deletion(-)

diff -puN arch/i386/Kconfig~i386-restore-CONFIG_PHYSICAL_START-option arch/i386/Kconfig
--- linux-2.6.20-rc2-reloc/arch/i386/Kconfig~i386-restore-CONFIG_PHYSICAL_START-option	2006-12-27 16:22:30.000000000 +0530
+++ linux-2.6.20-rc2-reloc-root/arch/i386/Kconfig	2006-12-27 16:48:30.000000000 +0530
@@ -777,6 +777,47 @@ config CRASH_DUMP
           PHYSICAL_START.
 	  For more details see Documentation/kdump/kdump.txt
 
+config PHYSICAL_START
+	hex "Physical address where the kernel is loaded" if (EMBEDDED || CRASH_DUMP)
+	default "0x100000"
+	help
+	  This gives the physical address where the kernel is loaded.
+
+	  If kernel is a not relocatable (CONFIG_RELOCATABLE=n) then
+	  bzImage will decompress itself to above physical address and
+	  run from there. Otherwise, bzImage will run from the address where
+	  it has been loaded by the boot loader and will ignore above physical
+	  address.
+
+	  In normal kdump cases one does not have to set/change this option
+	  as now bzImage can be compiled as a completely relocatable image
+	  (CONFIG_RELOCATABLE=y) and be used to load and run from a different
+	  address. This option is mainly useful for the folks who don't want
+	  to use a bzImage for capturing the crash dump and want to use a
+	  vmlinux instead. vmlinux is not relocatable hence a kernel needs
+	  to be specifically compiled to run from a specific memory area
+	  (normally a reserved region) and this option comes handy.
+
+	  So if you are using bzImage for capturing the crash dump, leave
+	  the value here unchanged to 0x100000 and set CONFIG_RELOCATABLE=y.
+	  Otherwise if you plan to use vmlinux for capturing the crash dump
+	  change this value to start of the reserved region (Typically 16MB
+	  0x1000000). In other words, it can be set based on the "X" value as
+	  specified in the "crashkernel=YM@XM" command line boot parameter
+	  passed to the panic-ed kernel. Typically this parameter is set as
+	  crashkernel=64M@16M. Please take a look at
+	  Documentation/kdump/kdump.txt for more details about crash dumps.
+
+	  Usage of bzImage for capturing the crash dump is recommended as
+	  one does not have to build two kernels. Same kernel can be used
+	  as production kernel and capture kernel. Above option should have
+	  gone away after relocatable bzImage support is introduced. But it
+	  is present because there are users out there who continue to use
+	  vmlinux for dump capture. This option should go away down the
+	  line.
+
+	  Don't change this unless you know what you are doing.
+
 config RELOCATABLE
 	bool "Build a relocatable kernel(EXPERIMENTAL)"
 	depends on EXPERIMENTAL
diff -puN include/asm-i386/boot.h~i386-restore-CONFIG_PHYSICAL_START-option include/asm-i386/boot.h
--- linux-2.6.20-rc2-reloc/include/asm-i386/boot.h~i386-restore-CONFIG_PHYSICAL_START-option	2006-12-27 16:22:30.000000000 +0530
+++ linux-2.6.20-rc2-reloc-root/include/asm-i386/boot.h	2006-12-27 16:22:30.000000000 +0530
@@ -13,7 +13,8 @@
 #define ASK_VGA		0xfffd		/* ask for it at bootup */
 
 /* Physical address where kenrel should be loaded. */
-#define LOAD_PHYSICAL_ADDR ((0x100000 + CONFIG_PHYSICAL_ALIGN - 1) \
+#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
+				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
 				& ~(CONFIG_PHYSICAL_ALIGN - 1))
 
 #endif /* _LINUX_BOOT_H */
_
