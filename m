Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268458AbUIFSmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268458AbUIFSmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 14:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268463AbUIFSmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 14:42:07 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:27060 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268458AbUIFSlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 14:41:55 -0400
Message-Id: <200409061841.i86Ifdnj008952@laptop11.inf.utfsm.cl>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: kbuild: Simplify vmlinux generation 
In-Reply-To: Message from Sam Ravnborg <sam@ravnborg.org> 
   of "Sun, 05 Sep 2004 22:12:35 +0200." <20040905201235.GC16901@mars.ravnborg.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Mon, 06 Sep 2004 14:41:39 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> said:

[...]

Some comments interspersed.

Signed off by: Horst H. von Brand <vonbrand@inf.utfsm.cl>

(Not too much intellect in here, and no property, but...)

> diff -Nru a/Makefile b/Makefile
> --- a/Makefile	2004-09-05 22:06:47 +02:00
> +++ b/Makefile	2004-09-05 22:06:47 +02:00
> @@ -545,67 +545,91 @@
>  
>  # Build vmlinux
>  # ---------------------------------------------------------------------------
> +# vmlinux is build from the objects seleted by $(vmlinux-init) and

                                       selected

> +# $(vmlinux-main). Most are built-in.o files from top-level directories
> +# in the kernel tree, others are specified in arch/$(ARCH)Makefile.
> +# Ordering when linking is important, and $(vmlinux-init) must be first.
> +#
> +# vmlinux
> +#   ^
> +#   |
> +#   +-< $(vmlinux-init)
> +#   |   +--< init/version.o + more
> +#   |
> +#   +-< built-in.o
> +#   |   +--< $(vmlinux-main)
> +#   |        +--< driver/built-in.o mm/built-in.o + more
> +#   |
> +#   +-< kallsyms.o (see description in CONFIG_KALLSYMS section)
> +#
> +# vmlinux version cannot be updated during normal descending-into-subdirs

     The vmlinux version? Or some file?

> +# phase since we do not yet know if we need to update vmlinux.
> +# Therefore this step is delayed until just before final link of vmlinux -
> +# except in kallsyms case where it is done just before adding the

            in the kallsyms case

