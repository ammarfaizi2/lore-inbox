Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937859AbWLGArS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937859AbWLGArS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 19:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937861AbWLGArS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 19:47:18 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:54136 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937860AbWLGArR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 19:47:17 -0500
Date: Thu, 7 Dec 2006 00:46:38 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061207004638.GA24032@linux-mips.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 11:16:55AM -0800, Christoph Lameter wrote:

> But then its also just requires disable/enable interrupts on UP which may 
> be cheaper than an atomic operation.
> 
> > For CPUs with load locked + store conditional, it is expensive.
> 
> Because it locks the bus? I am not that familiar with those architectures 
> but it seems that those will have a general problem anyways.

On a decent implementation ll/sc will have the same cost as ordinary
non-atomic load and store instructions.  A likely uniprocessor
implementation uses a single flip-flop ("llbit") in the CPU which is set
by ll and cleared by any exception handler, especially interrupt.  A later
store conditional will then simply fail if that bit is cleared.  That
is extremly trivial stuff.  On SMP it's somewhat more complex; A
processor will have to remember the address used with ll and start
snooping the bus for writes to it.  The store conditional will then
go and upgrade the cache line to exclusive state if the llbit is still
set and perform the store.  The llbit would be cleared if the processor
has snooped any other write to the cacheline.  Details are fun but that's
bascially how it's implemented.

Of course load linked / store conditional are typically used in loops
so there is a little extra overhead from that especially where when the
branch is misspredicted.

Also note there is no locked cycle required to implement load linked /
store conditional.

  Ralf
