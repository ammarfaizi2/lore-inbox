Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267892AbTAMSuW>; Mon, 13 Jan 2003 13:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267972AbTAMSuW>; Mon, 13 Jan 2003 13:50:22 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:52763 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267892AbTAMSuV>; Mon, 13 Jan 2003 13:50:21 -0500
Date: Mon, 13 Jan 2003 13:59:09 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200301131859.h0DIx9s10713@devserv.devel.redhat.com>
To: Greg KH <greg@kroah.com>, torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Problems with USB
In-Reply-To: <mailman.1042437481.27105.linux-kernel2news@redhat.com>
References: <OF5C27F452.AC6AECA2-ONC1256CAC.0070FAA4@vgd.cz> <mailman.1042437481.27105.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, Jan 12, 2003 at 09:44:42PM +0100, Petr.Titera@whitesoft.cz wrote:
>>      I have problems with USB in recent kernels (tested on 2.5.56) and
>> RedHat 8.0. Right after end of script  '/etc/rc.d/rc.sysinit' and before
>> script '/etc/rc.d/rc' which runs after USB  daemon khubd gets some signal
>> and ends.

> greg k-h
> 
> # USB: Fix from Jeff and Pete to keep khubd from being able to be killed
> #      by a signal
> 
> diff -Nru a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> --- a/drivers/usb/core/hub.c	Sun Jan 12 22:03:13 2003
> +++ b/drivers/usb/core/hub.c	Sun Jan 12 22:03:13 2003
> @@ -1085,6 +1085,12 @@
>  
>  	daemonize();
>  
> +	/* keep others from killing us */
> +	spin_lock_irq(&current->sig->siglock);
> +	sigemptyset(&current->blocked);
> +	recalc_sigpending();
> +	spin_unlock_irq(&current->sig->siglock);
> +
>  	/* Setup a nice name */
>  	strcpy(current->comm, "khubd");
>  

For the record, I disagree with this strongly.

In khubd case, the existing code did it righ. It ran
daemonize(), which should have divorced it from the session
and process group. If daemonize is buggy, it is the place
to fix it. Ingo has the fix for 2.5, in fact, I think he
may have sent it to Linus already (it's __set_special_pids()).

My version of the patch above never was intended as anything
but a stop-gap solution which allowed us to ship a beta on
schedule, while I was investigating the cause.

Jeff told me on IRC that "every bit in 8139too.c thread was
added as a response to a particular problem", but he did not
remember what particular problem this kludge fixed there.

I stole the stop-gap from Stephen's kjournald. Note, that
I do not have any idea why he put it in there. Very likely,
for entirely different reason than working around bugs in
daemonize().

-- Pete

[P.S. Greg, if Jeff's P.O.V. prevails in the court of Linus,
change that sigemptyset() to siginitsetinv(...., sigmask(SIGKILL)).
Otherwise the whole signal checking path in khubd becomes utterly
meaningless.]

[P.P.S And take my name from the bk message. Yes, I wrote
the patch, but I do not want to endorse it, however indirectly]
