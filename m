Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275155AbRJAPgB>; Mon, 1 Oct 2001 11:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275161AbRJAPfu>; Mon, 1 Oct 2001 11:35:50 -0400
Received: from Cambot.lecs.CS.UCLA.EDU ([131.179.144.110]:13584 "EHLO
	cambot.lecs.cs.ucla.edu") by vger.kernel.org with ESMTP
	id <S275155AbRJAPff>; Mon, 1 Oct 2001 11:35:35 -0400
Message-Id: <200110011536.f91Fa2k21097@cambot.lecs.cs.ucla.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FUSD v1.00: Framework for User-Space Devices 
In-Reply-To: <200109290118.f8T1Ixk05717@cambot.lecs.cs.ucla.edu> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21094.1001950562.1@cambot.lecs.cs.ucla.edu>
Date: Mon, 01 Oct 2001 08:36:02 -0700
From: Jeremy Elson <jelson@circlemud.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry to follow-up to my own post.  A few people pointed out that
v1.00 had some Makefile problems that prevented it from building.
I've released v1.02, which should be fixed.

Best,
Jer

Jeremy Elson writes:
>On behalf of Sensoria Corporation, I'm happy to announce the first
>public release of FUSD, a Linux Framework for User-Space Devices.
>
>Briefly, FUSD lets you write user-space daemons that can respond to
>device-file callbacks on files in /dev.  These device files look and
>act just like any other device file from the point of view of a
>process trying to use them.  When the FUSD kernel module receives a
>file callback on a device being managed from user-space, it marshals
>the arguments into a message (including data copied from the caller,
>if necessary), blocks the caller, and sends the message to the daemon
>managing the device.  When the daemon generates a reply, the process
>happens in reverse, and the caller is unblocked.
>
>More information can be found at the official FUSD home page:
>http://www.circlemud.org/~jelson/software/fusd
>
>I've pasted a portion of the README file below, which has a somewhat
>more detailed description of what FUSD is and does.  A much more
>comprehensive user manual is available on the web page (above).
>
>Best regards,
>Jeremy
>
>--------
>
>
>WHAT IS FUSD?
>=============
>
>FUSD (pronounced "fused") is a Linux framework for proxying device
>file callbacks into user-space, allowing device files to be
>implemented by daemons instead of kernel code.  Despite being
>implemented in user-space, FUSD devices can look and act just like any
>other file under /dev which is implemented by kernel callbacks.
>
>A user-space device driver can do many of the things that kernel
>drivers can't, such as perform a long-running computation, block while
>waiting for an event, or read files from the file system.  Unlike
>kernel drivers, a user-space device driver can use other device
>drivers--that is, access the network, talk to a serial port, get
>interactive input from the user, pop up GUI windows, or read from
>disks.  User-space drivers implemented using FUSD can be much easier to
>debug; it is impossible for them to crash the machine, are easily
>traceable using tools such as gdb, and can be killed and restarted
>without rebooting.  FUSD drivers don't have to be in C--Perl, Python,
>or any other language that knows how to read from and write to a file
>descriptor can work with FUSD.  User-space drivers can be swapped out,
>whereas kernel drivers lock physical memory.
>
>FUSD drivers are conceptually similar to kernel drivers: a set of
>callback functions called in response to system calls made on file
>descriptors by user programs.  FUSD's C library provides a device
>registration function, similar to the kernel's devfs_register_chrdev()
>function, to create new devices.  fusd_register() accepts the device
>name and a structure full of pointers.  Those pointers are callback
>functions which are called in response to certain user system
>calls--for example, when a process tries to open, close, read from, or
>write to the device file.  The callback functions should conform to
>the standard definitions of POSIX system call behavior.  In many ways,
>the user-space FUSD callback functions are identical to their kernel
>counterparts.
>
>The proxying of kernel system calls that makes this kind of program
>possible is implemented by FUSD, using a combination of a kernel
>module and cooperating user-space library.  The kernel module
>implements a character device, /dev/fusd, which is used as a control
>channel between the two.  fusd_register() uses this channel to send a
>message to the FUSD kernel module, telling the name of the device the
>user wants to register.  The kernel module, in turn, registers that
>device with the kernel proper using devfs.  devfs and the kernel don't
>know anything unusual is happening; it appears from their point of
>view that the registered devices are simply being implemented by the
>FUSD module.
>
>Later, when kernel makes a callback due to a system call (e.g. when
>the character device file is opened or read), the FUSD kernel module's
>callback blocks the calling process, marshals the arguments of the
>callback into a message and sends it to user-space.  Once there, the
>library half of FUSD unmarshals it and calls whatever user-space
>callback the FUSD driver passed to fusd_register().  When that
>user-space callback returns a value, the process happens in reverse:
>the return value and its side-effects are marshaled by the library
>and sent to the kernel.  The FUSD kernel module unmarshals this
>message, matches it up with a corresponding outstanding request, and
>completes the system call.  The calling process is completely unaware
>of this trickery; it simply enters the kernel once, blocks, unblocks,
>and returns from the system call---just as it would for any other
>blocking call.
>
>One of the primary design goals of FUSD is stability.  It should
>not be possible for a FUSD driver to corrupt or crash the kernel,
>either due to error or malice.  Of course, a buggy driver itself may
>corrupt itself (e.g., due to a buffer overrun).  However, strict error
>checking is implemented at the user-kernel boundary which should
>prevent drivers from corrupting the kernel or any other user-space
>process---including the errant driver's own clients, and other FUSD
>drivers.
>
>For more information, please see the comprehensive documentation in
>the 'doc' directory.
>
> Jeremy Elson <jelson@circlemud.org>
> Sensoria Corporation
> September 28, 2001
