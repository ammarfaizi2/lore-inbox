Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267962AbUHEU6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267962AbUHEU6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUHEU5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:57:43 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:29022 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S267973AbUHEUwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:52:30 -0400
Date: Thu, 5 Aug 2004 22:54:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andi Kleen <ak@suse.de>
Cc: Tom Duffy <tduffy@sun.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix x86_64 build of mmconfig.c
Message-ID: <20040805205401.GB22342@mars.ravnborg.org>
Mail-Followup-To: Andi Kleen <ak@suse.de>,
	Tom Duffy <tduffy@sun.com>, linux-kernel@vger.kernel.org
References: <1091728096.10131.16.camel@duffman> <20040805223205.3dd2ee1a.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805223205.3dd2ee1a.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 10:32:05PM +0200, Andi Kleen wrote:
> On Thu, 05 Aug 2004 10:48:16 -0700
> Tom Duffy <tduffy@sun.com> wrote:
> 
> > Signed-by: Tom Duffy <tduffy@sun.com>
> > 
> >   gcc -Wp,-MD,arch/x86_64/pci/.mmconfig.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude -Iinclude2 -I/build1/tduffy/openib-work/linux-2.6.8-rc3-openib/include -I/build1/tduffy/openib-work/linux-2.6.8-rc3-openib/arch/x86_64/pci -Iarch/x86_64/pci -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -mno-red-zone -mcmodel=kernel -pipe -fno-reorder-blocks -Wno-sign-compare -fno-asynchronous-unwind-tables -O2 -fomit-frame-pointer -Wdeclaration-after-statement -I/build1/tduffy/openib-work/linux-2.6.8-rc3-openib/ -I arch/i386/pci  -DKBUILD_BASENAME=mmconfig -DKBUILD_MODNAME=mmconfig -c -o arch/x86_64/pci/mmconfig.o /build1/tduffy/openib-work/linux-2.6.8-rc3-openib/arch/x86_64/pci/mmconfig.c
> > /build1/tduffy/openib-work/linux-2.6.8-rc3-openib/arch/x86_64/pci/mmconfig.c:10:17: pci.h: No such file or directory
> > 
> > --- arch/x86_64/pci/Makefile.orig	2004-08-05 09:54:24.932007000 -0700
> > +++ arch/x86_64/pci/Makefile	2004-08-05 09:53:53.171006000 -0700
> > @@ -3,7 +3,7 @@
> >  #
> >  # Reuse the i386 PCI subsystem
> >  #
> > -CFLAGS += -I arch/i386/pci
> > +CFLAGS += -Iarch/i386/pci
> 
> It never failed this way for me in hundreds of builds. Why is it failing for you? 
> What gcc version do you use? 
> 
> Normally -Ifoo and -I foo should be really equivalent.

Notice the originally poster uses the make O=dir syntax - visible from the include2
directory being present on the commandline.

This issue is kbuild related. When using 'make O=dir' syntax kbuild process
options passed to gcc, and all -Isomething are processed.
Whitin the limits of the make syntax it it not easy to handle -I something.
When I originally implemented this I grepped the kernel and did not
find any uses of -I something, but only -Isomething.
I may easy have overlooked one.

And to the easy answer: fix kbuild.
If anyone can see a way to fix this using make syntax please let me know. I did not
find the answer.
The lines to pay attention to are in Makefile.lib where cflags are processed.

Escaping to a shell is no option since this would be needed for all .o files
even in an otherwise noop build.
That's because all flags has to be evaluated each time to check if the flags changed.

	Sam
