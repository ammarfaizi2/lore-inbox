Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSHFR6w>; Tue, 6 Aug 2002 13:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315168AbSHFR6w>; Tue, 6 Aug 2002 13:58:52 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:28042 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S315167AbSHFR6v>; Tue, 6 Aug 2002 13:58:51 -0400
Date: Tue, 6 Aug 2002 20:01:52 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode
Message-Id: <20020806200152.6344802d.us15@os.inf.tu-dresden.de>
In-Reply-To: <200208061742.g76HgIg31452@karaya.com>
References: <20020806180202.66f1865a.us15@os.inf.tu-dresden.de>
	<200208061742.g76HgIg31452@karaya.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.k_:YaiBmqlV9?j"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.k_:YaiBmqlV9?j
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 06 Aug 2002 13:42:18 -0400
Jeff Dike <jdike@karaya.com> wrote:

> A couple of ways.  The system call path can call sigio_handler to clear
> out any pending IO.  The SIGIO that was trapped in the process will cause
> another call to sigio_handler which won't turn up any IO, but I don't 
> consider that to be a problem.

It is not a problem at all, just a small performance penalty.

> The kernel process can examine the signal pending mask of the process after
> it has transferred SIGIO to itself.  This can be done either through 
> /proc/<pid>/status or a ptrace extension, since we're happily postulating 
> new things for it to do anyway.  If there is a SIGIO pending, it calls
> sigio_handler.

I don't like the idea of having to fiddle with the proc filesystem. Some
people might not even mount it. A ptrace extension to look at and modify
the pending signal mask of a traced process would be very handy.

> Any other possibilities that you see?

Right now I'm doing something hackish. If the process enters with a syscall
(int 0x30 in my case) after the kernel expects it to enter due to an interrupt,
I just restart the task until it enters with the pending interrupt signal (SIGIO).
The task will do that before it can step on the int instruction again, and after
it returns to usermode it will step on the int again. This works well with faults.
The problem are traps, because the EIP points behind the instruction. In that
case the EIP needs to be adjusted. Ugly, I know.

-Udo.


--=.k_:YaiBmqlV9?j
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9UA8QnhRzXSM7nSkRAqqVAJ4z5v7BkTy2kzUEnmMH1O6f8XpYVACdE2Pq
qYB0O08GltxXZxHPRPwwWJo=
=ElMD
-----END PGP SIGNATURE-----

--=.k_:YaiBmqlV9?j--

