Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWFPUQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWFPUQD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 16:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWFPUQD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 16:16:03 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:14528 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751510AbWFPUQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 16:16:01 -0400
Date: Fri, 16 Jun 2006 16:16:05 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 16/16] 64bit Resource: finally enable 64bit resource sizes
Message-ID: <20060616201605.GA27462@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <11501587223213-git-send-email-greg@kroah.com> <11501587273612-git-send-email-greg@kroah.com> <11501587303683-git-send-email-greg@kroah.com> <11501587343689-git-send-email-greg@kroah.com> <Pine.LNX.4.62.0606141417430.1886@pademelon.sonytel.be> <20060614233507.GA23629@kroah.com> <20060615042806.GC8587@in.ibm.com> <Pine.LNX.4.62.0606151345420.21517@pademelon.sonytel.be> <20060615155643.GB8706@in.ibm.com> <20060616013543.GB2566@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060616013543.GB2566@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2006 at 06:35:43PM -0700, Greg KH wrote:
> On Thu, Jun 15, 2006 at 11:56:43AM -0400, Vivek Goyal wrote:
> > On Thu, Jun 15, 2006 at 01:47:43PM +0200, Geert Uytterhoeven wrote:
> > > On Thu, 15 Jun 2006, Vivek Goyal wrote:
> > > > On Wed, Jun 14, 2006 at 04:35:07PM -0700, Greg KH wrote:
> > > > > On Wed, Jun 14, 2006 at 02:20:06PM +0200, Geert Uytterhoeven wrote:
> > > > > > On Mon, 12 Jun 2006, Greg KH wrote:
> > > > > > > From: Greg Kroah-Hartman <gregkh@suse.de>
> > > > > > > 
> > > > > > > Introduce the Kconfig entry and actually switch to a 64bit value, if
> > > > > > > wanted, for resource_size_t.
> > > > > > 
> > > > > > > diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> > > > > > > index 805b81f..22dcaa5 100644
> > > > > > > --- a/arch/m68k/Kconfig
> > > > > > > +++ b/arch/m68k/Kconfig
> > > > > > > @@ -368,6 +368,13 @@ config 060_WRITETHROUGH
> > > > > > >  
> > > > > > >  source "mm/Kconfig"
> > > > > > >  
> > > > > > > +config RESOURCES_32BIT
> > > > > > > +	bool "32 bit Memory and IO resources (EXPERIMENTAL)"
> > > > > > > +	depends on EXPERIMENTAL
> > > > > > > +	help
> > > > > > > +	  By default resources are 64 bit. This option allows memory and IO
> > > > > > > +	  resources to be 32 bit to optimize code size.
> > > > > > > +
> > > > > > >  endmenu
> > > > > > 
> > > > > > Why is the default 64 bit? Because 32 bit became experimental?
> > > > > 
> > > > > That's a really good question.  Vivek, why did you change it to be this
> > > > > way?  In thinking about it some more, this should be a 64bit option
> > > > > instead.
> > > > > 
> > > > 
> > > > I thought 64bit is more inclusive. Works both for 32bit and 64bit BARs.
> > > 
> > > >From a PCI viewpoint? Not all machines have PCI.
> > > 
> > > > Also exports memory more than 4G through /proc/iomem without selecting
> > > > an additional option in config file. The flip side is that it introduces
> > > > little memory overhead. I thought most of the users should be ok with this
> > > > increased memory usage and those who are particular, they can choose
> > > > RESOURCES_32BIT.
> > > 
> > > Not all 32 bit platforms support more than 4 GiB of memory, so it's of no use
> > > to waste memory on 64 bit resources.
> > > 
> > 
> > Hmm.. That makes sense. I will rework the patch.
> 
> Thanks, just rework the last one.
> 
> And it looks like you can add just one entry to mm/Kconfig instead of
> touching every arch's Kconfig file.

Greg, Please find attached the reworked-patch. I have gotten rid of
CONFIG_RESOURCES_32BIT and instead introduced CONFIG_RESOURCES_64BIT in 
arch intenepndent file mm/Kconfig.

This patch assumes that 64bit kernels will define CONFIG_64BIT. All the
architectures seems to be adhering to this but can't find CONFIG_64BIT for 
sh64. Don't know much about this arch.



o Introuces CONFIG_RESOURCES_64BIT Kconfig option.

o This option is available only for 32bit platforms/kernels (!CONFIG_64BIT),
  as for 64bit kernels, resources have to be 64 bits and they already
  are.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.17-rc6-1M-vivek/arch/i386/Kconfig     |    1 +
 linux-2.6.17-rc6-1M-vivek/include/linux/types.h |    7 ++++++-
 linux-2.6.17-rc6-1M-vivek/mm/Kconfig            |    7 +++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff -puN mm/Kconfig~64bit-resources-modify-kconfig-options mm/Kconfig
--- linux-2.6.17-rc6-1M/mm/Kconfig~64bit-resources-modify-kconfig-options	2006-06-16 14:40:15.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/mm/Kconfig	2006-06-16 14:51:31.000000000 -0400
@@ -145,3 +145,10 @@ config MIGRATION
 	  while the virtual addresses are not changed. This is useful for
 	  example on NUMA systems to put pages nearer to the processors accessing
 	  the page.
+
+config RESOURCES_64BIT
+	bool "64 bit Memory and IO resources (EXPERIMENTAL)"
+	depends on (EXPERIMENTAL && !64BIT)
+	default n
+	help
+	  This option allows memory and IO resources to be 64 bit.
diff -puN include/linux/types.h~64bit-resources-modify-kconfig-options include/linux/types.h
--- linux-2.6.17-rc6-1M/include/linux/types.h~64bit-resources-modify-kconfig-options	2006-06-16 14:40:15.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/include/linux/types.h	2006-06-16 14:49:28.000000000 -0400
@@ -179,7 +179,12 @@ typedef __u64 __bitwise __be64;
 #ifdef __KERNEL__
 typedef unsigned __bitwise__ gfp_t;
 
-typedef unsigned long resource_size_t;
+#if defined(CONFIG_RESOURCES_64BIT) || defined(CONFIG_64BIT)
+typedef u64 resource_size_t;
+#else
+typedef u32 resource_size_t;
+#endif
+
 #endif
 
 struct ustat {
diff -puN arch/i386/Kconfig~64bit-resources-modify-kconfig-options arch/i386/Kconfig
--- linux-2.6.17-rc6-1M/arch/i386/Kconfig~64bit-resources-modify-kconfig-options	2006-06-16 14:40:15.000000000 -0400
+++ linux-2.6.17-rc6-1M-vivek/arch/i386/Kconfig	2006-06-16 14:40:15.000000000 -0400
@@ -511,6 +511,7 @@ config X86_PAE
 	bool
 	depends on HIGHMEM64G
 	default y
+	select RESOURCES_64BIT
 
 # Common NUMA Features
 config NUMA
_
