Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUEDBw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUEDBw2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 21:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263748AbUEDBw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 21:52:28 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:41364 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S263735AbUEDBw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 21:52:26 -0400
Date: Mon, 3 May 2004 18:52:18 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: olh@suse.de, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Fix booting some PPC32 machines
Message-ID: <20040504015217.GB6254@smtp.west.cox.net>
References: <20040503180945.GL26773@smtp.west.cox.net> <16534.58651.788709.350751@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16534.58651.788709.350751@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 10:34:35AM +1000, Paul Mackerras wrote:

> Tom Rini writes:
> 
> > Hello.  The following patch fixes booting on some PPC32 machines with
> > OpenFirmware, when booted without the aid of an additional bootloader.
> > The problem is that the linker script for the 'zImage' type targets was
> > put into the list of dependancies which objcopy would parse as a list of
> > files to copy into the resulting image.  The fix is to make the phony
> > zImage targets depend on the linker script.
> 
> I don't like this part of the fix:
> 
> >  $(images)/vmlinux.initrd.elf-pmac: $(obj)/image.initrd.o $(NEWWORLDOBJS) \
> > -				   $(LIBS) $(obj)/note $(boot)/ld.script
> > +				   $(LIBS) $(obj)/note
> >  	$(call cmd,gen-elf-pmac)
> 
> because the linking process (gen-elf-pmac) really does depend on
> ld.script.  Since gen-elf-pmac uses $<, not $^, it should be OK with
> the ld.script in the dependencies.  Did you verify that there was a
> problem with this rule or did you just rip out all of the ld.script
> dependencies?

I did just remove all of the previous dependancies and place them on the
zImage target (we don't mention that you can do 'make
arch/ppc/boot/images/foo.image, and I don't know if that would work, so
I don't think that'd be a problem).

> Similarly we need the ld.script dependency in here:
> 
> > -$(images)/zImage.chrp: $(CHRPOBJS) $(obj)/image.o $(LIBS) $(boot)/ld.script
> > +$(images)/zImage.chrp: $(CHRPOBJS) $(obj)/image.o $(LIBS)
> >  	$(call cmd,gen-chrp)
> > -$(images)/zImage.initrd.chrp: $(CHRPOBJS) $(obj)/image.initrd.o $(LIBS) $(boot)/ld.script
> > +$(images)/zImage.initrd.chrp: $(CHRPOBJS) $(obj)/image.initrd.o $(LIBS)
> >  	$(call cmd,gen-chrp)
> 
> Here, gen-chrp does have a problem because it uses $^, but it looks to
> me that with a minor change it could just use $< and avoid the
> problem.

IIRC, changing to $< means we have to compilcate the rules a bit more,
or thinking a bit harder, re-arrange the dependancies s.t.
$(obj)/image*.o is first, and gen-chrp (and gen-pmac) both know to use
$(CHRPOBJS) and $(LIBS).

-- 
Tom Rini
http://gate.crashing.org/~trini/
