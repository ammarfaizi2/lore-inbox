Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbTIEQgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 12:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbTIEQgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 12:36:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:31645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262718AbTIEQgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 12:36:43 -0400
Subject: Re: [TRIVIAL][PATCH] fix parallel builds for aic7xxx]
From: John Cherry <cherry@osdl.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: trivial@rustcorp.com.au,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <59600000.1062714135@aslan.btc.adaptec.com>
References: <1062698342.9322.73.camel@cherrytest.pdx.osdl.net>
	 <59600000.1062714135@aslan.btc.adaptec.com>
Content-Type: multipart/mixed; boundary="=-t66FG6AYhGT1fhfS89PE"
Organization: 
Message-Id: <1062779785.12723.41.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 05 Sep 2003 09:36:25 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t66FG6AYhGT1fhfS89PE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Short story: 

The makefile changes separate targets with identical dependencies.  In
the current Makefiles, things like "running the assembler" and "changing
file names" happen multiple times in parallel when building with
anything other than -j1.  Consider the following example Makefile:

targ: a b
a b: x
        touch a b
x:
        touch x
clean:
        rm a b x

Running the build with "make targ" yields:
touch x
touch a b

Running the build with "make -j2 targ" yields:
touch x
touch a b
touch a b

Notice that the "touch a b" output is not only executed twice, but on an
SMP machine, it could be run in parallel (with races).  These two
patches separate the targets with the same dependencies and prevent
these races.  I would actually consider this to be a bug in make, but
that is another story.

Long story:

Based on the explanation above, I have attached the output of the
aic7xxx build running it with -j1 and with -j2.  You can clearly see the
problems with parallel race conditions.

In the simplistic example above, this how I would change the Makefile to
avoid the parallel race.

targ: a b
a: x
        touch a
b: x
	touch b
x:
        touch x
clean:
        rm a b x

Please apply the patch.  It prevents broken builds when running with
anything other than -j1 and it does just what I have shown above.  BTW,
sometimes you get lucky and the build succeeds with a parallel build.

John


On Thu, 2003-09-04 at 15:22, Justin T. Gibbs wrote:
> > 
> > My compile regression scripts were getting random build failures for
> > aic7xxx.  The two makefiles could not handle parallel build. 
> > Occasionally they would succeed...timing dependent.  The following two
> > patches fix this.
> > 
> > Part 1 - drivers/scsi/aic7xxx/Makefile
> 
> I don't understand this patch.  It places the .seq file as a target
> that is rebuilt by invoking the assembler.  The .seq file is not
> a generated file.
> 
> Can you explain the nature of the failure and why you believe this
> fixes the problem (other than - "it seems to work with my testing").
> The previous Makefile appears to be perfectly valid.
> 
> > Part 2 - drivers/scsi/aic7xxx/aicasm/Makefile
> 
> This also doesn't make a lot of sense to me.  Is gmake so
> dumb as to not be able to understand that the invocation of
> a single target may satisfy multiple dependencies?
> 
> --
> Justin

--=-t66FG6AYhGT1fhfS89PE
Content-Disposition: attachment; filename=output.j1
Content-Type: text/plain; name=output.j1; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

make -C drivers/scsi/aic7xxx/aicasm
yacc -d -b aicasm_gram aicasm_gram.y
mv aicasm_gram.tab.c aicasm_gram.c
mv aicasm_gram.tab.h aicasm_gram.h
yacc -d -b aicasm_macro_gram -p mm aicasm_macro_gram.y
mv aicasm_macro_gram.tab.c aicasm_macro_gram.c
mv aicasm_macro_gram.tab.h aicasm_macro_gram.h
lex  -oaicasm_scan.c aicasm_scan.l
lex  -Pmm -oaicasm_macro_scan.c aicasm_macro_scan.l
gcc -I/usr/include -I. aicasm.c aicasm_symbol.c aicasm_gram.c aicasm_macro_gram.c aicasm_scan.c aicasm_macro_scan.c -o aicasm -ldb
drivers/scsi/aic7xxx/aicasm/aicasm -Idrivers/scsi/aic7xxx -r drivers/scsi/aic7xxx/aic79xx_reg.h \
		      -p drivers/scsi/aic7xxx/aic79xx_reg_print.c -i aic79xx_osm.h -o drivers/scsi/aic7xxx/aic79xx_seq.h \
		      drivers/scsi/aic7xxx/aic79xx.seq
drivers/scsi/aic7xxx/aicasm/aicasm: 785 instructions used
  CC [M]  drivers/scsi/aic7xxx/aic79xx_core.o
  CC [M]  drivers/scsi/aic7xxx/aic79xx_pci.o
  CC [M]  drivers/scsi/aic7xxx/aic79xx_reg_print.o
  CC [M]  drivers/scsi/aic7xxx/aic79xx_osm.o
  CC [M]  drivers/scsi/aic7xxx/aic79xx_proc.o
  CC [M]  drivers/scsi/aic7xxx/aic79xx_osm_pci.o
drivers/scsi/aic7xxx/aicasm/aicasm -Idrivers/scsi/aic7xxx -r drivers/scsi/aic7xxx/aic7xxx_reg.h \
		      -p drivers/scsi/aic7xxx/aic7xxx_reg_print.c -i aic7xxx_osm.h -o drivers/scsi/aic7xxx/aic7xxx_seq.h \
		      drivers/scsi/aic7xxx/aic7xxx.seq
drivers/scsi/aic7xxx/aicasm/aicasm: 879 instructions used
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_core.o
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_93cx6.o
  CC [M]  drivers/scsi/aic7xxx/aic7770.o
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_pci.o
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_reg_print.o
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_osm.o
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_proc.o
  CC [M]  drivers/scsi/aic7xxx/aic7770_osm.o
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_osm_pci.o
  LD [M]  drivers/scsi/aic7xxx/aic7xxx.o
  LD [M]  drivers/scsi/aic7xxx/aic79xx.o
  Building modules, stage 2.

