Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262041AbUKVKna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUKVKna (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 05:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbUKVKmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 05:42:46 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:15000 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262047AbUKVKkd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 05:40:33 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 22 Nov 2004 11:25:02 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Gerd Knorr <kraxel@suse.de>, Takashi Iwai <tiwai@suse.de>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: modprobe + request_module() deadlock
Message-ID: <20041122102502.GF29305@bytesex>
References: <20041117222949.GA9006@linuxtv.org> <1100749702.5865.39.camel@localhost.localdomain> <20041118135522.GA16910@linuxtv.org> <s5h4qjnc6zs.wl@alsa2.suse.de> <cnjr8v$dcu$1@sea.gmane.org> <s5hpt2aayco.wl@alsa2.suse.de> <20041119115042.GA30334@bytesex> <1101026370.18919.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1101026370.18919.32.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 	MODULE_DEPENDS_ON("somemodule");
> > 
> > On the other hand I don't depend on request_module() waiting for the
> > modprobe being finished.  So maybe we can solve that with a
> > request_module_async()?
> 
> The problem is fairly simple: we don't let you get at the symbols from a
> module which hasn't finished initializing yet.  This means that a
> request_module() inside a module's init() will fail if the requested
> module depends on this one.  async() will race with init() finishing, so
> won't really help.

Hmm, so module loading is not serialized by a lock?  I assumed that
caused the deadlock in $subject which started this thread ...

> The traditional way to do this has been to have saa7134-empress do its
> own probe, and likewise saa7134-dvb.

They can't actually probe themself.  It's _one_ PCI device (driven by
the saa7134 module) which can handle (among other v4l-related things)
the DMA transfer of mpeg streams.  That can be used in different ways
(or not at all) and the different use cases are handled by the
sub-modules.

So the way it is intended to work is that saa7134 has the pci table and
gets autoloaded by hotplug, it will have a look at the hardware and then
load either saa7134-empress or saa7134-dvb or none of them, so you'll
get everything nicely autoloaded.

> Unfortunately, these days modules are not supposed to fail to load
> simply because there are no devices, so wild module loading has a real
> cost.

Yes, thats exactly the problem.  And this is especially true for the
saa7134-dvb module as this one has a bunch of dependencies to other
modules of the dvb subsystem.  Thats why I try to avoid loading them
if they are not needed.

> Otherwise I'd be tempted to make multiple aliases load *all* of them,
> and solve the problem that way.

Well, that will actually work.  You can simply load both saa7134-empress
and saa7134-dvb, the saa7134 core module will take care that they can
only attach to devices they can actually handle.  Drawback is the memory
footprint ...

  Gerd

-- 
#define printk(args...) fprintf(stderr, ## args)
