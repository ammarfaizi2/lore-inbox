Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287488AbSAHAW3>; Mon, 7 Jan 2002 19:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287478AbSAHAW0>; Mon, 7 Jan 2002 19:22:26 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:64269 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287488AbSAHAVp>;
	Mon, 7 Jan 2002 19:21:45 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15418.15099.922688.165706@argo.ozlabs.ibm.com>
Date: Tue, 8 Jan 2002 11:19:07 +1100 (EST)
To: mike stump <mrs@windriver.com>
Cc: gdr@codesourcery.com, dewar@gnat.com, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <200201071936.LAA12038@kankakee.wrs.com>
In-Reply-To: <200201071936.LAA12038@kankakee.wrs.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike stump writes:

> #define hide(x) ({ void *vp = x; asm ("" : "+r" (vp)); vp; })
> 
> main() {
>   strcpy(buf, hide("eeeeeeeeeeeeeeeeeeeeeeeeeeeeeelksdlkjasdlkjasdlkjasdaaaaaaaaaa"+20));
> }
> 
> Perfectly clear, simple, doesn't burn regs and so on.  In fact, even
> the assembly file doesn't have any extraneous output, cool.

Clear to you, I had to look up the gcc info pages to find out what the
"+" constraint does. :)

Is the "r" constraint available (and reasonable) on all architectures
that GCC targets?

> > My main problem with this is that it doesn't actually solve the
> > problem AFAICS.
> 
> It does for now.  It will for the next 10 years, my guess.  volatile
> will solve it longer, at some performance penalty, if you prefer.
>
> > Dereferencing x is still undefined according to the rules in the gcc
> > manual.
> 
> ?  So what?  Pragmatically, for now, it does what the user wants.  By
> the time we break it, we'll probably have enough intelligence in the
> compiler to figure out what they were doing and still not break it.

I guess I am reacting to the criticism expressed in this thread
against people who write code which happens to work with a particular
compiler version but for which there is nothing in the standard or
documentation which says that it should work or will continue to work.
It seems to me that the asm is in that category.  If the gcc
maintainers were willing to document that side effect that would make
me more comfortable with it.  But it still seems like using an ax as a
screwdriver to me.

> Then move the bits to the right address before you execute the C code
> and code the thing that moves the bits in assembly.

Yes, I'm using -mrelocatable on the relevant files now instead of the
RELOC macro.  But there are still a couple of places where I need to
take a pointer value which is valid when running at the initial
address and adjust it so it will be valid later when running at the
final address.

The broader issue is one of how the kernel can construct pointers from
addresses in general and be sure that gcc won't assume it knows what
the pointer points to.  The kernel needs to be able to do this.

> > - it is a statement, which makes it less convenient to use than an
> >   expression
> 
> ? In my example, it is an expression.

Well, it's a statement expression. :)  Aren't those deprecated these
days?

> > - it requires an extra dummy variable declaration.
> 
> Mine doesn't.

<nitpicking> What's the "void *vp;" then? </nitpicking>

> > But my main objection is that I don't have any assurance that it
> > actually solves the problem in a lasting way.
> 
> The code only in that subset of C that is well defined and only use
> semantics that have mandated behavior.

That gives me no way to turn an address into a pointer.

Paul.
