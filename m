Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbSJCFON>; Thu, 3 Oct 2002 01:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262732AbSJCFOM>; Thu, 3 Oct 2002 01:14:12 -0400
Received: from surf.cadcamlab.org ([156.26.20.182]:28374 "EHLO
	surf.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S262731AbSJCFOK>; Thu, 3 Oct 2002 01:14:10 -0400
Date: Thu, 3 Oct 2002 00:18:33 -0500
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [kbuild-devel] RfC: Don't cd into subdirs during kbuild
Message-ID: <20021003051833.GN1536@cadcamlab.org>
References: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Random thoughts.  I haven't actually tested the patch yet, so feel
free to ignore me. (:


[Kai Germaschewski]
> i.e. the current working directory remains the top dir for all
> times.

Which top dir, src or obj?  Most end users will expect obj topdir.
More on that below.

> So gcc/ld/.. are now called from the topdir, allowing to
> closer resemble a non-recursive build.

I still think it's more intuitive to have $(obj) == '.', but you do
make some good arguments in the cset comment.

> -	@$(MAKE) -C $(patsubst _sfdep_%, %, $@) fastdep
> +	@$(call descend,$(patsubst _sfdep_%,%,$@),fastdep)
>  
>  else # !CONFIG_MODVERSIONS
>  
> @@ -533,7 +526,7 @@
>  
>  .PHONY: $(patsubst %, _modinst_%, $(SUBDIRS))
>  $(patsubst %, _modinst_%, $(SUBDIRS)) :
> -	@$(MAKE) -C $(patsubst _modinst_%, %, $@) modules_install
> +	$(descend,$(patsubst _modinst_%,%,$@),modules_install)

	$(call descend,
for consistency.

> -fastdep: sub_dirs
> -	@echo -n
> +fastdep: $(subdir-ym)
> +	@/bin/true

	@:
Seriously.  You can assume ':' is built in to your /bin/sh.  If not,
you've got bigger problems, like perhaps a /bin/sh -> csh link.

> -# we also have source in the subdirectories..
> -vpath %.c =  . linux pagebuf support

Good riddance!  This is worse than $(MAKEFILES) abuse. (:

>  # Objects in pagebuf/
> -xfs-objs			+= page_buf.o \
> -				   page_buf_locking.o
> +xfs-objs			+= $(addprefix pagebuf/, \
> +				   page_buf.o \
> +				   page_buf_locking.o)
>  # Objects in linux/
>  # Objects in support/

Go ahead and delete those comments as well.

>   ACPI was a bit lazy and just said compile all .c files in this directory,

Yeah, I always felt this was "too clever for its own good".  Same
category as fs/smbfs/proto.h...

>  $(obj)/devlist.h: $(src)/pci.ids $(obj)/gen-devlist
> -	$(obj)/gen-devlist < $<
> +	( cd $(obj); ./gen-devlist ) < $<

	cd $(obj); ./gen-devlist < $<

No need for parentheses - $(src) is an absolute path.

Really gen-devlist should output to stdout instead of a fixed file.

>  $(obj)/devlist.h: $(src)/zorro.ids $(obj)/gen-devlist
> -	$(obj)/gen-devlist < $<
> +	( cd $(obj); ./gen-devlist ) < $<

ditto

>  lxdialog:
> -	$(MAKE) -C lxdialog all
> +	$(call descend,lxdialog,)

	$(call descend,scripts/lxdialog,)
I didn't actually test this but isn't $(descend) relative to
$(TOPDIR)?  At least in your later changeset.

> diff -Nru a/drivers/isdn/i4l/isdn_ppp.h b/drivers/isdn/i4l/isdn_ppp.h
> --- a/drivers/isdn/i4l/isdn_ppp.h	Wed Oct  2 21:52:06 2002
> +++ b/drivers/isdn/i4l/isdn_ppp.h	Wed Oct  2 21:52:06 2002
> @@ -27,7 +27,7 @@
>  #else
>  
>  static inline int
> -isdn_ppp_xmit(struct sk_buff *, struct net_device *);
> +isdn_ppp_xmit(struct sk_buff *, struct net_device *)

Obviously correct, but was that supposed to be part of your changeset?
I suppose it relates to "kbuild" in that "I can't compile my
kernel". (:

> +# Add subdir path
> +
> +EXTRA_TARGETS	:= $(addprefix $(obj)/,$(EXTRA_TARGETS))
> +obj-y		:= $(addprefix $(obj)/,$(obj-y))
> +obj-m		:= $(addprefix $(obj)/,$(obj-m))
> +export-objs	:= $(addprefix $(obj)/,$(export-objs))
> +subdir-obj-y	:= $(addprefix $(obj)/,$(subdir-obj-y))
> +real-objs-y	:= $(addprefix $(obj)/,$(real-objs-y))
> +real-objs-m	:= $(addprefix $(obj)/,$(real-objs-m))
> +multi-used-y	:= $(addprefix $(obj)/,$(multi-used-y))
> +multi-used-m	:= $(addprefix $(obj)/,$(multi-used-m))
> +multi-objs-y	:= $(addprefix $(obj)/,$(multi-objs-y))
> +multi-objs-m	:= $(addprefix $(obj)/,$(multi-objs-m))
> +subdir-ym	:= $(addprefix $(obj)/,$(subdir-ym))

add_obj_prefix = $1 := $(addprefix $(obj)/,$($1))
$(call add_obj_prefix EXTRA_TARGETS)

or something like that?

>  ifndef O_TARGET
>  ifndef L_TARGET
> -O_TARGET := built-in.o
> +O_TARGET := $(obj)/built-in.o
> +endif
>  endif
> +
> +ifdef L_TARGET
> +L_TARGET := $(obj)/$(L_TARGET)
>  endif

Hey, why not make life exciting.  Don't ifndef the O_TARGET.  Just
break the existing O_TARGET users.

> +host-progs-single     := $(addprefix $(obj)/,$(host-progs-single))
> +host-progs-multi      := $(addprefix $(obj)/,$(host-progs-multi))
> +host-progs-multi-objs := $(addprefix $(obj)/,$(host-progs-multi-objs))

$(call add_obj_prefix host-progs-single)

> +ifeq ($(KBUILD_VERBOSE),1)
> +descend = echo '$(MAKE) -f $(1)/Makefile $(2)';
> +endif
> +descend += $(MAKE) -f $(1)/Makefile obj=$(1) $(2)

Heh, clever.

> -ACPI_CFLAGS	:= -D_LINUX -I$(CURDIR)/include
> +ACPI_CFLAGS	:= -D_LINUX -Idrivers/acpi/include

   ACPI_CFLAGS	:= -D_LINUX -I$(src)/include

or do you require '.' to be source TOPDIR?  If so, this is the
opposite of what most projects do.  Normally the user expects to build
from the top of $(obj).  Why not do the same here, even if it's a bit
more work?

> +++ b/drivers/ide/arm/Makefile	Wed Oct  2 21:52:10 2002
> @@ -2,6 +2,6 @@
>  obj-$(CONFIG_BLK_DEV_IDE_ICSIDE)	+= icside.o
>  obj-$(CONFIG_BLK_DEV_IDE_RAPIDE)	+= rapide.o
>  
> -EXTRA_CFLAGS	:= -I../
> +EXTRA_CFLAGS	:= -Idrivers/ide

again (and 3 more cases below)..

> +++ b/drivers/message/fusion/Makefile	Wed Oct  2 21:52:10 2002
> @@ -13,7 +13,7 @@
>  #			# sparc64
>  #EXTRA_CFLAGS += -gstabs+
>  
> -EXTRA_CFLAGS += -I. ${MPT_CFLAGS}
> +EXTRA_CFLAGS += ${MPT_CFLAGS}

So can we assume -I$(src) is always part of the cflags?

> +++ b/drivers/net/sk98lin/Makefile	Wed Oct  2 21:52:10 2002
> @@ -55,7 +55,7 @@
>  # SK_DBGCAT_DRV_INT_SRC         0x04000000      interrupts sources
>  # SK_DBGCAT_DRV_EVENT           0x08000000      driver events
>  
> -EXTRA_CFLAGS += -I. -DSK_USE_CSUM $(DBGDEF)
> +EXTRA_CFLAGS += -Idrivers/net/sk98lin -DSK_USE_CSUM $(DBGDEF)

...because if so, this isn't needed.

> +++ b/drivers/net/skfp/Makefile	Wed Oct  2 21:52:10 2002
> @@ -17,7 +17,7 @@
>  #   projects. To keep the source common for all those drivers (and
>  #   thus simplify fixes to it), please do not clean it up!
>  
> -EXTRA_CFLAGS += -I. -DPCI -DMEM_MAPPED_IO -Wno-strict-prototypes 
> +EXTRA_CFLAGS += -Idrivers/net/skfp -DPCI -DMEM_MAPPED_IO -Wno-strict-prototypes 

...or this.

> +++ b/drivers/usb/storage/Makefile	Wed Oct  2 21:52:10 2002
> @@ -5,7 +5,7 @@
>  # Rewritten to use lists instead of if-statements.
>  #
>  
> -EXTRA_CFLAGS	:= -I../../scsi/
> +EXTRA_CFLAGS	:= -Idrivers/scsi

once again is '.' always directly below $(src) or below $(obj)?

> -# This needs -I. because everything does #include <xfs.h> instead of "xfs.h".
> +# This needs -I because everything does #include <xfs.h> instead of "xfs.h".

This implies that -I$(src) is *not* implicit - right?

I hope this is intended to be temporary - xfs should just be changed
to #include "" like everybody else.

Peter
