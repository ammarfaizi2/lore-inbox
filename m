Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWFSN5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWFSN5u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 09:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWFSN5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 09:57:50 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35717 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932352AbWFSN5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 09:57:49 -0400
Date: Mon, 19 Jun 2006 09:57:31 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 16/16] 64bit Resource: finally enable 64bit resource sizes
Message-ID: <20060619135730.GA8172@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060614233507.GA23629@kroah.com> <20060615042806.GC8587@in.ibm.com> <Pine.LNX.4.62.0606151345420.21517@pademelon.sonytel.be> <20060615155643.GB8706@in.ibm.com> <20060616013543.GB2566@kroah.com> <20060616201605.GA27462@in.ibm.com> <Pine.LNX.4.62.0606171633190.24519@pademelon.sonytel.be> <20060618180547.GA14049@in.ibm.com> <Pine.LNX.4.62.0606191003230.6499@pademelon.sonytel.be> <Pine.LNX.4.64.0606191214320.12900@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606191214320.12900@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 12:17:12PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Mon, 19 Jun 2006, Geert Uytterhoeven wrote:
> 
> > > --- linux-2.6.17-rc6-1M/mm/Kconfig~64bit-resources-modify-kconfig-options	2006-06-18 13:35:13.000000000 -0400
> > > +++ linux-2.6.17-rc6-1M-vivek/mm/Kconfig	2006-06-18 13:35:13.000000000 -0400
> > > @@ -145,3 +145,12 @@ config MIGRATION
> > >  	  while the virtual addresses are not changed. This is useful for
> > >  	  example on NUMA systems to put pages nearer to the processors accessing
> > >  	  the page.
> > > +
> > > +config RESOURCES_64BIT
> > > +	bool "64 bit Memory and IO resources (EXPERIMENTAL)"
> > > +	depends on (EXPERIMENTAL && !64BIT) || 64BIT
> > > +	default y if 64BIT
> > 
> > it defaults to y if 64BIT. Roman?
> 
> This should do it:
> 
> config RESOURCES_64BIT
> 	bool "64 bit Memory and IO resources (EXPERIMENTAL)" if !64BIT && EXPERIMENTAL
> 	default 64BIT
>

Wow. That works. Thanks. I am attaching the patch. Hope this one is final :-)

Greg, can you please pick the patch.

Thanks
Vivek



o Introuces CONFIG_RESOURCES_64BIT Kconfig option.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 linux-2.6.17-rc6-1M-vivek/arch/i386/Kconfig     |    1 +
 linux-2.6.17-rc6-1M-vivek/include/linux/types.h |    7 ++++++-
 linux-2.6.17-rc6-1M-vivek/mm/Kconfig            |    6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

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
+++ linux-2.6.17-rc6-1M-vivek/mm/Kconfig	2006-06-19 09:48:41.000000000 -0400
@@ -145,3 +145,9 @@ config MIGRATION
 	  while the virtual addresses are not changed. This is useful for
 	  example on NUMA systems to put pages nearer to the processors accessing
 	  the page.
+
+config RESOURCES_64BIT
+	bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && EXPERIMENTAL)
+	default 64BIT
+	help
+	  This option allows memory and IO resources to be 64 bit.
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
_
