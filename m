Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUHHJgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUHHJgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 05:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUHHJgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 05:36:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10257 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S265237AbUHHJgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 05:36:22 -0400
Date: Sun, 8 Aug 2004 10:36:19 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.8-rc3 slab corruption (jffs2?)
Message-ID: <20040808103619.A7589@flint.arm.linux.org.uk>
Mail-Followup-To: Manfred Spraul <manfred@colorfullife.com>,
	linux-kernel@vger.kernel.org
References: <4115F0FA.30503@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <4115F0FA.30503@colorfullife.com>; from manfred@colorfullife.com on Sun, Aug 08, 2004 at 11:23:06AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 11:23:06AM +0200, Manfred Spraul wrote:
> rmk wrote:
> >Due to tail call optimisation, its difficult to work out exactly what's
> >going on, but the first seems to be a kfree call from the erase callback
> >(possibly jffs2_erase_callback).  The second function is the call to
> >jffs2_free_full_dirent() in jffs2_garbage_collect_deletion_dirent().
>
> I'd concentrate on cfi_intelext_erase_varsize+0x58/0x64:
> When slab encounters a corruption, it dumps three objects: the corrupted 
> one, the previous one and the next one. Theoretically, a write 
> before/after the end of the object could corrupt the neighboring object, 
> but probably the first function is the relevant one.

Remember - we report the _return_ address of a function when we use
__builtin_return_address(0) in that function.

This means that if kfree() is called from a tail-call optimised
position, the reported address will be the parent function of the
one which actually called it.

Therefore, cfi_intelext_erase_varsize() called some other function
(in this case, via a function pointer) which then called kfree() in
a tail-call optimised position.  jffs2_erase_callback() would be
called from this function pointer and does have kfree() in a tail-call
optimised position.

However, reading the code around jffs2_erase_callback() and
jffs2_erase_block(), I can find nothing obviously wrong.

The main problem is that I don't actually know what triggered it in the
first place - I'd just booted the machine and was just logging in when
it poped up, but repeating this does not cause the problem.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
