Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVDEPip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVDEPip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 11:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVDEPgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 11:36:10 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:58014 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261787AbVDEPbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 11:31:16 -0400
Date: Tue, 5 Apr 2005 11:31:04 -0400
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>,
       Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
       Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/04] Load keyspan firmware with hotplug
Message-ID: <20050405153104.GB31572@delft.aura.cs.cmu.edu>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <greg@kroah.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
	debian-kernel@lists.debian.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050404100929.GA23921@pegasos> <20050404191745.GB12141@kroah.com> <20050405042329.GA10171@delft.aura.cs.cmu.edu> <200504042351.22099.dtor_core@ameritech.net> <1112692926.8263.125.camel@pegasus> <20050405114543.GG10171@delft.aura.cs.cmu.edu> <1112711791.12406.26.camel@notepaq>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112711791.12406.26.camel@notepaq>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 04:36:31PM +0200, Marcel Holtmann wrote:
> > > I agree with Dmitry on this point. The IHEX parser should not be inside
> > > firmware_class.c. What about using keyspan_ihex.[ch] for it?
> > 
> > That's what I had originally, actually called firmware_ihex.ko, since
> > the IHEX format parser is not in any way keyspan specific and there are
> > several usb-serial converters that seem to use the same IHEX->.h trick
> > which could trivially be modified to use this loader.
> > 
> > But the compiled parser fairly small (< 2KB) and adding it to the
> > existing module didn't effectively add any size to the firmware_class
> > module since things are rounded to a page boundary anyways.
> 
> so it seems that this is usb-serial specific at the moment. Then I would

I really don't see the point you are trying to argue. I said, sure it is
possible to make it a separate module, that is what my initial
implementation was. Why do you want to pigeon-hole it with anything but
the existing firmware loading code?

It is _not_ usb-serial specific, in fact once the device is initialized
this isn't even needed. And the initialization as far as I can see uses
little or no usb-serial code.

It happens that many usb-serial devices are built around the ezusb
chipset, which in turn seems to be a 8051-based microcontroller. The
compilers for such microcontrollers seem to generate IHEX formatted
output possibly because eprom burners generally support the format.

> it up at the moment. People are also working on a replacement for the
> current request_firmware(), because the needs are changing. Try to keep
> it close with the usb-serial for now.

What? I find the existing request_firmware fairly simple and
straightforward, it has a very KISS-like quality to it, it is nice and
small and even the userspace support is trivial. I only saw a mention
about 'replacing' it in the current thread which mostly involved
complaints but didn't actually see anyone volunteering to start working
on such a replacement.

If a driver wants to load 5 different chunks, just call request_firmware
5 times (i.e. drivers/bluetooth/bcm203x.c). If the data is a single
binary blob, just ask for the single binary blob. In this case there
seems to be some structure to the blob that I wanted to preserve, and
that would either be some custom binary format that contains
[<address><length><data>]... tuples, which ofcourse causes problems for
our big-endian brothers, or a similar ascii format, where the IHEX is
not only pretty much standardized, it is trivial to parse and even adds
checksum information.

The only thing that I see missing right now is a change to the makefiles
to have in-tree firmware files get installed in /lib/modules/`uname
-r`/firmware or some similar place. Ideally people would add a line
like,

    fw-$(CONFIG_FOO) = foo-firmware-blob.fw

And make install could drop it a place where hotplug can find it.

Jan

