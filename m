Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbUDHSmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 14:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbUDHSmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 14:42:50 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:36274
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262217AbUDHSms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 14:42:48 -0400
Date: Thu, 8 Apr 2004 20:42:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] rmap: parisc __flush_dcache_page
Message-ID: <20040408184245.GO31667@dualathlon.random>
References: <20040408153412.GD31667@dualathlon.random> <1081439244.2165.236.camel@mulgrave> <20040408161610.GF31667@dualathlon.random> <1081441791.2105.295.camel@mulgrave> <20040408171017.GJ31667@dualathlon.random> <1081446226.2105.402.camel@mulgrave> <20040408175158.GK31667@dualathlon.random> <1081447654.1885.430.camel@mulgrave> <20040408181838.GN31667@dualathlon.random> <1081448897.2105.465.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1081448897.2105.465.camel@mulgrave>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 01:28:17PM -0500, James Bottomley wrote:
> So you're worried about our code?  OK, if you look, you'll see we only
> have to flush one address in the mmap_shared list, (which is usually the
> long list).

if you need to flush just one address, the prio-tree may give you an
huge boost, overall flush_dcache_page should become pretty quick in most
situations.

> I'd be very surprised if flush_dcache_page executes more than a few
> hundred instructions all told...that's certainly nowhere close to a
> timeslice.

What you miss is that the problem is not in flush_dcache_page, the
problem is that the _other_ users of the prio-tree may take as long as a
timeslice. So it's the _other_ user that you've no control about (i.e.
truncate) that may take timeslices with irq disabled.

But I've an fairly optimal solution for you, you should make it a
read_write spinlock, with the readers not disabling interrupts, and the
writer disabling interrupts, the writer of the prio-tree will not take a
timeslice, the readers instead will take a timeslice, but since they're
readers and you've only to read in the flush_dcache_page irq context,
you don't need to disable irqs for the readers.  I don't have better
solutions than this one at the moment (yeah there's the rcu reading of
the prio-tree but I'd leave it for later...)
