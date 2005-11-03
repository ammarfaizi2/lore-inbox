Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030404AbVKCRi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030404AbVKCRi2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 12:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVKCRi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 12:38:28 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:58533
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030396AbVKCRi1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 12:38:27 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: initramfs for /dev/console with udev?
Date: Thu, 3 Nov 2005 11:38:09 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <20051102222030.GP23316@pengutronix.de> <200511022140.25268.rob@landley.net> <20051103064727.GR23316@pengutronix.de>
In-Reply-To: <20051103064727.GR23316@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200511031138.10414.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 November 2005 00:47, Robert Schwebel wrote:
> On Wed, Nov 02, 2005 at 09:40:24PM -0600, Rob Landley wrote:
> > > dir /dev 0755 0 0
> > > nod /dev/console 0600 0 0 c 5 1
> > > nod /dev/null 0600 0 0 c 1 3
> > > dir /root 0700 0 0
> > >
> > > and let CONFIG_INITRAMFS_SOURCE point to that file. The gpio archive is
> > > built correctly with that, but my kernel doesn't seem to use it.
> >
> > 1) You have no init in initramfs, so it goes ahead and mounts whatever
> > root= points to over it. I'm guessing that's where it's looking for
> > /dev/console from.
>
> Hmm, I thought something like that. That means that I do need a complete
> klibc based early userspace, just to get these two device nodes?

No, you just need a statically linked init program.  (Which can be a shell 
script using a statically linked shell.  For testing purposes it can be 
statically linked against glibc, it'll just be a bloated pig.)

I have a /tools directory that builds uClibc executables.  (Like Linux From 
Scratch Chapter 5: extract it as /tools, export PATH=/tools/bin:$PATH, and 
then build software as normal.)  I can post that somewhere if you'd like, or 
you can extract it yourself out of my firmware linux build 
(http://www.landley.net/code/firmware)...

The switch_root program in busybox is still being banged on (by me).  I 
haven't quite worked out what to do about /dev/console yet.  I'm thinking if 
it's not there, keep the one from initramfs, but haven't implemented that 
tweak yet...

You also have the option of putting a single static node (console) in the /dev 
directory you're going to overmount.  It shouldn't hurt anything at present.  
And if nothing else, it'll confirm where it's trying to get the sucker 
from...

> Seems 
> like I'll have to do some deeper investigation of klibc; last time I
> looked it didn't even compile for ARCH=um.

Klibc didn't, or the kernel didn't?

> > 2) What's the directory /root for?
>
> Just a relict from the default script; the first three lines should be
> enought. But it shouldn't matter.
>
> > > Is anything else needed to use an initrd, like a command line argument?
> > > My kernel boots from a nfs partition, so it sets nfsroot=...
> >
> > Note that initramfs and initrd and very different things.
>
> Is there any other known possibility to get just these two device nodes
> in an automatic way?

>From initramfs, you could try:

mount -t sysfs /sys /sys
CDEV=`cat /sys/class/tty/console`
mknod /dev/console c $(echo $CDEV | sed 's/:.*//') \
  $(echo $CDEV | sed 's/.*://')

Bit of a chicken and egg problem if it refuses to run /init if it's not 
already there, though.  We're heading towards fully dynamic devices, but not 
quite there yet...

> I'm trying to get rid of devfs, and udev works just 
> fine. The only thing not solved yet is how to get the beast started
> without /dev/console and /dev/null. I don't want to create the nodes
> statically, because that's only possible with root permissions.

You don't need root access to make an initramfs configuration text file. :)

> Some background: I'm building root filesystems for embedded systems with
> PTXdist; the user is able to build the whole thing without root
> permissions; either with a cross compiler and mount it via NFS or build
> a JFFS2 image, or, with one switch, build and run it with an uml kernel.

I did something like that, only from scratch:
http://www.landley.net/code/firmware

I'll probably release version 0.8.10 later today.  (Still need to make an 
installer for the bootable version before I can call it 0.9...)

> I also tried ndevfs, just to get these two nodes, but I didn't find out
> how to automatically mount it on boot yet.

Presumably, either via initramfs or from init/main.c

> Robert

Rob
