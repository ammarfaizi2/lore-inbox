Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267410AbTALTTK>; Sun, 12 Jan 2003 14:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267411AbTALTTH>; Sun, 12 Jan 2003 14:19:07 -0500
Received: from AMarseille-201-1-1-174.abo.wanadoo.fr ([193.252.38.174]:42609
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S267410AbTALTTE> convert rfc822-to-8bit; Sun, 12 Jan 2003 14:19:04 -0500
Subject: Re: Linux 2.4.21-pre3-ac4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
References: <200301121807.h0CI7Qp04542@devserv.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1042399796.525.215.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Jan 2003 20:29:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 19:07, Alan Cox wrote:
> Various compile fixes, and the next stage of IDE updating. In particular
> the PIIX driver has been subjected to a full review of Intel chipset
> errata. I've also added the framework to fix the problems Ross Biro found
> but not yet enabled its use. Once enabled that should fix a lot of the
> problems with shared IRQ IDE. Handle with care as usual.

It seems it lacks the code to actually blast the cmd byte passed
as a parameter...

Also, how are we supposed to use it exactly ? We shall fill the taskfile
first I beleive, so I suppose we shall call ide_spin_wait_hwgroup()
first which gets us a channel locked and not busy, right ?

That would do something like:

  if (ide_spin_wait_hwgroup(drive))
	return -EBUSY;
  hwgroup->busy = 1;
  .. put stuffs in taskfile regs ..
  spin_unlock_irq(&io_request_lock);
  ide_execute_command(drive, ...)
  
Ànd then hopefully wait (wait_for_completion() ?) for some action by
the expiry or the handler, right ?

I'm just trying to make sure I understand the purpose of this new function...

Ben.



