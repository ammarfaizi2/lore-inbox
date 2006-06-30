Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWF3KMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWF3KMq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 06:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWF3KMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 06:12:46 -0400
Received: from liaag1ag.mx.compuserve.com ([149.174.40.33]:3507 "EHLO
	liaag1ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750832AbWF3KMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 06:12:45 -0400
Date: Fri, 30 Jun 2006 06:07:05 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.17-mm4
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606300609_MC3-1-C3D7-6B49@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060629232739.GA28306@elte.hu>

On Fri, 30 Jun 2006 01:27:39 +0200, Ingo Molnar wrote:

> > +profile-likely-unlikely-macros.patch
> 
> CONFIG_PROFILE_LIKELY doesnt quite work:
> 
>  Low memory ends at vaddr f7e00000
>  node 0 will remap to vaddr f7e00000 - f8000000
>  High memory starts at vaddr f7e00000
>  found SMP MP-table at 000f5680
>  NX (Execute Disable) protection: active
>  Unknown interrupt or fault at EIP 00000060 c1d9f264 00000002
>  Unknown interrupt or fault at EIP 00000060 c0100295 0000f264
>  Unknown interrupt or fault at EIP 00000060 c0100295 00000294
>  Unknown interrupt or fault at EIP 00000060 c0100295 00000294
>  Unknown interrupt or fault at EIP 00000060 c0100295 00000294
>  Unknown interrupt or fault at EIP 00000060 c0100295 00000294
> 
> disabling it makes these go away.

Can you find out what source line belongs to c1d9f264?

arch/i386/kernel/head.S::ignore_int(), which produced those messages,
is horribly broken.  The first fault was likely a page fault attempting
to write to some unmapped area.  Since page fault pushes an error code
onto the stack and ignore_int() doesn't pop it because it has no idea
whether one is there, it attempts to return to cs:eip f264:00000002
which causes segment-not-present for segment index f264 in the GDT.
Same thing then happens when _that_ tries to return to 0295:0000f264;
now we are into infinite recursion. Eventually the stack will overflow
and more fun errors will occur...

Is this worth fixing?  We could get nice diagnostics for page fault
here by writing a handler for early init code.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
