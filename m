Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161577AbWHDW4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161577AbWHDW4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 18:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161576AbWHDW4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 18:56:47 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:6805 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161574AbWHDW4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 18:56:46 -0400
Date: Fri, 4 Aug 2006 18:56:11 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org,
       Horms <horms@verge.net.au>, Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Linda Wang <lwang@redhat.com>
Subject: Re: [RFC] ELF Relocatable x86 and x86_64 bzImages
Message-ID: <20060804225611.GG19244@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 04:58:49AM -0600, Eric W. Biederman wrote:
> 
> The problem:
> 
> We can't always run the kernel at 1MB or 2MB, and so people who need
> different addresses must build multiple kernels.  The bzImage format
> can't even represent loading a kernel at other than it's default address.
> With kexec on panic now starting to be used by distros having a kernel
> not running at the default load address is starting to become common.
> 
Hi Eric,

There seems to be a small anomaly in the current set of patches for i386.

For example if one compiles the kernel with CONFIG_RELOCATABLE=y
and CONFIG_PHYSICAL_START=0x400000 (4MB) and he uses grub to load
the kernel then kernel would run from 1MB location. I think user would
expect it to run from 4MB location.

I think distro's might want to keep above config options enabled. 
CONFIG_RELOCATABLE=y so that kexec can load kdump kernel at a 
different address and CONFIG_PHYSICAL_START=non 1MB location, to
extract better performance. (As we had discussions on mailing list
some time back.)

In principle this is a limitation on boot-loaders part but as we can
not fix the boot-loaders out there, probably we can try fixing it
at kernel level.

What I have done here is that decompressor code will determine the
final resting place of the kernel based on boot loader type. So 
if I have been loaded by kexec, I am supposed to run from loaded address
otherwise I am supposed to run from CONFIG_PHYSICAL_START as I have been
loaded at 1MB address due to boot loader limitation and that's not the
intention.

A prototype patch is attached with the mail. I have assumed that I can
assign a boot loader type id 9 to kexec (Documentation/i386/boot.txt).
Also assuming that all other boot loaders apart from kexec have got 1MB
limitation. If not, its trivial to include their boot loader ids also.

I have tested this patch and it works fine. What do you think about
this approach ?

Thanks
Vivek




Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/i386/boot/compressed/head.S |   32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff -puN arch/i386/boot/compressed/head.S~debug1-patch arch/i386/boot/compressed/head.S
--- linux-2.6.18-rc3-1M/arch/i386/boot/compressed/head.S~debug1-patch	2006-08-04 18:03:02.000000000 -0400
+++ linux-2.6.18-rc3-1M-root/arch/i386/boot/compressed/head.S	2006-08-04 18:18:26.000000000 -0400
@@ -60,13 +60,32 @@ startup_32:
 	 * a relocatable kernel this is the delta to our load address otherwise
 	 * this is the delta to CONFIG_PHYSICAL start.
 	 */
+
 #ifdef CONFIG_RELOCTABLE
+	/* If loaded by non kexec boot loader, then we will be loaded
+	 * at 1MB fixed address. But probably the intention is to run
+	 * from a address for which kernel has been compiled which can
+	 * be non 1MB.
+	 */
+	xorl %eax, %eax
+	movb 0x210(%esi), %al
+
+	/ * check boot loader type. Kexec bootloader id 9, version any */
+	shrl $4, %eax
+	subl $0x9, %eax
+	jnz  1f
+
+	/* Run kernel from the location it has been loaded at. */
 	movl %ebp, %ebx
+	jmp  2f
+
+	/* Run the kernel from compiled destination location. */
+1:	movl $(CONFIG_PHYSICAL_START - startup32), %ebx
 #else
 	movl $(CONFIG_PHYSICAL_START - startup_32), %ebx
 #endif
 
-	/* Replace the compressed data size with the uncompressed size */
+2:	/* Replace the compressed data size with the uncompressed size */
 	subl input_len(%ebp), %ebx
 	movl output_len(%ebp), %eax
 	addl %eax, %ebx
@@ -95,7 +114,16 @@ startup_32:
 /* Compute the kernel start address.
  */
 #ifdef CONFIG_RELOCATABLE
+	xorl %eax, %eax
+	movb 0x210(%esi), %al
+	/ * check boot loader type. Kexec bootloader id 9, version any */
+	shrl $4, %eax
+	subl $0x9, %eax
+	jnz  3f
 	leal	startup_32(%ebp), %ebp
+	jmp 4f
+3:
+	movl	$CONFIG_PHYSICAL_START, %ebp
 #else
 	movl	$CONFIG_PHYSICAL_START, %ebp
 #endif
@@ -103,7 +131,7 @@ startup_32:
 /*
  * Jump to the relocated address.
  */
-	leal relocated(%ebx), %eax
+4:	leal relocated(%ebx), %eax
 	jmp *%eax
 .section ".text"
 relocated:
_
