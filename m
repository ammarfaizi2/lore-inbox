Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVCESoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVCESoG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 13:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVCEScP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 13:32:15 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16135 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263338AbVCESbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 13:31:36 -0500
Date: Sat, 5 Mar 2005 19:31:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Dike <jdike@addtoit.com>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Blaisorblade <blaisorblade@yahoo.it>,
       lkml <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: Partial fix! - Was: Re: [BUG report] UML linux-2.6 latest BK doesn't compile
Message-ID: <20050305183134.GH6373@stusta.de>
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk> <200502081829.j18ITAs0003968@ccure.user-mode-linux.org> <200502081837.22519.blaisorblade@yahoo.it> <200502082223.j18MMxs0013724@ccure.user-mode-linux.org> <1108380903.22656.9.camel@imp.csi.cam.ac.uk> <200503051945.j25JjIB5003539@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503051945.j25JjIB5003539@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2005 at 02:45:18PM -0500, Jeff Dike wrote:
> aia21@cam.ac.uk said:
> > Yes.  I finally found a way to get it to compile.  Compiling without
> > TT mode and WITHOUT static build it still fails with the same problem
> > (__bb_init_func problem I already reported).  But compiling without TT
> > but WITH static build the __bb_init_func problem goes away but instead
> > I get a __gcov_init missing symbol in my modules.
> >
> > Note I have gcc-3.3.4-11 (SuSE 9.2) and it defines __gcov_init.  So I
> > added this as an export symbol and lo and behold the kernel and
> > modules compiled and I am now up an running with UML and NTFS as a
> > module.  (-: 
> 
> Can you try this patch?  It exports either __gcov_init or __bb_init_func
> depending on your gcc version.
> 
> 			Jeff
> 
> Index: linux-2.6.10/arch/um/kernel/gmon_syms.c
> ===================================================================
> --- linux-2.6.10.orig/arch/um/kernel/gmon_syms.c	2005-02-28 17:22:29.000000000 -0500
> +++ linux-2.6.10/arch/um/kernel/gmon_syms.c	2005-03-02 12:19:14.000000000 -0500
> @@ -5,8 +5,14 @@
>  
>  #include "linux/module.h"
>  
> +#if __GNUC__ > 3 || (__GNUC__ == 3 && __GNUC_MINOR__ > 3) || \
> +	(__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ > 4)

This line has to be something like

( (__GNUC__ == 3 && __GNUC_MINOR__ == 3 && __GNUC_PATCHLEVEL__ >= 4) && \
   HEAVILY_PATCHES_SUSE_GCC ) 


I hope SuSE has added some #define to distinguish what they call 
"gcc 3.3.4" from GNU gcc 3.3.4 ...


> +extern void __gcov_init(void *);
> +EXPORT_SYMBOL(__gcov_init);
> +#else
>  extern void __bb_init_func(void *);
>  EXPORT_SYMBOL(__bb_init_func);
> +#endif
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

