Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWDBIAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWDBIAV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 04:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWDBIAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 04:00:21 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10256 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751472AbWDBIAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 04:00:20 -0400
Date: Sun, 2 Apr 2006 08:59:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Lameter <clameter@sgi.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
       David Mosberger-Tang <David.Mosberger@acm.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
Message-ID: <20060402075959.GB19149@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Lameter <clameter@sgi.com>,
	"Luck, Tony" <tony.luck@intel.com>,
	David Mosberger-Tang <David.Mosberger@acm.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
	"Boehm, Hans" <hans.boehm@hp.com>,
	"Grundler, Grant G" <grant.grundler@hp.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F061AAF44@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.64.0603301657470.2068@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603301657470.2068@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 04:58:25PM -0800, Christoph Lameter wrote:
> On Thu, 30 Mar 2006, Luck, Tony wrote:
> 
> > > Also some higher level functions may want to have the mode passed to them 
> > > as parameters. See f.e. include/linux/buffer_head.h. Without the 
> > > parameters you will have to maintain farms of definitions for all cases.
> > 
> > But if any part of the call chain from those higher level functions
> > down to these low level functions is not inline, then the compiler
> > won't be able to collapse out the "switch (mode)" ... so we'd end up
> > with a ton of extra object code.
> 
> Correct. But such bitops are typically defined to be inline.

That's doesn't seem to be the point that Tony was making.  To illustrate
it let's add a practical example:

static inline void clear_bit_mode(int bit, unsigned long *ptr, int mode)
{
	case (mode) {
	...
	}
}

void foo(blah blah, int mode)
{
	... complex function ...
	clear_bit_mode(bit, ptr, mode);
	...
}

void bar(blah blah)
{
	foo(blah, MODE_BARRIER);
}

In this case, the compiler can not optimise the unnecessary code from
the clear_bit_mode because the mode argument quite definitely is not a
constant known at compile time.  Only if 'foo' was a static inline
would it be known.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
