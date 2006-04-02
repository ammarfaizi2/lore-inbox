Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751276AbWDBHyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbWDBHyg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 03:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbWDBHyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 03:54:35 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29705 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751276AbWDBHyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 03:54:35 -0400
Date: Sun, 2 Apr 2006 08:54:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
Message-ID: <20060402075403.GA19149@flint.arm.linux.org.uk>
Mail-Followup-To: Christoph Lameter <clameter@sgi.com>,
	Andi Kleen <ak@suse.de>, Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
	"Boehm, Hans" <hans.boehm@hp.com>,
	"Grundler, Grant G" <grant.grundler@hp.com>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com> <p73vetu921a.fsf@verdi.suse.de> <Pine.LNX.4.64.0603310943480.6628@schroedinger.engr.sgi.com> <200603311948.38218.ak@suse.de> <Pine.LNX.4.64.0603310952540.6825@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0603310952540.6825@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 09:56:23AM -0800, Christoph Lameter wrote:
> On Fri, 31 Mar 2006, Andi Kleen wrote:
> 
> > > Powerpc can do similar things AFAIK. Not sure what other arches have 
> > > finer grained control over barriers but it could cover a lot of special 
> > > cases for other processors as well.
> > 
> > Yes, but I don't think the goal of a portable atomic operations API
> > in Linux is it to cover everybody's special case in every possible 
> > combination. The goal is to have an abstraction that will lead to 
> > portable code. I don't think your proposal will do this.
> 
> AFAIK The goal of a bitmap operations API (we are not talking about atomic 
> operations here) is to make bitmap operations as efficient as possible and 
> as simple as possible.

If we are not talking about atomic operations...

> We already have multiple special cases for each 
> bitmap operation
> 
> I.e.
> 
> clear_bit()

why do you then bring up the atomic bitop operation here?

> __clear_bit()

this is the non-atomic bitop operation.

> and some people talk abouit
> 
> clear_bit_lock()
> clear_bit_unlock()

Neither of these exist in the kernel.

> What I am prosing is to do one clear_bit_mode function that can take a 
> parameter customizing its synchronization behavior.
> 
> clear_bit_mode(bit,addr,mode)

Which means for architectures which implement bitops out of line (due
to their size) that you end up making those architectures even more
inefficient because they now have to decode the "mode" parameter which
will take several compares and branches.

The only way around that would be for such architectures to do:

#define clear_bit_mode(bit,addr,mode)	clear_bit_mode_##mode(bit,addr)

and then we're back to the named function approach.

Incidentally, you say that the named function approach is not extensible.
Do you have a limit on the number of functions you can have in your
kernel?  If not, I don't see where such a statement would come from -
you obviously can extend "clear_bit_atomic" and "clear_bit_nonatomic"
by adding eg, "clear_bit_barrier".  And if you really want to multiplex
them through one function, you can do:

#define clear_bit_atomic(bit,addr)	clear_bit_mode(bit,addr,MODE_ATOMIC)
#define clear_bit_nonatomic(bit,addr)	clear_bit_mode(bit,addr,MODE_NONATOMIC)
#define clear_bit_barrier(bit,addr)	clear_bit_mode(bit,addr,MODE_BARRIER)

etc.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
