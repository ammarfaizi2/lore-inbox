Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265936AbSKKSX1>; Mon, 11 Nov 2002 13:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266880AbSKKSX1>; Mon, 11 Nov 2002 13:23:27 -0500
Received: from host194.steeleye.com ([66.206.164.34]:58636 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265936AbSKKSXZ>; Mon, 11 Nov 2002 13:23:25 -0500
Message-Id: <200211111830.gABIU5519529@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Linus Torvalds <torvalds@transmeta.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NCR53C9x ESP: C99 designated initializers
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Nov 2002 13:30:03 -0500
From: "J.E.J. Bottomley" <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Nov 2002, Alan Cox wrote:
> 
> The stupid thing is we take the lock then call the eh function then drop
> it. You can drop the lock, wait and retake it. I need to fix a couple of
> other drivers to do a proper wait and in much the same way.

I agree.  You can simply drop the lock with no adverse consequences.

torvalds@transmeta.com wrote:
> Hmm.. I wonder if the thing should disable the queue (plug it) and
> release  the lock before calling reset. I assume we don't want any new
> requests at  this point anyway, and having the low-level drivers know
> about stopping  the queue etc sounds like a bad idea..

The queue doesn't need plugging, because only the error handler is a consumer 
of this function (which stops the queue as it begins and  restarts the queue 
on exit).  As Alan said, the lock stuff is a bit daft since the whole reason 
the new eh came into being was to do this from a kernel thread so you could 
sleep...

arjanv@redhat.com said:
> something similar is needed in the scsi layer for other reasons too; I
> can imagine something that behaves similar as the network layer's
> netif_stop_queue() and allows drivers to inform the upper layer to
> stop trying to submit requests to the lower level driver. Fiber
> channel drivers can do this for example on LIP down (and enable again
> on LIP up). LIP is not the only reason this is useful; overall I
> estimate that over half of the code in the (out of tree) qlogic 2x00
> driver can be removed if this functionality was available.

The API exists (scsi_block_requests, scsi_unblock_requests).  It was 
previously never really used because calling block_requests with no commands 
outstanding hung the driver.  However, this problem has been fixed.

The one thing this API doesn't do is stop timers on the outstanding commands, 
but that could be done too, probably by a flag passed in.

James


