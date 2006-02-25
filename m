Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWBYVXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWBYVXD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 16:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWBYVXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 16:23:03 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35851 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750767AbWBYVXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 16:23:02 -0500
Date: Sat, 25 Feb 2006 21:22:48 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060225212247.GC15276@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <0.399206195@selenic.com> <4.399206195@selenic.com> <20060224221909.GD28855@flint.arm.linux.org.uk> <20060225065136.GH13116@waste.org> <20060225084955.GA27538@flint.arm.linux.org.uk> <20060225145412.GI13116@waste.org> <20060225180521.GB15276@flint.arm.linux.org.uk> <20060225210454.GL13116@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225210454.GL13116@waste.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 03:04:54PM -0600, Matt Mackall wrote:
> On Sat, Feb 25, 2006 at 06:05:21PM +0000, Russell King wrote:
> > It seems that you're missing this case - the case where lib/inflate.c
> > is used elsewhere in the kernel apart from the boot time decompressors.
> 
> I think you must be getting confused with lib/zlib. lib/inflate.c is
> only used at boot.

No I'm not.  Look:

$ grep -r '#include.*lib/inflate.c' [a-z]*
arch/alpha/boot/misc.c:#include "../../../lib/inflate.c"
arch/arm/boot/compressed/misc.c:#include "../../../../lib/inflate.c"
arch/arm26/boot/compressed/misc.c:#include "../../../../lib/inflate.c"
arch/cris/arch-v10/boot/compressed/misc.c:#include "../../../../../lib/inflate.c"
arch/cris/arch-v32/boot/compressed/misc.c:#include "../../../../../lib/inflate.c"
arch/i386/boot/compressed/misc.c:#include "../../../../lib/inflate.c"
arch/m32r/boot/compressed/misc.c:#include "../../../../lib/inflate.c"
arch/sh/boot/compressed/misc.c:#include "../../../../lib/inflate.c"
arch/sh64/boot/compressed/misc.c:#include "../../../../lib/inflate.c"
arch/x86_64/boot/compressed/misc.c:#include "../../../../lib/inflate.c"

All these are to do with decompressing a compressed kernel.  If they
fail, halting is perfectly reasonable because we probably don't have
an executable kernel.  Your arguments are fine for these.  But, that's
not the full story - there are two more places where this code is
used:

init/do_mounts_rd.c:#include "../lib/inflate.c"
init/initramfs.c:#include "../lib/inflate.c"

for these your arguments that halting is fine is _NOT_ correct nor is it
desirable.  The first of these is the cause of the problems both myself
and others saw, as detailed in the URL I posted previously in this thread.
Did you read that post?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
