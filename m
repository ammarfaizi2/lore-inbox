Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262337AbUKQPAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbUKQPAy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 10:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262339AbUKQPAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 10:00:54 -0500
Received: from postino3.roma1.infn.it ([141.108.26.5]:25824 "EHLO
	postino3.roma1.infn.it") by vger.kernel.org with ESMTP
	id S262337AbUKQPAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 10:00:41 -0500
Subject: Re: isa memory address
From: Antonino Sergi <Antonino.Sergi@roma1.infn.it>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1100622139.16321.217.camel@delphi.roma1.infn.it>
References: <1099901664.2718.92.camel@delphi.roma1.infn.it>
	 <418FA2F1.2090003@osdl.org>
	 <1100014956.30102.54.camel@delphi.roma1.infn.it>
	 <Pine.LNX.4.58L.0411091638570.9795@blysk.ds.pg.gda.pl>
	 <1100079437.30102.66.camel@delphi.roma1.infn.it>
	 <Pine.LNX.4.58L.0411110329260.10663@blysk.ds.pg.gda.pl>
	 <1100622139.16321.217.camel@delphi.roma1.infn.it>
Content-Type: text/plain
Message-Id: <1100703633.2090.11.camel@delphi.roma1.infn.it>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 16:00:33 +0100
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.28.0.12; VDF 6.28.0.77
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I made another test: I tried the same compiled kernel version on both
machines (P233MMX and PIII500) without any other module loaded and I
still have different behavior, as described in my previous e-mail, so it
should be some hardware difference, but I don't know.

Thank you for any suggestion

Antonino Sergi  


On Tue, 2004-11-16 at 17:22, Antonino Sergi wrote:
> Hi,
> 
> I found a new problem: I was testing my driver on a P233MMX with
> 2.6.5 i586 compiled without any trouble. When I moved to a PIII500
> with the 2.6.9 i686 compiled I got kernel oops because the IOaddresss
> (0xd0000) was remapped to 0x20d0000 and
> "Unable to handle kernel paging request at virtual address fef66c58"
> I think it is something related to 4GB memory kernel config parameter
> 
> Because of some hurry I tried the other kernel (2.6.9 i586 compiled)
> and this problem disappeared (IOaddresss 0xd0000 remapped to
> 0xc00d0000), but it seems that the requested memory area is not
> protected anymore by foreign access, in fact:
> -on both machines, if the kernel module is not loaded, I can see, on
> hard disk activity, a blinking LED on the data acquisition system,
> notifying some access to the device
> -on P233MMX and NOT on PIII500, once the module is loaded, these
> accidental accesses are actually forbidden. This produces, on PIII500,
> fake data
> 
> Is there any remarkable difference in resource reservation between these
> two kernels or it is due to some hardware difference? I tried to look at
> include/linux/ioport.h and kernel/resource.c but I could not notice any
> difference.
> 
> Thank you
> 
> Antonino Sergi
> 
> On Thu, 2004-11-11 at 04:54, Maciej W. Rozycki wrote:
> > On Wed, 10 Nov 2004, Antonino Sergi wrote:
> > 
> > > >  Because you are trying to use the region in the I/O port space.  That's
> > > > probably not what you want to do and an 8-bit ISA board cannot decode it
> > > > at all anyway.  Actually for some platforms using the I/O space outside
> > > > the low 16-bit range may be quite difficult even for buses and devices
> > > > that support it and Linux does not support it then, either.  So Linux 
> > > > correctly informs you you cannot use that range.
> > > 
> > > This is actually not clear for me.
> > 
> >  The port I/O space range differs among platforms.  You get -EBUSY in a
> > response to a request for a range of ports outside the supported range.
> > 
> > > >  ... or better yet request_mem_region()/release_resource(), as the former 
> > > > is deprecated and will be removed.
> > > 
> > > I tried but (on 2.4.2):
> > > - request_region fails but, ignoring it and remapping physical address
> > > to virtual, everything works fine, except for release_region, of course.
> > > - request_mem_region works but what I get from communication with the
> > > actual device are numbers that sometimes are surely wrong.
> > 
> >  As both request_region() and request_mem_region() merely reserve
> > different resources in Linux structures, you can't get a different
> > behavior from your device depending on which one you call, if any at all,
> > unless you change code elsewhere at the same time.
> > 
> > > I couldn't understand what is the actual difference between
> > > ioport_resource and iomem_resource to track the problem.
> > 
> >  The former holds I/O resources mapped in the port space, whilst the
> > latter holds ones mapped in the memory space.  The spaces use different
> > cycles each at the bus the destined device is located on.
> > 
> >   Maciej

