Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271947AbRHVGt1>; Wed, 22 Aug 2001 02:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271951AbRHVGtK>; Wed, 22 Aug 2001 02:49:10 -0400
Received: from c526559-a.rchdsn1.tx.home.com ([24.11.31.247]:6272 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S271950AbRHVGs5>; Wed, 22 Aug 2001 02:48:57 -0400
Message-ID: <3B8355D9.7DE64E38@home.com>
Date: Wed, 22 Aug 2001 01:48:57 -0500
From: Jordan Breeding <ledzep37@home.com>
Organization: University of Texas at Dallas - Student
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.8-ac7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: usb not working with 2.4.8-ac8
In-Reply-To: <mailman.998431141.21252.linux-kernel2news@redhat.com> <200108220004.f7M04Qx01206@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.4.8-ac7 using the alternate uhci driver both my USB keyboard
and mouse work fine.  I can't use the regular uhci driver because it
aparently has SMP issues with keyboards and like to hard lock the entire
system, no oops or anything, if any LED key
(numlock,capslock,scrolllock) is pressed enough times to turn an LED on
and then off.  Using 2.4.8-ac8 with the patch from below at least works
more than stock 2.4.8-ac8 but I still get failures: specifically the
regular uhci driver seems to work perfectly except for the issue noted
above.  But my uchi controller using the alternate uhci driver on
2.4.8-ac8 results in an unusable system, and with the patch below kind
of works.  By kind of I mean that it doesn't oops and there aren't any
of the couldn't assign id type messages but I get a ton of the "raced
timeout" messages and the mouse and keyboard only sporadically work, the
really weird thing is that while they sporadically work for X and the
console, SysRq keys on the USB keyboard seem to be perfectly
functional.  I don't feel that I need both drivers to work all the time,
but it would be nice to either get the regular uhci driver stable with
my keyboard and SMP motherboard, or get a functional alternate uchi in
-ac again.  Hope that helps in at least some small way to figure out
what happend.

Jordan

Pete Zaitcev wrote:
> 
> > Looks like the change int he usb_start_wait_urb code is a problem.
> 
> Yes, something was not right with my change.
> I am trying to coax people into testing this (on top of -ac8):
> 
> --- linux-2.4.8-ac8/drivers/usb/usb.c   Tue Aug 21 14:39:55 2001
> +++ linux-2.4.8-ac8-niph/drivers/usb/usb.c      Tue Aug 21 16:02:01 2001
> @@ -1080,10 +1080,17 @@
>         current->state = TASK_RUNNING;
>         remove_wait_queue(&awd.wqh, &wait);
> 
> -       if (!timeout) {
> -               printk("usb_control/bulk_msg: timeout\n");
> -               usb_unlink_urb(urb);  // remove urb safely
> -               status = -ETIMEDOUT;
> +       if (!awd.done) {
> +               if (urb->status != -EINPROGRESS) {      /* No callback?!! */
> +                       printk(KERN_ERR "usb: raced timeout, "
> +                           "pipe 0x%x status %d time left %d\n",
> +                           urb->pipe, urb->status, timeout);
> +                       status = urb->status;
> +               } else {
> +                       printk("usb_control/bulk_msg: timeout\n");
> +                       usb_unlink_urb(urb);  // remove urb safely
> +                       status = -ETIMEDOUT;
> +               }
>         } else
>                 status = urb->status;
> 
> 
> > I suspect either you need to add wmb() and rmb() to stop misoptimisations
> > on done (along with making it (!timeout && !awd.done)
> 
> Arjan said so too - I'll add them later just in case.
> About (!timeout && !awd.done) - it's not going to be enough,
> I think. I suspect that callback is not delivered at all
> in some circumstances, or something really screwy like that.
> 
> > there is a signal related problem - if so  making it set the state
> > to TASK_UNINTERRUPTIBLE might cure it
> 
> I tried that first and it worked, but someone disagreed. Dunno...
> 
> -- Pete
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
