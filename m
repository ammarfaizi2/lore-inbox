Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318963AbSHFBxQ>; Mon, 5 Aug 2002 21:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318964AbSHFBxQ>; Mon, 5 Aug 2002 21:53:16 -0400
Received: from mnh-1-09.mv.com ([207.22.10.41]:40966 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S318963AbSHFBxP>;
	Mon, 5 Aug 2002 21:53:15 -0400
Message-Id: <200208060255.VAA04809@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
Cc: rz@linux-m68k.org, alan@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode 
In-Reply-To: Your message of "Tue, 06 Aug 2002 02:16:07 +0200."
             <20020806021607.28a75a3d.us15@os.inf.tu-dresden.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 05 Aug 2002 21:55:05 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

us15@os.inf.tu-dresden.de said:
> If my understanding of UML is right, you implement interrupts with
> socket pairs where the interrupt handler writes a byte into one end
> and the other end receives an async notification (SIGIO). 

It sounds like you're confusing two mechanisms.  Device interrupts are 
implemented with something that supports SIGIO (socketpair, tty) with one
end outside UML and one end inside UML generating the SIGIOs.

I use socketpairs in the way you describe to implement context switching.
Out-of-context processes are sleeping in a read on their socket, and are
woken up by an soon-to-be-out-of-context process writing a byte down it.
There's no SIGIO there at all.

I also use socketpairs with SIGIO to implement IPIs on SMP UML.

> In order to
> stop the right task with a SIGIO, you change the socket owner on each
> context switch using fcntl. 

Yup.  More precisely, in order to ensure that the correct process receives
SIGIO when input comes in from the outside, I F_SETOWN the descriptors to
the incoming process during a context switch.

> If you have one process per task and a kernel process, the kernel
> process cannot change socket ownership over to the next task's
> process, because it's not allowed to.

Why not?  I see nothing at all in the implementation of F_SETOWN that requires
that it be called by the current owner:

		case F_SETOWN:
			lock_kernel();
			filp->f_owner.pid = arg;
			filp->f_owner.uid = current->uid;
			filp->f_owner.euid = current->euid;
			...

There are no general checks earlier in do_fcntl or sys_fcntl either.

				Jeff

