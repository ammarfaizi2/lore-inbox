Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932583AbVKAFAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbVKAFAW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVKAFAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:00:22 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:41866 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932583AbVKAFAU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:00:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TC3mMEDZHp9EfkcUqfvN6J87jdabDURFMJ5BOsUpknMihcasRkPL31H2gAFsIbxPv1JrGgorZKyhfqPzk7W8uF9xAwGZqyVT4+f+COu9IAy3Ux/nK+LH+IwaDNLzGd3x7dBR/3WKH9S4WKzVzk/y5Os6ZpJ7KL55q6Z2l7zBVwo=
Message-ID: <4cd031a50510312100n23bffa13jb48a6daa33bce80b@mail.gmail.com>
Date: Tue, 1 Nov 2005 16:00:19 +1100
From: Nicholas Jefferson <xanthophile@gmail.com>
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: <REAL> iBurst (TM) compatible driver
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051027153104.1a6531db@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4cd031a50510270924r38ad4d5oa88ae92a514df3cf@mail.gmail.com>
	 <20051027153104.1a6531db@dxpl.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Thank you for your comments. A new version of the iBurst (TM) wireless
compatible driver (and a patch against 2.6.13.4) is now available [1]
under the linux-2.6-ibdriver-2.0 release.

[1] http://sourceforge.net/projects/ibdriver

> 1. Your network device registration code is wrong.

Okay. ib_net_register now uses alloc_netdev with the appropriate
changes elsewhere.

> 2. Transmit routine is wrong. Drop packets if out of memory.

Okay. ib_net_tx_start does not allocate memory now.

> 3. You need to flow control the transmit queue.

ib_net_tx_prepare already did netif_stop_queue and netif_wake_queue.
Would you prefer this to be in ib_net_tx_start instead?

> 4. WTF is the whole ib_net_tap file stuff, and why do you need it?

The modem can return status information (signal strength, etc.). This
information is accessed from usermode by device files. There is also
an interactive "talk" channel to control the modem, but I don't know
what it can do. The ib-file module implements these device files. It
is not essential for the driver and we don't yet know the modem
protocol anyway, so I've removed it.

> 5. Why bother with a /proc interface?
> 6. If you must then use seq_file.
> 7. If you must then do one device per file.

The /proc interface was for debugging and may later be used to provide
the status information instead of the device files. It's not
essential, so I've removed this as well.

> 8. Then you can get rid of having a global array of device structures
>    which is hard to maintain properly.

The global array was used to set up the correspondence between the
device files (via the minor device file numbers) and the modem
structures (via the index to the global array). It's gone now ;-)

> 9. If you don't support ioctl's just leave dev->ioctl as NULL
> 10. Error code's from call's like register_netdev() should propogate back out.
> 11. ib_net_open, ib_net_close only called from user context don't need
> irqsave use spin_lock_irq()
> 12. Coding style: don't use u_long it's a BSDism
> 13. Please have source code laid out as patch to kernel, not out of tree driver

Okay.

Kind regards,

Nicholas
