Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVBMRaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVBMRaG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 12:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVBMRaD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 12:30:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6922 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261287AbVBMR3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 12:29:47 -0500
Date: Sun, 13 Feb 2005 17:29:40 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: ARM undefined symbols.  Again.
Message-ID: <20050213172940.A12469@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>
References: <20050124154326.A5541@flint.arm.linux.org.uk> <20050131161753.GA15674@mars.ravnborg.org> <20050207114359.A32277@flint.arm.linux.org.uk> <20050208194243.GA8505@mars.ravnborg.org> <20050208200501.B3544@flint.arm.linux.org.uk> <20050209104053.A31869@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050209104053.A31869@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Wed, Feb 09, 2005 at 10:40:53AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 10:40:53AM +0000, Russell King wrote:
> On Tue, Feb 08, 2005 at 08:05:01PM +0000, Russell King wrote:
> > On Tue, Feb 08, 2005 at 08:42:43PM +0100, Sam Ravnborg wrote:
> > > On Mon, Feb 07, 2005 at 11:43:59AM +0000, Russell King wrote:
> > > > 
> > > > Maybe we need an architecture hook or something for post-processing
> > > > vmlinux?
> > > Makes sense.
> > > For now arm can provide an arm specific cmd_vmlinux__ like um does.
> > > 
> > > The ?= used in Makefile snippet below allows an ARCH to override the
> > > definition of quiet_cmd_vmlinux__ and cmd_vmlinux__
> > 
> > Great - I'll merge your previous idea with this one and throw a patch
> > here.
> 
> Well, this was a great idea until you find that this is also used for
> linking the intermediate vmlinux objects for kallsyms, and kallsyms
> uses weak (== undefined) symbols:
> 
>   LD      .tmp_vmlinux1
> .tmp_vmlinux1: error: undefined symbol(s) found:
>          w kallsyms_addresses
>          w kallsyms_markers
>          w kallsyms_names
>          w kallsyms_num_syms
>          w kallsyms_token_index
>          w kallsyms_token_table
> 
> Maybe kallsyms needs to provide an empty object with these symbols
> defined for the first linker pass, instead of using weak symbols?

So, what's the answer?  Maybe this patch?  With this, we can drop the
__attribute__((weak)) from the kallsyms symbols since they're always
provided.

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/Makefile linux/Makefile
--- orig/Makefile	Sun Feb 13 17:26:38 2005
+++ linux/Makefile	Sun Feb 13 17:24:17 2005
@@ -702,14 +702,20 @@ quiet_cmd_kallsyms = KSYM    $@
       cmd_kallsyms = $(NM) -n $< | $(KALLSYMS) \
                      $(if $(CONFIG_KALLSYMS_ALL),--all-symbols) > $@
 
-.tmp_kallsyms1.o .tmp_kallsyms2.o .tmp_kallsyms3.o: %.o: %.S scripts FORCE
+.tmp_kallsyms0.o .tmp_kallsyms1.o .tmp_kallsyms2.o .tmp_kallsyms3.o: %.o: %.S scripts FORCE
 	$(call if_changed_dep,as_o_S)
 
+.tmp_kallsyms0.S: FORCE
+	@( echo ".data"; \
+	  for sym in addresses markers names num_syms token_index token_table; \
+	  do echo -e ".globl kallsyms_$$sym\nkallsyms_$$sym:\n"; done; \
+	  echo ".word 0"; ) > $@
+
 .tmp_kallsyms%.S: .tmp_vmlinux% $(KALLSYMS)
 	$(call cmd,kallsyms)
 
 # .tmp_vmlinux1 must be complete except kallsyms, so update vmlinux version
-.tmp_vmlinux1: $(vmlinux-lds) $(vmlinux-all) FORCE
+.tmp_vmlinux1: $(vmlinux-lds) $(vmlinux-all) .tmp_kallsyms0.o FORCE
 	$(call if_changed_rule,ksym_ld)
 
 .tmp_vmlinux2: $(vmlinux-lds) $(vmlinux-all) .tmp_kallsyms1.o FORCE
diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/arch/arm/Makefile linux/arch/arm/Makefile
--- orig/arch/arm/Makefile	Mon Nov 15 09:15:02 2004
+++ linux/arch/arm/Makefile	Wed Feb  9 10:09:36 2005
@@ -156,6 +156,17 @@ else
 all: zImage
 endif
 
+# Override the default command for generating vmlinux, so we can check for
+# the assembler bug with undefined symbols.
+cmd_vmlinux__ = $(LD) $(LDFLAGS) $(LDFLAGS_vmlinux) -o $@       \
+	-T $(vmlinux-lds) $(vmlinux-init)                       \
+	--start-group $(vmlinux-main) --end-group               \
+	$(filter-out $(vmlinux-lds) $(vmlinux-init) $(vmlinux-main) FORCE ,$^); \
+	if [ "`$(NM) -u $@`" != "" ]; then                      \
+	   echo "$@: error: undefined symbol(s) found:";        \
+	   $(NM) -u $@; exit 1;                                 \
+	fi
+
 boot := arch/arm/boot
 
 #	Update machine arch and proc symlinks if something which affects


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
