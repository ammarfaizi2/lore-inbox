Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSGYONw>; Thu, 25 Jul 2002 10:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSGYONw>; Thu, 25 Jul 2002 10:13:52 -0400
Received: from [217.167.51.129] ([217.167.51.129]:54497 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S313477AbSGYONv>;
	Thu, 25 Jul 2002 10:13:51 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>, <martin@dalecki.de>,
       Vojtech Pavlik <vojtech@suse.cz>,
       William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: PCI config locking (WAS Re: [RFC/CFT] cmd640 irqlocking fixes)2 
Date: Thu, 25 Jul 2002 16:18:10 +0200
Message-Id: <20020725141811.29565@192.168.4.1>
In-Reply-To: <20020725133918.37@192.168.4.1>
References: <20020725133918.37@192.168.4.1>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Martin this patch should do the job. It uses the correct pci_config_lock
>>and it also adds the 2.4 probe safety checks for deciding which pci
>>modes to use.
>
>Hrm... pci_config_lock is specific to arch/i386 it seems (and is even
>a static in 2.4.19rc3). That is no good as this isn't the only
>driver to do config access from interrupts, so at least PPC is
>broken in this regard.
>
>Wouldn't it make sense to generalize it and implement it on all archs ?
>
>(That is move extern declaration of it to linux/pci.h, definition to
>drivers/pci/pci.c, and so on...)
>
>I'd rather have a per-host lock, but on the other hand, the host bus
>mecanism is still quite arch-specific, thus making difficult to use
>a per-host lock in drivers, at least in 2.4

Ok, fixing my own crap...

So there seem to be a problem with your patch: pci_config_lock appears
to be an x86-only thing that lives deep inside arch/i386/xxx/pci-pc.c
(xxx beeing kernel or pci)

On the other hand, there is already such a lock provided by
drivers/pci/access.c (pci_lock). You should probably fix your patch
to use that one. (and eventually get rid of the pci_config_lock
in x86, provided I didn't miss something else). But does anybody
but x86 uses CMD640 ? :)

Now, after more thinking and discussions, it seems we may actually
want 2 different things:

 - Protecting the pci config ops themselves as they are usually
indirect access, and thus potentially race. This is also what the
current pci_lock does and is somewhat duplicated by the pci_config_lock
used on x86. That could eventually be moved to a per-host lock

 - Protecting a device, that is preventing (usually from a driver)
any config access during some time, either for doing what you are
doing in the cmd640 patch, but also for _batching_ a set of config
space accesses that have to be atomic together on this device.

The later would probably be better done with a per-device lock. What
I don't like that much here is that normal access will result in 2
spinlocks beeing taken, though config space accesses are usually
rare and slow compared to other IOs, so it may not be that a problem.

That would require the pci config ops to be split into normal
pci_config_xxx that does take the per-device lock, and _pci_config_xxx
that doesn't, so a driver can manually take that lock, batch accesses
and release it.

What do you think ?

Ben.


