Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270825AbRIRMxm>; Tue, 18 Sep 2001 08:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270847AbRIRMxd>; Tue, 18 Sep 2001 08:53:33 -0400
Received: from chaos.analogic.com ([204.178.40.224]:26243 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S270825AbRIRMxW>; Tue, 18 Sep 2001 08:53:22 -0400
Date: Tue, 18 Sep 2001 08:53:27 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Chow <davidchow@rcn.com.hk>
cc: linux-kernel@vger.kernel.org
Subject: Re: EFAULT from file read.
In-Reply-To: <3BA710EF.FC38A28B@rcn.com.hk>
Message-ID: <Pine.LNX.3.95.1010918083824.20907A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Sep 2001, David Chow wrote:

> Dear all,
> 
> I am having trouble in reading a file in the kernel space using the
> file->f_op->read call, everything is ok. I start off file->f_pos = 0 . I
> also did a mntget to the super block before I call
> "file=dentry_open(.....)" . I intend to open the file in read only mode.
> What can be wrong? I have also check the inode->i_size is large enough
> for me to just read 8 bytes from the file. I keep having EFAULT error
> from the read call... also before calling mntget, also did a dget to the
> dentry. Any help is welcomed. Thanks.
> 
> regards,
> 
> David Chow
> -

Are you attempting file access in the kernel from a kernel-thread,
or have you just decided to perform file access from some random
kernel code?

File I/O requires a process context. Your file descriptor means
nothing unless associated with the process that opened the file.
The kernel, itself, is not a process. It functions in the process
context of the caller. Also file I/O sleeps and pages. You need to
understand this before you attempt to access files from within the
kernel.

Normally, you don't access files from within the kernel. If you
need file data for a driver for instance, you write an appropriate
ioctl() function in your driver so a user-mode task can send the
data to the driver. Your startup script inserts the module, then
executes a program which initializes the module with the appropriate
file data and initialization commands, all sent from user mode.
Once the driver is initialized, the user-mode "starter" exits,
freeing resources which would otherwise be trapped forever in your
driver.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


