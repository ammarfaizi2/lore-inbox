Return-Path: <linux-kernel-owner+w=401wt.eu-S1760334AbWLJHZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760334AbWLJHZN (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 02:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760335AbWLJHZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 02:25:13 -0500
Received: from colo.lackof.org ([198.49.126.79]:45636 "EHLO colo.lackof.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760334AbWLJHZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 02:25:11 -0500
Date: Sun, 10 Dec 2006 00:25:08 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Greg KH <greg@kroah.com>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>,
       e1000-devel@lists.sourceforge.net, linux-scsi@vger.kernel.org,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH 1/5] Update Documentation/pci.txt
Message-ID: <20061210072508.GA12272@colo.lackof.org>
References: <456404E2.1060102@jp.fujitsu.com> <20061122182804.GE378@colo.lackof.org> <45663EE8.1080708@jp.fujitsu.com> <20061124051217.GB8202@colo.lackof.org> <20061206072651.GG17199@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061206072651.GG17199@kroah.com>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 11:26:51PM -0800, Greg KH wrote:
...
> I do have a few minor comments:
...
> > Please mark the initialization and cleanup functions where appropriate
> > (the corresponding macros are defined in <linux/init.h>):
> > 
> > 	__init		Initialization code. Thrown away after the driver
> > 			initializes.
> > 	__exit		Exit code. Ignored for non-modular drivers.
> > 	__devinit	Device initialization code. Identical to __init if
> > 			the kernel is not compiled with CONFIG_HOTPLUG, normal
> > 			function otherwise.
> > 	__devexit	The same for __exit.
> > 
> > Tips on marks:
> > 	o The module_init()/module_exit() functions (and all initialization
> >           functions called _only_ from these) should be marked __init/__exit.
> > 
> > 	o The struct pci_driver shouldn't be marked with any of these tags.
> > 
> > 	o The ID table array should be marked __devinitdata.
> > 
> > 	o The probe() and remove() functions (and all initialization
> > 	  functions called only from these) should be marked __devinit
> > 	  and __devexit.
> > 
> > 	o If the driver is not a hotplug driver then use only
> > 	  __init/__exit and __initdata/__exitdata.
> 
> No, don't say this, pci drivers are not "hotplug drivers",

agreed - removed that bullet item.

> and since CONFIG_HOTPLUG is really hard to turn off these days,
> don't confuse people with the devinit stuff.  Everyone gets it wrong...

While revisiting this bit, I started thinking:

o While I agree HOTPLUG is essential to desktop and server,
  I don't think that's true for "embedded" (e.g. routers/switches).

o drivers should use __dev* exactly because HOTPLUG is defined.

o Why does everyone get __dev* wrong? Bad API? Missing or bad Documentation?
  [ This is not a free-for-all...I'd like a clear answer from
  Greg what would help driver writers get this right. ]

o Prefer a seperate patch to clean this up?
  Take what I have for now and sort out the __devinit handling in
  another round?

o Note what I have is essentially the original text - just reformatted
  to be a bit more readable.

o Hrm...what did greg mean with "it"? All of the markers?
  Or just the __dev* markers?

> > 	o Pointers to functions marked as __devexit must be created using
> > 	  __devexit_p(function_name).  That will generate the function
> > 	  name or NULL if the __devexit function will be discarded.
> 
> I really recommend just not using any of these for almost all PCI
> drivers, as the space savings just really isn't there...

It's a bit too late for that, no?
And even if it's more of a PITA than it's worth, we do save something:

# hppa64-linux-gnu-readelf -S vmlinux
...
 [26] .init.text        PROGBITS         0000000040598000  00457000
      0000000000022280  0000000000000000  AX       0     0     8
 [27] .init.data        PROGBITS         00000000405ba280  00479280
      000000000001faf0  0000000000000000  WA       0     0     8
...

Reality is they are used in _alot_ of drivers.
I checked 2.6.19:
grundler <514>find -name \*.c | xargs fgrep __devinit | wc
   2723   16812  235863

I'd prefer to keep the short references here if you
don't mind too much. At least until you can get some
consensus that __init and __exit should go away
or get replaced by easier-to-get-right markers.

thanks,
grant
