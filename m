Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbTESMDl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 08:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262426AbTESMDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 08:03:41 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:25301 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262412AbTESMDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 08:03:39 -0400
Date: Mon, 19 May 2003 14:16:24 +0200 (MEST)
Message-Id: <200305191216.h4JCGONj015081@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: alexander.riesen@synopsys.COM, sfr@canb.auug.org.au
Subject: Re: 2.5.69+bk: oops in apmd after waking up from suspend mode
Cc: linux-kernel@vger.kernel.org, linux-laptop@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003 11:48:13 +0200, Alex Riesen wrote:
>I have an old Compaq Armada 1592DT. The thing goes automagically into
>suspend mode after being forgotten for a while. And there is this button
>to wake it up (the blue one, above the keyboard).
>
>Last time i tried to wake it up it produced the attached oops.
>"Unknown key"s are probable the blue button.
>After printing out the oops, the system went back into suspend.
>
>-alex
>
>Suspending devices
>Suspending device c03219ac
>Unable to handle kernel NULL pointer dereference at virtual address 00000090
> printing eip:
>c011459f
>*pde = 00000000
>Oops: 0000 [#1]
>CPU:    0
>EIP:    0060:[<c011459f>]    Not tainted
>EFLAGS: 00010202
>EIP is at fix_processor_context+0x5f/0x100
>eax: 0000007c   ebx: c5f0e000   ecx: 00000002   edx: 00000000
>esi: 00000060   edi: 00000000   ebp: c5f0ff5c   esp: c5f0ff54
>ds: 007b   es: 007b   ss: 0068
>Process kapmd (pid: 4, threadinfo=c5f0e000 task=c5fbc640)

After receiving Alex' .config and gcc version (3.2.3), I've been
able to decipher this. current->mm is NULL in the kapmd task. The call

	load_LDT(&current->mm->context);	/* This does lldt */

in fix_processor_context() computes the address of context as
(current->mm)+0x7c, which is 0x7c. load_LDT_nolock() dereferences
0x7c+0x14 (void *segments = pc->ldt) and the oops follows.

As to _why_ kapmd's current->mm is NULL, I don't know. It isn't
when I test APM suspend in 2.5.69-bk. A lot of code dereferences
current->mm without checking, so I guess current->mm==NULL is a bug.

/Mikael
