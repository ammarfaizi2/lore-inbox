Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbTIAHPf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 03:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTIAHPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 03:15:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22673 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262734AbTIAHPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 03:15:23 -0400
Date: Mon, 1 Sep 2003 00:06:15 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: mfedyk@matchmail.com, lm@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-Id: <20030901000615.28d93760.davem@redhat.com>
In-Reply-To: <20030901064231.GJ748@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk>
	<20030829154101.GB16319@work.bitmover.com>
	<20030829230521.GD3846@matchmail.com>
	<20030830221032.1edf71d0.davem@redhat.com>
	<20030831224937.GA29239@mail.jlokier.co.uk>
	<20030831223102.3affcb34.davem@redhat.com>
	<20030901064231.GJ748@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003 07:42:31 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> David S. Miller wrote:
> > On Sun, 31 Aug 2003 23:49:37 +0100
> > Jamie Lokier <jamie@shareable.org> wrote:
> > 
> > > It uses POSIX shared memory and (necessarily) MAP_SHARED, which
> > > doesn't constrain the mapping alignment.
> > 
> > That's wrong.  If a platform needs to, it should properly
> > align the mapping when MAP_SHARED is used on a file.
> > 
> > If you look in arch/sparc64/kernel/sys_sparc.c, you'll see
> > that when we're mmap()'ing a file and MAP_SHARED is specified,
> > we align things to SHMLBA.
> 
> Then you have a bug in the Sparc code.  It looks like it should return
> -EINVAL when a misaligned mapping is used with MAP_FIXED|MAP_SHARED,
> but the test program is clearly getting mappings that aren't aligned
> to SHMLBA.

I disagree, MAP_FIXED means "I know what I am doing don't override
this unless the mapping area is not available in my address space."
You should never specify MAP_FIXED unless you _REALLY_ know what you
are doing.

> Thus I have three Sparc-specific questions:
> 
> 	1. How does userspace find out the value of SHMLBA?
> 	   On Sparc, it is not a compile-time constant.

Don't specify MAP_FIXED for MAP_SHARED mapping if you want
proper coherency, that's my answer for this one.

> 	2. Is flushing part of the data cache something I can do from
> 	   userspace?  (I'll figure out the exact machine instructions
> 	   myself if I need to do this, but it'd be nice to know if
> 	   it's possible before I have a go).

There is no efficient way to do this from userspace, only the
kernel has access to the more efficient cache flushing instructions.
You'd need to flush via loads to displace the aliasing cache lines.

> 	3. Is there a kernel bug on Sparc, because the test program
> 	   is either getting mappings that aren't aligned to run time
> 	   SHMLBA, or the kernel's run time SHMLBA value is not correct.

No, the user is allowed to hang himself with MAP_FIXED.

The bug is in your code :)
