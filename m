Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271200AbRHTL7u>; Mon, 20 Aug 2001 07:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271204AbRHTL7k>; Mon, 20 Aug 2001 07:59:40 -0400
Received: from mail.scs.ch ([212.254.229.5]:26117 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S271200AbRHTL7b>;
	Mon, 20 Aug 2001 07:59:31 -0400
Message-ID: <3B80FBA9.556B7B2B@scs.ch>
Date: Mon, 20 Aug 2001 13:59:37 +0200
From: Thomas Sailer <sailer@scs.ch>
Reply-To: t.sailer@alumni.ethz.ch
Organization: SCS
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.3-13jnx i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>
CC: johannes@erdfelt.com, linux-kernel@vger.kernel.org
Subject: Re: Patch for bizzare oops in USB
In-Reply-To: <20010818013101.A7058@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev schrieb:

> diff -ur -X dontdiff linux-2.4.8/drivers/usb/usb.c linux-2.4.8-e/drivers/usb/usb.c
> --- linux-2.4.8/drivers/usb/usb.c       Tue Jul 24 14:20:56 2001
> +++ linux-2.4.8-e/drivers/usb/usb.c     Fri Aug 17 22:03:27 2001
> @@ -1066,7 +1066,7 @@
> 
>         awd.wakeup = &wqh;
>         init_waitqueue_head(&wqh);
> -       current->state = TASK_INTERRUPTIBLE;
> +       current->state = TASK_UNINTERRUPTIBLE;  /* MUST BE SO. -- zaitcev */
>         add_wait_queue(&wqh, &wait);
>         urb->context = &awd;
>         status = usb_submit_urb(urb);

This is bad for other users of usb_control_msg/usb_bulk_msg that depend on
the sleep to be interruptible. Instead of bouncing back and forth whether
those routines shall sleep interruptibly or uninterruptibly, we should either
provide two routines or a parameter that specifies whether the sleep
shall be interruptible, or create a local version of usb_control_msg
if ov511 is the only user requiring uninterruptible sleep.

Tom
