Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUHQBGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUHQBGd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 21:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268064AbUHQBGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 21:06:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:13263 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268059AbUHQBGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 21:06:25 -0400
Date: Mon, 16 Aug 2004 21:05:33 -0400
From: Alan Cox <alan@redhat.com>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Alan Cox <alan@redhat.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: switch ide-proc to use the ide_key functionality
Message-ID: <20040817010533.GB32628@devserv.devel.redhat.com>
References: <20040815150414.GA12181@devserv.devel.redhat.com> <200408170135.11465.bzolnier@elka.pw.edu.pl> <20040817001336.GA25753@devserv.devel.redhat.com> <200408170231.25725.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408170231.25725.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW this may help if I document the locks and what they cover in case its
not obvious

drives_lock is the spin lock you must own to update the drive list

ide_cfg_sem is the semaphore you must own to walk or hold loose references
to the ide_hwif_t array and elements relating to adding/removing/busy status

ide_lock is taken when you want to write that array and deal with elements
that are interrupt walked by other devices. Notably this means the hwgroup
chains.

ide_settings_sem could be per drive but isnt, it is used when you are
processing the ioctl/proc objects attached to the driver either by walking
them or removing them.


drivers_lock is the spin lock you must own to update the drivers list
drivers_sem is the semaphore you must own to walk the list and while
holding loose references to drivers (ie when the busy/lists are not
consistent)

The lock order is

	ide_cfg_sem
	drivers_sem
	ide_settings_sem
	drivers_lock | drives_lock
	ide_lock


Which means my cunning plan from the previous mail doesn't actually work
unless we take ide_cfg_sem at the top of the proc code before setting_sem. 
Also looking over it I need to send you the bits to take the sems in each 
proc routine for that case.  

PS: what do you think about deprecating (but not yet removing) ide_write_config
and ide_read_config now we have sysfs ? Does anyone actually use its
"wait for non busy and then pci config write" - does anyone use it at all ?

Also while looking at proc it would clean up read_imodel and make it a ton
more useful to stick the string pointers into hwif->chipset_name or somesuch
so we can report the PCI ones in detail ?

Alan


