Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263148AbVFXJxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263148AbVFXJxs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 05:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263151AbVFXJxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 05:53:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63244 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263148AbVFXJxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 05:53:31 -0400
Date: Fri, 24 Jun 2005 10:53:28 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Finding what change broke ARM
Message-ID: <20050624105328.C23185@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050624101951.B23185@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050624101951.B23185@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Fri, Jun 24, 2005 at 10:19:51AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 10:19:51AM +0100, Russell King wrote:
> When building current git for ARM, I see:
> 
>   CC      arch/arm/mm/consistent.o
> arch/arm/mm/consistent.c: In function `dma_free_coherent':
> arch/arm/mm/consistent.c:357: error: `mem_map' undeclared (first use in this function)
> arch/arm/mm/consistent.c:357: error: (Each undeclared identifier is reported only once
> arch/arm/mm/consistent.c:357: error: for each function it appears in.)
> make[2]: *** [arch/arm/mm/consistent.o] Error 1
> 
> How can I find what change elsewhere in the kernel tree caused this
> breakage?
> 
> With bk, you could ask for a per-file revision history of the likely
> candidates, and then find the changeset to view the other related
> changes.
> 
> With git... ?  We don't have per-file revision history so...

This particular breakage appears to have been caused by kbuild not
automatically updating .config.  That's odd because at other times
I've seen kbuild be over-insistent that it needs to update .config.

However, now I get a different error:

  CC      arch/arm/mm/discontig.o
arch/arm/mm/discontig.c:19:3: #error Fix Me Please
arch/arm/mm/discontig.c:30: warning: excess elements in array initializer
arch/arm/mm/discontig.c:30: warning: (near initialization for `discontig_node_data')
arch/arm/mm/discontig.c:31: warning: excess elements in array initializer
arch/arm/mm/discontig.c:31: warning: (near initialization for `discontig_node_data')
arch/arm/mm/discontig.c:32: warning: excess elements in array initializer
arch/arm/mm/discontig.c:32: warning: (near initialization for `discontig_node_data')
make[2]: *** [arch/arm/mm/discontig.o] Error 1

and a .config which looks like this:

CONFIG_ARCH_SA1100=y
...
# CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_DISCONTIGMEM=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_NEED_MULTIPLE_NODES=y

At a guess, this is because we have two memory models selected - because
the Kconfig magic in mm/Kconfig isn't correct for ARM.

ARM selects CONFIG_DISCONTIGMEM for certain platforms (based on
CONFIG_ARCH_SA1100 in this case.)  mm/Kconfig decides on its own back
that it'll choose CONFIG_FLATMEM for us.  So two models get selected.

Should I remove the mm/Kconfig include and replicate what's required for
ARM, or... ?  TBH mm/Kconfig seems to be rather OTT.

Help!

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
