Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264096AbUEDAes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264096AbUEDAes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 20:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264103AbUEDAes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 20:34:48 -0400
Received: from ozlabs.org ([203.10.76.45]:54917 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264096AbUEDAeq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 20:34:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16534.58651.788709.350751@cargo.ozlabs.ibm.com>
Date: Tue, 4 May 2004 10:34:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: olh@suse.de, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix booting some PPC32 machines
In-Reply-To: <20040503180945.GL26773@smtp.west.cox.net>
References: <20040503180945.GL26773@smtp.west.cox.net>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini writes:

> Hello.  The following patch fixes booting on some PPC32 machines with
> OpenFirmware, when booted without the aid of an additional bootloader.
> The problem is that the linker script for the 'zImage' type targets was
> put into the list of dependancies which objcopy would parse as a list of
> files to copy into the resulting image.  The fix is to make the phony
> zImage targets depend on the linker script.

I don't like this part of the fix:

>  $(images)/vmlinux.initrd.elf-pmac: $(obj)/image.initrd.o $(NEWWORLDOBJS) \
> -				   $(LIBS) $(obj)/note $(boot)/ld.script
> +				   $(LIBS) $(obj)/note
>  	$(call cmd,gen-elf-pmac)

because the linking process (gen-elf-pmac) really does depend on
ld.script.  Since gen-elf-pmac uses $<, not $^, it should be OK with
the ld.script in the dependencies.  Did you verify that there was a
problem with this rule or did you just rip out all of the ld.script
dependencies?

Similarly we need the ld.script dependency in here:

> -$(images)/zImage.chrp: $(CHRPOBJS) $(obj)/image.o $(LIBS) $(boot)/ld.script
> +$(images)/zImage.chrp: $(CHRPOBJS) $(obj)/image.o $(LIBS)
>  	$(call cmd,gen-chrp)
> -$(images)/zImage.initrd.chrp: $(CHRPOBJS) $(obj)/image.initrd.o $(LIBS) $(boot)/ld.script
> +$(images)/zImage.initrd.chrp: $(CHRPOBJS) $(obj)/image.initrd.o $(LIBS)
>  	$(call cmd,gen-chrp)

Here, gen-chrp does have a problem because it uses $^, but it looks to
me that with a minor change it could just use $< and avoid the
problem.

The other places where you have removed ld.script from the
dependencies look OK to me.

Regards,
Paul.
