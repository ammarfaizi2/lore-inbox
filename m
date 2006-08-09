Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030371AbWHIAlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371AbWHIAlH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 20:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030375AbWHIAlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 20:41:07 -0400
Received: from B.painless.aaisp.net.uk ([81.187.81.52]:19848 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S1030371AbWHIAlG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 20:41:06 -0400
Date: Wed, 9 Aug 2006 01:41:04 +0100
From: Andrew Clayton <andrew@digital-domain.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc strange hotplug/udev/uevent problem
Message-ID: <20060809014104.0be41976@alpha.digital-domain.net>
In-Reply-To: <20060808060211.GA3206@kroah.com>
References: <44D79574.8080703@digital-domain.net>
	<20060808060211.GA3206@kroah.com>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.6.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Aug 2006 23:02:11 -0700, Greg KH wrote:
 
> Can you use 'git bisect' to try to narrow it down which change caused
> the problem?

I did 

git bisect start drivers/scsi drivers/usb
git bad v2.6.18-rc1
git good v2.6.17

Heres what git bisect came up with

c32ba30f76eb18b3d4449072fe9c345a9574796b is first bad commit
commit c32ba30f76eb18b3d4449072fe9c345a9574796b
Author: Paul Serice <paul@serice.net>
Date:   Wed Jun 7 10:23:38 2006 -0700

    [PATCH] USB: EHCI works again on NVidia controllers with >2GB RAM

    From: Paul Serice <paul@serice.net>

    The workaround in commit f7201c3dcd7799f2aa3d6ec427b194225360ecee
    broke.  The work around requires memory for DMA transfers for some
    NVidia EHCI controllers to be below 2GB, but recent changes have
    caused some DMA memory to be allocated before the DMA mask is set.

    Signed-off-by: Paul Serice <paul@serice.net>
    Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

:040000 040000 754a9f8cccedc71e8e3689f2b0dee811d94fdc11 5559c0eafe042377430052272d027f0458805126 M      drivers


What would be the way to revert that patch from 2.6.18-rc4 to confirm it's the culprit?
 
Heres the output from git bisect log

git-bisect start 'drivers/scsi' 'drivers/usb'
# bad: [7df8ea909888d4856d3aff1c41192739d715a393] Linux 2.6.18-rc1
git-bisect bad 7df8ea909888d4856d3aff1c41192739d715a393
# good: [8ba130df4b67fa40878ccf80d54615132d24bc68] Linux v2.6.17
git-bisect good 8ba130df4b67fa40878ccf80d54615132d24bc68
# good: [d7a80dad2fe19a2b8c119c8e9cba605474a75a2b] libata: convert several bmdma-style controllers to new EH, take #3
git-bisect good d7a80dad2fe19a2b8c119c8e9cba605474a75a2b
# bad: [d5681fe8110e1169902df37a8fd8bd01c2b7810e] USB: unusual_devs entry for Nokia N80
git-bisect bad d5681fe8110e1169902df37a8fd8bd01c2b7810e
# bad: [7327413c745c2f8e8d4b92f76759821263b095c1] USB: added support for ASIX 88178 chipset USB Gigabit Ethernet adaptor
git-bisect bad 7327413c745c2f8e8d4b92f76759821263b095c1
# good: [cb63067a772c0149184309a1f232d62c81a93673] [SCSI] qla2xxx: Consolidate "qla2xxx" string usage to a #define.
git-bisect good cb63067a772c0149184309a1f232d62c81a93673
# good: [beb40487508290f5d6565598c60a3f44261beef2] [SCSI] remove scsi_request infrastructure
git-bisect good beb40487508290f5d6565598c60a3f44261beef2
# good: [67d59dfdeb21df2c16dcd478b66177e91178ecd0] [SCSI] 53c700: remove reliance on deprecated cmnd fields
git-bisect good 67d59dfdeb21df2c16dcd478b66177e91178ecd0
# good: [c6387a48cf5958e43c201fc27a158c328927531a] [SPARC]: Kill __irq_itoa().
git-bisect good c6387a48cf5958e43c201fc27a158c328927531a
# bad: [5cd330f4f30eb154e7af9210bed42dfcd447997f] USB: add YEALINK phones to the HID_QUIRK_IGNORE blacklist
git-bisect bad 5cd330f4f30eb154e7af9210bed42dfcd447997f
# bad: [c32ba30f76eb18b3d4449072fe9c345a9574796b] USB: EHCI works again on NVidia controllers with >2GB RAM
git-bisect bad c32ba30f76eb18b3d4449072fe9c345a9574796b
# good: [28e4b224955cbe30275b2a7842e729023a4f4b03] Merge master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6
git-bisect good 28e4b224955cbe30275b2a7842e729023a4f4b03

> thansk,
> 
> greg k-h


Cheers,

Andrew
