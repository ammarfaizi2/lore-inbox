Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267215AbSKUX5w>; Thu, 21 Nov 2002 18:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267222AbSKUX5w>; Thu, 21 Nov 2002 18:57:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48906 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267215AbSKUX5u>; Thu, 21 Nov 2002 18:57:50 -0500
Date: Thu, 21 Nov 2002 16:04:22 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] export e820 table on x86
In-Reply-To: <3DDD7067.6090500@us.ibm.com>
Message-ID: <Pine.LNX.4.44.0211211556340.5779-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 21 Nov 2002, Dave Hansen wrote:
> > 
> >  - why isn't the info in /proc/iomem good enough - ie wouldn't it be 
> >    better to just extend resource handling to 64 bit instead of
> >    creating a new file.
> 
> It looks good enough.  The only irritating part is turning the "S3 
> Inc. Trio 64 3D" or "ACPI Tables" back into the numberic e820 type.

Actually, those aren't part of the e820 map at all - Linux gets those from 
doing PCI probing, since the e820 table does not itself tell _what_ the 
resources are allocated for.

> What would you think of just adding another field to /proc/iomem which 
> contains the e820 field type?

Actually, it's already there, to some degree. See the case statement in	
register_memory() in arch/i386/kernel/setup.c, and see how all the e820 
information percolates down from the e820 array into a simple 
"request_resource()".

See also how we artificially only show 32-bit resources, because "struct
resource" uses "unsigned long". That's a design mistake, and it _should_
be "u64" (this actually could cause problems already on 64-bit PCI on
32-bit hosts, although it appears that nobody even tries to map devices
past the 4GB area anyway), but I've never had a test-case for fixing it
and seeing any difference.

In other words, I would suggest you fix that 64-bit issue, remove the
artificial limiting in setup.c, extend the "case" statement to cover any
cases you're interested in, and test it on something with >4GB of memory
to see that it works, and I'll be more than happy to take it.

Please?

		Linus

