Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285703AbSAGTh7>; Mon, 7 Jan 2002 14:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285724AbSAGThu>; Mon, 7 Jan 2002 14:37:50 -0500
Received: from unknown-1-11.windriver.com ([147.11.1.11]:37277 "EHLO
	mail.wrs.com") by vger.kernel.org with ESMTP id <S285703AbSAGThe>;
	Mon, 7 Jan 2002 14:37:34 -0500
From: mike stump <mrs@windriver.com>
Date: Mon, 7 Jan 2002 11:36:45 -0800 (PST)
Message-Id: <200201071936.LAA12038@kankakee.wrs.com>
To: gdr@codesourcery.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: dewar@gnat.com, gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        trini@kernel.crashing.org, velco@fadata.bg
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Paul Mackerras <paulus@samba.org>
> Date: Mon, 7 Jan 2002 08:59:47 +1100 (EST)
> To: Gabriel Dos Reis <gdr@codesourcery.com>

> > Personnally, I don't have any sentiment against the assembler
> > solution.  Dewar said it was unnecessarily un-portable, but that the
> > construct by itself *is* already unportable. 

> I assume that what we're talking about is using an asm statement like:

> 	asm("" : "=r" (x) : "0" (y));

Ick!  No, that's horrible.

char buf[1024];

#define hide(x) ({ void *vp = x; asm ("" : "+r" (vp)); vp; })

main() {
  strcpy(buf, hide("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeelksdlkjasdlkjasdlkjasdaaaaaaaaaa"+20));
}

Perfectly clear, simple, doesn't burn regs and so on.  In fact, even
the assembly file doesn't have any extraneous output, cool.

> My main problem with this is that it doesn't actually solve the
> problem AFAICS.

It does for now.  It will for the next 10 years, my guess.  volatile
will solve it longer, at some performance penalty, if you prefer.

> Dereferencing x is still undefined according to the rules in the gcc
> manual.

?  So what?  Pragmatically, for now, it does what the user wants.  By
the time we break it, we'll probably have enough intelligence in the
compiler to figure out what they were doing and still not break it.

> I would prefer a solution that will last, rather than one which
> relies on details of the current gcc implementation.

Then move the bits to the right address before you execute the C code
and code the thing that moves the bits in assembly.

> - it is hard to read; it wouldn't be obvious to someone who doesn't
>   know the details of gcc asm syntax what it is doing or why

See the comment just above.

> - it is a statement, which makes it less convenient to use than an
>   expression

? In my example, it is an expression.

> - it requires an extra dummy variable declaration.

Mine doesn't.

> But my main objection is that I don't have any assurance that it
> actually solves the problem in a lasting way.

The code only in that subset of C that is well defined and only use
semantics that have mandated behavior.
