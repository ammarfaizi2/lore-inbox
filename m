Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276538AbRI2QDz>; Sat, 29 Sep 2001 12:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276539AbRI2QDq>; Sat, 29 Sep 2001 12:03:46 -0400
Received: from smtp8.xs4all.nl ([194.109.127.134]:11464 "EHLO smtp8.xs4all.nl")
	by vger.kernel.org with ESMTP id <S276538AbRI2QDk>;
	Sat, 29 Sep 2001 12:03:40 -0400
From: thunder7@xs4all.nl
Date: Sat, 29 Sep 2001 18:03:59 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (lkml)Re: floppy hang with 2.4.9-ac1x
Message-ID: <20010929180359.A871@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
In-Reply-To: <20010928210355.A2837@middle.of.nowhere> <E15n60s-00006n-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15n60s-00006n-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 11:21:42PM +0100, Alan Cox wrote:
> > 2.4.9-ac10 onwards, IIRC) hard-hangs my linux system....
> 
> Knowing exactly which release would be useful

It worked with 2.4.9-ac15 and before, and it doesn't work with
2.4.9-ac16.

> 
> > dual P3/700, SMP kernel, gcc-3.0.1, Abit VP6 with VIA 694X chipset,
> > mtools-3.9.7
> 
> Does it occur with gcc 2.95/2.96 ?

yes, 2.4.9-ac16 crashes both with gcc-3.0.1 and with gcc-2.95.2.

> 
> > the console hangs, and switching to another doesn't work. Also the
> > num-lock key is dead. The floppy light stays on, but it doesn't sound
> > like it is doing anything but spinning the motor.
> > There are no messages in the system logs.
> > 
> > Any hints on what to do?
> 
> Try an older gcc to eliminate that case (I dont think it is the guilty party
> but I dont trust the memory barriers in such an old ugly driver to be right)
> and then find out which precise release broke it
> 
It's 2.4.9-ac16 that broke it, and I've straced it. This is in
2.4.9-ac15:

open("/home/jurriaan/.mtoolsrc", O_RDONLY) = -1 ENOENT (No such file or directory)
rt_sigaction(SIGHUP, {0x805ff50, [HUP], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {0x805ff50, [INT], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x805ff50, [TERM], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {0x805ff50, [QUIT], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
stat64("/home/jurriaan/.mcwd", 0xbffff37c) = -1 ENOENT (No such file or directory)
open("/dev/fd0", O_RDONLY|O_EXCL|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFBLK|0660, st_rdev=makedev(2, 0), ...}) = 0
flock(4, LOCK_SH|LOCK_NB)               = 0
ioctl(4, FDGETPRM, 0xbfffddd0)          = 0
read(4, "\353V\220DRDOS  7\0\2\1\1\0\2\340\0@\v\360\t\0\22\0\2\0"..., 256) = 256
ioctl(4, FDGETPRM, 0xbfffe5e0)          = 0
old_mmap(NULL, 151552, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4014d000
brk(0x8075000)                          = 0x8075000
_llseek(4, 512, [512], SEEK_SET)        = 0
read(4, "\360\377\377\3@\0\5`\0\7\200\0\t\240\0\v\300\0\r\340\0"..., 17920) = 17920
open("/etc/localtime", O_RDONLY)        = 5
fstat64(5, {st_mode=S_IFREG|0644, st_size=1058, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40017000
read(5, "TZif\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\v\0\0\0\v\0"..., 4096) = 1058
close(5)                                = 0

and in 2.4.9-ac16 I see:

open("/home/jurriaan/.mtoolsrc", O_RDONLY) = -1 ENOENT (No such file or directory)
rt_sigaction(SIGHUP, {0x805ff50, [HUP], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGINT, {0x805ff50, [INT], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGTERM, {0x805ff50, [TERM], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
rt_sigaction(SIGQUIT, {0x805ff50, [QUIT], SA_RESTART|0x4000000}, {SIG_DFL}, 8) = 0
stat64("/home/jurriaan/.mcwd", 0xbffff37c) = -1 ENOENT (No such file or directory)
open("/dev/fd0", O_RDONLY|O_EXCL|O_LARGEFILE) = 4
fstat64(4, {st_mode=S_IFBLK|0660, st_rdev=makedev(2, 0), ...}) = 0
flock(4, LOCK_SH|LOCK_NB)               = 0
ioctl(4, FDGETPRM, 0xbfffddd0)          = 0
read(4, "\353V\220DRDOS  7\0\2\1\1\0\2\340\0@\v\360\t\0\22\0\2\0"..., 256) = 256
ioctl(4, FDGETPRM, 0xbfffe5e0)          = 0
old_mmap(NULL, 151552, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4014d000
brk(0x8075000)                          = 0x8075000
_llseek(4, 512, [512], SEEK_SET)        = 0
read(4,

and there it hangs. Also, in 2.4.9-ac16 it is reading from fd 3 for some
reason, but I couldn't quite see why. The values in the ioctl lines etc.
are the same. Exchanging mtools-3.9.7 with 3.9.8-pre6 (the latest
release) didn't change anything.

Good luck,
Jurriaan



-- 
Whoever thought that one up should have his head examined. Bloody minstrels...
	Simon R Green - Blue Moon Rising
GNU/Linux 2.4.9-ac16 SMP/ReiserFS 2x1402 bogomips load av: 0.57 0.15 0.05
