Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135601AbRDSJJI>; Thu, 19 Apr 2001 05:09:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135600AbRDSJI7>; Thu, 19 Apr 2001 05:08:59 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:13759 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S135599AbRDSJIr>;
	Thu, 19 Apr 2001 05:08:47 -0400
Date: Thu, 19 Apr 2001 05:08:32 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <3ADEA746.D3A44511@alsa-project.org>
Message-ID: <Pine.GSO.4.21.0104190457050.15153-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Abramo Bagnara wrote:

> Alon Ziv wrote:
> > 
> > Hmm...
> > I already started (long ago, and abandoned since due to lack of time :-( )
> > down another path; I'd like to resurrect it...
> > 
> > My lightweight-semaphores were actually even simpler in userspace:
> > * the userspace struct was just a signed count and a file handle.
> > * Uncontended case is exactly like Linus' version (i.e., down() is decl +
> > js, up() is incl()).
> > * The contention syscall was (in my implementation) an ioctl on the FH; the
> > FH was a special one, from a private syscall (although with the new VFS I'd
> > have written it as just another specialized FS, or even referred into the
> > SysVsem FS).
> > 
> > So, there is no chance for user corruption of kernel data (as it just ain't
> > there...); and the contended-case cost is probably equivalent (VFS cost vs.
> > validation).
> 
> This would also permit:
> - to have poll()
> - to use mmap() to obtain the userspace area
> 
> It would become something very near to sacred Unix dogmas ;-)

I suspect that simple pipe with would be sufficient to handle contention
case - nothing fancy needed (read when you need to block, write upon up()
when you have contenders)

Would something along the lines of (inline as needed, etc.)

down:
	lock decl count
	js __down_failed
down_done:
	ret

up:
	lock incl count
	jle __up_waking
up_done:
	ret

__down_failed:
	call down_failed
	jmp down_done
__up_waking:
	call up_waking
	jmp up_done

down_failed()
{
	read(pipe_fd, &dummy, 1);
}

up_waking()
{
	write(pipe_fd, &dummy, 1);
}

be enough?
								Al

