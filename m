Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbUKQRbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbUKQRbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 12:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUKQR3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 12:29:30 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:43493 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262456AbUKQR2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 12:28:38 -0500
Subject: Re: PATCH (for comment): ide-cd possible race in PIO mode
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041117153706.GH26240@suse.de>
References: <1100697589.32677.3.camel@localhost.localdomain>
	 <20041117153706.GH26240@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100708728.420.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 17 Nov 2004 16:25:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-11-17 at 15:37, Jens Axboe wrote:
> > -		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
> > +		spin_lock_irqsave(&ide_lock, flags);
> > +		HWIF(drive)->OUTBSYNC(WIN_PACKETCMD, IDE_COMMAND_REG);
> > +		ndelay(400);
> > +		spin_unlock_irqsave(&ide_lock, flags);
> >  		return (*handler) (drive);
> >  	}
> >  }
> 
> What good does the lock do?

The same as in ide_execute_command - make sure we don't take an IDE
interrupt that tries to read the state during the delay. That is the old
2.4 "may drives shared IRQ random fails" fix and why the lock is taken
in ide_execute_command.


