Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbQJ3I7n>; Mon, 30 Oct 2000 03:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129029AbQJ3I7e>; Mon, 30 Oct 2000 03:59:34 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:10246 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129026AbQJ3I7S>; Mon, 30 Oct 2000 03:59:18 -0500
Date: Mon, 30 Oct 2000 01:55:46 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030015546.B19869@vger.timpanogas.org>
In-Reply-To: <20001030010808.B19615@vger.timpanogas.org> <Pine.LNX.4.21.0010301047030.3186-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.21.0010301047030.3186-100000@elte.hu>; from mingo@elte.hu on Mon, Oct 30, 2000 at 10:52:08AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 10:52:08AM +0100, Ingo Molnar wrote:
> 
> On Mon, 30 Oct 2000, Jeff V. Merkey wrote:
> 
> > [...] All protection has to go away in all LAN paths for this to
> > happen, and user space apps set to ring 0. [...]
> 
> i found that this is not a requirement for good network scalability. We do
> not do a syscall for every packet, so the cost evens out. Sure, it does
> not hurt to not eat ~1 microsecond per system-call, but it causes no
> overhead or scalability limit otherwise. In the TUX webserver we have
> user-space modules doing context-switch-less webserving, and it scales
> quite well, and is generic.
> 
> 	Ingo

No argument here, but the overhead of reloading CR3 period will kill
performance.  2.4 does not beat NetWare, BTW, it gets a little further,
but still hits the wall, and Netware keeps going strong, and scales 
up to 5000 users on file and print, with a SINGLE processor at less <
40% utilization.  Linux hits the wall at a few hundred file and print
users.  It's the overhead of CR3 switching at all that is causing this
and the heavy usage of Intel's protection model.

For example, if you put a MOV EAX, CR3;  MOV CR3, EAX; in a context switching
path, on a PPro 200, you can do about 35,000 context switches/second
(I did this in NetWare 4.x in 1994) with the same code without the 
CR3 reload, I could do over 2,000,000 context switches/second without
the CR3 load.  INVL Page[0] in the same path is less heavy, but still
reduced context switches to 135,000/second.  It's the CR3 activity period
that kills performance.  There's also the use of segment registers
all over the place to copy from kernel to user and user to kernel 
space memory. Having the fast paths you mention does help a lot,
but it's the fact that this goes on at all that will make it tough 
to walk into a NetWare shop with Linux and rip out NetWare servers
and replace them unless we look at a NetWare vs. NetLinux (that's 
what we call it! a NetWare-like Linux platform).  

If we had this, MS would be running for the trenches.  Coupling the 
internet application base of Linux with the speed of NetWare would
be Mr. Gate's worst nightmare.  They've been trying to kill off NetWare
for almost 15 years, and it's still out there and they are still 
slower, and everyone knows it.  It's not Linux or NT that's killing 
off NetWare, right now, it's the incompetent management in San Jose
who are trying to rape Novell's rich bank accounts 
(Schmidt and Sonsini and friends), and the fact they have no IA64
NetWare (they would be shipping it not if I were still there ....).

It could be as easy as a compile option in .config (NETWARE_SERVER_MODE [Y/N])
with WTD (which is a more sophistacted method for doing lazy VM and 
controlling context switching activity for fast path I/O) and 
mapping of te Linux address space as linear -- you can still have 
protection with this model, just some apps would be able to load
in the kernel address space, and run at ring 0).

:-)

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
