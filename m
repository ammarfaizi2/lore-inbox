Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266906AbUFZJJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266906AbUFZJJW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 05:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266918AbUFZJJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 05:09:22 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:59655
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S266906AbUFZJJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 05:09:18 -0400
Date: Sat, 26 Jun 2004 01:58:00 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
cc: Jens Axboe <axboe@suse.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, Ed Tomlinson <edt@aei.ca>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: ide errors in 7-rc1-mm1 and later
In-Reply-To: <Pine.LNX.4.10.10406260118220.19080-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.10.10406260147000.19080-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One more thing ...

Barriers are useless unless always used.
Given drives will autoflush cache and should an error occur, then a manual
flush cache is issued the drive goes offline.  The state machine is in an
error and can not be recovered.  So actually there needs to be an error
state test opcode or something first.

However, since barriers generally are not wrapped around all writes
associated with the entire transaction (ie transaction is larger than
total sectors transferred), multiple writes, flush(1), down block,
flush(2) for journalling ...

Failure on flush(1) could play havoc if there were cached writes from
previous non journalled transactions to the device.  This kind of recovery
would require block_request_aging similar to VM paging (clean/dirty lists)
and has the potential to be come ugly.

I have the full model to deploy, but I have no time or desire to champion
the project.

Regards,

Andre Hedrick
LAD Storage Consulting Group


On Sat, 26 Jun 2004, Andre Hedrick wrote:

> 
> Eric,
> 
> There is no need for a new opcode.
> The behavior is simple and trivial to support.
> 
> If standard flush_cache/ext were to behave just like standard data_in
> taskfile register setup, yet use a non_data command state machine it would
> be done.
> 
> Special case would be deal with LBA Zero and this would have to behave
> like a complete device flush.  Since flushing sector zero is not generally
> done ... well this would go into a design debate and it is not my issue
> nor my desire to enter one today.
> 
> 28-bit would support max 256 sectors
> 48-bit would support max 65536 sectors
> 
> Anyone could write this simple proposal to T13 for SATA and T10 for SAS.
> 
> Cheers,
> 
> Andre Hedrick
> LAD Storage Consulting Group
> 
> On Thu, 10 Jun 2004, Eric D. Mudama wrote:
> 
> > On Thu, Jun 10 at  8:11, Jens Axboe wrote:
> > >On Thu, Jun 10 2004, Bartlomiej Zolnierkiewicz wrote:
> > >> 
> > >> /me just thinks loudly
> > >> 
> > >> 'linear range' FLUSH CACHE seems so easy to implement that I always wondered
> > >> why FLUSH CACHE command doesn't make any use of LBA address and number
> > >> of sectors.
> > >
> > >Indeed, that would be very helpful as well.
> > 
> > Neat idea... so you send us a LBA and a block count, and we return
> > good status if that region is flushed.
> > 
> > Each command can specify a 32MiB region, assuming a device with
> > 512-byte LBAs.
> > 
> > Propose an exact implementation and an opcode...
> > 
> > -- 
> > Eric D. Mudama
> > edmudama@mail.bounceswoosh.org
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

