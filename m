Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUHQKvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUHQKvJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 06:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265041AbUHQKvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 06:51:08 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8161 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265098AbUHQKu6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 06:50:58 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>
Subject: Re: PATCH: switch ide-proc to use the ide_key functionality
Date: Tue, 17 Aug 2004 12:48:12 +0200
User-Agent: KMail/1.6.2
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20040815150414.GA12181@devserv.devel.redhat.com> <200408170231.25725.bzolnier@elka.pw.edu.pl> <20040817010533.GB32628@devserv.devel.redhat.com>
In-Reply-To: <20040817010533.GB32628@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408171248.12235.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 August 2004 03:05, Alan Cox wrote:
> BTW this may help if I document the locks and what they cover in case its
> not obvious
>
> drives_lock is the spin lock you must own to update the drive list
>
> ide_cfg_sem is the semaphore you must own to walk or hold loose references
> to the ide_hwif_t array and elements relating to adding/removing/busy
> status
>
> ide_lock is taken when you want to write that array and deal with elements
> that are interrupt walked by other devices. Notably this means the hwgroup
> chains.
>
> ide_settings_sem could be per drive but isnt, it is used when you are
> processing the ioctl/proc objects attached to the driver either by walking
> them or removing them.
>
>
> drivers_lock is the spin lock you must own to update the drivers list
> drivers_sem is the semaphore you must own to walk the list and while
> holding loose references to drivers (ie when the busy/lists are not
> consistent)
>
> The lock order is
>
> 	ide_cfg_sem
> 	drivers_sem
> 	ide_settings_sem
> 	drivers_lock | drives_lock
> 	ide_lock
>
>
> Which means my cunning plan from the previous mail doesn't actually work
> unless we take ide_cfg_sem at the top of the proc code before setting_sem.
> Also looking over it I need to send you the bits to take the sems in each
> proc routine for that case.

Yes, on the other hand we may try to do real refcounting.

Actually I think there are holes in the above locking scheme but need to think 
more about it - i.e. what protects us from removing hwif while it is being 
configured by host driver?

> PS: what do you think about deprecating (but not yet removing)
> ide_write_config and ide_read_config now we have sysfs ? Does anyone

sysfs doesn't help at all as IDE is not ready for full sysfs support
(missed locking, no refcounting and no dynamic objects)

I also can't see how sysfs can help with synchronizing writes to ISA/PCI 
config space with ongoing I/O?

Please also note that PCI writes currently doesn't work because of "... || 
hwif->pci_dev->vendor" instead of "... || !hwif->pci_dev->vendor" - somebody 
(I think you :) broke this back in 2.4.21 kernel.

> actually use its "wait for non busy and then pci config write" - does
> anyone use it at all ?

I'm not aware of any users and I have patch ready to deprecate it.

> Also while looking at proc it would clean up read_imodel and make it a ton
> more useful to stick the string pointers into hwif->chipset_name or
> somesuch so we can report the PCI ones in detail ?

Yes, but reporting PCI ones in detail will brake any users of this /proc entry 
(if there are any of course).

Thanks.
