Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264034AbTCXBhB>; Sun, 23 Mar 2003 20:37:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264036AbTCXBhA>; Sun, 23 Mar 2003 20:37:00 -0500
Received: from AMarseille-201-1-1-254.abo.wanadoo.fr ([193.252.38.254]:13351
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S264034AbTCXBg7>; Sun, 23 Mar 2003 20:36:59 -0500
Subject: Re: [PATCH] fix powerbook media bay
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <1048460903.10712.89.camel@irongate.swansea.linux.org.uk>
References: <15997.17378.538276.91950@nanango.paulus.ozlabs.org>
	 <1048433932.10727.18.camel@irongate.swansea.linux.org.uk>
	 <15998.10367.608276.488022@nanango.paulus.ozlabs.org>
	 <1048460903.10712.89.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048470547.582.23.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Mar 2003 02:49:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 00:08, Alan Cox wrote:
> On Sun, 2003-03-23 at 21:34, Paul Mackerras wrote:
> > Is the IDE stuff still in the middle of open-heart surgery?  I'm happy
> > to hack on it and send you patches if it isn't all going to change
> > dramatically in the next week anyway.
> 
> Its on the crash trolley right now, but we think we may be able to save
> the patient. The registration is saner now for PCI but not for the non
> PCI cases. In addition the resource allocation is ass backwards and that
> I will change at some point so the caller does the resource work.
> PC9800 requires this really, PCMCIA badly needs it, and it lets me
> remove a ton of hacks from the mmio aware drivers.

Yes, please, do that :)

I did the hwif->mmio == 2 case especially for that purpose, that is
let the hwif driver deal with resource management since I need it
for ide-pmac.
(today, hwif->mmio == 0 means PIO, == 1 means MMIO with request_xxx
done by the generic code & other assumptions, and == 2 means the
generic code does nothing)

Paul: regarding media-bay, don't waste too much time on this for 2.5,
the whole probing stuff is going to change once I get the macio-asic
bus getting in and all those drivers moved to the new model.

The kernel still badly lacks some good way to deal with driver
dependencies (similar what I did with OCP stuff where a driver
can return -EAGAIN on probe when it relies on some other
not-yet-probed driver, but that's really a hack).

What I will do is that:

 - PCI layer will probe the macio-asic (based on matching the
OF node with whatever pmac_feature will have detected. I did consider
moving all of pmac_feature to macio-asic, but we still need too many
stuff beeing initialized early, so at least for 2.5, it will stay split)

 - macio-asic declares a bus type, and will probe devices based
on the OF tree. At this point, it will probe media-bays first

 - then it probes IDE drivers. Thus, the registration mecanism of
ide-pmac will be a carbon-copy of the one for IDE PCI devices.

In order to deal with ordering properly, media-bay will not call
ide_register_hw directly. Instead, it will call a pmac-ide specific
routine (either via macio-asic, that is it will force macio-asic
to add a new device to it's tree as by default, it will only be
one level deep, or I will go directly to ide-pmac, I haven't
decided yet).

At that point, ide-pmac can decide what to do, that is just reserve
the hwif slot for later probe, or really call ide_register_hw.

Ben.


