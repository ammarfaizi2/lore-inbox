Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311884AbSELJFT>; Sun, 12 May 2002 05:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311898AbSELJFS>; Sun, 12 May 2002 05:05:18 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:13014 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S311884AbSELJFR> convert rfc822-to-8bit; Sun, 12 May 2002 05:05:17 -0400
Date: Sun, 12 May 2002 11:04:50 +0200
From: "Axel H. Siebenwirth" <axel@hh59.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [patch] 2.4.19-pre8-ac2 kbuild 2.4 tmp_include_depends
Message-ID: <20020512090450.GA481@neon>
Mail-Followup-To: Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
In-Reply-To: <20819.1021169484@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Organization: hh59.org
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

Applied your patch but it still fails.
I did 

make mrproper
cp ../.config .
make oldconfig dep clean bzImage

init/do_mounts.c:351: warning: ount_nfs_root' defined but not used
init/do_mounts.c:382: warning: hange_floppy' defined but not used
init/do_mounts.c:972: warning: rd_load' defined but not used
make: *** No rule to make target .tmp_include_depends', needed by
dir_kernel'.  Stop.

Regards,
Axel Siebenwirth

On Sun, 12 May 2002, Keith Owens wrote:

> make clean dep works, make dep clean deletes the .tmp file created by
> make dep and complains 'no rule to make .tmp_include_depends'.  Change
> the filenames to avoid make clean and add them to mrproper.
> 
> diff -urN 2.4.19-pre8-ac2/Makefile 2.4.19-pre8-ac2-test/Makefile
> --- 2.4.19-pre8-ac2/Makefile	Sun May 12 11:24:45 2002
> +++ 2.4.19-pre8-ac2-test/Makefile	Sun May 12 12:00:26 2002
> @@ -226,6 +226,7 @@
>  # files removed with 'make mrproper'
>  MRPROPER_FILES = \
>  	include/linux/autoconf.h include/linux/version.h \
> +	tmp* \
>  	drivers/net/hamradio/soundmodem/sm_tbl_{afsk1200,afsk2666,fsk9600}.h \
>  	drivers/net/hamradio/soundmodem/sm_tbl_{hapn4800,psk4800}.h \
>  	drivers/net/hamradio/soundmodem/sm_tbl_{afsk2400_7,afsk2400_8}.h \
> @@ -353,13 +354,13 @@
>  
>  comma	:= ,
>  
> -init/version.o: init/version.c include/linux/compile.h .tmp_include_depends
> +init/version.o: init/version.c include/linux/compile.h tmp_include_depends
>  	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) -DUTS_MACHINE='"$(ARCH)"' -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o init/version.o init/version.c
>  
> -init/main.o: init/main.c .tmp_include_depends
> +init/main.o: init/main.c tmp_include_depends
>  	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o $*.o $<
>  
> -init/do_mounts.o: init/do_mounts.c .tmp_include_depends
> +init/do_mounts.o: init/do_mounts.c tmp_include_depends
>  	$(CC) $(CFLAGS) $(CFLAGS_KERNEL) $(PROFILING) -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c -o $*.o $<
>  
>  fs lib mm ipc kernel drivers net: dummy
> @@ -386,7 +387,7 @@
>  modules: $(patsubst %, _mod_%, $(SUBDIRS))
>  
>  .PHONY: $(patsubst %, _mod_%, $(SUBDIRS))
> -$(patsubst %, _mod_%, $(SUBDIRS)) : include/linux/version.h .tmp_include_depends
> +$(patsubst %, _mod_%, $(SUBDIRS)) : include/linux/version.h tmp_include_depends
>  	$(MAKE) -C $(patsubst _mod_%, %, $@) CFLAGS="$(CFLAGS) $(MODFLAGS)" MAKING_MODULES=1 modules
>  
>  .PHONY: modules_install
> @@ -491,13 +492,13 @@
>  ifdef CONFIG_MODVERSIONS
>  	$(MAKE) update-modverfile
>  endif
> -	(find $(TOPDIR) \( -name .depend -o -name .hdepend \) -print | xargs $(AWK) -f scripts/include_deps) > .tmp_include_depends
> -	sed -ne 's/^\([^ ].*\):.*/  \1 \\/p' .tmp_include_depends > .tmp_include_depends_1
> -	(echo ""; echo "all: \\"; cat .tmp_include_depends_1; echo "") >> .tmp_include_depends
> -	rm .tmp_include_depends_1
> +	(find $(TOPDIR) \( -name .depend -o -name .hdepend \) -print | xargs $(AWK) -f scripts/include_deps) > tmp_include_depends
> +	sed -ne 's/^\([^ ].*\):.*/  \1 \\/p' tmp_include_depends > tmp_include_depends_1
> +	(echo ""; echo "all: \\"; cat tmp_include_depends_1; echo "") >> tmp_include_depends
> +	rm tmp_include_depends_1
>  
> -.tmp_include_depends: include/config/MARKER dummy
> -	$(MAKE) -r -f .tmp_include_depends all
> +tmp_include_depends: include/config/MARKER dummy
> +	$(MAKE) -r -f tmp_include_depends all
>  
>  ifdef CONFIG_MODVERSIONS
>  MODVERFILE := $(TOPDIR)/include/linux/modversions.h
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
