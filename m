Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbUKQPhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbUKQPhp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 10:37:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbUKQPhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 10:37:45 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44269 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262343AbUKQPhg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 10:37:36 -0500
Date: Wed, 17 Nov 2004 16:37:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH (for comment): ide-cd possible race in PIO mode
Message-ID: <20041117153706.GH26240@suse.de>
References: <1100697589.32677.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100697589.32677.3.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17 2004, Alan Cox wrote:
> Working on tracing down Fedora bug #115458
> (https://bugzilla.redhat.com/bugzilla/process_bug.cgi) I found what
> appears to be a race between the IDE CD driver and the hardware status.
> It doesn't appear to explain the bug at all but it does look like a bug
> of itself
> 
> When we issue an ide command the status bits don't become valid for
> 400nS. In the DMA case ide_execute_command handles this but in the PIO
> case we don't do the needed locking, use OUTBSYNC to avoid posting or
> delay. This means that in some situations we can execute the command
> handler in PIO mode before the command status bits are valid and the
> handler may read and act wrongly.
> 
> --- drivers/ide/ide-cd.c~	2004-11-17 14:08:42.950485320 +0000
> +++ drivers/ide/ide-cd.c	2004-11-17 14:08:42.951485168 +0000
> @@ -897,7 +897,10 @@
>  		return ide_started;
>  	} else {
>  		/* packet command */
> -		HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
> +		spin_lock_irqsave(&ide_lock, flags);
> +		HWIF(drive)->OUTBSYNC(WIN_PACKETCMD, IDE_COMMAND_REG);
> +		ndelay(400);
> +		spin_unlock_irqsave(&ide_lock, flags);
>  		return (*handler) (drive);
>  	}
>  }

What good does the lock do?

-- 
Jens Axboe

