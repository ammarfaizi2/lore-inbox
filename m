Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262954AbUDPMIi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 08:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUDPMIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 08:08:35 -0400
Received: from sigma.informatik.hu-berlin.de ([141.20.20.51]:31893 "EHLO
	sigma.informatik.hu-berlin.de") by vger.kernel.org with ESMTP
	id S262954AbUDPMIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 08:08:17 -0400
From: Axel Weiss <aweiss@informatik.hu-berlin.de>
Organization: Humboldt-Universitaet zu Berlin
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: compiling external modules
Date: Fri, 16 Apr 2004 14:06:17 +0200
User-Agent: KMail/1.5.4
References: <200404152305.49456.aweiss@informatik.hu-berlin.de> <20040415215907.GD2656@mars.ravnborg.org>
In-Reply-To: <20040415215907.GD2656@mars.ravnborg.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404161406.17241.aweiss@informatik.hu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Sam,

I have patched to 2.6.6-rc1 (patch-2.6.6-rc1 over kernel 2.6.5 - am I right or 
am I missing some patches in between?), and now symbol exports between 
modules fails. An example with two module-objects - one exports some symbols 
used by the other - shows compile output:

scripts/Makefile.build:36: kbuild: /home/axel/freeSP-1.0.4/drivers/linux/
adc64/busmaster/Makefile - Usage of export-objs is obsolete in 2.6. Please 
fix!

8<

*** Warning: "adc64_count" [/home/axel/freeSP-1.0.4/drivers/linux/adc64/
driver/adc64.ko] undefined!
*** Warning: "release_adc64_busmaster" [/home/axel/freeSP-1.0.4/drivers/linux/
adc64/driver/adc64.ko] undefined!
*** Warning: "get_adc64_busmaster" [/home/axel/freeSP-1.0.4/drivers/linux/
adc64/driver/adc64.ko] undefined!

8<

The first (exporting) module loads cleanly (lsmod shows the loaded module), 
but insmod'ing the second fails with:

insmod: error inserting './adc64.ko': -1 Unknown symbol in module

What's the trick in 2.6.6?

Regards,
Axel

On Thursday 15 April 2004 23:59, Sam Ravnborg wrote:
> On Thu, Apr 15, 2004 at 11:05:49PM +0200, Axel Weiss wrote:
> > Hi,
> >
> > after some study of kernel Makefiles, I'm able now to compile externel
> > modules for both, 2.4 and 2.6 kernels correctly. I'd like to share my
> > Makefiles here, maybe somebody finds them useful.
>
> Thanks.
>
> > 2.6-compilation of drivers consisting of more than one module leaded to
> > very ugly warnings from scripts/Makefile.modpost, when make was invoked
> > after 'make clean'. The reason were lying-around objects in .tmp_versions
> > directory which were not deleted by 'make clean'. Solution: clean must
> > explicitly delete the version-object in .tmp_versions.
>
> With 2.6.5-rc1 the warning are gone.
>
> > 2.4-compilation requires inclusion of Rules.make and an additional rule
> > for module-object linkage. In 2.6 Rules.make does not exist, and the
> > linking rule would conflict with an already defined one. Solution:
> > distinct current kernel version.
>
> You should be able to use:
> -include Rules.make
>
> See 'info make' - look after the include directive.
>
> > When I gave the rule:
> > clean:
> > 	$(MAKE) -C $(KDIR) SUBDIRS=$(PWD) clean
> > the whole kernel tree was cleaned. This is not my intention, when I'm
> > working on external modules and want to make clean e.g. for cvs commits.
> > So I defined my own clean rule, kicking away everything but source files.
>
> With 2.6.5-rc1 this will only cause files in the $(PWD) dir to be deleted,
> not the kernel tree.
>
> > So far the difficulties. Next I propose an assumption about filenames,
> > when a module consists of several objects which will be linked together.
> > Let <module-name> be a basic name for the module, so <module-name>.(k)o
> > (with k for 2.6, without for 2.4) will be the final target. I assume that
> > all elementary object-filenames begin with <module-name>, for
> > clarification. E.g. the module adc64.ko is composed of adc64_module.o,
> > adc64_device.o, adc64_io.o and so on. Generally, the name of an object is
> > <module-name>_<object-name>.o, and the object-names can be collected in a
> > symbol <module-name>-obj-names. Some objects may export symbols to other
> > modules, they can be collected in a <module-name>-exp-names list.
>
> I really do not see the benefit compared to the current more free
> naming scheme - which works.
>
> > Finally, all the modules' Makefiles were very similar, so I split them
> > into two files: one Makefile for every module and a common
> > Makefile.module which is included by each Makefile. Each module-specific
> > Makefile contains the definition of
> > - <module-name>
> > - <module-name>-obj-names
> > - <module-name>-exp-names
> > - EXTRA_CFLAGS
> > which makes up all information Makfile.module needs.
>
> The general feedback is that it looks like you have
> made it less simple than it ought to be.
>
> You should also consider that you end up with files
> that does not look like ordinary kbuild makefiles.
>
> When I get some spare time I will try to come up with a simpler example.
>
> 	Sam
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

