Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262147AbSJVEhA>; Tue, 22 Oct 2002 00:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262148AbSJVEhA>; Tue, 22 Oct 2002 00:37:00 -0400
Received: from codepoet.org ([166.70.99.138]:45218 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S262147AbSJVEg7>;
	Tue, 22 Oct 2002 00:36:59 -0400
Date: Mon, 21 Oct 2002 22:43:10 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] work around duff ABIs
Message-ID: <20021022044309.GA25172@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Matthew Wilcox <willy@debian.org>,
	Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
References: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk> <20021020045149.GA27887@codepoet.org> <20021020135109.D5285@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021020135109.D5285@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Oct 20, 2002 at 01:51:09PM +0100, Matthew Wilcox wrote:
> On Sat, Oct 19, 2002 at 10:51:49PM -0600, Erik Andersen wrote:
> > Nonono.  Please see __LONG_LONG_PAIR in /usr/include/endian.h.
> > Your user space code should be doing something like this:
> > 
> >     static inline _syscall5(ssize_t, __syscall_pread, int, fd, void *, buf,
> > 	    size_t, count, off_t, offset_hi, off_t, offset_lo);
> > 
> >     ssize_t __libc_pread(int fd, void *buf, size_t count, off_t offset)
> >     {
> > 	return(__syscall_pread(fd,buf,count,__LONG_LONG_PAIR((off_t)0,offset)));
> >     }
> > 
> >     ssize_t __libc_pread64(int fd, void *buf, size_t count, off64_t offset)
> >     {
> > 	return(__syscall_pread(fd, buf, count,
> > 		    __LONG_LONG_PAIR((off_t)(offset>>32),
> > 		    (off_t)(offset&0xffffffff))));
> >     }
> > 
> > Your patch is going to break GNU libc, uClibc, and anyone else in
> > userspace that is doing pread and pread64 correctly....
> 
> Well... since you just proved that you don't understand the problem,
> I'd hazard a guess that uClibc is also broken, as well as glibc.

I understand the problem very well.  Passing 64 bit stuff via
syscalls is a major pain in the butt.  But your patch is not just
changing hppa and mips -- you are breaking the ABI on x86, arm,
powerpc, etc, etc. etc where it is currently working.  Look very
closely at your patch.  See those endianness ifdefs?  You are
adding endianness specific ifdefs into pread, truncate, and
ftruncate to switch the argument order.  User space is already
doing that too.  At no time on any architecture is the low stuff
passed into arg3.  Ergo, your patch is going to break userspace
where pread and pread64 are now working correctly....

If you want to change the kernel to passing eliminate 64 bit
stuff via syscalls, and instead pass pairs of 32bit entities --
I'm all for that as that would make explicit what user space is
doing anyways.  But don't break binary compatibility for no
reason.  Why make both user-space _and_ kernel space add ifdefs
for endianness?  Make arg3 _always_ contain the hi-bits.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
