Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVCODGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVCODGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 22:06:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262212AbVCODGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 22:06:41 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:15276 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261500AbVCODGc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 22:06:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=rDGJ61iD5nmfnjt3oCWtgrDOhrgZc9mbiuvYmWUCrM8VRTyt6YlmuTTTu9RyACznNR6yiCgGYstwvfzfBL/JYT90NHRMMfKYEmLb4yALvHkCIVI+il5IBP9oHqsxYy6pNs2fwdh82/GMXFJf53iwbaCkB/8HQjmmkTkr8hBSRrs=
Message-ID: <90f56e4805031411593fd945f2@mail.gmail.com>
Date: Mon, 14 Mar 2005 11:59:26 -0800
From: Ajay Patel <patela@gmail.com>
Reply-To: Ajay Patel <patela@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [KBUILD] Bug in make deb-pkg when using seperate source and object directories
In-Reply-To: <20050313060940.GB7828@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050313060940.GB7828@mythryan2.michonline.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

I had a similar problem building binrpm-pkg.
Try following patch. It worked for me.

Thanks
Ajay

Index: Makefile
===================================================================
RCS file: ./scripts/package/Makefile,v
retrieving revision 1.2
diff -d -c -5 -p -r1.2 Makefile
*** Makefile    25 Feb 2005 22:35:22 -0000      1.2
--- Makefile    14 Mar 2005 19:56:06 -0000
*************** clean-files := $(objtree)/kernel.spec
*** 57,67 ****
  .PHONY: binrpm-pkg
  $(objtree)/binkernel.spec: $(MKSPEC) $(srctree)/Makefile
        $(CONFIG_SHELL) $(MKSPEC) prebuilt > $@

  binrpm-pkg: $(objtree)/binkernel.spec
!       $(MAKE)
        set -e; \
        $(CONFIG_SHELL) $(srctree)/scripts/mkversion > $(objtree)/.tmp_version
        set -e; \
        mv -f $(objtree)/.tmp_version $(objtree)/.version
        -@[ -d $(objtree)/../../pkgdir ] || mkdir -p $(objtree)/../../pkgdir
--- 57,67 ----
  .PHONY: binrpm-pkg
  $(objtree)/binkernel.spec: $(MKSPEC) $(srctree)/Makefile
        $(CONFIG_SHELL) $(MKSPEC) prebuilt > $@

  binrpm-pkg: $(objtree)/binkernel.spec
!       $(MAKE) KBUILD_SRC=
        set -e; \
        $(CONFIG_SHELL) $(srctree)/scripts/mkversion > $(objtree)/.tmp_version
        set -e; \
        mv -f $(objtree)/.tmp_version $(objtree)/.version
        -@[ -d $(objtree)/../../pkgdir ] || mkdir -p $(objtree)/../../pkgdir
*************** clean-files += $(objtree)/binkernel.spec
*** 74,84 ****
  # Deb target
  # ---------------------------------------------------------------------------
  #
  .PHONY: deb-pkg
  deb-pkg:
!       $(MAKE)
        $(CONFIG_SHELL) $(srctree)/scripts/package/builddeb

  clean-dirs += $(objtree)/debian/


--- 74,84 ----
  # Deb target
  # ---------------------------------------------------------------------------
  #
  .PHONY: deb-pkg
  deb-pkg:
!       $(MAKE) KBUILD_SRC=
        $(CONFIG_SHELL) $(srctree)/scripts/package/builddeb

  clean-dirs += $(objtree)/debian/
  $(MAKE)

========================================================

On Sun, 13 Mar 2005 01:09:41 -0500, Ryan Anderson <ryan@michonline.com> wrote:
> Sam,
> 
> When running "make O=something deb-pkg", I get a failure that claims I
> haven't configured my kernel (I have).  Running it a second time tells
> me to run "make mrproper"  (include/linux/version.h got built on the
> first run)
> 
> I did some preliminary poking around, but kbuild is still, well, mostly
> magic to me - I can't see where the object directory is getting lost.
> 
> Think you can take a look?  (Note, this failure shouldn't require
> anything Debian specific on your system to trigger - it's failing, as
> far as I can tell, on the $(MAKE) right before the call build the
> builddeb script, so it should be easy to reproduce)
> 
> The log of when I run it follows:
> 
> ryan@mythryan2 ~/dev/linux/local-quilt$ blocal deb-pkg
> make
> make -C /home/ryan/dev/linux/local-quilt
> O=/home/ryan/dev/linux/output/local
> Makefile:487: .config: No such file or directory
>   Using /home/ryan/dev/linux/local-quilt as source for kernel
>   CHK     include/linux/version.h
>   UPD     include/linux/version.h
>   SYMLINK include/asm -> include/asm-i386
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/basic/split-include
>   HOSTCC  scripts/basic/docproc
>   SHIPPED scripts/kconfig/zconf.tab.h
>   SHIPPED scripts/kconfig/zconf.tab.c
>   SHIPPED scripts/kconfig/lex.zconf.c
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/mconf.o
>   HOSTCC  scripts/kconfig/zconf.tab.o
>   HOSTLD  scripts/kconfig/conf
> scripts/kconfig/conf -s arch/i386/Kconfig
> ***
> *** You have not yet configured your kernel!
> ***
> *** Please run some configurator (e.g. "make oldconfig" or
> *** "make menuconfig" or "make xconfig").
> ***
> make[6]: *** [silentoldconfig] Error 1
> make[5]: *** [silentoldconfig] Error 2
> make[4]: *** [include/linux/autoconf.h] Error 2
> make[3]: *** [all] Error 2
> make[2]: *** [deb-pkg] Error 2
> make[1]: *** [deb-pkg] Error 2
> make: *** [deb-pkg] Error 2
> 
> "blocal" is a simple wrapper to cut down on retyping things, it's just
> this:
> 
> ryan@mythryan2 ~/dev/linux/local-quilt$ cat /home/ryan/bin/blocal
> #!/bin/bash -e
> 
> PWD=`pwd`
> 
> if [ "$PWD" != "/home/ryan/dev/linux/local-quilt" ]; then
>         cd /home/ryan/dev/linux/local-quilt
> fi
> 
> make O=../output/local/ -j4 CC="ccache distcc" $*
> 
> --
> 
> Ryan Anderson
>   sometimes Pug Majere
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
