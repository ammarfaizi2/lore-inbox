Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272006AbTG2TVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 15:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272150AbTG2TVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 15:21:11 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:51466 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S272006AbTG2TVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:21:00 -0400
Date: Tue, 29 Jul 2003 21:20:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux-2.6.0-test2 h8300 archtecure support update (1/6)
Message-ID: <20030729192056.GB5791@mars.ravnborg.org>
Mail-Followup-To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Linus Torvalds <torvalds@osdl.org>,
	linux kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m2smoqag5s.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2smoqag5s.wl%ysato@users.sourceforge.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 11:18:23PM +0900, Yoshinori Sato wrote:
>  BOARD := $(board-y)

There is no need for renaming this variable, it is only reference three
times, so board-y would be fine.
Same goes for MODEL.

> +
> +vmlinux.bin: vmlinux
> +	$(OBJCOPY) -Obinary $< $@
> +
> +vmlinux.srec: vmlinux
> +	$(OBJCOPY) -Osrec $< $@
The above is more suited for a seperate boot/ directory.

Example:
boot := arch/$(ARCH)/boot
vmlinux.srec vmlinux.bin: vmlinux
	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@

archclean:
	$(Q)$(MAKE) $(clean)=$(boot)

(The current archclean rule is plain wrong).


And in boot/Makefile

OBJCOPYFLAGS_vmlinux.srec := -Osrec
OBJCOPYFLAGS_vmlinux.bin  := -Obinary
$(obj)/vmlinux.srec $(obj)/vmlinux.bin: vmlinux FORCE
	$(call if_changed,objcopy)
	@echo '  Kernel: $@ is ready'

targets += vmlinux.srec vmlinux.bin


> +
> +define archhelp
> +  echo  'vmlinux.bin  - Create raw binary'
> +  echo  'vmlinux.srec - Create srec binary'
> +endef
OK - shall stay in arch/$(ARCH)/Makefile

> +
> +CLEAN_FILES += arch/$(ARCH)/vmlinux.bin arch/$(ARCH)/vmlinux.srec

Replaced by targets assignment in boot/Makefile.
But you shall add files related to asm-offsets:
CLEAN_FILES += include/asm-$(ARCH)/asm-offsets.h

	Sam
