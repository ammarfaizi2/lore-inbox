Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266961AbTBXTwV>; Mon, 24 Feb 2003 14:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266983AbTBXTwV>; Mon, 24 Feb 2003 14:52:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:3038 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266961AbTBXTwS>;
	Mon, 24 Feb 2003 14:52:18 -0500
Date: Mon, 24 Feb 2003 11:58:17 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: tinglett@vnet.ibm.com, torvalds@transmeta.com
Subject: Re: zImage now holds vmlinux, System.map and config in sections. (fwd)
Message-Id: <20030224115817.6da45cf2.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.33.0302241010200.1088-100000@localhost.localdomain>
References: <Pine.LNX.4.33.0302241010200.1088-100000@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| Date: Fri,  7 Feb 2003 21:36:21 +0000
| From: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
| To: BK Commits List:  ;
| Subject: zImage now holds vmlinux, System.map and config in sections.
| 
| ChangeSet 1.914.1.34, 2003/02/07 15:36:21-06:00, tinglett@vnet.ibm.com
| 
| 	zImage now holds vmlinux, System.map and config in sections.


I'm very happy to see such a patch added to Linux (especially referring
to saving the .config file in the kernel image).  This is nice.

I've had such a patch for several months now but it's not quite as
simple as this one....so... I don't know linker scripts very well.
Can this be done for all architectures?
I'd like to see a solution that is arch-independent.

And I do prefer to see the config data saved with the kernel image file
(like this) and accessible even when the kernel isn't running, instead
of only being available in /proc/config.gz when that kernel is running.

Thanks,
~Randy




