Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265816AbTIJVrE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 17:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265817AbTIJVrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 17:47:04 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:12945 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S265816AbTIJVq7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 17:46:59 -0400
Date: Wed, 10 Sep 2003 22:46:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <davej@redhat.com>,
       Mitchell Blank Jr <mitch@sfgoth.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oops_in_progress is unlikely()
Message-ID: <20030910214610.GB24258@mail.jlokier.co.uk>
References: <20030907064204.GA31968@sfgoth.com> <20030907221323.GC28927@redhat.com> <20030910142031.GB2589@elf.ucw.cz> <20030910142308.GL932@redhat.com> <20030910152902.GA2764@elf.ucw.cz> <Pine.LNX.4.53.0309101147040.14762@chaos> <20030910183138.GA23783@mail.jlokier.co.uk> <Pine.LNX.4.53.0309101439390.18459@chaos> <20030910201240.GB24424@mail.jlokier.co.uk> <Pine.LNX.4.53.0309101619020.18924@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309101619020.18924@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> > 		cmpl	$1,%eax
> > 		jbe	1f
> > 		call	do_default
> > 	more_code:
> > 		.subsection 1
> > 	1:	jnz	2f
> > 		call	do_something_if_equal
> > 		jmp	more_code
> > 	2:	call	do_something_if_less
> > 		jmp	more_code
> > 		.previous
> >
> 
> You are a magician! Putting in a .subsection to hide the jump
> is absolute bullshit. The built-in macros, ".subsection", and
> ".previous" just made the damn linker do the fixup. You just
> did a long jump, out of the current code-stream, into some
> other section. Then you jumped back. Hell of an optimization!

".subsection" does not create jump instructions.  The linker does not
create jump instructions.  The only jump instructions are the ones
written in the source code.

The above code will execute three instructions in the do_default case:
"cmpl", "jbe" and "call".  No jumps are taken in that case.

The code does exactly what you said is logically impossible: one of
the cases, presumably marked "likely" in C code, takes no jumps at
all.  What the other cases do is irrelevant.  That is called
optimising for the likely case, at the expense of the others.

Try assembling the above source, with a "ret" after it, and then
disassemble the object file, if you don't believe me.

Or just read Pavel's example.

If you don't understand Pavel's example, there is no hope of you
grokking the advanced stuff ;)

Seriously, you can't possibly have done asm programming for 30
years without optimising for fast paths... surely?

> Linker tricks won't work for me.

You'll be glad to know GCC does it without linker tricks.

> Also, putting some address on the stack and executing 'ret' emulate
> a jump won't impress me either.

It shouldn't.  That would misalign the RSB (return stack buffer:
target prediction for "ret") causing several subsequent "ret"
instructions to mispredict their targets and stall the pipeline.

-- Jamie
