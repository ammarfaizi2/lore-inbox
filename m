Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292899AbSCDUsT>; Mon, 4 Mar 2002 15:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292903AbSCDUsL>; Mon, 4 Mar 2002 15:48:11 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:11991 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S292899AbSCDUr7>;
	Mon, 4 Mar 2002 15:47:59 -0500
Date: Mon, 4 Mar 2002 15:48:48 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Robert Love <rml@tech9.net>, Rusty Russell <rusty@rustcorp.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fast Userspace Mutexes III.
Message-ID: <20020304154848.A1055@elinux01.watson.ibm.com>
In-Reply-To: <1015271393.15277.112.camel@phantasy> <Pine.LNX.4.44.0203041208310.1561-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0203041208310.1561-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Mon, Mar 04, 2002 at 12:13:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 12:13:50PM -0800, Davide Libenzi wrote:
> On 4 Mar 2002, Robert Love wrote:
> 
> > On Sun, 2002-03-03 at 22:55, Rusty Russell wrote:
> > > 1) Use mmap/mprotect bits, not new syscall (thanks RTH, Erik Biederman)
> > > 2) Fix wakeup race in kernel (thanks Martin Wirth, Paul Mackerras)
> > > 3) Simplify locking to a single atomic (no more arch specifics!)
> > > 4) Use wake-one by handcoding queues.
> > > 5) Comments added.
> > >
> > > Thanks to all for feedback and review: I'd appreciate a comment from
> > > those arch's which need to do something with the PROT_SEM bit.
> > >
> > > Once again, tested on 2.4.18 UP PPC, compiles on 2.5.6-pre1.
> > >
> > > Bad news is that we're up to 206 lines again.
> > > Rusty.
> >
> > Good work.  I likee.
> 
> Ok, i reply to this because my 'd' Pine's key is heavily used in these days :-)
> I took a look at the code yesterday night and i've a stupid question
> Rusty. I do not know what is the code used in the upper part of the
> iceberg ( userspace ) but are you doing a dec_and_test() on userspace
> before entering the kernel ? Or, is the kernel code the slow path or you
> enter it by default ?
> 
> 
> 
> - Davide
> 

Yes, that section is missing. It should be just as you said.

int futex_down(atomic_t *count)
{
	if (!atomic_dec_and_test(count)) 
		return sys_futex(count,FUTEX_DOWN);
	return 0;
}	

One needs to ensure that the atomic nature is compiled in (i.e. SMP) 
even if SMP is not enabled in the machine.

Rusty, could you post that code that you are using.


Also, the check on PROT_SEM is missing. I tried this before and glibc filtered
these flags out when set. But effectively, one still needs to check
whether semaphores are allowed during the sys_futex call.
This is expensive, because the protections are associated with the VMA.
find_vma() is not an option here, that's why I did the hashing and more persistent
objects rather than hashed wait queues.

I'd suggest to drop the requirements for this flag PROT_SEM.
I don't see tremendous value for it anyway, and it creates quite some 
headache if its to be enforced, which it is not in Rusty's code.
My code could do it, but as it comes with the complexity discussed earlier.

-- Hubertus
