Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWEPChc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWEPChc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 22:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbWEPChc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 22:37:32 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:27559 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751081AbWEPChb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 22:37:31 -0400
Date: Mon, 15 May 2006 22:29:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Segfault on the i386 enter instruction
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200605152231_MC3-1-BFDF-12B4@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44676F42.7080907@aknet.ru>

On Sun, 14 May 2006 21:56:18 +0400, Stas Sergeev wrote:

> Andi Kleen wrote:
> > Handling it like you expect would require to disassemble 
> > the function in the page fault handler and it's probably not 
> > worth doing that for this weird case.
> Just wondering, is this case really that weird?
> In fact, the check against %esp that the kernel
> does, looks strange. I realize that it can catch a
> (very rare) user-space bug of accessing below %esp, but
> other than that it looks redundant (IMHO) and as soon as
> it triggers the false-positives, what is it really good for?

I can't get a SIGSEGV on any native i386 kernel, not even when
running on AMD64.  It only happens on native x86_64 kernels.

Looking at the AMD instruction manual, the pseudo-code for 'enter'
ends with:

RSP.s = RSP - temp_ALLOC_SPACE // Leave "temp_ALLOC_SPACE" free bytes on
                               // the stack
WRITE_MEM.v [SS:RSP.s] = temp_unused // ENTER finishes with a memory write
                                     // check on the final stack pointer,
                                     // but no write actually occurs.
RBP.v = temp_RBP
EXIT


And the Intel manual says:

IF 64-Bit Mode (StackSize = 64)
THEN
        RBP = FrameTemp;
        RSP = RSP - Size;
ELSE IF StackSize = 32
THEN
        EBP = FrameTemp;
        ESP = ESP - Size;
ELSE (* StackSize = 16 *)
        BP = FrameTemp;
        SP = SP - Size;
FI;
END;


Intel says nothing about a write check.  Is that a mistake in the manual
or is that something only AMD64 does, and then only in long mode?


-- 
Chuck

"The x86 isn't all that complex -- it just doesn't make a lot of sense."
                                                        -- Mike Johnson
