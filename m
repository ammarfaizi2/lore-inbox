Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbTBISaM>; Sun, 9 Feb 2003 13:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267425AbTBISaM>; Sun, 9 Feb 2003 13:30:12 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59470 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267429AbTBISaK>; Sun, 9 Feb 2003 13:30:10 -0500
To: Corey Minyard <cminyard@mvista.com>
Cc: Kenneth Sumrall <ken@mvista.com>, linux-kernel@vger.kernel.org,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       lkcd-devel@lists.sourceforge.net
Subject: Re: Kexec, DMA, and SMP
References: <3E448745.9040707@mvista.com> <m1isvuzjj2.fsf@frodo.biederman.org>
	<3E45661A.90401@mvista.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Feb 2003 11:39:27 -0700
In-Reply-To: <3E45661A.90401@mvista.com>
Message-ID: <m1d6m1z4bk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <cminyard@mvista.com> writes:

> The panic case is actually the most interesting for us.  We are using bootimg
> with the MCL coredump to take a kernel core to memory and pick it up on the next
> boot. 

[snip]

With respect to DMA and SMP handling for kexec on panic that case is
much trickier.  A lot of the normal methods simply don't apply because
by definition in a panic something is broken, and that something may
be the code we need to cleanly shutdown the hardware.  But I an not
ready to sacrifice a method that works well in a properly working
kernel just because the panic case can't use it.

In getting it working I suggest we start with the easy cases, where
DMA and SMP are not big issues.  And then we can have a working
framework.

I am still digesting the crash dump code I have seen, but as far as I
can tell what it does is to compress the contents of memory, for
writing out later.

To handle the hard cases for kexec on panic I would recommend the
following.

- Place the recovery code in a reserved area of memory that the normal
  kernel will not touch, and actually run the code there.  This
  trivially solves the DMA problem because the hardware is not DMA'ing

- Setup the kernel that does the recovery so that the pool of memory
  it uses for dynamic allocations is also in the reserved area of
  memory so that it is equally free of DMA dangers.

- Modify the kernel that does the recovery so it can be run at
  different physical address from the standard kernel, so it will not
  need to be moved out of the reserved area of memory.

- Modify the kernel that does the recovery to not care about
  which cpu in a SMP system it comes up on first.

- Modify the kernel that does the recovery so that it is very robust
  in reinitializing devices.  So it can cope with devices in a random
  state.  Though most devices can be handled by simply ignoring them.

- Possibly preserve in the reserved area a separate copy of the tables
  ACPI/MP/etc that the kernel needs for coming up.  I actually don't
  think this needs to happen as the kernel preserves those in place
  already.

At that point I believe a full memory core dump can be achieved
without needing to do anything except to jump to the other kernel
on panic.  All of the memory can be preserved because the kexec case
would not have touched it.

I find this very attractive because it can be done with a very low
impact on the primary kernel whose panic we want to capture, plus it
is an extremely robust solution.

The one piece I don't know about is how to prioritize which pieces of
memory are written out first.  It is certainly a desirable feature
but do we need that, if we can preserve everything?  Or is it easy
enough to get the prioritizing information that we don't care.

Eric
