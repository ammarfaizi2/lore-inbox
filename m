Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbSJTMpH>; Sun, 20 Oct 2002 08:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262474AbSJTMpG>; Sun, 20 Oct 2002 08:45:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32516 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262469AbSJTMpF>;
	Sun, 20 Oct 2002 08:45:05 -0400
Date: Sun, 20 Oct 2002 13:51:09 +0100
From: Matthew Wilcox <willy@debian.org>
To: Erik Andersen <andersen@codepoet.org>, Matthew Wilcox <willy@debian.org>,
       Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] work around duff ABIs
Message-ID: <20021020135109.D5285@parcelfarce.linux.theplanet.co.uk>
References: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk> <20021020045149.GA27887@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021020045149.GA27887@codepoet.org>; from andersen@codepoet.org on Sat, Oct 19, 2002 at 10:51:49PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 10:51:49PM -0600, Erik Andersen wrote:
> Nonono.  Please see __LONG_LONG_PAIR in /usr/include/endian.h.
> Your user space code should be doing something like this:
> 
>     static inline _syscall5(ssize_t, __syscall_pread, int, fd, void *, buf,
> 	    size_t, count, off_t, offset_hi, off_t, offset_lo);
> 
>     ssize_t __libc_pread(int fd, void *buf, size_t count, off_t offset)
>     {
> 	return(__syscall_pread(fd,buf,count,__LONG_LONG_PAIR((off_t)0,offset)));
>     }
> 
>     ssize_t __libc_pread64(int fd, void *buf, size_t count, off64_t offset)
>     {
> 	return(__syscall_pread(fd, buf, count,
> 		    __LONG_LONG_PAIR((off_t)(offset>>32),
> 		    (off_t)(offset&0xffffffff))));
>     }
> 
> Your patch is going to break GNU libc, uClibc, and anyone else in
> userspace that is doing pread and pread64 correctly....

Well... since you just proved that you don't understand the problem,
I'd hazard a guess that uClibc is also broken, as well as glibc.

Here's how the ABI specifies that pread() shall take its arguments:

asmlinkage ssize_t sys_pread64(unsigned int fd, char *buf, size_t count,
				loff_t pos)

fd	arg0
buf	arg1
count	arg2
pos	arg4 & arg5

Here's what __LONG_LONG_PAIR does:

fd	arg0
buf	arg1
count	arg2
pos(HI)	arg3
pos(LO)	arg4

-- 
Revolutions do not require corporate support.
