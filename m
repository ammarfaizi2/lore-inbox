Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262931AbSJBCOO>; Tue, 1 Oct 2002 22:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262932AbSJBCOO>; Tue, 1 Oct 2002 22:14:14 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:45832 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262931AbSJBCON>;
	Tue, 1 Oct 2002 22:14:13 -0400
Date: Tue, 1 Oct 2002 19:17:13 -0700
From: Greg KH <greg@kroah.com>
To: Krishnakumar B <kitty@cse.wustl.edu>,
       Johannes Erdfelt <johannes@erdfelt.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple OOPS with Linux-2.5.40
Message-ID: <20021002021713.GC11453@kroah.com>
References: <15770.19197.730535.272727@samba.doc.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15770.19197.730535.272727@samba.doc.wustl.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 08:25:17PM -0500, Krishnakumar B wrote:
> hcd-pci.c: uhci-hcd @ 00:1f.2, Intel Corp. 82801AA USB
> hcd-pci.c: irq 19, io base 0000ff80
> hcd.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found at 0
> hub.c: 2 ports detected
> Debug: sleeping function called from illegal context at /u/scratch/downloads/kernel/linux-2.5.40/include/asm/semaphore.h:119
> df675f70 e2886692 e28926c0 00000077 df675fa8 df808760 df664f88 df66e0d0 
>        df674000 dfb36100 00000286 df674000 df674000 df675fc0 df674000 e28869f5 
>        dfa1b860 dfb36100 df674000 df81df34 00000000 dfa1b860 c0118260 00000000 
> Call Trace:
>  [<e2886692>]usb_hub_events+0x82/0x3b0 [usbcore]
>  [<e28926c0>].rodata.str1.32+0xd20/0x28e2 [usbcore]
>  [<e28869f5>]usb_hub_thread+0x35/0x100 [usbcore]
>  [<c0118260>]default_wake_function+0x0/0x40
>  [<e28869c0>]usb_hub_thread+0x0/0x100 [usbcore]
>  [<c0105665>]kernel_thread_helper+0x5/0x10

I think this is due to the following lines of code in
drivers/usb/core/hub.c:
		spin_lock_irqsave(&hub_event_lock, flags);

		....

		down(&hub->khubd_sem); /* never blocks, we were on list */
		spin_unlock_irqrestore(&hub_event_lock, flags);

Johannes, any reason for the down() when we have a spinlock held?

thanks,

greg k-h
