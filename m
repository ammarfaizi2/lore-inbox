Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262938AbVGNHMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262938AbVGNHMI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 03:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVGNHMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 03:12:08 -0400
Received: from web32007.mail.mud.yahoo.com ([68.142.207.104]:63910 "HELO
	web32007.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262938AbVGNHMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 03:12:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=rKXA8zcp9YAPoyxt5RbJG5Ki1gVYA+sSdK3cbbfBUSv1IdAF7VucALUFoUkS6MqD6zb3zUUrnP+19rEiX5o4OPxwkRxrxOecguJxDgowElFC9IK26QHnzXq+7UjPwDq8nEYa54S5+wtH7wiU4aF/SSEqpsfl3YzQ5Twci9fsXcw=  ;
Message-ID: <20050714071202.88368.qmail@web32007.mail.mud.yahoo.com>
Date: Thu, 14 Jul 2005 00:12:02 -0700 (PDT)
From: Sam Song <samlinuxkernel@yahoo.com>
Subject: Re: [patch 2.6.13-git] 8250 tweaks
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: mgreer@mvista.com, david-b@pacbell.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050713134837.B6791@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> v. whining
> 
>     1. To utter a plaintive, high-pitched,
> protracted sound, as in pain,
>        fear, supplication, or complaint.
>     2. To complain or protest in a childish fashion.
>     3. To produce a sustained noise of relatively
> high pitch: jet engines
>        whining.
> 
> The kernel isn't doing any of those.

Oops, I misused this word. Thanks for your correction.
 
> Anyway, you're going to have to help me out a lot -

I'd love to:-)

> Also, having the contents of /sys/devices/platform
> or /sys/bus/platform/* would be useful.
> 
> For some reason, it appears that the serial driver
> is being asked to register two serial ports at MMIO 
> address 0, from one platform device,
> which it apparantly detects as being present.  I
> suspect these are coming from some table included 
> via asm-ppc/serial.h, but where that
> is I've no idea.
> 
> It's then asked to add two more ports from the
> serial8250.0 device, which doesn't exist.  These 
> come from a platform device in arch/ppc.
> Again, where these come from I don't know.

It doesn't matter. Your notes is good enough to put
me the right direction to find out the bug in my 
platform.

> So.  The serial driver is being asked to create
> _four_ ports.  It's created two, but can't create 
> the other two, failing with error -22.
> 22 is EINVAL, which means there was something wrong
> with what was requested.  That generally points to 
> uartclk being zero, which would
> be a bug in the PPC architecture code.  You can
> confirm this by applying this patch:

Sure. The uartclk printed zero. Your simple patch
did a good help. Then I tracked down to the _four_
port registering and finally picked out the "bug".

It turned out the conflict of uart init definition 
like MPC10X_UART0_IRQ in ../syslib/mpc10x_common.c 
and SERIAL_PORT_DFNS in ../platform/sandpoint.h. By
now, only MPC10X_UART0_IRQ stuff is needed. 
SERIAL_PORT_DFNS should be omitted. 

Seems it's time for me to stand with Russell:-)

I must confess that I am a stupid guy on kernel 
programming. The result on PPC side, I mean sandpoint
board, still needs Mark's confirmation.

Following is the bug-fixed boot log on a custom
8241 board. 

Loading kernel ......
Linux version 2.6.13-rc3 (root@sam.acs.net) (gcc
version 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-
......
Based on the Freescale Sandpoint Development System
Built 1 zonelists
Kernel command line: console=ttyS1,115200 
root=/dev/nfs rw
nfsroot=192.168.57.200:/opt/eldk3/ppc_82xx 
ip=192.168.57.243:192.1OpenPIC
Version 1.2 (1 CPUs and 11 IRQ sources) at fdf40000
OpenPIC timer frequency is 100.000000 MHz
PID hash table entries: 512 (order: 9, 8192 bytes)
time_init: decrementer frequency = 25.000000 MHz
Dentry cache hash table entries: 16384 (order: 4, 
65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 
bytes)
Memory: 62848k available (1572k kernel code, 388k 
data, 104k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 1 of device 
0000:00:00.0
inotify syscall
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096
bytes)
Installing knfsd (copyright (C) 1996
okir@monad.swb.de).
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports,
IRQ sharing disabled
ttyS0 at MMIO 0xfdf04500 (irq = 9) is a 16550A
ttyS1 at MMIO 0xfdf04600 (irq = 10) is a 16550A
io scheduler noop registered
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
PPP BSD Compression module registered
......
IP-Config: Guessing netmask 255.255.255.0
IP-Config: Complete:
      device=eth0, addr=192.168.57.243,
mask=255.255.255.0,
gw=255.255.255.255,
     host=8241, domain=, nis-domain=(none),
     bootserver=192.168.57.200,
rootserver=192.168.57.200, rootpath=
Looking up port of RPC 100003/2 on 192.168.57.200
Looking up port of RPC 100005/1 on 192.168.57.200
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 104k init
INIT: version 2.84 booting
        Welcome to DENX Embedded Linux Environment
        Press 'I' to enter interactive startup.
Building the cache [  OK  ]
Mounting proc filesystem:  [  OK  ]
Configuring kernel parameters:  [  OK  ]
......
Mounting NFS filesystems:  [  OK  ]
Mounting other filesystems:  [  OK  ]
Starting xinetd: [  OK  ]

8241 login: root
Last login: Wed Dec 31 19:00:33 on console
bash-2.05b# ls
bash-2.05b# cd /
bash-2.05b# ls
bin   dev  images  lib    mnt   root  tmp  var
boot  etc  proc  sbin  usr
bash-2.05b# cat /proc/interrupts
           CPU0
  0:      18707   OpenPIC   Level     eth0
 10:        258   OpenPIC   Level     serial
BAD:         14

Thanks for your time,

Sam

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
