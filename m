Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317544AbSH3VNE>; Fri, 30 Aug 2002 17:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319670AbSH3VNE>; Fri, 30 Aug 2002 17:13:04 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:8713 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319668AbSH3VNB>; Fri, 30 Aug 2002 17:13:01 -0400
Message-ID: <3D6FE062.A48B6F03@zip.com.au>
Date: Fri, 30 Aug 2002 14:15:14 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Terence Ripperda <tripperda@nvidia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: lockup on Athlon systems, kernel race condition?
References: <20020830204022.GC736@hygelac>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terence Ripperda wrote:
> 
> ...
>
> asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
> {
>         struct file * filp;
>         unsigned int flag;
>         int on, error = -EBADF;
> 
>         filp = fget(fd);
>         if (!filp)
>                 goto out;
>         error = 0;
>         lock_kernel();    <====
>         switch (cmd) {

This CPU is spinning, waiting for kernel_flag.  It will take the IPI
and the other CPU's smp_call_function() will succeed.

Possibly the IPI has got lost - seems that this is a popular failure mode
for flakey chipsets/motherboards.

Or someone has called sys_ioctl() with interrupts disabled.  That's very
doubtful.
