Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313751AbSD3REA>; Tue, 30 Apr 2002 13:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSD3RD7>; Tue, 30 Apr 2002 13:03:59 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:23558 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313751AbSD3RD6>; Tue, 30 Apr 2002 13:03:58 -0400
Date: Tue, 30 Apr 2002 18:03:51 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: devfs: BKL *not* taken while opening devices
Message-ID: <20020430180351.O26943@flint.arm.linux.org.uk>
In-Reply-To: <20020429141301.B16778@flint.arm.linux.org.uk> <3CCD672E.5040005@us.ibm.com> <3CCD811E.8689F4B0@redhat.com> <20020430134557.C26943@flint.arm.linux.org.uk> <3CCEC978.2090602@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2002 at 09:42:32AM -0700, Dave Hansen wrote:
> I like the idea.  But, while we're at it, does anyone have a good enough 
> grasp of locking the the TTY layer that we can start peeling some of the 
> BKL out of there?  Somebody was doing tests over a serial console here 
> and the lockmeter data showed horrible BKL contention and hold times.

I'm sure it isn't *that* bad for average workloads.  Sure, if you hammer
the TTY layer madly to measure the BKL it will show up, but that isn't
an average workload.

I purposely didn't mention this in the previous mail.  The tty code is
beyond any type of "peeling".  The whole thing relies on the behaviour
of the BKL - in that when you sleep the BKL is released.  Think about
someone opening /dev/cua0 while /dev/ttyS0 is trying to be opened, or
a hangup while a port is being opened, or... the list is endless.

It's not as simple as replacing the BKL with a semaphore or spinlock.

I've actually brought this up in passing with Alan back in October - his
feeling at the time was (iirc) that the effort required isn't worth the
rewards you'd get.

When I talked to Ted last, Ted was going to rewrite the whole thing to
get it into a reasonable shape, which included a BKL free tty layer.
I've not heard anything from Ted recently on this though.

However, being able to type on a laptop over a ssh connection to another
machine, and have everything freeze while the hard disk spins up for no
apparant reason (other than your typing) is an annoyance that I wouldn't
mind see "disappear".

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

