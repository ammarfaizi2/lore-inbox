Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266280AbUANEKo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 23:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUANEKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 23:10:44 -0500
Received: from felinemenace.org ([65.248.4.252]:23200 "EHLO felinemenace.org")
	by vger.kernel.org with ESMTP id S266280AbUANEKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 23:10:40 -0500
Date: Tue, 13 Jan 2004 20:08:21 -0800
From: andrewg@felinemenace.org
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Capability problems in 2.6.1?
Message-ID: <20040114040821.GC8928@felinemenace.org>
References: <20040112094819.GA25633@felinemenace.org> <20040113161737.A30560@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113161737.A30560@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 04:17:37PM -0800, Chris Wright wrote:
> * andrewg@felinemenace.org (andrewg@felinemenace.org) wrote:
> > Hello,
> > 
> > 	I seem to be having problems with getting capabilities to work
> > correctly under 2.6.1. This is the code I'm using to drop it with.
> 
> I'm aware of one bug here.  However, I'm not entirely sure what bug
> you're trying to report.  Specifically, you show the cap_eff values
> (which appear inconsistent) as well as saying operations perform fine in
> each case.  Does this mean you are allowed to mount when you took away
> CAP_SYS_ADMIN (buggy) or that you were properly denied?

I'm reporting that mount worked find when CAP_SYS_ADMIN was taken away.

Whats buggy about it? :

> 
> > #define HIGHSEC (CAP_TO_MASK(CAP_FOWNER) | CAP_TO_MASK(CAP_LINUX_IMMUTABLE) |\
> >                 CAP_TO_MASK(CAP_NET_ADMIN) | CAP_TO_MASK(CAP_SYS_MODULE) |\
> >                 CAP_TO_MASK(CAP_SYS_RAWIO) | CAP_TO_MASK(CAP_SYS_PACCT) |\
> >                 CAP_TO_MASK(CAP_SYS_ADMIN) | CAP_TO_MASK(CAP_SYS_BOOT) |\
> >                 CAP_TO_MASK(CAP_SYS_TIME) | CAP_TO_MASK(CAP_NET_RAW) |\
> >                 CAP_TO_MASK(CAP_SYS_TTY_CONFIG) | CAP_TO_MASK(CAP_IPC_OWNER) |\
> >                 CAP_TO_MASK(CAP_KILL) | CAP_TO_MASK(CAP_SETPCAP) |\
> >                 CAP_TO_MASK(CAP_NET_BROADCAST) | CAP_TO_MASK(CAP_SYS_CHROOT) |\
> >                 CAP_TO_MASK(CAP_SYS_PTRACE) | CAP_TO_MASK(CAP_SYS_NICE) |\
> >                 CAP_TO_MASK(CAP_SYS_RESOURCE) | CAP_TO_MASK(CAP_MKNOD))
> > 
> >         if(current->pid != 1) {
> >                 printk(KERN_INFO "sys_chroot(%s): HIGHSEC mask: %08x, cap_permitted: %08x, cap_inheritable: %08x, cap_effective: %08x\n", filename, HIGHSEC, current->cap_permitted, current->cap_inheritable, current->cap_effective);
> > 
> >                 current->cap_permitted = cap_drop(current->cap_permitted, HIGHSEC);
> >                 current->cap_inheritable = cap_drop(current->cap_inheritable, HIGHSEC);
> >                 current->cap_effective = cap_drop(current->cap_effective, HIGHSEC);
> > 
> >                 printk(KERN_INFO "sys_chroot(%s): HIGHSEC mask: %08x, cap_permitted: %08x, cap_inheritable: %08x, cap_effective: %08x\n", filename, HIGHSEC, current->cap_permitted, current->cap_inheritable, current->cap_effective);
> > 
> >         }
> 
> I assume this is code you added to sys_chroot().
> 
> > To test, I chroot a process, and check the /proc/self/status flag, and attempt
> 
> Do you have your own test process that calls chroot(2) itself, or are you
> using chroot(1) (which will do an execve(2)).  If you are doing the
> latter, the execve(2) basically resets the capabilities.

Okay, so why would the capabilities show to be masked out? I have been using
chroot + execve. I'll write a test program later, and report.

> 
> > mounting/dismounting a filesystem (which should fail, since we are taking 
> > CAP_SYS_ADMIN away.). I've tried various combinations of LSM selections, but
> > this doesn't seem to help. I edited capability.h to change the effective set
> > had SET_PCAP. (Yes, I realise I should set the allowed capabilities ;) not the
> > opposite)
> 
> OK, so all the 0xffffffff below reflect the added CAP_SETPCAP (typically it'd
> be 0xfffffeff).
> 
> > CONFIG_SECURITY=n
> > 	Causes the chrooted process mask to be 0xffffffff, and operations are 
> > 	performed fine.
> 
> OK, w/out CONFIG_SECURITY you have created a kernel that is most like
> the 2.4 kernels with capabilities built in.
> 
> > 	
> > CONFIG_SECURITY=y
> > 	Causes the chrooted process mask to be 0xf00044d7, and operations are
> > 	performed fine.
> 
> This means you are just using the default LSM hooks, which (as of now)
> don't care about any of the cap_* fields.
> 
> > CONFIG_SECURITY=y && CONFIG_SECURITY_CAPABILITIES=m
> > 	When unloaded: 
> > 		Causes the chrooted process mask to be 0xf00044d7, and 
> > 		operations are preformed fine.		
> 
> using default hooks, as above.
> 
> > 	When loaded:
> > 		Causes the chrooted process mask to be 0xffffffff, and 
> > 		operations are preformed fine.
> 
> capabilities installed, execve() will reset the cap_* fields.
> 
> > 	When unloaded:
> > 		Causes the chrooted process mask to be 0xf00044d7, and
> > 		operations are preformed fine. (I made sure capability and
> > 		common cap where removed.)
> 
> using default hooks.
> 
> > 	When just commoncap is loaded:
> > 		Causes the chrooted process mask to be 0xf00044d7, and
> > 		operations are preformed fine. 
> 
> ditto.
> 
> > CONFIG_SECURITY=y && CONFIG_SECURITY_CAPABILITIES=y
> > 	Causes the chrooted process mask to be 0xffffffff, and operations are
> > 	performed fine.
> 
> capabilities installed, execve() will reset the cap_* fields.
> 
> > It also appears securebits.h has something to do with the whole thing as well,
> > but I don't know. If I've missed something that causes capabilities to work in
> > the 2.4 (or how I remember :/) series, I'd appreciate it if anyone could 
> > point it out.
> 
> The cases where you have capabilities loaded are behaving the same as
> 2.4.

Okay, thats good to know. I notice in securebits.h, there is SECURE_NOROOT
and SECURE_NO_SETUID_FIXUP, can they do what I'd like (capabilities are
transferred across execve, and aren't dropped? If so, how I can use it?

> 
> > Otherwise, does it look like this is a bug, and possibly a bad one since
> > people could/would assume it would work the same as 2.4, and there previously
> > capability restricted binds and wu-ftpds are now open?
> 
> Those will rely on capset(2) which will (should) return an error from
> modules that don't support the interface.
> 
> thanks,
> -chris
> -- 
> Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

Thanks,
Andrew Griffiths
