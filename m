Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUCTXyu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 18:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263575AbUCTXyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 18:54:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:56581 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262424AbUCTXyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 18:54:49 -0500
Date: Sat, 20 Mar 2004 23:54:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>,
       Jaroslav Kysela <perex@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: can device drivers return non-ram via vm_ops->nopage?
Message-ID: <20040320235445.B24744@flint.arm.linux.org.uk>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jaroslav Kysela <perex@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20040320133025.GH9009@dualathlon.random> <20040320144022.GC2045@holomorphy.com> <20040320150621.GO9009@dualathlon.random> <20040320154419.A6726@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403201651520.1816@pnote.perex-int.cz> <20040320160911.B6726@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403202038530.1816@pnote.perex-int.cz> <20040320222341.J6726@flint.arm.linux.org.uk> <20040320224518.GQ2045@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040320224518.GQ2045@holomorphy.com>; from wli@holomorphy.com on Sat, Mar 20, 2004 at 02:45:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 02:45:18PM -0800, William Lee Irwin III wrote:
> Is there any possibility of an extension to remap_area_pages() that
> could resolve this? I can't say I fully understood and/or remember
> the issue with it that you pointed out.

The issues are:

1. ALSA wants to mmap the buffer used to transfer data to/from the
   card into user space.  This buffer may be direct-mapped RAM,
   memory allocated via dma_alloc_coherent(), an on-device buffer,
   or anything else.

   The user space mapping must likewise be DMA-coherent.

   Currently, ALSA just does virt_to_page() on whatever address it
   feels like in its nopage() function, which is obviously not
   acceptable for two out of the three specific cases above.

2. ALSA wants to _coherently_ share data between the kernel-side
   drivers, and user space ALSA library, mainly the DMA buffer
   head/tail pointers so both kernel space and user space knows
   when the buffer is full/empty.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
