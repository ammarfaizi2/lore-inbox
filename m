Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265766AbSJTEpn>; Sun, 20 Oct 2002 00:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265767AbSJTEpn>; Sun, 20 Oct 2002 00:45:43 -0400
Received: from codepoet.org ([166.70.99.138]:40065 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S265766AbSJTEpm>;
	Sun, 20 Oct 2002 00:45:42 -0400
Date: Sat, 19 Oct 2002 22:51:49 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] work around duff ABIs
Message-ID: <20021020045149.GA27887@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Matthew Wilcox <willy@debian.org>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
References: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Oct 20, 2002 at 05:31:47AM +0100, Matthew Wilcox wrote:
> 
> *sigh*.  i hate this kind of bullshit.  please, don't anyone ever try
> to pass 64-bit args through the syscall interface again.

I agree it can be a pain.

[-----------snip-------------]
> -asmlinkage ssize_t sys_pread64(unsigned int fd, char *buf,
> -			     size_t count, loff_t pos)
> +#ifdef __BIG_ENDIAN
> +asmlinkage ssize_t sys_pread64(unsigned int fd, char *buf, size_t count,
> +				unsigned int high, unsigned int low)
> +#else
> +asmlinkage ssize_t sys_pread64(unsigned int fd, char *buf, size_t count,
> +				unsigned int low, unsigned int high)
> +#endif

Nonono.  Please see __LONG_LONG_PAIR in /usr/include/endian.h.
Your user space code should be doing something like this:

    static inline _syscall5(ssize_t, __syscall_pread, int, fd, void *, buf,
	    size_t, count, off_t, offset_hi, off_t, offset_lo);

    ssize_t __libc_pread(int fd, void *buf, size_t count, off_t offset)
    {
	return(__syscall_pread(fd,buf,count,__LONG_LONG_PAIR((off_t)0,offset)));
    }

    ssize_t __libc_pread64(int fd, void *buf, size_t count, off64_t offset)
    {
	return(__syscall_pread(fd, buf, count,
		    __LONG_LONG_PAIR((off_t)(offset>>32),
		    (off_t)(offset&0xffffffff))));
    }

Your patch is going to break GNU libc, uClibc, and anyone else in
userspace that is doing pread and pread64 correctly....

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