--=-t66FG6AYhGT1fhfS89PE
Content-Disposition: attachment; filename=output.j2
Content-Type: text/plain; name=output.j2; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

make -C drivers/scsi/aic7xxx/aicasm
yacc -d -b aicasm_gram aicasm_gram.y
yacc -d -b aicasm_macro_gram -p mm aicasm_macro_gram.y
mv aicasm_macro_gram.tab.c aicasm_macro_gram.c
mv aicasm_macro_gram.tab.h aicasm_macro_gram.h
yacc -d -b aicasm_gram aicasm_gram.y
mv aicasm_gram.tab.c aicasm_gram.c
mv aicasm_gram.tab.h aicasm_gram.h
lex  -oaicasm_scan.c aicasm_scan.l
mv aicasm_gram.tab.c aicasm_gram.c
lex  -Pmm -oaicasm_macro_scan.c aicasm_macro_scan.l
mv: can't stat source aicasm_gram.tab.c
make[2]: [aicasm_gram.c] Error 1 (ignored)
mv aicasm_gram.tab.h aicasm_gram.h
mv: can't stat source aicasm_gram.tab.h
make[2]: [aicasm_gram.c] Error 1 (ignored)
gcc -I/usr/include -I. aicasm.c aicasm_symbol.c aicasm_gram.c aicasm_macro_gram.c aicasm_scan.c aicasm_macro_scan.c -o aicasm -ldb
drivers/scsi/aic7xxx/aicasm/aicasm -Idrivers/scsi/aic7xxx -r drivers/scsi/aic7xxx/aic79xx_reg.h \
		      -p drivers/scsi/aic7xxx/aic79xx_reg_print.c -i aic79xx_osm.h -o drivers/scsi/aic7xxx/aic79xx_seq.h \
		      drivers/scsi/aic7xxx/aic79xx.seq
drivers/scsi/aic7xxx/aicasm/aicasm -Idrivers/scsi/aic7xxx -r drivers/scsi/aic7xxx/aic79xx_reg.h \
		      -p drivers/scsi/aic7xxx/aic79xx_reg_print.c -i aic79xx_osm.h -o drivers/scsi/aic7xxx/aic79xx_seq.h \
		      drivers/scsi/aic7xxx/aic79xx.seq
drivers/scsi/aic7xxx/aicasm/aicasm: 785 instructions used
drivers/scsi/aic7xxx/aicasm/aicasm -Idrivers/scsi/aic7xxx -r drivers/scsi/aic7xxx/aic79xx_reg.h \
		      -p drivers/scsi/aic7xxx/aic79xx_reg_print.c -i aic79xx_osm.h -o drivers/scsi/aic7xxx/aic79xx_seq.h \
		      drivers/scsi/aic7xxx/aic79xx.seq
drivers/scsi/aic7xxx/aicasm/aicasm: 785 instructions used
drivers/scsi/aic7xxx/aicasm/aicasm -Idrivers/scsi/aic7xxx -r drivers/scsi/aic7xxx/aic7xxx_reg.h \
		      -p drivers/scsi/aic7xxx/aic7xxx_reg_print.c -i aic7xxx_osm.h -o drivers/scsi/aic7xxx/aic7xxx_seq.h \
		      drivers/scsi/aic7xxx/aic7xxx.seq
drivers/scsi/aic7xxx/aicasm/aicasm: 879 instructions used
drivers/scsi/aic7xxx/aicasm/aicasm -Idrivers/scsi/aic7xxx -r drivers/scsi/aic7xxx/aic7xxx_reg.h \
		      -p drivers/scsi/aic7xxx/aic7xxx_reg_print.c -i aic7xxx_osm.h -o drivers/scsi/aic7xxx/aic7xxx_seq.h \
		      drivers/scsi/aic7xxx/aic7xxx.seq
drivers/scsi/aic7xxx/aicasm/aicasm: 785 instructions used
drivers/scsi/aic7xxx/aicasm/aicasm -Idrivers/scsi/aic7xxx -r drivers/scsi/aic7xxx/aic7xxx_reg.h \
		      -p drivers/scsi/aic7xxx/aic7xxx_reg_print.c -i aic7xxx_osm.h -o drivers/scsi/aic7xxx/aic7xxx_seq.h \
		      drivers/scsi/aic7xxx/aic7xxx.seq
drivers/scsi/aic7xxx/aicasm/aicasm: 879 instructions used
  CC [M]  drivers/scsi/aic7xxx/aic79xx_core.o
drivers/scsi/aic7xxx/aicasm/aicasm: 879 instructions used
  CC [M]  drivers/scsi/aic7xxx/aic79xx_pci.o
  CC [M]  drivers/scsi/aic7xxx/aic79xx_reg_print.o
  CC [M]  drivers/scsi/aic7xxx/aic79xx_osm.o
  CC [M]  drivers/scsi/aic7xxx/aic79xx_proc.o
  CC [M]  drivers/scsi/aic7xxx/aic79xx_osm_pci.o
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_core.o
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_93cx6.o
  CC [M]  drivers/scsi/aic7xxx/aic7770.o
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_pci.o
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_reg_print.o
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_osm.o
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_proc.o
  CC [M]  drivers/scsi/aic7xxx/aic7770_osm.o
  CC [M]  drivers/scsi/aic7xxx/aic7xxx_osm_pci.o
  LD [M]  drivers/scsi/aic7xxx/aic7xxx.o
  LD [M]  drivers/scsi/aic7xxx/aic79xx.o
  Building modules, stage 2.

--=-t66FG6AYhGT1fhfS89PE--

