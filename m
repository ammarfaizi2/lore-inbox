Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVBYTtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVBYTtG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 14:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVBYTtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 14:49:06 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8210 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261260AbVBYTsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 14:48:36 -0500
Date: Fri, 25 Feb 2005 19:48:24 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: ARM undefined symbols.  Again.
Message-ID: <20050225194823.A27842@flint.arm.linux.org.uk>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>
References: <20050124154326.A5541@flint.arm.linux.org.uk> <20050131161753.GA15674@mars.ravnborg.org> <20050207114359.A32277@flint.arm.linux.org.uk> <20050208194243.GA8505@mars.ravnborg.org> <20050208200501.B3544@flint.arm.linux.org.uk> <20050209104053.A31869@flint.arm.linux.org.uk> <20050213172940.A12469@flint.arm.linux.org.uk> <4210A345.6030304@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4210A345.6030304@grupopie.com>; from pmarques@grupopie.com on Mon, Feb 14, 2005 at 01:10:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 01:10:29PM +0000, Paulo Marques wrote:
> Russell King wrote:
> > On Wed, Feb 09, 2005 at 10:40:53AM +0000, Russell King wrote:
> >>On Tue, Feb 08, 2005 at 08:05:01PM +0000, Russell King wrote:
> >>[...]
> >>  LD      .tmp_vmlinux1
> >>.tmp_vmlinux1: error: undefined symbol(s) found:
> >>         w kallsyms_addresses
> >>         w kallsyms_markers
> >>         w kallsyms_names
> >>         w kallsyms_num_syms
> >>         w kallsyms_token_index
> >>         w kallsyms_token_table
> >>
> >>Maybe kallsyms needs to provide an empty object with these symbols
> >>defined for the first linker pass, instead of using weak symbols?
> > 
> > 
> > So, what's the answer?  Maybe this patch?  With this, we can drop the
> > __attribute__((weak)) from the kallsyms symbols since they're always
> > provided.
> > 
> > diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/Makefile linux/Makefile
> > --- orig/Makefile	Sun Feb 13 17:26:38 2005
> > +++ linux/Makefile	Sun Feb 13 17:24:17 2005
> > @@ -702,14 +702,20 @@ quiet_cmd_kallsyms = KSYM    $@
> >        cmd_kallsyms = $(NM) -n $< | $(KALLSYMS) \
> >                       $(if $(CONFIG_KALLSYMS_ALL),--all-symbols) > $@
> >  
> > -.tmp_kallsyms1.o .tmp_kallsyms2.o .tmp_kallsyms3.o: %.o: %.S scripts FORCE
> > +.tmp_kallsyms0.o .tmp_kallsyms1.o .tmp_kallsyms2.o .tmp_kallsyms3.o: %.o: %.S scripts FORCE
> >  	$(call if_changed_dep,as_o_S)
> >  
> > +.tmp_kallsyms0.S: FORCE
> > +	@( echo ".data"; \
> > +	  for sym in addresses markers names num_syms token_index token_table; \
> > +	  do echo -e ".globl kallsyms_$$sym\nkallsyms_$$sym:\n"; done; \
> > +	  echo ".word 0"; ) > $@
> 
> I think it would be better to pass an argument to scripts/kallsyms (like 
> -0 or something) that instructed it to generate the same file it usually 
> generates but without any actual symbol information.
> 
> This way it will be easier to maintain this code in case new symbols are 
> needed in the future. Having this done in the Makefile means that to add 
> a new symbol we will have to change scripts/kallsyms, kernel/kallsyms 
> and a not so clearly related Makefile.
> 
> I'll try to make a small patch if I can get some time (maybe later this 
> week).

So, what's happening about this?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
