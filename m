Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVCYWg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVCYWg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVCYW3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:29:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:57525 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261853AbVCYW1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:27:16 -0500
Subject: Re: [PATCH] ppc32/64: Map prefetchable PCI without guarded bit
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200503240854.45741.jbarnes@engr.sgi.com>
References: <1111645464.5569.15.camel@gaston>
	 <200503240854.45741.jbarnes@engr.sgi.com>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 09:23:40 +1100
Message-Id: <1111789420.5570.67.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-24 at 08:54 -0800, Jesse Barnes wrote:
> On Wednesday, March 23, 2005 10:24 pm, Benjamin Herrenschmidt wrote:
> > While experimenting with framebuffer access performances, we noticed a
> > very significant improvement in write access to it when not setting
> > the "guarded" bit on the MMU mappings. This bit basically says that
> > reads and writes won't have side effects (it allows speculation). It
> > appears that it also disables write combining.
> 
> Doesn't pgprot_writecombine imply non-guarded, so can't you use it instead?  
> Either way, you'll probably want to fix fbmem.c as well and turn off 
> _PAGE_GUARDED?

I'm not sure we implement pgprot_writecombine. But anyway, that wouldn't
help as X uses /dev/mem which doesn't use that, and sysfs new mmap
interface doesn't have anything for setting writecombine.

The interface I propose could be made generic, that is the whole point.
It's basically a mean for the arch to say "heh, somebody wants to map
this bit of physical address space, what pgprot should I use" :) The
decision of wether to do uncacheable or writecombine, all the
page_in_ram() trickery in /dev/mem or fbmem can be moved to arch
specific routines and cleanup the generic stuff.

> Maybe it's time for a more generic call to support this stuff, both for 
> in-kernel mappings and ones that we export to userspace.

Yah, in-kernel mappings aren't covered yet, as my interface supposes a
"struct file" but then, I don't use the struct file argument in my ppc
implementation (I exposed it for the sake of archs that may want it). We
could just define that in-kernel mappings can call this with NULL for
struct file.

Ben.


