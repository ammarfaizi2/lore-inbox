Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133058AbRDRIxW>; Wed, 18 Apr 2001 04:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133059AbRDRIxM>; Wed, 18 Apr 2001 04:53:12 -0400
Received: from stm.lbl.gov ([131.243.16.51]:12814 "EHLO stm.lbl.gov")
	by vger.kernel.org with ESMTP id <S133058AbRDRIxB>;
	Wed, 18 Apr 2001 04:53:01 -0400
Date: Wed, 18 Apr 2001 01:52:54 -0700
From: David Schleef <ds@schleef.org>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] copy_*_user length bugs?
Message-ID: <20010418015254.A29893@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
In-Reply-To: <200104180439.VAA21983@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104180439.VAA21983@csl.Stanford.EDU>; from engler@csl.Stanford.EDU on Tue, Apr 17, 2001 at 09:39:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 09:39:15PM -0700, Dawson Engler wrote:
> Hi All,
> 
> at the suggestion of Chris (chris@ferret.lmh.ox.ac.uk) I wrote a simple
> checker to warn when the length parameter to copy_*_user was (1) an
> integer and (2) not checked < 0.    
> 
> As an example, the ipv6 routine rawv6_geticmpfilter gets an integer 'len'
> from user space, checks that it is smaller than a struct size and then
> uses length as an argument to copy_to_user: 
> 
>                 if (get_user(len, optlen))
>                         return -EFAULT;
>                 if (len > sizeof(struct icmp6_filter))
>                         len = sizeof(struct icmp6_filter);
>                 if (put_user(len, optlen))
>                         return -EFAULT;
>                 if (copy_to_user(optval, &sk->tp_pinfo.tp_raw.filter, len))
>                         return -EFAULT;
> 
> Is this a real bug?  Or is the checked rule only applicable to
> __copy_*_user routines rather than copy_*_user routines?  (If its a real
> bug, theres about 8 others that we found).


The len parameter is an unsigned value, so this code is ok as
long as access_ok() correctly checks that the range to copy
doesn't stray outside of the userspace range, including the
possible wraparound for a very large len.  access_ok() on i386
checks for the wraparound.  m68k doesn't use it.  PowerPC
is correct, but only because TASK_SIZE is 0x80000000.  If it
is ever changed, there could be a problem.  I didn't check
other architectures, because I don't understand the asm.




dave...

