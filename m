Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319015AbSHFIJX>; Tue, 6 Aug 2002 04:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319016AbSHFIJX>; Tue, 6 Aug 2002 04:09:23 -0400
Received: from zeus.kernel.org ([204.152.189.113]:51964 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S319015AbSHFIJW>;
	Tue, 6 Aug 2002 04:09:22 -0400
Date: Tue, 6 Aug 2002 10:10:59 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Jeff Dike <jdike@karaya.com>
Cc: rz@linux-m68k.org, alan@redhat.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode
Message-Id: <20020806101059.51ae728d.us15@os.inf.tu-dresden.de>
In-Reply-To: <200208060255.VAA04809@ccure.karaya.com>
References: <20020806021607.28a75a3d.us15@os.inf.tu-dresden.de>
	<200208060255.VAA04809@ccure.karaya.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Aug 2002 21:55:05 -0500
> 
> > If you have one process per task and a kernel process, the kernel
> > process cannot change socket ownership over to the next task's
> > process, because it's not allowed to.
> 
> Why not?  I see nothing at all in the implementation of F_SETOWN that requires
> that it be called by the current owner:
> 
> 		case F_SETOWN:
> 			lock_kernel();
> 			filp->f_owner.pid = arg;
> 			filp->f_owner.uid = current->uid;
> 			filp->f_owner.euid = current->euid;
> 			...

Ok, I was looking at sockets and not tty's and that has the following in
net/core/sock.c
                   case F_SETOWN:
                        /*
                         * This is a little restrictive, but it's the only
                         * way to make sure that you can't send a sigurg to
                         * another process.
                         */
                        if (current->pgrp != -arg &&
                                current->pid != arg &&
                                !capable(CAP_KILL)) return(-EPERM);
                        sk->proc = arg;
                        return(0);

So it wouldn't work with socketpairs, but with tty's it should.

-Udo.
