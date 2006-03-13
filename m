Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWCMEPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWCMEPA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 23:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWCMEPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 23:15:00 -0500
Received: from soundwarez.org ([217.160.171.123]:61144 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751464AbWCMEO7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 23:14:59 -0500
Date: Mon, 13 Mar 2006 05:14:58 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Andrew Morton <akpm@osdl.org>
Cc: drzeus-list@drzeus.cx, ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-ID: <20060313041458.GA13605@vrfy.org>
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx> <20060301194532.GB25907@vrfy.org> <4406AF27.9040700@drzeus.cx> <20060302165816.GA13127@vrfy.org> <44082E14.5010201@drzeus.cx> <4412F53B.5010309@drzeus.cx> <20060311173847.23838981.akpm@osdl.org> <4414033F.2000205@drzeus.cx> <20060312172332.GA10278@vrfy.org> <20060312145543.194f4dc7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060312145543.194f4dc7.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 02:55:43PM -0800, Andrew Morton wrote:
> Kay Sievers <kay.sievers@vrfy.org> wrote:
> > On Sun, Mar 12, 2006 at 12:17:19PM +0100, Pierre Ossman wrote:
> > > Andrew Morton wrote:
> > > > I assume you mean that the drivers/pnp/card.c patch of
> > > > pnp-modalias-sysfs-export.patch needs to be removed and this patch applies
> > > > on top of the result.
> > > >
> > > > But I don't want to break udev.
> > > >   
> > > I suppose I wasn't entirely clear there. I'd like you to do the first
> > > part (remove the card.c part), but not apply this second patch. I just
> > > sent that in as a means of getting the ball rolling again.
> > 
> > Again, multiline sysfs modalias files are not going to happen. Find a
> > sane way to encode the list of devices into a single string, or don't do
> > it at all. And it must be available in the event environment too.
> > 
> > > The reason I'm pushing this issue is that Red Hat decided to drop all
> > > magical scripts that figured out what modules to load and instead only
> > > use the modalias attribute. They consider the right way to go is to get
> > > the PNP layer to export modalias, so that's what I'm trying to do.
> > 
> > There is no need to rush out with this half-baken solution. This simple
> > udev rule does the job for you, if you want pnp module autoloading with
> > the current kernel:
> >   SUBSYSTEM=="pnp", RUN+="/bin/sh -c 'while read id; do /sbin/modprobe pnp:d$$id; done < /sys$devpath/id'"
> > 
> > Andrew, please make sure, that this patch does not hit mainline until
> > there is a _sane_ solution to the multiple id's exported for a single
> > device problem.
> > 
> The only patch I presently have is:

> +	/* FIXME: modalias can only do one alias */
> +	return sprintf(buf, "pnp:d%s\n", pos->id);

> Is that OK?

No, it claims to export the modalias for the PnP device, but it is in
some cases (3 of 12 on my recent Laptop) not correct and we should not
have it at all until this issue is solved. If it would be _that_ easy,
it would have been long done, as several people already run into this
problem. :)
Let me explain it in detail, maybe someone has an idea how to solve that.

The problem is that we use the modalias value exported/created from the
kernel to lookup a matching kernel module name.

Kernel modules can contain entries from the module device table with
wildcard matches, which depmod collects and puts all of them into a
single file: /lib/modules/`uname -r`/modules.alias.

Now the enumerated/probed bus device instances export a modalias string
which contains the native id's of the bus. You can pass that string
directly to modprobe and modprobe will look up a matching driver for
that device and load the module.

That made the whole device <-> kernel module as easy as calling modprobe
once for every device the kernel creates, compared to the complex
userspace mess with map files we did in the past with shell scripts.
Here is a tg3 pci network card:
  $ cat /sys/bus/pci/devices/0000:02:00.0/modalias
  pci:v000014E4d0000167Dsv00001014sd00000577bc02sc00i00

  $ modprobe -v -n --first-time pci:v000014E4d0000167Dsv00001014sd00000577bc02sc00i00
  FATAL: Module tg3 already in kernel.

PnP, as some other buses, face the problem, that they don't have a
single identifier like a pci:$vendor-$product, or usb:$vendor-$product,
they can have multiple identifiers, which all have to be passed to
modprobe at once or one after the other. Exporting only one of these id's
is just wrong.
Here we see multiple id's for the same device:
  $ grep . /sys/bus/pnp/devices/*/id
  /sys/bus/pnp/devices/00:01/id:PNP0a08
  /sys/bus/pnp/devices/00:01/id:PNP0a03

  /sys/bus/pnp/devices/00:08/id:IBM0057
  /sys/bus/pnp/devices/00:08/id:PNP0f13

The problem is to represent multiple id's in a single string or find
another sane way to export multiple id's to userspace. Introducing
multiline values in sysfs for modalias is probably no the way to go
and if we really would want to do this, we need to prepare that
very carefully. There is currently already a PnP specific file called
"id", which is a multiline file and can be easily used to trick around
the problem without messing up "modalias".

Also at the same time we export a modalias file, we require a $MODALIAS
value in the event environment to be available, which is kind of ugly
for a multiline value.

Macio solved the problem by adding all devices to a single string and
let the device table match one of these id's in that single string:
  http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;hb=HEAD;f=drivers/macintosh/macio_sysfs.c#l42

We should first check if that is possible for PnP too, or solve that
problem in general at that level before we introduce such a hack.

Thanks,
Kay
