Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133085AbRDRLPV>; Wed, 18 Apr 2001 07:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133084AbRDRLPL>; Wed, 18 Apr 2001 07:15:11 -0400
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:58126 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S133085AbRDRLPA>; Wed, 18 Apr 2001 07:15:00 -0400
Date: Wed, 18 Apr 2001 12:14:56 +0100 (BST)
From: Chris Evans <chris@scary.beasts.org>
To: David Schleef <ds@schleef.org>
cc: Dawson Engler <engler@csl.Stanford.EDU>, <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] copy_*_user length bugs?
In-Reply-To: <20010418015254.A29893@stm.lbl.gov>
Message-ID: <Pine.LNX.4.30.0104181206130.28455-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Apr 2001, David Schleef wrote:

> On Tue, Apr 17, 2001 at 09:39:15PM -0700, Dawson Engler wrote:
> > Hi All,
> >
> > at the suggestion of Chris (chris@ferret.lmh.ox.ac.uk) I wrote a simple
> > checker to warn when the length parameter to copy_*_user was (1) an
> > integer and (2) not checked < 0.
> >
> > As an example, the ipv6 routine rawv6_geticmpfilter gets an integer 'len'
> > from user space, checks that it is smaller than a struct size and then
> > uses length as an argument to copy_to_user:
> >
> >                 if (get_user(len, optlen))
> >                         return -EFAULT;
> >                 if (len > sizeof(struct icmp6_filter))
> >                         len = sizeof(struct icmp6_filter);
> >                 if (put_user(len, optlen))
> >                         return -EFAULT;
> >                 if (copy_to_user(optval, &sk->tp_pinfo.tp_raw.filter, len))
> >                         return -EFAULT;
> >
> > Is this a real bug?  Or is the checked rule only applicable to
> > __copy_*_user routines rather than copy_*_user routines?  (If its a real
> > bug, theres about 8 others that we found).
>
> The len parameter is an unsigned value, so this code is ok as
> long as access_ok() correctly checks that the range to copy
> doesn't stray outside of the userspace range, including the
> possible wraparound for a very large len.  access_ok() on i386
> checks for the wraparound.  m68k doesn't use it.  PowerPC
> is correct, but only because TASK_SIZE is 0x80000000.  If it
> is ever changed, there could be a problem.  I didn't check
> other architectures, because I don't understand the asm.

Incorrect - if the "len" variable is a signed integer, this is a nasty
bug.

To justify this, consider if len were set to minus 2 billion. This will
pass the sanity check, and pass the value straight on to copy_to_user. The
copy_to_user parameter is unsigned, so this value because approximately
+2Gb.

Now, providing the malicious user passes a low user space pointer (e.g.
just above 0), the kernel's virtual address space wrap check will not
trigger because ~0 + ~2Gb does not exceed 4G. And the result is the user
being able to read kernel memory.

Cheers
Chris