| diff -Nru a/arch/ppc64/boot/Makefile b/arch/ppc64/boot/Makefile
| --- a/arch/ppc64/boot/Makefile	Sat Feb 22 13:05:38 2003
| +++ b/arch/ppc64/boot/Makefile	Sat Feb 22 13:05:38 2003
| @@ -24,35 +24,45 @@
|  #CROSS32_COMPILE = /usr/local/ppc/bin/powerpc-linux-
|  
| +#-----------------------------------------------------------
| +# ELF sections within the zImage bootloader/wrapper
| +#-----------------------------------------------------------
| +required := vmlinux .config System.map
| +initrd   := initrd
| +
| +obj-sec = $(foreach section, $(1), $(patsubst %,$(obj)/kernel-%.o, $(section)))
| +src-sec = $(foreach section, $(1), $(patsubst %,$(obj)/kernel-%.c, $(section)))
| +gz-sec  = $(foreach section, $(1), $(patsubst %,$(obj)/kernel-%.gz, $(section)))
| +
| +host-progs		:= piggy addnote addSystemMap addRamDisk
| +EXTRA_TARGETS 		+= zImage zImage.initrd imagesize.c \
| +			   $(patsubst $(obj)/%,%, $(call obj-sec, $(required) $(initrd))) \
| +			   $(patsubst $(obj)/%,%, $(call src-sec, $(required) $(initrd))) \
| +			   $(patsubst $(obj)/%,%, $(call gz-sec, $(required) $(initrd))) \
|  			   vmlinux.sm vmlinux.initrd vmlinux.sminitrd \
|  			   sysmap.o initrd.o
|  
| @@ -69,42 +79,48 @@
|  $(obj)/vmlinux.sminitrd: $(obj)/vmlinux.sm $(obj)/addRamDisk $(obj)/ramdisk.image.gz FORCE
|  	$(call if_changed,ramdisk)
|  
| +$(obj)/sysmap.o: System.map $(obj)/piggyback
| +	$(call if_changed,piggy)
| +
| +addsection = $(BOOTOBJCOPY) $(1) \
| +		--add-section=.kernel:$(strip $(patsubst $(obj)/kernel-%.o,%, $(1)))=$(patsubst %.o,%.gz, $(1)) \
| +		--set-section-flags=.kernel:$(strip $(patsubst $(obj)/kernel-%.o,%, $(1)))=$(OBJCOPYFLAGS)
| +
| +quiet_cmd_addnote = ADDNOTE $@ 
| +      cmd_addnote = $(BOOTLD) $(BOOTLFLAGS) -o $@ $(obj-boot) && $(obj)/addnote $@
|  
|  quiet_cmd_piggy = PIGGY   $@
|        cmd_piggy = $(obj)/piggyback $(@:.o=) < $< | $(BOOTAS) -o $@
|  
| -$(obj)/image.o: $(obj)/vmlinux.gz $(obj)/piggyback FORCE
| -	$(call if_changed,piggy)
| +$(call gz-sec, $(required)): $(obj)/kernel-%.gz: %
| +	$(call if_changed,gzip)
|  
| -$(obj)/sysmap.o: System.map $(obj)/piggyback FORCE
| -	$(call if_changed,piggy)
| +$(obj)/kernel-initrd.gz: $(obj)/ramdisk.image.gz
| +	cp -f $(obj)/ramdisk.image.gz $@
|  
| -$(obj)/initrd.o: $(obj)/ramdisk.image.gz $(obj)/piggyback FORCE
| -	$(call if_changed,piggy)
| +$(call src-sec, $(required) $(initrd)): $(obj)/kernel-%.c: $(obj)/kernel-%.gz
| +	touch $@
|  
| -quiet_cmd_addnote = ADDNOTE $@ 
| -      cmd_addnote = $(BOOTLD) $(LD_ARGS) -T $(obj)/zImage.lds -o $@ $(OBJS) $<\
| -		    && $(obj)/addnote $@
| +$(call obj-sec, $(required) $(initrd)): $(obj)/kernel-%.o: $(obj)/kernel-%.c
| +	$(call if_changed_dep,bootcc)
| +	$(call addsection, $@)
|  
| -$(obj)/zImage: $(obj)/no_initrd.o $(OBJS) $(obj)/addnote FORCE
| +$(obj)/zImage: obj-boot += $(call obj-sec, $(required))
| +$(obj)/zImage: $(call obj-sec, $(required)) $(obj-boot) $(obj)/addnote FORCE
|  	$(call if_changed,addnote)
|  
| -$(obj)/zImage.initrd: $(obj)/initrd.o $(OBJS) $(obj)/addnote FORCE
| +$(obj)/zImage.initrd: obj-boot += $(call obj-sec, $(required) $(initrd))
| +$(obj)/zImage.initrd: $(call obj-sec, $(required) $(initrd)) $(obj-boot) $(obj)/addnote FORCE
|  	$(call if_changed,addnote)
|  
| -$(obj)/vmlinux.bin: vmlinux FORCE
| -	$(call if_changed,objcopy)
| -
| -$(obj)/vmlinux.gz: $(obj)/vmlinux.bin FORCE
| -	$(call if_changed,gzip)
| -
|  $(obj)/imagesize.c: vmlinux
|  	@echo Generating $@
|  	ls -l vmlinux | \
|  	awk '{printf "/* generated -- do not edit! */\n" \
| -		"int uncompressed_size = %d;\n", $$5}' > $(obj)/imagesize.c
| +		"unsigned long vmlinux_filesize = %d;\n", $$5}' > $(obj)/imagesize.c
|  	$(CROSS_COMPILE)nm -n vmlinux | tail -1 | \
| -	awk '{printf "long vmlinux_end = 0x%s;\n", substr($$1,8)}' \
| +	awk '{printf "unsigned long vmlinux_memsize = 0x%s;\n", substr($$1,8)}' \
|  		>> $(obj)/imagesize.c
|  
| -clean-files :=  $(targets)
| +
| +clean-files := $(patsubst $(obj)/%,%, $(obj-boot))
| diff -Nru a/arch/ppc64/boot/README b/arch/ppc64/boot/README
| --- /dev/null	Wed Dec 31 16:00:00 1969
| +++ b/arch/ppc64/boot/README	Sat Feb 22 13:05:38 2003
| @@ -0,0 +1,11 @@
| +
| +To extract the kernel vmlinux, System.map, .config or initrd from the zImage binary:
| +
| +objcopy -j .kernel:vmlinux -O binary zImage vmlinux.gz
| +objcopy -j .kernel:System.map -O binary zImage System.map.gz
| +objcopy -j .kernel:.config -O binary zImage config.gz
| +objcopy -j .kernel:initrd -O binary zImage.initrd initrd.gz


| diff -Nru a/arch/ppc64/boot/zImage.lds b/arch/ppc64/boot/zImage.lds
| --- a/arch/ppc64/boot/zImage.lds	Sat Feb 22 13:05:38 2003
| +++ b/arch/ppc64/boot/zImage.lds	Sat Feb 22 13:05:38 2003
| @@ -58,6 +58,27 @@
|      *(.dynamic)
|      CONSTRUCTORS
|    }
| +
| +  . = ALIGN(4096);
| +  _vmlinux_start =  .;
| +  .kernel:vmlinux : { *(.kernel:vmlinux) }
| +  _vmlinux_end =  .;
| +
| +  . = ALIGN(4096);
| +  _dotconfig_start =  .;
| +  .kernel:.config : { *(.kernel:.config) }
| +  _dotconfig_end =  .;
| +
| +  . = ALIGN(4096);
| +  _sysmap_start =  .;
| +  .kernel:System.map : { *(.kernel:System.map) }
| +  _sysmap_end =  .;
| +
| +  . = ALIGN(4096);
| +  _initrd_start =  .;
| +  .kernel:initrd : { *(.kernel:initrd) }
| +  _initrd_end =  .;
| +
|    . = ALIGN(4096);
|    _edata  =  .;
|    PROVIDE (edata = .);
| -
