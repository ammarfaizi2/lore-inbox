Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262911AbRE1CYc>; Sun, 27 May 2001 22:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262912AbRE1CYW>; Sun, 27 May 2001 22:24:22 -0400
Received: from lpce020.lss.emc.com ([168.159.62.20]:772 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S262911AbRE1CYF>; Sun, 27 May 2001 22:24:05 -0400
Date: Sun, 27 May 2001 09:21:50 -0400
Message-Id: <200105271321.f4RDLoM00342@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Akash Jain" <aki.jain@stanford.edu>
Cc: <torvalds@transmeta.com>, <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>, <su.class.cs99q@nntp.stanford.edu>
Subject: Re: [PATCH] fs/devfs/base.c
In-Reply-To: <GLEPIDKFGKPCBDLKDHEAAELGDDAA.aki.jain@stanford.edu>
In-Reply-To: <GLEPIDKFGKPCBDLKDHEAAELGDDAA.aki.jain@stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akash Jain writes:
> hello,
> 
> in fs/devfs/base.c,
> the struct devfsd_notify_struct is approx 1056 bytes, allocating it
> on a stack of 8k seems unreasonable.  here we simply move it to the
> heap, i don't think it is a _must_ be on stack type thing

I absolutely don't want this patch applied. It's bogus. It is entirely
safe to alloc 1 kB on the stack in this code, since it has a short and
well-controlled code path from syscall entry to the function. This is
not some function that can be called from some random place in the
kernel and thus has a random call path.

Using the stack is much faster than calling kmalloc() and it also
doesn't add to system memory pressure. That's why I did it this way in
the first place. Further, it's much safer to use the stack, since the
memory is freed automatically. Thus, there's less scope for
introducing errors.

Please fix your checker to deal with this class of functions which
have a well-defined call path. I'd suggest looking at the total stack
allocations from syscall entry point all the way to the end function.
Ideally, you'd trace the call path to every function, but of course
that may be computationally infeasible. Hopefully it's feasible to do
this for any function which has a stack allocation which exceeds some
threshold.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
