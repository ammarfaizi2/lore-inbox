Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbUAMB6i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 20:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUAMB55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 20:57:57 -0500
Received: from felinemenace.org ([65.248.4.252]:8078 "EHLO felinemenace.org")
	by vger.kernel.org with ESMTP id S263642AbUAMB5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 20:57:42 -0500
Date: Mon, 12 Jan 2004 01:48:19 -0800
From: andrewg@felinemenace.org
To: linux-kernel@vger.kernel.org
Subject: Capability problems in 2.6.1?
Message-ID: <20040112094819.GA25633@felinemenace.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I seem to be having problems with getting capabilities to work
correctly under 2.6.1. This is the code I'm using to drop it with.

#define HIGHSEC (CAP_TO_MASK(CAP_FOWNER) | CAP_TO_MASK(CAP_LINUX_IMMUTABLE) |\
                CAP_TO_MASK(CAP_NET_ADMIN) | CAP_TO_MASK(CAP_SYS_MODULE) |\
                CAP_TO_MASK(CAP_SYS_RAWIO) | CAP_TO_MASK(CAP_SYS_PACCT) |\
                CAP_TO_MASK(CAP_SYS_ADMIN) | CAP_TO_MASK(CAP_SYS_BOOT) |\
                CAP_TO_MASK(CAP_SYS_TIME) | CAP_TO_MASK(CAP_NET_RAW) |\
                CAP_TO_MASK(CAP_SYS_TTY_CONFIG) | CAP_TO_MASK(CAP_IPC_OWNER) |\
                CAP_TO_MASK(CAP_KILL) | CAP_TO_MASK(CAP_SETPCAP) |\
                CAP_TO_MASK(CAP_NET_BROADCAST) | CAP_TO_MASK(CAP_SYS_CHROOT) |\
                CAP_TO_MASK(CAP_SYS_PTRACE) | CAP_TO_MASK(CAP_SYS_NICE) |\
                CAP_TO_MASK(CAP_SYS_RESOURCE) | CAP_TO_MASK(CAP_MKNOD))

        if(current->pid != 1) {
                printk(KERN_INFO "sys_chroot(%s): HIGHSEC mask: %08x, cap_permitted: %08x, cap_inheritable: %08x, cap_effective: %08x\n", filename, HIGHSEC, current->cap_permitted, current->cap_inheritable, current->cap_effective);

                current->cap_permitted = cap_drop(current->cap_permitted, HIGHSEC);
                current->cap_inheritable = cap_drop(current->cap_inheritable, HIGHSEC);
                current->cap_effective = cap_drop(current->cap_effective, HIGHSEC);

                printk(KERN_INFO "sys_chroot(%s): HIGHSEC mask: %08x, cap_permitted: %08x, cap_inheritable: %08x, cap_effective: %08x\n", filename, HIGHSEC, current->cap_permitted, current->cap_inheritable, current->cap_effective);

        }

To test, I chroot a process, and check the /proc/self/status flag, and attempt
mounting/dismounting a filesystem (which should fail, since we are taking 
CAP_SYS_ADMIN away.). I've tried various combinations of LSM selections, but
this doesn't seem to help. I edited capability.h to change the effective set
had SET_PCAP. (Yes, I realise I should set the allowed capabilities ;) not the
opposite)

My results:	

CONFIG_SECURITY=n
	Causes the chrooted process mask to be 0xffffffff, and operations are 
	performed fine.
	
CONFIG_SECURITY=y
	Causes the chrooted process mask to be 0xf00044d7, and operations are
	performed fine.

CONFIG_SECURITY=y && CONFIG_SECURITY_CAPABILITIES=m
	When unloaded: 
		Causes the chrooted process mask to be 0xf00044d7, and 
		operations are preformed fine.		

	When loaded:
		Causes the chrooted process mask to be 0xffffffff, and 
		operations are preformed fine.

	When unloaded:
		Causes the chrooted process mask to be 0xf00044d7, and
		operations are preformed fine. (I made sure capability and
		common cap where removed.)

	When just commoncap is loaded:
		Causes the chrooted process mask to be 0xf00044d7, and
		operations are preformed fine. 

CONFIG_SECURITY=y && CONFIG_SECURITY_CAPABILITIES=y
	Causes the chrooted process mask to be 0xffffffff, and operations are
	performed fine.

It also appears securebits.h has something to do with the whole thing as well,
but I don't know. If I've missed something that causes capabilities to work in
the 2.4 (or how I remember :/) series, I'd appreciate it if anyone could 
point it out.

Otherwise, does it look like this is a bug, and possibly a bad one since
people could/would assume it would work the same as 2.4, and there previously
capability restricted binds and wu-ftpds are now open?

Thanks in advance,
Andrew Griffiths

P.S I'm not subscribed, but I'd appreciate it if you could cc me in any replies,
thanks.
