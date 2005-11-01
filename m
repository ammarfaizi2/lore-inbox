Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbVKAXVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbVKAXVd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 18:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVKAXVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 18:21:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:53939 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751426AbVKAXVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 18:21:32 -0500
Date: Tue, 1 Nov 2005 15:21:28 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Nicholas Jefferson <xanthophile@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: <REAL> iBurst (TM) compatible driver
Message-ID: <20051101152128.121792bf@dxpl.pdx.osdl.net>
In-Reply-To: <4cd031a50510312100n23bffa13jb48a6daa33bce80b@mail.gmail.com>
References: <4cd031a50510270924r38ad4d5oa88ae92a514df3cf@mail.gmail.com>
	<20051027153104.1a6531db@dxpl.pdx.osdl.net>
	<4cd031a50510312100n23bffa13jb48a6daa33bce80b@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.9.15 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2005 16:00:19 +1100
Nicholas Jefferson <xanthophile@gmail.com> wrote:

> Hi Stephen,
> 
> Thank you for your comments. A new version of the iBurst (TM) wireless
> compatible driver (and a patch against 2.6.13.4) is now available [1]
> under the linux-2.6-ibdriver-2.0 release.
> 
> [1] http://sourceforge.net/projects/ibdriver
> 
> > 1. Your network device registration code is wrong.
> 
> Okay. ib_net_register now uses alloc_netdev with the appropriate
> changes elsewhere.

Where is updated code?

> 
> > 2. Transmit routine is wrong. Drop packets if out of memory.
> 
> Okay. ib_net_tx_start does not allocate memory now.
> 
> > 3. You need to flow control the transmit queue.
> 
> ib_net_tx_prepare already did netif_stop_queue and netif_wake_queue.
> Would you prefer this to be in ib_net_tx_start instead?

There is still a race with poll and tx_start.
Better to have tx_start check for space after queuing and have
poll wake_queue when space becomes available.


> > 4. WTF is the whole ib_net_tap file stuff, and why do you need it?
> 
> The modem can return status information (signal strength, etc.). This
> information is accessed from usermode by device files. There is also
> an interactive "talk" channel to control the modem, but I don't know
> what it can do. The ib-file module implements these device files. It
> is not essential for the driver and we don't yet know the modem
> protocol anyway, so I've removed it.

Some possibilities:
1. Could you support a subset of the existing wireless functions. Then
   all the cool tools like wireless strength stuff would work.
2. Or add a sysfs status files
3. Or a /proc file per device

It makes sense for the driver to give as much information to the user
as possible. Just try and use existing API's first.

> > 5. Why bother with a /proc interface?
> > 6. If you must then use seq_file.
> > 7. If you must then do one device per file.
> 
> The /proc interface was for debugging and may later be used to provide
> the status information instead of the device files. It's not
> essential, so I've removed this as well.

One way I use is to keep a separate patch around that adds in the
/proc stuff for when debugging, but not put it in the main kernel.

> > 8. Then you can get rid of having a global array of device structures
> >    which is hard to maintain properly.
> 
> The global array was used to set up the correspondence between the
> device files (via the minor device file numbers) and the modem
> structures (via the index to the global array). It's gone now ;-)
> 
> > 9. If you don't support ioctl's just leave dev->ioctl as NULL
> > 10. Error code's from call's like register_netdev() should propogate back out.
> > 11. ib_net_open, ib_net_close only called from user context don't need
> > irqsave use spin_lock_irq()
> > 12. Coding style: don't use u_long it's a BSDism
> > 13. Please have source code laid out as patch to kernel, not out of tree driver
> 
Also.

* Default name should be "ib%d" so you can handle multiple cards without
  getting an error.
* Why so many symbols exported?
* Ethtool and standard message level support would be cool (but not required).


-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
