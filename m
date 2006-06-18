Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWFSAfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWFSAfi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 20:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbWFSAfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 20:35:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:9959 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750779AbWFSAfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 20:35:37 -0400
Date: Sun, 18 Jun 2006 14:05:47 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 16/16] 64bit Resource: finally enable 64bit resource sizes
Message-ID: <20060618180547.GA14049@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <11501587303683-git-send-email-greg@kroah.com> <11501587343689-git-send-email-greg@kroah.com> <Pine.LNX.4.62.0606141417430.1886@pademelon.sonytel.be> <20060614233507.GA23629@kroah.com> <20060615042806.GC8587@in.ibm.com> <Pine.LNX.4.62.0606151345420.21517@pademelon.sonytel.be> <20060615155643.GB8706@in.ibm.com> <20060616013543.GB2566@kroah.com> <20060616201605.GA27462@in.ibm.com> <Pine.LNX.4.62.0606171633190.24519@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0606171633190.24519@pademelon.sonytel.be>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 04:34:41PM +0200, Geert Uytterhoeven wrote:
> > diff -puN mm/Kconfig~64bit-resources-modify-kconfig-options mm/Kconfig
> > --- linux-2.6.17-rc6-1M/mm/Kconfig~64bit-resources-modify-kconfig-options	2006-06-16 14:40:15.000000000 -0400
> > +++ linux-2.6.17-rc6-1M-vivek/mm/Kconfig	2006-06-16 14:51:31.000000000 -0400
> > @@ -145,3 +145,10 @@ config MIGRATION
> >  	  while the virtual addresses are not changed. This is useful for
> >  	  example on NUMA systems to put pages nearer to the processors accessing
> >  	  the page.
> > +
> > +config RESOURCES_64BIT
> > +	bool "64 bit Memory and IO resources (EXPERIMENTAL)"
> > +	depends on (EXPERIMENTAL && !64BIT)
> > +	default n
> > +	help
> > +	  This option allows memory and IO resources to be 64 bit.
> > diff -puN include/linux/types.h~64bit-resources-modify-kconfig-options include/linux/types.h
> > --- linux-2.6.17-rc6-1M/include/linux/types.h~64bit-resources-modify-kconfig-options	2006-06-16 14:40:15.000000000 -0400
> > +++ linux-2.6.17-rc6-1M-vivek/include/linux/types.h	2006-06-16 14:49:28.000000000 -0400
> > @@ -179,7 +179,12 @@ typedef __u64 __bitwise __be64;
> >  #ifdef __KERNEL__
> >  typedef unsigned __bitwise__ gfp_t;
> >  
> > -typedef unsigned long resource_size_t;
> > +#if defined(CONFIG_RESOURCES_64BIT) || defined(CONFIG_64BIT)
> 
> If you'd set CONFIG_RESOURCES_64BIT in Kconfig if CONFIG_64BIT, you don't need
> the `|| defined(CONFIG_64BIT)'.
> 
> IMHO it looks a bit confusing that resources are 64 bit on 64 bit platforms,
> while CONFIG_RESOURCES_64BIT is not set.
> 

Ok. Here is another take. I have used "select" in arch dependent files to
select CONFIG_RESOURCES_64BIT forcibly if 64BIT is set. Please suggest if
there is an arch independent way to do that.

There is a small issue though. On 64bit kernels RESOURCES_64BIT should not
be exprimental as rosources are already 64bit. "select" will make sure
that RESOURCES_64BIT is set but following line will be visible to user on 
64bit platforms and user might be confused about "EXPERIMENTAL" keyword.

"64 bit Memory and IO resources (EXPERIMENTAL)"

At the same time this key word is required on 32bit platforms so that user
knows that this is something new and experimental.

Please suggest if there is a way to handle this situation. Ideally I would
like to set RESOURCES_64BIT on 64bit platforms without prompting anything
to user.



o Introuces CONFIG_RESOURCES_64BIT Kconfig option.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.17-rc6-1M-vivek/arch/alpha/Kconfig    |    1 +
 linux-2.6.17-rc6-1M-vivek/arch/i386/Kconfig     |    1 +
 linux-2.6.17-rc6-1M-vivek/arch/ia64/Kconfig     |    1 +
 linux-2.6.17-rc6-1M-vivek/arch/mips/Kconfig     |    1 +
 linux-2.6.17-rc6-1M-vivek/arch/parisc/Kconfig   |    1 +
 linux-2.6.17-rc6-1M-vivek/arch/powerpc/Kconfig  |    1 +
 linux-2.6.17-rc6-1M-vivek/arch/s390/Kconfig     |    1 +
 linux-2.6.17-rc6-1M-vivek/arch/sparc64/Kconfig  |    1 +
 linux-2.6.17-rc6-1M-vivek/arch/x86_64/Kconfig   |    1 +
 linux-2.6.17-rc6-1M-vivek/include/linux/types.h |    7 ++++++-
 linux-2.6.17-rc6-1M-vivek/mm/Kconfig            |    9 +++++++++
 11 files changed, 24 insertions(+), 1 deletion(-)

diff -puN include/linux/types.h~64bit-resources-modify-kconfig-options include/linux/types.h
--- linux-2.6.17-rc6-1M/include/linux/types.h~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/include/linux/types.h	2006-06-18 13:35:13.000000000 -0400
@@ -179,7 +179,12 @@ typedef __u64 __bitwise __be64;
 #ifdef __KERNEL__
 typedef unsigned __bitwise__ gfp_t;
 
-typedef unsigned long resource_size_t;
+#ifdef CONFIG_RESOURCES_64BIT
+typedef u64 resource_size_t;
+#else
+typedef u32 resource_size_t;
+#endif
+
 #endif
 
 struct ustat {
diff -puN mm/Kconfig~64bit-resources-modify-kconfig-options mm/Kconfig
--- linux-2.6.17-rc6-1M/mm/Kconfig~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/mm/Kconfig	2006-06-18 13:35:13.000000000 -0400
@@ -145,3 +145,12 @@ config MIGRATION
 	  while the virtual addresses are not changed. This is useful for
 	  example on NUMA systems to put pages nearer to the processors accessing
 	  the page.
+
+config RESOURCES_64BIT
+	bool "64 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on (EXPERIMENTAL && !64BIT) || 64BIT
+	default y if 64BIT
+	help
+	  This option allows memory and IO resources to be 64 bit.
+
+
diff -puN arch/alpha/Kconfig~64bit-resources-modify-kconfig-options arch/alpha/Kconfig
--- linux-2.6.17-rc6-1M/arch/alpha/Kconfig~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/arch/alpha/Kconfig	2006-06-18 13:35:13.000000000 -0400
@@ -13,6 +13,7 @@ config ALPHA
 
 config 64BIT
 	def_bool y
+	select RESOURCES_64BIT
 
 config MMU
 	bool
diff -puN arch/i386/Kconfig~64bit-resources-modify-kconfig-options arch/i386/Kconfig
--- linux-2.6.17-rc6-1M/arch/i386/Kconfig~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/arch/i386/Kconfig	2006-06-18 13:35:13.000000000 -0400
@@ -511,6 +511,7 @@ config X86_PAE
 	bool
 	depends on HIGHMEM64G
 	default y
+	select RESOURCES_64BIT
 
 # Common NUMA Features
 config NUMA
diff -puN arch/ia64/Kconfig~64bit-resources-modify-kconfig-options arch/ia64/Kconfig
--- linux-2.6.17-rc6-1M/arch/ia64/Kconfig~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/arch/ia64/Kconfig	2006-06-18 13:35:13.000000000 -0400
@@ -21,6 +21,7 @@ config IA64
 config 64BIT
 	bool
 	default y
+	select RESOURCES_64BIT
 
 config MMU
 	bool
diff -puN arch/mips/Kconfig~64bit-resources-modify-kconfig-options arch/mips/Kconfig
--- linux-2.6.17-rc6-1M/arch/mips/Kconfig~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/arch/mips/Kconfig	2006-06-18 13:35:13.000000000 -0400
@@ -1382,6 +1382,7 @@ config 32BIT
 config 64BIT
 	bool "64-bit kernel"
 	depends on CPU_SUPPORTS_64BIT_KERNEL && SYS_SUPPORTS_64BIT_KERNEL
+	select RESOURCES_64BIT
 	help
 	  Select this option if you want to build a 64-bit kernel.
 
diff -puN arch/parisc/Kconfig~64bit-resources-modify-kconfig-options arch/parisc/Kconfig
--- linux-2.6.17-rc6-1M/arch/parisc/Kconfig~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/arch/parisc/Kconfig	2006-06-18 13:35:13.000000000 -0400
@@ -128,6 +128,7 @@ config PREFETCH
 config 64BIT
 	bool "64-bit kernel"
 	depends on PA8X00
+	select RESOURCES_64BIT
 	help
 	  Enable this if you want to support 64bit kernel on PA-RISC platform.
 
diff -puN arch/powerpc/Kconfig~64bit-resources-modify-kconfig-options arch/powerpc/Kconfig
--- linux-2.6.17-rc6-1M/arch/powerpc/Kconfig~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/arch/powerpc/Kconfig	2006-06-18 13:35:13.000000000 -0400
@@ -18,6 +18,7 @@ config PPC32
 config 64BIT
 	bool
 	default y if PPC64
+	select RESOURCES_64BIT
 
 config PPC_MERGE
 	def_bool y
diff -puN arch/s390/Kconfig~64bit-resources-modify-kconfig-options arch/s390/Kconfig
--- linux-2.6.17-rc6-1M/arch/s390/Kconfig~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/arch/s390/Kconfig	2006-06-18 13:35:13.000000000 -0400
@@ -39,6 +39,7 @@ comment "Processor type and features"
 
 config 64BIT
 	bool "64 bit kernel"
+	select RESOURCES_64BIT
 	help
 	  Select this option if you have a 64 bit IBM zSeries machine
 	  and want to use the 64 bit addressing mode.
diff -puN arch/sparc64/Kconfig~64bit-resources-modify-kconfig-options arch/sparc64/Kconfig
--- linux-2.6.17-rc6-1M/arch/sparc64/Kconfig~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/arch/sparc64/Kconfig	2006-06-18 13:35:13.000000000 -0400
@@ -21,6 +21,7 @@ config SPARC64
 
 config 64BIT
 	def_bool y
+	select RESOURCES_64BIT
 
 config MMU
 	bool
diff -puN arch/x86_64/Kconfig~64bit-resources-modify-kconfig-options arch/x86_64/Kconfig
--- linux-2.6.17-rc6-1M/arch/x86_64/Kconfig~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/arch/x86_64/Kconfig	2006-06-18 13:35:13.000000000 -0400
@@ -19,6 +19,7 @@ config X86_64
 
 config 64BIT
 	def_bool y
+	select RESOURCES_64BIT
 
 config X86
 	bool
_
