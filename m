Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262505AbSJAVGU>; Tue, 1 Oct 2002 17:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262514AbSJAVGU>; Tue, 1 Oct 2002 17:06:20 -0400
Received: from crack.them.org ([65.125.64.184]:43524 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262505AbSJAVGR>;
	Tue, 1 Oct 2002 17:06:17 -0400
Date: Tue, 1 Oct 2002 17:12:11 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Capabilities-related change in 2.5.40
Message-ID: <20021001211210.GA8784@nevyn.them.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021001164907.GA25307@nevyn.them.org> <20021001134552.A26557@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021001134552.A26557@figure1.int.wirex.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2002 at 01:45:52PM -0700, Chris Wright wrote:
> > Second of all, my login shell (as a user) gets a very bizarre response to sys_capget:
> > 
> > capget(0x19980330, 0, {CAP_CHOWN | CAP_DAC_OVERRIDE | CAP_DAC_READ_SEARCH |
> >   CAP_FOWNER | CAP_FSETID | CAP_KILL | CAP_SETGID | CAP_SETUID |
> >   CAP_LINUX_IMMUTABLE | CAP_NET_BIND_SERVICE | CAP_NET_BROADCAST |
> >   CAP_NET_ADMIN | CAP_NET_RAW | CAP_IPC_LOCK | CAP_IPC_OWNER | CAP_SYS_MODULE
> >   | CAP_SYS_RAWIO | CAP_SYS_CHROOT | CAP_SYS_PTRACE | CAP_SYS_PACCT |
> >   CAP_SYS_ADMIN | CAP_SYS_BOOT | CAP_SYS_NICE | CAP_SYS_RESOURCE |
> >   CAP_SYS_TIME | CAP_SYS_TTY_CONFIG | 0xf8000000,
> >   CAP_CHOWN | CAP_DAC_OVERRIDE
> >   | CAP_DAC_READ_SEARCH | CAP_FOWNER | CAP_FSETID | CAP_KILL | CAP_SETGID |
> >   CAP_SETUID | CAP_SETPCAP | CAP_LINUX_IMMUTABLE | CAP_NET_BIND_SERVICE |
> >   CAP_NET_BROADCAST | CAP_NET_ADMIN | CAP_NET_RAW | CAP_IPC_LOCK |
> >   CAP_IPC_OWNER | CAP_SYS_MODULE | CAP_SYS_RAWIO | CAP_SYS_CHROOT |
> >   CAP_SYS_PTRACE | CAP_SYS_PACCT | CAP_SYS_ADMIN | CAP_SYS_BOOT | CAP_SYS_NICE
> >   | CAP_SYS_RESOURCE | CAP_SYS_TIME | CAP_SYS_TTY_CONFIG | 0xf8000000,}) = 0
> > 
> > The reason?  cap_get_proc has always been broken.  But the capability set of
> > task 0, swapper, has now changed.  It used to be empty.  So, I'll go report
> > this to libcap.  The change in capabilities for swapper is presumably
> > benign.
> 
> I'm not sure what you are pointing out?  Is cap_get_proc using header.pid = 0
> regardless?  Hmm, yes.
> 
> cap_get_proc()
> 	cap_init()
> 		malloc
> 		memset(0)
> 		head.version = _LINUX_CAPABILITY_VERSION
> 	capget(&head, &set)	<-- head.pid = 0
> 

Yes.  It was pointed out to me that libcap2 snapshots behave correctly.

> Also, I've just looked at 2.2, 2.4, 2.5 and they all have the same caps
> for INIT_TASK:
> 
> 2.2
> #define CAP_FULL_SET        to_cap_t(~0)
> #define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
> #define CAP_INIT_INH_SET    to_cap_t(0)
> /* caps */	CAP_INIT_EFF_SET,CAP_INIT_INH_SET,CAP_FULL_SET,	\
> /* keep_caps */	0,  						\
> 
> 2.4
> #define CAP_FULL_SET        to_cap_t(~0)
> #define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
> #define CAP_INIT_INH_SET    to_cap_t(0)
>     cap_effective:	CAP_INIT_EFF_SET,	\
>     cap_inheritable:	CAP_INIT_INH_SET,	\
>     cap_permitted:	CAP_FULL_SET,		\
>     keep_capabilities:	0,			\
> 
> 2.5
> #define CAP_FULL_SET        to_cap_t(~0)
> #define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
> #define CAP_INIT_INH_SET    to_cap_t(0)
> 	.cap_effective  = CAP_INIT_EFF_SET,	\
> 	.cap_inheritable = CAP_INIT_INH_SET,	\
> 	.cap_permitted  = CAP_FULL_SET,		\
> 	.keep_capabilities = 0,			\

Not init: swapper.  Try it on 2.4:
drow@nevyn:~% getpcaps 0
Capabilities for `0': =

2.5.40 gives me a very different answer :)

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
