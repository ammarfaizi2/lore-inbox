Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263153AbVFXKdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbVFXKdP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 06:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263221AbVFXKdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 06:33:15 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:34318 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263153AbVFXKdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 06:33:03 -0400
Date: Fri, 24 Jun 2005 11:32:58 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Finding what change broke ARM
Message-ID: <20050624113258.A27909@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20050624101951.B23185@flint.arm.linux.org.uk> <20050624105328.C23185@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050624105328.C23185@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Fri, Jun 24, 2005 at 10:53:28AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2005 at 10:53:28AM +0100, Russell King wrote:
> and a .config which looks like this:
> 
> CONFIG_ARCH_SA1100=y
> ...
> # CONFIG_ARCH_DISCONTIGMEM_ENABLE is not set
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_FLATMEM_MANUAL=y
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> # CONFIG_SPARSEMEM_MANUAL is not set
> CONFIG_DISCONTIGMEM=y
> CONFIG_FLATMEM=y
> CONFIG_FLAT_NODE_MEM_MAP=y
> CONFIG_NEED_MULTIPLE_NODES=y
> 
> At a guess, this is because we have two memory models selected - because
> the Kconfig magic in mm/Kconfig isn't correct for ARM.
> 
> ARM selects CONFIG_DISCONTIGMEM for certain platforms (based on
> CONFIG_ARCH_SA1100 in this case.)  mm/Kconfig decides on its own back
> that it'll choose CONFIG_FLATMEM for us.  So two models get selected.
> 
> Should I remove the mm/Kconfig include and replicate what's required for
> ARM, or... ?  TBH mm/Kconfig seems to be rather OTT.
> 
> Help!

Well, this fixes the problem, but I doubt people will like it.

Index: mm/Kconfig
===================================================================
--- fc736377c5c7e23ee78569392ed31a6030289e44/mm/Kconfig  (mode:100644)
+++ uncommitted/mm/Kconfig  (mode:100644)
@@ -71,7 +71,7 @@
 
 config FLATMEM
 	def_bool y
-	depends on (!DISCONTIGMEM && !SPARSEMEM) || FLATMEM_MANUAL
+	depends on (!DISCONTIGMEM && !SPARSEMEM) #|| FLATMEM_MANUAL
 
 config FLAT_NODE_MEM_MAP
 	def_bool y


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
