Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269752AbUICT30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269752AbUICT30 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269755AbUICT2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:28:14 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:33093 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S269758AbUICT0R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:26:17 -0400
Date: Fri, 3 Sep 2004 21:28:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Mart?n Chikilian <slack@efn.uncor.edu>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: Weird problem when compiling kernel
Message-ID: <20040903192853.GA15783@mars.ravnborg.org>
Mail-Followup-To: Mart?n Chikilian <slack@efn.uncor.edu>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <4135C57C.9080604@efn.uncor.edu> <20040902201945.GB15298@mars.ravnborg.org> <4138727D.8040602@efn.uncor.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4138727D.8040602@efn.uncor.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 10:32:45AM -0300, Mart?n Chikilian wrote:
 > 
> >
> rm -rf .tmp_versions
> mkdir -p .tmp_versions
> make -f scripts/Makefile.build obj=scripts/basic
> make -f scripts/Makefile.build obj=scripts
> make -f scripts/Makefile.build obj=arch/i386/kernel 
> arch/i386/kernel/asm-offsets.s
> make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
> make -f scripts/Makefile.build obj=init
> make -f scripts/Makefile.build obj=usr
>  gcc -Wp,-MD,usr/.gen_init_cpio.d -Wall -Wstrict-prototypes -O2 
> -fomit-frame-pointer        -o usr/gen_init_cpio usr/gen_init_cpio.c
>  ./usr/gen_init_cpio > usr/initramfs_data.cpio

Here I expected gzip to be called???

>  gcc -Wp,-MD,usr/.initramfs_data.o.d -nostdinc -iwithprefix include 
> -D__KERNEL__ -Iinclude  -D__ASSEMBLY__ 
> -Iinclude/asm-i386/mach-default    -c -o usr/initramfs_data.o 
> usr/initramfs_data.S
>   ld -m elf_i386  -r -o usr/built-in.o

And this looks pretty veird to me also. I should have one inputfile listed.

> ld: no input files
> scripts/Makefile.build:229: *** [usr/built-in.o] Error 1
> Makefile:600: *** [usr] Error 2
> 

Plase apply following patch and post output of:
rm usr/*o
make V=1

Apply patch using: 

$ patch -p1 < my_patch

when current directory is root of kernel tree.

	Sam

===== usr/Makefile 1.10 vs edited =====
--- 1.10/usr/Makefile	2004-08-10 21:42:40 +02:00
+++ edited/usr/Makefile	2004-09-03 21:22:16 +02:00
@@ -18,15 +18,20 @@
 # Commented out for now
 # initramfs-y := $(obj)/root/hello
 
+$(warning obj-y=$(obj-y))
+$(warning obj=$(obj))
+
 quiet_cmd_cpio = CPIO    $@
       cmd_cpio = ./$< > $@
 
 $(obj)/initramfs_data.cpio: $(obj)/gen_init_cpio $(initramfs-y) FORCE
+	@echo cpio: $@ - $^ - $?
 	$(call if_changed,cpio)
 
 targets += initramfs_data.cpio
 
 $(obj)/initramfs_data.cpio.gz: $(obj)/initramfs_data.cpio FORCE
+	@echo gzip: $@ - $^ - $?
 	$(call if_changed,gzip)
 
 targets += initramfs_data.cpio.gz