> +# symbols to the kernel.
> +#
> +# System.map is generated to document addresses of all kernel symbols
>  
> -#	This is a bit tricky: If we need to relink vmlinux, we want
> -#	the version number incremented, which means recompile init/version.o
> -#	and relink init/init.o. However, we cannot do this during the
> -#       normal descending-into-subdirs phase, since at that time
> -#       we cannot yet know if we will need to relink vmlinux.
> -#	So we descend into init/ inside the rule for vmlinux again.
> -vmlinux-objs := $(head-y) $(init-y) $(core-y) $(libs-y) $(drivers-y) $(net-y)
> -
> -quiet_cmd_vmlinux__ = LD      $@
> -define cmd_vmlinux__
> -	$(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) $(head-y) $(init-y) \
> -	--start-group \
> -	$(core-y) \
> -	$(libs-y) \
> -	$(drivers-y) \
> -	$(net-y) \
> -	--end-group \
> -	$(filter .tmp_kallsyms%,$^) \
> -	-o $@
> -endef
> +vmlinux-init := $(head-y) $(init-y)
> +vmlinux-main := $(core-y) $(libs-y) $(drivers-y) $(net-y)
> +vmlinux-all  := $(vmlinux-init) built-in.o
> +vmlinux-lds  := arch/$(ARCH)/kernel/vmlinux.lds
> +
> +# Rule to link vmlinux - also used during CONFIG_KALLSYMS
> +# May be overridden by arch/$(ARCH)/Makefile
> +quiet_cmd_vmlinux__  = LD      $@
> +      cmd_vmlinux__  = $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) \
> +                           -T $(filter-out FORCE, $^) -o $@
> +
> +# Generate new vmlinux version
> +quiet_cmd_vmlinux_version = GEN     .version
> +      cmd_vmlinux_version = set -e;                     \
> +	. $(srctree)/scripts/mkversion > .tmp_version;	\
> +	mv -f .tmp_version .version;			\
> +	$(MAKE) $(build)=init
> +	
> +# Generate System.map
> +quiet_cmd_sysmap = SYSMAP 
> +      cmd_sysmap = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
>  
> -#	set -e makes the rule exit immediately on error
> +# Link of vmlinux
> +# If CONFIG_KALLSYMS is set .version is already updated
> +# Generate System.map and verify that the content is consistent
>  
>  define rule_vmlinux__
> -	+set -e;							\
> -	$(if $(filter .tmp_kallsyms%,$^),,				\
> -	  echo '  GEN     .version';					\
> -	  . $(srctree)/scripts/mkversion > .tmp_version;		\
> -	  mv -f .tmp_version .version;					\
> -	  $(MAKE) $(build)=init;					\
> -	)								\
> -	$(if $($(quiet)cmd_vmlinux__),					\
> -	  echo '  $($(quiet)cmd_vmlinux__)' &&) 			\
> -	$(cmd_vmlinux__);						\
> -	echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
> +	$(if $(CONFIG_KALLSYMS),,$(call cmd,vmlinux_version))
> +	
> +	$(call cmd,vmlinux__)
> +	$(Q)echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
> +	
> +	$(Q)$(if $($(quiet)cmd_sysmap),                 \
> +	  echo '  $($(quiet)cmd_sysmap) System.map' &&) \
> +	$(cmd_sysmap) $@ System.map;                    \
> +	if [ $$? -ne 0 ]; then                          \
> +		rm -f $@;                               \
> +		/bin/false;                             \
> +	fi;
> +	$(verify_kallsyms)
>  endef
>  
> -quiet_cmd_sysmap = SYSMAP 
> -      cmd_sysmap = $(CONFIG_SHELL) $(srctree)/scripts/mksysmap
> -		   
> -LDFLAGS_vmlinux += -T arch/$(ARCH)/kernel/vmlinux.lds
> -
> -#	Generate section listing all symbols and add it into vmlinux
> -#	It's a three stage process:
> -#	o .tmp_vmlinux1 has all symbols and sections, but __kallsyms is
> -#	  empty
> -#	  Running kallsyms on that gives us .tmp_kallsyms1.o with
> -#	  the right size
> -#	o .tmp_vmlinux2 now has a __kallsyms section of the right size,
> -#	  but due to the added section, some addresses have shifted
> -#	  From here, we generate a correct .tmp_kallsyms2.o
> -#	o The correct .tmp_kallsyms2.o is linked into the final vmlinux.
> -#	o Verify that the System.map from vmlinux matches the map from
> -#	  .tmp_vmlinux2, just in case we did not generate kallsyms correctly.
> -#	o If CONFIG_KALLSYMS_EXTRA_PASS is set, do an extra pass using
> -#	  .tmp_vmlinux3 and .tmp_kallsyms3.o.  This is only meant as a
> -#	  temporary bypass to allow the kernel to be built while the
> -#	  maintainers work out what went wrong with kallsyms.
>  
>  ifdef CONFIG_KALLSYMS
> +# Generate section listing all symbols and add it into vmlinux $(kallsyms.o)
> +# It's a three stage process:
> +# o .tmp_vmlinux1 has all symbols and sections, but __kallsyms is
> +#   empty
> +#   Running kallsyms on that gives us .tmp_kallsyms1.o with
> +#   the right size - vmlinux version updated during this step

                                        is updated

> +# o .tmp_vmlinux2 now has a __kallsyms section of the right size,
> +#   but due to the added section, some addresses have shifted.
> +#   From here, we generate a correct .tmp_kallsyms2.o
> +# o The correct .tmp_kallsyms2.o is linked into the final vmlinux.
> +# o Verify that the System.map from vmlinux matches the map from
> +#   .tmp_vmlinux2, just in case we did not generate kallsyms correctly.
> +# o If CONFIG_KALLSYMS_EXTRA_PASS is set, do an extra pass using
> +#   .tmp_vmlinux3 and .tmp_kallsyms3.o.  This is only meant as a
> +#   temporary bypass to allow the kernel to be built while the
> +#   maintainers work out what went wrong with kallsyms.
>  
>  ifdef CONFIG_KALLSYMS_EXTRA_PASS
>  last_kallsyms := 3
> @@ -615,16 +639,28 @@
>  
>  kallsyms.o := .tmp_kallsyms$(last_kallsyms).o
>  
> -define rule_verify_kallsyms
> +define verify_kallsyms

Why delete "rule_" here? Down you create a new rule with "rule_"

[No further comments, rest snipped]
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
