Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbTKSFfi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 00:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbTKSFfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 00:35:38 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:34945
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S263848AbTKSFff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 00:35:35 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Patrick's Test9 suspend code.
Date: Tue, 18 Nov 2003 23:26:17 -0600
User-Agent: KMail/1.5
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0311170844230.12994-100000@cherise> <200311181612.52176.rob@landley.net> <20031118232125.GA30268@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20031118232125.GA30268@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311182326.17838.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 November 2003 17:21, Pavel Machek wrote:
> Hi!
>
> > > > It then saved happily but didn't resume because I hadn't told it the
> > > > default resume partition was /dev/hda2.  (I don't have to specify
> > > > which partition to save to, why do I have to specify which one to
> > > > resume from? Oh
> > > > well...)
> > >
> > > Think again. How is kernel expected to find out partition which it
> > > should resume from? Try all of them?
> > >
> > > You did swapon before suspend, that's where you specified "which
> > > partition". You need to tell it what to resume from...
> >
> > I know.  Then again, if grub can read ext2... :)
> >
> :-), Okay, we could make grub read /etc/fstab... But again user can do
>
> swapoff and swapon manually etc.

During resume?

> > Better would be the initramfs stuff, though.  If there's a way to trigger
> > a resume that kills all running processes and loads userspace from the
> > swap partition, then you could do that from initramfs _after_ finding
> > /root a checking fstab, life is good.  (of course ext3 is brain-dead
> > enough to always replay the journal even if it mounts read-only, so you'd
> > have to mount it ext2 or something...  Hmmm...)
>
> Having sto stop userspace processes and bring hardware back to some
> sane state would complicate swsusp (and its testing!) a lot. Maybe in
> 2.8 when it works perfectly in other cases....

If there's only one "init" style task running from initramfs, which simply 
looks at the partitions and gets the info it needs from disk labels or 
something without actually mounting a filesystem (or mounts it read only, no 
journal playback, and then unmounts it again afterwards...)  And then the 
system call/whatever it does is sematically "exit and resume from swap"...

There might have to be some way to plug the hotplug event queue, though.  I 
don't know enough about what's involved in the interaction between hotplug 
and suspend...

> > > Strange, it looks like you tried suspending in the middle of module
> > > being [un]loaded?
> >
> > This was _right_ after the system booted up.  Possibly hotplug was still
> > finding stuff, or the pcmcia wireless card had just decided it had found
> > its access point, or some such...
> >
> > These kinds of asynchronous module loads and unloads do happen.  The
> > orinoco card driver is broken enough to sometimes decide that when it
> > loses connection with the access point, instead of toggling the link
> > status it decides the card has been unplugged!  (Real pain when that
> > happens, by the way...)
> >
> > So I can imagine modprobe was running, yeah.  But I hadn't done it
> > personally.
>
> I'd attribute it to buggy module.  If you can reproduce it you can try
> to fix it....
>
> ....but swsusp with modular kernels... I'm not sure if it can even
> work. .. yes it can but you really should get it working monolithic, first.

Okay.  Tell me how to get hotplug devices (cardbus, usb) working 
monolithically, and I'm all for it.

They mostly work now.  I've currently got these loaded:

orinoco_cs 7432 1 - Live 0xcc072000
orinoco 37508 1 orinoco_cs, Live 0xcc07f000
hermes 7936 2 orinoco_cs,orinoco, Live 0xcc06f000
ds 11264 5 orinoco_cs, Live 0xcc06b000
yenta_socket 14080 1 - Live 0xcc050000
pcmcia_core 58624 3 orinoco_cs,ds,yenta_socket, Live 0xcc05b000

> 								Pavel

Rob
