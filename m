Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVAPU5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVAPU5U (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 15:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVAPU5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 15:57:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:3047 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262604AbVAPU5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 15:57:17 -0500
Date: Sun, 16 Jan 2005 12:57:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH-RFC] arch/i386/kernel/: kill some sparse warnings
In-Reply-To: <20050116202335.GA11791@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0501161237350.8178@ppc970.osdl.org>
References: <20050116202335.GA11791@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 Jan 2005, Sam Ravnborg wrote:
> 
> loadsegment take the pointer to second argument and cast it to unsigned
> int *. Using a properly sized variable as argument to loadsegment kills
> this warning.

I think the bug here is in "loadsegment".

I don't really see why it uses "m" in the first place, since you can 
certainly move to a segment register from a reg too.

Afaik, that

	"m" (*(unsigned int *)&(value)))

is likely from some old bogus code for totally historical reasons, and it 
should likely just be

	"rm" (value)

instead.

Of course, there may be some strange mis-use of the thing somewhere which 
explains why the code does something that strange, and thus it might be 
best to check that all users are ok.

> For this fix I wonder what happened to the upper bits in the old
> implmentation - they were undefined per definition.

They are ignored by the definition of the instruction, and the 32-bit 
version (without a data size override) is selected just because it is 
faster. Which may be why it does that strange cast too: to make sure that 
the size of the operand matches (not that it should _matter_ for a memory 
op).

Oh, and the "%0" in the asm descriptor should probably have the operand 
character override for a full word, to make sure that the operand size 
(when we use a register - where it _does_ matter) matches the "movl". 

I think that means it should be "%k0" instead of "%0", ie something like

	"movl %k0,%%" #seg "\n"

for the move itself, along with the fix for the strange value thing.

Willing to see if that works ok?

		Linus
