Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262820AbSJAUrv>; Tue, 1 Oct 2002 16:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262833AbSJAUrv>; Tue, 1 Oct 2002 16:47:51 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:3579 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S262820AbSJAUrt>; Tue, 1 Oct 2002 16:47:49 -0400
Date: Tue, 1 Oct 2002 13:45:52 -0700
From: Chris Wright <chris@wirex.com>
To: linux-kernel@vger.kernel.org
Cc: dan@debian.org
Subject: Re: Capabilities-related change in 2.5.40
Message-ID: <20021001134552.A26557@figure1.int.wirex.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, dan@debian.org
References: <20021001164907.GA25307@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021001164907.GA25307@nevyn.them.org>; from dan@debian.org on Tue, Oct 01, 2002 at 12:49:07PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Daniel Jacobowitz (dan@debian.org) wrote:
> First of all, I think the LSM code is confused in its use of cap_t.  I think
> that cap_capget should be using to_cap_t instead; it's converting _to_ a
> kernel_cap_t, right?

I believe capget should be using cap_t (it's been this way since
2.2).  The macros are kind of meaningless unless you have defined
STRICT_CAP_T_TYPECHECKS.  And anyway, cap_t is used to extract a cap
(to a __u32) from a structure.  While to_cap_t is used to place a __u32
in a cap structure.  capget is retrieving the value from a structure and
simply placing it in a __u32 that is copied back to userspace.  However,
there is a merge error there with duplicate code.

--- 1.5/kernel/capability.c	Sun Sep 15 12:19:29 2002
+++ edited/capability.c	Tue Oct  1 13:30:19 2002
@@ -60,9 +60,6 @@
           goto out;
      }
 
-     data.permitted = cap_t(target->cap_permitted);
-     data.inheritable = cap_t(target->cap_inheritable); 
-     data.effective = cap_t(target->cap_effective);
      ret = security_ops->capget(target, &data.effective, &data.inheritable, &data.permitted);
 
 out:

> Second of all, my login shell (as a user) gets a very bizarre response to sys_capget:
> 
> capget(0x19980330, 0, {CAP_CHOWN | CAP_DAC_OVERRIDE | CAP_DAC_READ_SEARCH |
>   CAP_FOWNER | CAP_FSETID | CAP_KILL | CAP_SETGID | CAP_SETUID |
>   CAP_LINUX_IMMUTABLE | CAP_NET_BIND_SERVICE | CAP_NET_BROADCAST |
>   CAP_NET_ADMIN | CAP_NET_RAW | CAP_IPC_LOCK | CAP_IPC_OWNER | CAP_SYS_MODULE
>   | CAP_SYS_RAWIO | CAP_SYS_CHROOT | CAP_SYS_PTRACE | CAP_SYS_PACCT |
>   CAP_SYS_ADMIN | CAP_SYS_BOOT | CAP_SYS_NICE | CAP_SYS_RESOURCE |
>   CAP_SYS_TIME | CAP_SYS_TTY_CONFIG | 0xf8000000,
>   CAP_CHOWN | CAP_DAC_OVERRIDE
>   | CAP_DAC_READ_SEARCH | CAP_FOWNER | CAP_FSETID | CAP_KILL | CAP_SETGID |
>   CAP_SETUID | CAP_SETPCAP | CAP_LINUX_IMMUTABLE | CAP_NET_BIND_SERVICE |
>   CAP_NET_BROADCAST | CAP_NET_ADMIN | CAP_NET_RAW | CAP_IPC_LOCK |
>   CAP_IPC_OWNER | CAP_SYS_MODULE | CAP_SYS_RAWIO | CAP_SYS_CHROOT |
>   CAP_SYS_PTRACE | CAP_SYS_PACCT | CAP_SYS_ADMIN | CAP_SYS_BOOT | CAP_SYS_NICE
>   | CAP_SYS_RESOURCE | CAP_SYS_TIME | CAP_SYS_TTY_CONFIG | 0xf8000000,}) = 0
> 
> The reason?  cap_get_proc has always been broken.  But the capability set of
> task 0, swapper, has now changed.  It used to be empty.  So, I'll go report
> this to libcap.  The change in capabilities for swapper is presumably
> benign.

I'm not sure what you are pointing out?  Is cap_get_proc using header.pid = 0
regardless?  Hmm, yes.

cap_get_proc()
	cap_init()
		malloc
		memset(0)
		head.version = _LINUX_CAPABILITY_VERSION
	capget(&head, &set)	<-- head.pid = 0


Also, I've just looked at 2.2, 2.4, 2.5 and they all have the same caps
for INIT_TASK:

2.2
#define CAP_FULL_SET        to_cap_t(~0)
#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
#define CAP_INIT_INH_SET    to_cap_t(0)
/* caps */	CAP_INIT_EFF_SET,CAP_INIT_INH_SET,CAP_FULL_SET,	\
/* keep_caps */	0,  						\

2.4
#define CAP_FULL_SET        to_cap_t(~0)
#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
#define CAP_INIT_INH_SET    to_cap_t(0)
    cap_effective:	CAP_INIT_EFF_SET,	\
    cap_inheritable:	CAP_INIT_INH_SET,	\
    cap_permitted:	CAP_FULL_SET,		\
    keep_capabilities:	0,			\

2.5
#define CAP_FULL_SET        to_cap_t(~0)
#define CAP_INIT_EFF_SET    to_cap_t(~0 & ~CAP_TO_MASK(CAP_SETPCAP))
#define CAP_INIT_INH_SET    to_cap_t(0)
	.cap_effective  = CAP_INIT_EFF_SET,	\
	.cap_inheritable = CAP_INIT_INH_SET,	\
	.cap_permitted  = CAP_FULL_SET,		\
	.keep_capabilities = 0,			\

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
