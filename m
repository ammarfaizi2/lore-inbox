Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbQKPOKO>; Thu, 16 Nov 2000 09:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130304AbQKPOKF>; Thu, 16 Nov 2000 09:10:05 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59696 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130139AbQKPOJq>; Thu, 16 Nov 2000 09:09:46 -0500
Subject: Re: [PATCH] pcmcia event thread. (fwd)
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 16 Nov 2000 13:39:05 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), torvalds@transmeta.com,
        dhinds@valinux.com, linux-kernel@vger.kernel.org
In-Reply-To: <3A1009DB.CC98CE06@mandrakesoft.com> from "Jeff Garzik" at Nov 13, 2000 10:33:47 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wPFs-0007og-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > up_and_exit() would do it. Or preferably passing the address of the
> > semaphore as an extra argument to kernel_thread() in the first place.
> 
> Any solution which involves a function being called from a kernel
> thread, and/or passing another arg to a kernel thread, is a non-starter
> ...  See the discussion about timer_exit() a while ago.  This sort of

timer_exit is a completely unrelated situation

> IMHO it is possible to solve this in a generic way without having to
> change the code for every single kernel thread.

It comes entirely down to one thing. The termination function of the thread
has to be code in the kernel code not a module. Thats it, nothing else. So
you just need some kind of sleep/wakeup proceedure for it.

As far as I can see all you need is


wait_and_die(sem)
{
	up(&sem);	/* In the kernel so can unload */
	sys_exit(0);	/* Never return to the unloaded module code */
}

in the main kernel. In fact if you were bored you could build this on the kernel
stack ;)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
