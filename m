Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLKCuh>; Sun, 10 Dec 2000 21:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129226AbQLKCu1>; Sun, 10 Dec 2000 21:50:27 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:17559 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S129260AbQLKCuK>; Sun, 10 Dec 2000 21:50:10 -0500
Date: Sun, 10 Dec 2000 16:35:22 +0000
From: David Brownell <david-b@pacbell.net>
Subject: Re: hotplug mopup
To: Andrew Morton <andrewm@uow.edu.au>, lkml <linux-kernel@vger.kernel.org>,
        linux-usb-devel@lists.sourceforge.net
Message-id: <02a401c062d6$0e35bca0$6600000a@brownell.org>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
In-Reply-To: <3A3377B3.FDCBE4AD@uow.edu.au>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - I don't think we can say that the kernel hotplug interface is
>   complete until we have real, working, tested userspace tools.  David,
>   could you please summarise the state of play here? In particular,
>   what still needs to be done?

I think there's a lot of scope for more and better userspace tools, and we
have a great starting point with the latest 2.4 kernels.  I think such tools
are pretty well _enabled_ now by the kernel.  Some drivers don't yet help to
autoconfigure their devices; that'll come with time.


There's the "reference" /sbin/hotplug (CVS at linux-usb.sourceforge.net)
that makes a lot of devices usable immediately after you plug them in to
USB or CardBus.  Real and working ... but more testing is always good.
(I got a bug report yesterday ... :-)

    - Prefers to delegate to /etc/hotplug/$TYPE.agent if that's there,
      otherwise it falls back to simple algorithms (next bullets).

    - When new USB or PCI/Cardbus devices get added, driver modules
      will get loaded (and maybe initialized).  For 2.4 based systems,
      drivers need a MODULE_DEVICE_TABLE for the driver to load.

    - There's a convention that /etc/hotplug/$TYPE/$MODULE startup scripts
      will get run.  This hook lets you do things like running a program
      to talk to your PDA (call from /etc/hotplug/usb/visor) or printer.

    - When a new network device is registered, and "/sbin/ifup" is there,
      it's invoked to try bringing up the device. 

For 2.2.18 systems, USB hotplugging works (or so I'm told :-) using an older
approach to the problem solved by MODULE_DEVICE_TABLE in 2.4.x kernels.


One thing that needs to be done: figure out how to evolve the user mode
software moving forward.  Right now that's one script, but I forsee smarter
hotplug agents complicating the picture.  Life will be simpler if all distros
can share both core functionality (/sbin/hotplug) and ways to extend it (like
/etc/hotplug conventions).  It'd happen more easily if we put "/sbin/hotplug"
into some official tool package (say, modutils) but that's not the only way.


As for system "hotplug" class functionality that's missing, "pcmcia_cs" is
a partial blueprint.  Some of this needs kernel support:

    - There's no Cardbus support for stuff like "cardctl eject", which
      would call the PCI driver remove() method and let the driver shut
      down cleanly while the device is still connected.  I suspect a
      solution like new ioctls on /proc/bus/pci files could solve that.

    - Similarly with USB; though there's no tool like "cardctl" that
      folk are no expecting to use.  (If PCMCIA really needs tools to
      cleanly shut down drivers, then it'd seem other hotplug busses
      must too ... but nobody's suffering for this USB feature now.)

    - Unless I missed a recent patch, only Cardbus (PCI) drivers get
      hotplug notifications, not PCMCIA (ISA-ish) ones ... so there's
      currently still a need for "cardmgr" if you're using PCMCIA cards.
      (Getting rid of it isn't a 2.4.0 task; maybe not a 2.4.x task.)

    - There's a feeling that IEEE 1394, SCSI, disk partitions, input,
      and other sorts of Linux driver frameworks should move towards
      autoconfiguration ("hotplug") ... surely not 2.4.0 issues!

There's some other stuff that seems less likely to need kernel changes:

    - 'remove' events are ignored ... something else must unload modules,
      like the "rmmod -as" cron job some systems run, or smarter agents
      to handle the "remove" hotplug events.

    - Devices that are recognized at boot before the root filesystem is
      mounted are not going to get configured by /sbin/hotplug ...
      something needs to run after root is mounted, scanning the busses
      (/proc/bus/pci; and usbdevfs in /proc/bus/usb if it's configured
      and mounted) and effectively faking hotplug events.

    - For 2.4.x systems with "pcmcia_cs", the network hotplugging has
      kicked in before the "pcmcia_cs" support doing the same stuff.
      Something smart should IMHO remove that overlap, preferably by
      making this something pcmcia_cs just doesn't do any more.

    - More documentation will likely be needed.

All those additional usermode-only behaviors would seem to strongly benefit
from Linux standards for the relevant sysadmin and booting procedures, but
as I understand it they don't exist yet.

- Dave




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
