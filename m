Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281879AbRKWELi>; Thu, 22 Nov 2001 23:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281880AbRKWEL1>; Thu, 22 Nov 2001 23:11:27 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:38928 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S281879AbRKWELL>;
	Thu, 22 Nov 2001 23:11:11 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15357.51377.732840.867724@cargo.ozlabs.ibm.com>
Date: Fri, 23 Nov 2001 14:55:29 +1100 (EST)
To: "Christopher Friesen" <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problem accessing /dev/port
In-Reply-To: <3BFD769A.376003D5@nortelnetworks.com>
In-Reply-To: <3BFD769A.376003D5@nortelnetworks.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher Friesen writes:

> To begin, I'm running 2.2.17 with some patches.
> 
> I'm attempting to have a userspace app read and write I/O ports on a powerpc
> machine.  The obvious method (iopl()) doesn't seem to be available (using glibc,
> but sys/io.h doesn't exist).
> 
> When I try and access /dev/port with a small utility that works fine on my PIII,
> I get the error message "Device not configured".  The file exists in /dev and
> has the same permissions on both machines.

If you look in drivers/char/mem.c you will see an #if that eliminates
the statement filp->f_op = &port_fops if CONFIG_PPC is defined.  The
reason for this is that accessing a non-existent I/O port on powermacs
generates a machine check interrupt which, in 2.2.x kernels, causes a
panic.  The situation is better in 2.4 because we catch the machine
check and arrange for inb/w/l to return ~0.

> Do I need to enable something in the kernel to support this?  Where is this
> configured?

Change the #if line to take out the defined(CONFIG_PPC) part.

The other way to access I/O from userspace is to mmap /dev/mem at the
offset that corresponds to the physical address where your PCI host
bridge maps PCI I/O space, e.g. you would use an offset of 0xfe000000
for an MPC106 (grackle) bridge.  Once again the situation is better in
2.4 since you can mmap the /proc/bus/pci/bb/dd.f file corresponding to
your pci device and access its memory and I/O regions that way.

Paul.
