Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbUCTR4F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 12:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263497AbUCTR4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 12:56:05 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52950
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263493AbUCTR4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 12:56:00 -0500
Date: Sat, 20 Mar 2004 18:56:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320175652.GC9009@dualathlon.random>
References: <20040320133025.GH9009@dualathlon.random> <Pine.LNX.4.58.0403200937500.1106@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403200937500.1106@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 09:39:51AM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 20 Mar 2004, Andrea Arcangeli wrote:
> >
> > The only bugreport I've got so far for the latest anon_vma code is from
> > Jens, and it's a device driver bug in my opinion, but I'd like to have a
> > definitive confirmation from you about the ->nopage API.
> 
> I'd say that this is definitely a driver bug.
> 
> If a driver wants to map non-RAM pages, that's perfectly ok, but it MUST 
> NOT happen through "nopage()". The driver should map them with 
> "remap_page_range()", and thus never take a page fault for such pages at 
> all.
> 
> There is no reason to ever lazily map non-RAM pages - clearly they aren't 
> using any "real memory", so there is no reason to not fill the page tables 
> at mmap() time.
> 
> In other words, the driver is horribly broken.

thanks for the clarification.

At the moment I'm not sure anymore if this was non-ram or a
VM_FAULT_SIGBUS because I noticed I was doing BUG_ON(!pfn_valid)
_before_ checking new_page == VM_FAULT_SIGBUS. Though my theory about
do_no_page working fine with non-ram page_t with >=128m machines up to
2.6.4 still holds, and it's not obvious that Jens triggered a SIGBUS
either.
