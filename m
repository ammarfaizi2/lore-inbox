Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316635AbSFDTmN>; Tue, 4 Jun 2002 15:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316636AbSFDTmM>; Tue, 4 Jun 2002 15:42:12 -0400
Received: from air-2.osdl.org ([65.201.151.6]:13703 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316635AbSFDTmL>;
	Tue, 4 Jun 2002 15:42:11 -0400
Date: Tue, 4 Jun 2002 12:38:06 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: "David S. Miller" <davem@redhat.com>
cc: <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
In-Reply-To: <20020604.111337.51699424.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0206041227410.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Jun 2002, David S. Miller wrote:

>    From: Patrick Mochel <mochel@osdl.org>
>    Date: Tue, 4 Jun 2002 08:50:11 -0700 (PDT)
> 
>    On Sun, 2 Jun 2002, David S. Miller wrote:
>    
>    > It's happening on every platform.  It should be done before
>    > arch_initcalls actually, but after core_initcalls.  I would suggest to
>    > rename unused_initcall into postcore_iniscall, then use it for this
>    > and sys_bus_init which has the same problem.
>    
>    Can't it go the other way? Instead of mass-promotion of the setup 
>    functions, can't we demote the ones that are causing the problems? 
>    
> There's this middle area between core and subsys, why not
> just be explicit about it's existence?
> 
> Short of making the true dependencies describable, I think my
> postcore_initcall solution is fine.

What sense is there in naming it postcore_initcall? What does it tell you 
about the intent of the function? 

The problem is that if we have arbitrary names with arbitrary priority 
levels, people will think they're more important than most, if not all, of 
the other initcall users and leapfrog over them into earlier levels. It's 
already happened at least once, and I expect to happen more. 

The initcall levels are not a means to bypass true dependency resolution. 
They're an alternative means to solving some of the dependency problems 
without having a ton of #ifdefs and hardcoded, explicit calls to 
initialization routines. 

We can add more levels and change names. But, we should make them 
meaningful for at least two reasons:

- It's obvious to people who are using them what they should use
- It's obvious to someone looking at the code when it gets initialized

That said, how about doing this:

- core
- subsys
- arch
- driver

core initializes the core, as always.

subsys initializes bus and device class subsystems and registers them with 
the core.

arch does arch- and platform- specific initlization. arch_initcalls 
appear only in arch/ subdirectories, and they happen after 
subsys_initcalls. 

driver initializes all the device drivers compiled in. 

	-pat

