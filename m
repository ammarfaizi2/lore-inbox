Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266406AbTAUIjy>; Tue, 21 Jan 2003 03:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266537AbTAUIjy>; Tue, 21 Jan 2003 03:39:54 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:28314 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S266406AbTAUIjw>; Tue, 21 Jan 2003 03:39:52 -0500
Message-Id: <200301210835.h0L8ZhOf002653@eeyore.valparaiso.cl>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch?: linux-2.5.59/sound/soundcore.c referenced non-existant errno variable 
In-Reply-To: Your message of "Mon, 20 Jan 2003 11:53:54 PST."
             <200301201953.LAA15002@adam.yggdrasil.com> 
Date: Tue, 21 Jan 2003 09:35:43 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> said:
> On Mon, 20 Jan 2003, Horst von Brand wrote:
> >"Adam J. Richter" <adam@yggdrasil.com> said:
> >> 	To my knowledge, a goto in this case is not necessary for
> >> avoiding code duplication.  If there are a small number of failable
> >> steps that may need to be unwound, you could adopt the style of my patch
> >> (which shortened the code slightly):
> >> 
> >>        if (step1() == ok) {
> >> 		if (step2() == ok) {
> >> 			if (strep3() == ok)
> >> 				return OK;
> >> 			undo_step2();
> >> 		}
> >> 		undo_step1();
> >> 	}
> >> 	return failure;

> >The "undo_stepX()"'s pollute the CPU's cache,
> 
> 	I believe my example should generate exactly the same machine
> object code as what Petr was describing,

You very much overestimate current C compilers. The code in real examples
is much more complicated than a single undo_foo line, with its own control
structures. 

>                                          that is, something like this,
> which is longer and has more labels to remember or potentially a
> mistake in jumping to the wrong label:
> 
> 	if (step1() != ok)
> 		goto abort1;
> 
> 	if (step2() != ok)
> 		goto abort2;
> 
> 	if (step3() == ok)
> 		return OK;
> 
> 	undo_step2();
> abort2:
> 	undo_step1();
> abort1:
> 	return failure;
> 
> 	In both cases, the compiler is normally going to put all of
> error handling code after all of the success code,

In a simple case like this, maybe; in complex cases it won't.

>                                                    so the only extra
> instructions read into the cache will be from the tail end of the

> >and (even much worse) the gentle reader's.
> 
> 	Don't know what you mean here, given that the number of
> steps is small.

The number of steps in cleanups generally isn't all that small. Besides, a
stack of:

   label2:
       undo_2;
   label1:
       undo_1;
   label0:
       finish_up;
       return;

is easier to check that all undoX' get done in the right order.

[...]

> >screws up or gives bad code due to compiler
> >bugs.
> 
> 	Can you elaborate on this?  "if()" obviously is a widely used
> facility, so I assume you're talking about something more specific,
> but I don't know what.  I'd be interested if you could point me to the
> specific bug or bugs you are refererring to.

There have been cases where gcc generated rather funny code for inline
functions, or just didn't optimize over inline function boundaries.

> >Plus has the gentle reader who wants to check error handling chasing
> >all over the place.
> 
> 	But that is even more the case with gotos, which involves
> remembering labels and noramlly has no indentation to show the
> structure of the branches.

The structure (in the kernel's use of this) is very simple, linear as shown
above. Sure, you can make a real mess, but I'm saying you should be careful
not to.

> >> 	In general, I recommend using goto only when it is
> >> topologically necessary to avoid code duplication or due to some
> >> compiler quirk where you want to sqeeze a few more cycles out of code
> >> in a critical path.  That way, the use of goto basically flags these
> >> unusual cases for other programmers.
> 
> >IMVHO, any general criterion that is not strictly based on code
> >understandability, possibly mitigated by a justified need of maximal speed,
> >is flawed. This might come close, but won't cut it for me.
> 
> 	Firstly, I think my recommendation happens to be "based on
> code understandability, possibly mititgated by a justified need for
> maximal speed".

Topology sure has a relation to the cognitive processes involved in code
understanding, but can't be all AFAICS. "Topologically necessary" doesn't
consider size of code involved (perhaps duplicating one simple line is
clearer code in the end), and doesn't distinguish between functions of code
streches, i.e., main code vs auxiliary code (like error handling). Perhaps
a goto is topologically unnecessary, placing the error handling into the
main code stream, or even worse, placing main and auxiliary code in similar
positions, where it is harder to distinguish between them. And code is put
to different uses, sometimes I'll concentrate on the main flow (error
handling is irrelevant), others I'm checking errors are handled in the
right order (main flow is unimportant then), a separation is useful. What
distinguishes stepX() and undoX() in your example is just their names, if
they where a dozen lines of code each with their own control structures,
you'd have no clue which is main code and which is cleanup. In Linus'
style, the error handling code is all together, at the end, clearly
separated from the main flow of control.

> 	Secondly, at the risk of going off on a tangent, I also happen
> to think your thesis is not well defined and also wrong in some cases.

> 	Your thesis uses the terms "strictly" and "flawed" without
> defining them well.  If you were to replace those terms with a more
> objective descriptions (e.g., "will likely cause more bugs to be
> missed" if that is only what you mean) then it would be clearer
> whether I (or any other reader) agrees or disagrees with your claim,
> and exactly where.

There has not been (and probably can't be) a quantitative comparison of
debuggability of code written with differing styles and restrictions of
goto use, so this is moot.

> 	To the extent that I think we might agree on possible meanings
> for terms like "flawed", I think your thesis is technically false
> because it fails to consider that there may be other desired benefits.
> I can think of numerous general criteria that are not "strictly based
> on the need for understandability, possibly mititigated by speed."
> For instance, deleting functionality can make code more understandable
> and faster, and yet I would not say that every criteria of the form
> "functionality X is should be provided for reason Y" is flawed.

If you are bound to "reason Y" has to be provided, the question is not IF
but HOW. And the "cut out crap" is an extremely fruitful design strategy.

> Otherwise, perhaps you would want to run the following very
> understandable and fast kernel:
> 
> 		/* This is the entire kernel.  It is very understandable
> 		   and fast! */
> 		void linux_version_3_0(void) {
> 			for(;;)
> 				;

Right. Full POSIX compatible, I presume.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
