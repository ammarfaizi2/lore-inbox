Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932680AbWBYSFg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932680AbWBYSFg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 13:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbWBYSFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 13:05:36 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:55821 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932680AbWBYSFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 13:05:36 -0500
Date: Sat, 25 Feb 2006 18:05:21 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060225180521.GB15276@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <0.399206195@selenic.com> <4.399206195@selenic.com> <20060224221909.GD28855@flint.arm.linux.org.uk> <20060225065136.GH13116@waste.org> <20060225084955.GA27538@flint.arm.linux.org.uk> <20060225145412.GI13116@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225145412.GI13116@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 08:54:12AM -0600, Matt Mackall wrote:
> On Sat, Feb 25, 2006 at 08:49:55AM +0000, Russell King wrote:
> > On Sat, Feb 25, 2006 at 12:51:36AM -0600, Matt Mackall wrote:
> > > On Fri, Feb 24, 2006 at 10:19:09PM +0000, Russell King wrote:
> > > > How does this change handle the case where we run out of input data?
> > > > This condition needs to be handled explicitly because the inflate
> > > > functions can infinitely loop.
> > > 
> > > And if you look at the current users, you'll see that only two of 15
> > > actually use it.
> > 
> > Sorry, I don't understand the relevance of your comment.
> 
> The other 13 did the right thing, namely halt in get_byte. Without
> adding a magic goto inside of a macro.
> 
> > Please do not back out this fix.
> 
> The backing out is only temporary, as I stated in my message. That
> said, it should have never gone in.

Nevertheless, it's a wilful re-introduction of a real bug.

> > > > Relying on a bit pattern returned by get_byte() is how this code
> > > > pre-fix used to work, and it caused several confused bug reports.
> > > 
> > > Just about everywhere, get_byte prints an error message and halts.
> > 
> > And the cases where it doesn't halt is the important case.
> 
> Again, current state of things. Did you read the rest of my message?

And you're failing to see the problem.

> The end result is that it will halt in all cases. This code _will_not_
> infinitely loop. Instead, it will dereference null or print a
> diagnostic. I can add another patch to make sure it prints a nice
> diagnostic in all cases if you care, but I don't think it's terribly
> important.

Not acceptable.

We DO NOT want to halt in ALL cases.  There is ONE case where we
definitely do want to GRACEFULLY fail and _NOT_ halt the kernel.

It seems that you're missing this case - the case where lib/inflate.c
is used elsewhere in the kernel apart from the boot time decompressors.
The behaviour you describe is perfectly reasonable for the boot time
decompressors, but _NOT_ once the kernel has been decompressed.

Sorry, I'm disgusted that it's come to this to get my point across.
Do I really have to use capital letters in an attempt to convey the
point?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
