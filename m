Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129722AbQKAPDy>; Wed, 1 Nov 2000 10:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130119AbQKAPDo>; Wed, 1 Nov 2000 10:03:44 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:34311 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129722AbQKAPDh>; Wed, 1 Nov 2000 10:03:37 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14848.12475.791640.17546@wire.cadcamlab.org>
Date: Wed, 1 Nov 2000 09:03:23 -0600 (CST)
To: Christoph Hellwig <hch@caldera.de>
Cc: torvalds@transmeta.com, linux-kbuild@torque.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] list-style makefile boilerplate without reordering
In-Reply-To: <20001101125837.A28861@caldera.de>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Christoph Hellwig <hch@caldera.de>]
> +
> +# include a local makefile, if present
> +-include Makefile.local

Why?


> +%.i: %.c
> +	$(CPP) $(CFLAGS) $(EXTRA_CFLAGS) $(CFLAGS_$@) $< > $@

Why?  Well, I know, it's historical, but does anyone think we actually
need this?


> +%.s: %.S
> +	$(CPP) $(AFLAGS) $(EXTRA_AFLAGS) $(AFLAGS_$@) $< > $@

Ditto.


> +# Rule to compile a set of .o files into one .o file
> +$(O_TARGET): $(obj-y)
> +	rm -f $@
> +    ifneq "$(strip $(obj-y))" ""
> +	$(LD) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(obj-y), $^)
> +    else
> +	$(AR) rcs $@ $(filter $(obj-y), $^)
                     ^^^^^^^^^^^^^^^^^^^^^^
We have just determined that this is empty.  I think it would be more
readable to say

        $(AR) rcs $@

The whole line is a clever hack to produce something in the event of an
empty list, and this makes it more obvious what is going on.


> +# this make dependencies (not that ...) quickly
> +fastdep: dummy
> +	$(TOPDIR)/scripts/mkdep $(wildcard *.[chS] local.h.master) > .depend
> +ifdef all-subdirs
> +	$(MAKE) $(patsubst %,_sfdep_%,$(all-subdirs)) _FASTDEP_ALL_SUB_DIRS="$(all-subdirs)"
> +endif
> +
> +ifdef _FASTDEP_ALL_SUB_DIRS
> +$(patsubst %,_sfdep_%,$(_FASTDEP_ALL_SUB_DIRS)):
> +	$(MAKE) -C $(patsubst _sfdep_%,%,$@) fastdep
> +endif

This needs rethinking.  I know this is how Rules.make does it, but
wouldn't it be faster to eliminate one level of recursion?

  fastdep: dummy $(patsubst %,_sfdep_%,$(all-subdirs))
  	$(TOPDIR)/scripts/mkdep $(wildcard *.[chS] local.h.master) > .depend
  $(patsubst %,_sfdep_%,$(all-subdirs)):
  	$(MAKE) -C $(patsubst _sfdep_%,%,$@) fastdep

Untested, but is there some reason that wouldn't work?  Order of
execution shouldn't matter to mkdep, right?


> +# a rule to make subdirectories
> +sub_dirs: dummy $(patsubst %,_subdir_%,$(subdir-y))
> +
> +ifdef subdir-y
   ^^^^^^^^^^^^^^
   ifneq "$(strip $(subdir-y))" ""


> +PDWN=$(shell $(CONFIG_SHELL) $(TOPDIR)/scripts/pathdown.sh)

I think invoking pathdown.sh is probably unnecessary, see below.


> +.PHONY: $(patsubst %,_modinst_%,$(subdir-m))
> +$(patsubst %,_modinst_%,$(subdir-m)) : dummy
> +	$(MAKE) -C $(patsubst _modinst_%,%,$@) modules_install
> +endif

This is the only case where $(PDWN) is needed, so IMHO we should just
supply it internally -- faster than a shell process:

   $(patsubst %,_modinst_%,$(subdir-m)): dummy
   	$(MAKE) -C $(patsubst _modinst_%,%,%@ modules_install \
	  PDWN=$(PDWN)$(patsubst _modinst_%,%,%@)/

Or, if that looks funny, we can initialize PDWN to '.' in
$(TOPDIR)/Makefile and use
       ...PDWN=$(PDWN)/$(patsubst _modinst_%,%,%@)


> +ifdef CONFIG_MODULES
> +ifdef CONFIG_MODVERSIONS
[...]
> +ifdef CONFIG_SMP

Eric Raymond won't like this.  He at one point was pushing for phasing
out and eliminating 'ifdef CONFIG_*' from makefiles so he could define
CONFIG_* to be 'n' as distinguished from ''.  I think it's a good idea.

   ifneq "$(CONFIG_MODULES)$(CONFIG_MODVERSIONS)" ""
   [...]
   ifneq "$(CONFIG_SMP)" ""


Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
