Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUAaSPp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 13:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbUAaSPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 13:15:45 -0500
Received: from buerotecgmbh.de ([217.160.181.99]:3459 "EHLO buerotecgmbh.de")
	by vger.kernel.org with ESMTP id S265045AbUAaSPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 13:15:34 -0500
Date: Sat, 31 Jan 2004 19:15:59 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Greg KH <greg@kroah.com>, linux-hotplug-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] udev 015 release
Message-ID: <20040131181559.GA22442@vrfy.org>
References: <20040126215036.GA6906@kroah.com> <1075395125.7680.21.camel@nosferatu.lan> <20040129215529.GB9610@kroah.com> <20040131031718.GA21129@vrfy.org> <1075571697.7232.11.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1075571697.7232.11.camel@nosferatu.lan>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 07:54:57PM +0200, Martin Schlemmer wrote:
> On Sat, 2004-01-31 at 05:17, Kay Sievers wrote:
> > On Thu, Jan 29, 2004 at 01:55:29PM -0800, Greg KH wrote:
> > > On Thu, Jan 29, 2004 at 06:52:05PM +0200, Martin Schlemmer wrote:
> > > > On Mon, 2004-01-26 at 23:50, Greg KH wrote:
> > > > 
> > > > Is there a known issue that the daemon do not spawn?
> > > 
> > > Hm, I don't know.  This code is under major flux right now...
> > 
> > Hi Martin,
> > sorry, the code in the tree doesn't work.
> > I decided to try pthreads, cause I gave up with the I/O multiplexing,
> > forking and earning SIGCHLDS for manipulating the global lists.
> > 
> > The multithreaded udevd takes multiple events at the same time on a unix
> > domain socket, sorts it in a linked list and handles the timeouts if
> > events are missing.
> > It executes our current udev in the background and delays the execution
> > for events with the same DEVPATH. So we serialize the events only for
> > different devices.
> > 
> > I've posted the latest patch to the list a few minutes ago.
> > If you like, I'm happy to hear from your testing :)
> > 
> > If we decide not to stay with the threads model, cause klibc doesn't
> > support it now and ..., we at least have a working model to implement
> > in a different way.
> > 
> 
> Thanks - I wanted to have a go at it, but after not working, wanted to
> check if it might be my setup, or known issue ...  I will see if I can
> get time to test your latest patch - anything specific you need testing
> of ?

Nothing specific, I just need to know if it's working on other setups too :)

Just compile it with DEBUG=true and let the '/etc/hotplug.d/default/udev.hotplug'
symlink point to udevsend instead of udev. udevd will be automatically started.
On reboot the first sequence I get in the syslog is 138 and udevd is pid [51].

Don't mount /udev as tmpfs. udevd places its socket and lock file in there,
long before you mount it over. I just recognized it cause I had two
udevd running. /var/lock doesn't work cause it's also cleaned up after we
are running.

You may watch the syslog while connecting/disconnecting devices, to see if
the events are applied in the right order.

thanks,
Kay
