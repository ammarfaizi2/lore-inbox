Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271153AbSISKuG>; Thu, 19 Sep 2002 06:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271162AbSISKuG>; Thu, 19 Sep 2002 06:50:06 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:32243
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S271153AbSISKuF>; Thu, 19 Sep 2002 06:50:05 -0400
Subject: Re: ide double init? + Re: BUG: Current 2.5-BK tree dies on boot!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Anton Altaparmakov <aia21@cantab.net>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020919100831.GC31033@suse.de>
References: <E17rlgP-0006wL-00@storm.christs.cam.ac.uk>
	<E17rlgP-0006wL-00@storm.christs.cam.ac.uk>
	<5.1.0.14.2.20020919102432.0438bec0@pop.cus.cam.ac.uk>
	<20020919094520.GB31033@suse.de>  <20020919100831.GC31033@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 11:58:30 +0100
Message-Id: <1032433110.26669.30.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 11:08, Jens Axboe wrote:
> Seems to be ide probe calling the pci probe functions, and then they get
> called by the pci layer later when they register. Dunno what the best
> way to handle this is. Alan quotes ordering constraints as the reason.
> Then maybe the easiest fix is to just do

Something is very wrong if they initialize twice. Hacking chipset_init
is not a fix its an ugly hack.

They should end up on the ide queue to init, then transfer to the core
PCI hotplug layer. The hotplug layer won't call the setups again because
the device is already owned by the driver that grabbed it.

In 2.4 at least pci_register_driver checks that it doesnt do that

    pci_for_each_dev(dev) {
                if (!pci_dev_driver(dev))
                        count += pci_announce_device(drv, dev);
        }


2.5 should do the same

Alan

