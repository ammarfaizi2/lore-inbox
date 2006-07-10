Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWGJGIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWGJGIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 02:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWGJGIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 02:08:04 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:47392 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751351AbWGJGID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 02:08:03 -0400
Date: Mon, 10 Jul 2006 08:06:03 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, davem@davemloft.net, schwidefsky@de.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] disallow modular binfmt_elf32
Message-ID: <20060710060603.GA9440@osiris.boeblingen.de.ibm.com>
References: <20060708180554.GB7034@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060708180554.GB7034@lst.de>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2006 at 08:05:54PM +0200, Christoph Hellwig wrote:
> Currently most architectures either always build binfmt_elf32 in the
> kernel image or make it a boolean option.  Only sparc64 and s390 allow
> to build it modularly.  This patch turns the option into a boolean
> aswell because elf requires various symbols that shouldn't be available
> to modules.  The most urgent one is tasklist_lock whos export this patch
> series kills, but there are others like force_sgi aswell.
> [...] 
> Index: linux-2.6/arch/s390/Kconfig
> ===================================================================
> --- linux-2.6.orig/arch/s390/Kconfig	2006-07-06 14:21:17.000000000 +0200
> +++ linux-2.6/arch/s390/Kconfig	2006-07-08 19:08:46.000000000 +0200
> @@ -119,7 +119,7 @@
>  	default y
>  
>  config BINFMT_ELF32
> -	tristate "Kernel support for 31 bit ELF binaries"
> +	bool "Kernel support for 31 bit ELF binaries"
>  	depends on COMPAT
>  	help

Martin and I discussed this already a few days ago. This config option
should go away on s390, since everybody who wants CONFIG_COMPAT also wants
CONFIG_BINFMT_ELF32. See patch below which applies on top of yours:

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[PATCH] s390: remove BINFMT_ELF32 config option

Remove BINFMT_ELF32 config option. Support should be always compiled in
if CONFIG_COMPAT is set.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/Kconfig         |    7 -------
 arch/s390/kernel/Makefile |    4 ++--
 2 files changed, 2 insertions(+), 9 deletions(-)

Index: linux-2.6/arch/s390/Kconfig
===================================================================
--- linux-2.6.orig/arch/s390/Kconfig
+++ linux-2.6/arch/s390/Kconfig
@@ -118,13 +118,6 @@ config SYSVIPC_COMPAT
 	depends on COMPAT && SYSVIPC
 	default y
 
-config BINFMT_ELF32
-	bool "Kernel support for 31 bit ELF binaries"
-	depends on COMPAT
-	help
-	  This allows you to run 32-bit Linux/ELF binaries on your zSeries
-	  in 64 bit mode. Everybody wants this; say Y.
-
 comment "Code generation options"
 
 choice
Index: linux-2.6/arch/s390/kernel/Makefile
===================================================================
--- linux-2.6.orig/arch/s390/kernel/Makefile
+++ linux-2.6/arch/s390/kernel/Makefile
@@ -17,8 +17,8 @@ obj-$(CONFIG_MODULES)		+= s390_ksyms.o m
 obj-$(CONFIG_SMP)		+= smp.o
 
 obj-$(CONFIG_COMPAT)		+= compat_linux.o compat_signal.o \
-					compat_wrapper.o compat_exec_domain.o
-obj-$(CONFIG_BINFMT_ELF32)	+= binfmt_elf32.o
+					compat_wrapper.o compat_exec_domain.o \
+					binfmt_elf32.o
 
 obj-$(CONFIG_VIRT_TIMER)	+= vtime.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
