Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131052AbQKNNPY>; Tue, 14 Nov 2000 08:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131076AbQKNNPO>; Tue, 14 Nov 2000 08:15:14 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:9732 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S131052AbQKNNPJ>; Tue, 14 Nov 2000 08:15:09 -0500
Date: Tue, 14 Nov 2000 14:55:28 +0100 (MET)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] Re: reliability of linux-vm subsystem
In-Reply-To: <20001114004547.D12931@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.30.0011141244510.20626-100000@fs129-190.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Nov 2000, Erik Mouw wrote:
> On Mon, Nov 13, 2000 at 10:50:05PM +0100, Szabolcs Szakacsits wrote:
> > But it doesn't work for this kind of application misbehaviours (or
> > user attacks):
> > main() { while(1) if (fork()) malloc(1); }
> Proper process limits stop the fork bomb.

You completely missed the point. Other OS'es can survive without
process limits, Linux can't. Also fork bomb isn't really an issue
for years, the above is a memory exhaustive fork bomb [mallocing 4096
is more effective/fast]. No guarantee for a user space solution it can
do its job [especially if the kernel kills it] even if there are
"decent" limits otherwise the limits should be so strict that the
system would be close to unusable for the user.

> > or using IPC shared memory (code by Michal Zalewski)
> > int i,d=1; char*x; main(){ while(1){ x=shmat(shmget(0,10000000/d,511),0,0);
> > if(x==-1){ d*=10; continue; } for(i=0;i<10000000/d;i++) if(*(x+i)); } }
> I don't remember if this already fixed.

It was long ago. But process limits aren't enough, you should also set
/proc/sys/kernel/shmall. The default system-wide IPC shared memory
limt is 16 GB (2^34) but you can't use more than SHMMAX*SHMMNI
(2^25+2^7 on i386 by default). So the above code could be modified to
kill any small (< 4 GB RAM) Linux box if /proc/sys/kernel/shmall isn't
set.

> > With the patch below [tried only with 2.2.18pre21 but it's easy to port to
> > 2.4 and should apply to any late 2.2 kernels] Linux should also survive in
> > both cases without any performance loss (well, trashing would start about
> > the same time by adding 1.66% extra swap as the original one).
> Looks like a nice feature to me. Any VM guru that cares to comment?

I'm not a VM guru but I can comment my patch :)

- It's more like a hack not a clean solution. But IMHO a clean
  solution is a 2.5 topic.

- Race on SMP. User can acquire the reserved pages for superuser.
  Ugly and not foolproof workaround is vm_reserved *= NR_CPU

- OOM killer is interfered. If too much VM pages are reserved so there
  is still free on the swap then processes won't be killed, the system
  just trashes waiting for root to clean up. Well, this can be even
  useful but still potential deadlock if root can't log in for
  some reason [e.g. user used up other resources].

- I'm quite sure it's not a perfect solution. Kernel should be looked
  through where users can steal additional VM (e.g. network buffers)
  or what other resources they can exhaust or block (e.g. file
  descriptors, processes are OK).

- Maybe euid=0 and CAP_SYS_ADMIN should be also allowed to use
  the reserved memory in case of emergency

- compile time option

- optional real-time priority for root in emergency

> This is a mechanism vs. policy issue. The kernel hands you enough
> mechanisms (well, except your patch) to handle misbehaving users. It is
> up to the sysadmin to enforce the policy. For the home user it means
> that the distribution providers have to set decent limits, for
> enterprises it means that they have to hire a sysadmin.

I advocated about the same in the last 5 years, teaching and helping
people how to setup a safe box [even it's not my job] but you know,
after some time when the complaints are just growing you really start
to feel that something is badly broken .... especially if it could be
solved easily in kernel side saving a lot of training and setup time
and/or money. Still lot's of area where they could be spent [and
please don't get me wrong again, limits are *also* very important].

	Szaka

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
