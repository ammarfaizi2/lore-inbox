Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVDGQd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVDGQd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 12:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262513AbVDGQd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 12:33:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:51905 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262511AbVDGQd4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 12:33:56 -0400
Date: Thu, 7 Apr 2005 09:35:49 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Stas Sergeev <stsp@aknet.ru>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: Re: crash in entry.S restore_all, 2.6.12-rc2, x86, PAGEALLOC
In-Reply-To: <42555BBF.6090704@aknet.ru>
Message-ID: <Pine.LNX.4.58.0504070930190.28951@ppc970.osdl.org>
References: <20050405065544.GA21360@elte.hu> <4252E2C9.9040809@aknet.ru>
 <Pine.LNX.4.58.0504051217180.2215@ppc970.osdl.org> <4252EA01.7000805@aknet.ru>
 <Pine.LNX.4.58.0504051249090.2215@ppc970.osdl.org> <425403F6.409@aknet.ru>
 <20050407080004.GA27252@elte.hu> <42555BBF.6090704@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2005, Stas Sergeev wrote:
> 
> > because it adds the 2 words space that is needed - but the information 
> > relied on by your irq-return test is still bogus.
>
> But as an example for demonstrating the problem,
> I thought, it could do:)

Ingo: the information is bogus, but you're wrong: the code doesn't "rely"  
on it.

The fact is, bogus information is _fine_. That's what speculative work is 
all about: working with bogus information, with the assumption that some 
later test will ignore it if it's not relevant.

And the later test _will_ ignore it if it isn't relevant. Look for 
yourself:

        cmpl $((4 << 8) | 3), %eax
        je ldt_ss                       # returning to user-space with LDT SS

notice how the "cmpl" _only_ triggers if the old CS had the low three bits 
set and if EFLAGS_VM is clear. So if we return to kernel mode (or vm86) 
mode, we _know_ that the SS is bogus, but we don't care. We've tested for 
the proper thing, and we only do the special user-space LDT SS case if
 - the LDT bit was set in SS (possibly bogus)
AND
 - old CS was user space
AND
 - old eflags wasn't vm86 mode.

Ie the two second checks are what validates the first (possibly bogus) 
one.

So I really think that the _correct_ fix is literally to move the "cli" 
in the sysenter path down two lines. It doesn't just "hide" the bug, it 
literally fixes is.

		Linus
