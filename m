Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261199AbVABLz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261199AbVABLz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 06:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVABLz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 06:55:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32273 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261199AbVABLzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 06:55:23 -0500
Date: Sun, 2 Jan 2005 11:55:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix MMC warnings
Message-ID: <20050102115520.A4166@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <41D73B43.3080109@drzeus.cx> <20050102084409.A1925@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050102084409.A1925@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Jan 02, 2005 at 08:44:09AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 08:44:09AM +0000, Russell King wrote:
> On Sun, Jan 02, 2005 at 01:07:31AM +0100, Pierre Ossman wrote:
> > Here's a patch that fixes the compiler warnings in mmc.c.
> 
> I'd rather the compiler was fixed so that it does proper analysis of
> the code, rather than blatently issuing warnings for code which is
> unreachable.

Actually, you're quite correct about the first instance - 'mask' may
be generated from 1 << 32 - 1, which is definitely reachable, and gcc
will warn about.  There's also another bug - an out by one on whether
to use the second word to construct the value.

However, the other 5 warnings are due to (corrected version):

	if (16 + 0 > 32)
		__res |= resp[__off-1] << (32 - 0);

Obviously, this code is not reachable since the if condition is false.
Therefore, gcc's whinging about the shift being >= 32 is wrong.

That said, the fix doesn't change gcc's code generation, so I think I'll
apply the changes.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
