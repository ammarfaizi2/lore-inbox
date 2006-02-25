Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWBYW6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWBYW6H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWBYW6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:58:07 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35089 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750702AbWBYW6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:58:06 -0500
Date: Sat, 25 Feb 2006 22:57:49 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060225225748.GF15276@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060224221909.GD28855@flint.arm.linux.org.uk> <20060225065136.GH13116@waste.org> <20060225084955.GA27538@flint.arm.linux.org.uk> <20060225145412.GI13116@waste.org> <20060225180521.GB15276@flint.arm.linux.org.uk> <20060225210454.GL13116@waste.org> <20060225212247.GC15276@flint.arm.linux.org.uk> <20060225214704.GN13116@waste.org> <20060225215850.GD15276@flint.arm.linux.org.uk> <20060225223737.GO13116@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225223737.GO13116@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 04:37:37PM -0600, Matt Mackall wrote:
> On Sat, Feb 25, 2006 at 09:58:50PM +0000, Russell King wrote:
> > 1. kernel is loaded.
> > 2. firmware scans loaded kernel, finds gzip magic numbers (the compressed
> >    kernel.)
> > 3. firmware sets initrd pointeres to point at the compressed kernel.
> > 4. firmware calls kernel decompressor.
> > 5. kernel decompresses and self-relocates.
> > 6. compressed kernel image is thereby partly corrupted.
> > 7. kernel boots.
> > 8. kernel tries to decompress the compressed kernel image.
> > 9. decompressor gets confused and tries to gobble more data than is
> >    available.
> > 10. kernel sits there being a dumb fuck.
> 
> Why are we attempting to decompress the kernel image again? Accident?

The firmware is trying to be "clever" - looking in the object it TFTP'd
for the gzip magic numbers and assuming that any it finds are an initrd.
The firmware then points the kernel at the start of that gzipped image.

The fact that a zImage contains the gzip magic numbers never occurred to
the people who implemented this misfeature in the firmware.  It is a
misfeature because:

1. this exact problem - that a zImage contents can be mistaken for an initrd.
2. an initrd doesn't have to be compressed with gzip.
3. an initrd may contain gzip markers which do not relate to the start of
   the initrd.

> > > In my mind, being unable to decompress init* is every bit as fatal as
> > > being unable to mount root.
> > 
> > It's very simple.  With fix, the kernel successfully boots on these
> > machines.  Without fix, the kernel hangs on these machines for _no_
> > good reason other than the firmware did something that was stupid.
> 
> And how does this work currently? We attempt to decompress the kernel
> a second time, give up and move on?

Yes.

> Assuming we can write to the compressed image (and thereby corrupt
> it), wouldn't it be better to just stomp on the gzip magic and spare
> us the overhead of decompressing it twice?

That's not guaranteed, so is impossible to do in the boot time
decompressor.

> > I'm sorry, I just do not see why you're being soo bloody difficult
> > over this.
> 
> Because it's taken this long to get close to an explanation of what
> the problem is.

$#%@%#$%#@!!!  I really think you're intentionally trying to wind me up
through this whole thread.

The email:

  http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/1024.html

contains a full and clear explaination of the situation.  The second
paragraph of that email is key to understanding the problem and makes
it absolutely clear what is trying to be decompressed as the initrd
(the corrupted compressed piggy).

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
