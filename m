Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262890AbTIEXsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 19:48:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263026AbTIEXsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 19:48:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:3026 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262890AbTIEXsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 19:48:24 -0400
Subject: Re: [TRIVIAL][PATCH] fix parallel builds for aic7xxx]
From: John Cherry <cherry@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, trivial@rustcorp.com.au,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20030905192141.GA9277@mars.ravnborg.org>
References: <1062698342.9322.73.camel@cherrytest.pdx.osdl.net>
	 <59600000.1062714135@aslan.btc.adaptec.com>
	 <1062779785.12723.41.camel@cherrytest.pdx.osdl.net>
	 <20030905192141.GA9277@mars.ravnborg.org>
Content-Type: text/plain
Organization: 
Message-Id: <1062805657.29888.19.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 Sep 2003 16:47:37 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

I don't know if this patch makes it any more obvious, but it does
exactly the same thing as the original patch.  If a phony target makes
things more obvious, OK.  I am more concerned that it is fixed, not how
it is fixed at this point.  I tested the new patch on a dual proc using
-j4 and it built just fine.

John

On Fri, 2003-09-05 at 12:21, Sam Ravnborg wrote:
> Hi Justin, John.
> 
> I agree with Justin that the patch for aic7xxx/Makefile looks a bit suspisious.
> I have modifed it to use a phony target as serialisation point.
> In this way it is more obvious what is actually happening.
> The patch for aicasm/Makefile looked OK - included here as well to make the
> patch complete.
> 
> I have tested this patch on UP only, with make -j4.
> Before it broke in aicasm, now it succeeds.
> 
> Justin, does this look OK for you?
> 
> 
> On Fri, Sep 05, 2003 at 09:36:25AM -0700, John Cherry wrote:
> > Short story: 
> > 
> > The makefile changes separate targets with identical dependencies.  In
> > the current Makefiles, things like "running the assembler" and "changing
> > file names" happen multiple times in parallel when building with
> > anything other than -j1.  Consider the following example Makefile:
> > 
> > targ: a b
> > a b: x
> >         touch a b
> > x:
> >         touch x
> > clean:
> >         rm a b x
> > 
> > Running the build with "make targ" yields:
> > touch x
> > touch a b
> > 
> > Running the build with "make -j2 targ" yields:
> > touch x
> > touch a b
> > touch a b
> > 
> > Notice that the "touch a b" output is not only executed twice, but on an
> > SMP machine, it could be run in parallel (with races).  These two
> > patches separate the targets with the same dependencies and prevent
> > these races.  I would actually consider this to be a bug in make, but
> > that is another story.
> Nope, consider the command to execute was: touch $@ - then it make all
> sense again.
> 
> 	Sam
> 
> ===== drivers/scsi/aic7xxx/Makefile 1.21 vs edited =====
> --- 1.21/drivers/scsi/aic7xxx/Makefile	Fri May  2 20:04:40 2003
> +++ edited/drivers/scsi/aic7xxx/Makefile	Fri Sep  5 21:14:01 2003
> @@ -58,7 +58,13 @@
>  	-p $(obj)/aic7xxx_reg_print.c -i aic7xxx_osm.h
>  
>  ifeq ($(CONFIG_AIC7XXX_BUILD_FIRMWARE),y)
> -$(aic7xxx-gen-y): $(src)/aic7xxx.seq $(src)/aic7xxx.reg $(obj)/aicasm/aicasm
> +$(aic7xxx-gen-y): $(src)/aic7xxx.seq $(src)/aic7xxx.reg
> +$(aic7xxx-gen-y): doaic7xasm
> +
> +.PHONY: doaic7xasm
> +$(aic7xxx-gen-y): doaic7xasm
> +
> +doaic7xasm: $(obj)/aicasm/aicasm
>  	$(obj)/aicasm/aicasm -I$(src) -r $(obj)/aic7xxx_reg.h \
>  			      $(aicasm-7xxx-opts-y) -o $(obj)/aic7xxx_seq.h \
>  			      $(src)/aic7xxx.seq
> @@ -72,7 +78,12 @@
>  	-p $(obj)/aic79xx_reg_print.c -i aic79xx_osm.h
>  
>  ifeq ($(CONFIG_AIC79XX_BUILD_FIRMWARE),y)
> -$(aic79xx-gen-y): $(src)/aic79xx.seq $(src)/aic79xx.reg $(obj)/aicasm/aicasm
> +$(aic79xx-gen-y): $(src)/aic79xx.seq $(src)/aic79xx.reg
> +
> +.PHONY: doaic79asm
> +$(aic79xx-gen-y): doaic79asm
> +
> +doaic79asm: $(obj)/aicasm/aicasm
>  	$(obj)/aicasm/aicasm -I$(src) -r $(obj)/aic79xx_reg.h \
>  			      $(aicasm-79xx-opts-y) -o $(obj)/aic79xx_seq.h \
>  			      $(src)/aic79xx.seq
> ===== drivers/scsi/aic7xxx/aicasm/Makefile 1.11 vs edited =====
> --- 1.11/drivers/scsi/aic7xxx/aicasm/Makefile	Tue Mar 11 01:57:17 2003
> +++ edited/drivers/scsi/aic7xxx/aicasm/Makefile	Fri Sep  5 21:02:54 2003
> @@ -49,14 +49,18 @@
>  clean:
>  	rm -f $(clean-files)
>  
> -aicasm_gram.c aicasm_gram.h: aicasm_gram.y
> +aicasm_gram.c: aicasm_gram.h 
> +	mv $(<:.h=).tab.c $(<:.h=.c)
> +
> +aicasm_gram.h: aicasm_gram.y
>  	$(YACC) $(YFLAGS) -b $(<:.y=) $<
> -	mv $(<:.y=).tab.c $(<:.y=.c)
>  	mv $(<:.y=).tab.h $(<:.y=.h)
>  
> -aicasm_macro_gram.c aicasm_macro_gram.h: aicasm_macro_gram.y
> +aicasm_macro_gram.c: aicasm_macro_gram.h
> +	mv $(<:.h=).tab.c $(<:.h=.c)
> +
> +aicasm_macro_gram.h: aicasm_macro_gram.y
>  	$(YACC) $(YFLAGS) -b $(<:.y=) -p mm $<
> -	mv $(<:.y=).tab.c $(<:.y=.c)
>  	mv $(<:.y=).tab.h $(<:.y=.h)
>  
>  aicasm_scan.c: aicasm_scan.l
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

