Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030450AbWAXK7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030450AbWAXK7L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 05:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbWAXK7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 05:59:10 -0500
Received: from soundwarez.org ([217.160.171.123]:64475 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1030448AbWAXK7J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 05:59:09 -0500
Date: Tue, 24 Jan 2006 11:58:57 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: uevent buffer overflow in input layer
Message-ID: <20060124105857.GA9210@vrfy.org>
References: <1137973421.4907.14.camel@localhost.localdomain> <20060124050346.GC22848@kroah.com> <200601240101.21238.dtor_core@ameritech.net> <20060124060741.GA23869@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124060741.GA23869@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 10:07:41PM -0800, Greg KH wrote:
> On Tue, Jan 24, 2006 at 01:01:19AM -0500, Dmitry Torokhov wrote:
> > On Tuesday 24 January 2006 00:03, Greg KH wrote:
> > > On Mon, Jan 23, 2006 at 10:43:41AM +1100, Benjamin Herrenschmidt wrote:
> > > > Current -git as of today does this on an x86 box with a logitech USB
> > > > keyboard:
> > > > 
> > > > (the $$$ is debug stuff I added to print_modalias(), size is the size
> > > > passed in and "Total len" is the value of "len" before returning). We
> > > > end up overflowing, thus we pass a negative size to snprintf which
> > > > causes the WARN_ON. Bumping the uevent buffer size in lib/kobject_uevent.c
> > > > from 1024 to 2048 seems to fix the oops and /dev/input/mice is now properly
> > > > created and works (it doesn't without the fix, X fails and we end up back
> > > > in console with a dead keyboard).
> > > > 
> > > > I'm not sure it's the correct solution as I'm not too familiar with the
> > > > uevent code though, so I'll let you guys decide on the proper approach.
> > > 
> > > Yes, input has some big strings, I'd recommend bumping it up like you
> > > suggest.
> > > 
> > > Care to make up a patch as you found the problem and should get the
> > > credit?  :)

Yes, sounds sane, to double the sizes of BUFFER_SIZE and NUM_ENVP in
lib/kobject_uevent.c. I'll do the same for udev now.

> > Actually, is it too late to convert modalias data to the same format
> > (bitmap) we are using in /proc/bus/input/devices (keeping cutting key
> > info at KEY_MIN_INTERESTING)? It looks like it will be more compact
> > and let us keep 1024 bytes buffer...
> 
> I don't think so, but Kay knows best about this.  Kay?

Sure, that's fine to change. Nobody besides modprobe should be interested in
the content of the string. We just pass it back to modprobe which matches
against the depmod generated list in /lib/modules/<2.6.16...>/modules.alias
to find the modules to load. If you make sure that modprobe $MODALIAS still
loads the right modules, everything should be fine.

Both changes sounds good to me, please do.

Thanks,
Kay
