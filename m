Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbTATTqx>; Mon, 20 Jan 2003 14:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266749AbTATTpk>; Mon, 20 Jan 2003 14:45:40 -0500
Received: from h-64-105-35-85.SNVACAID.covad.net ([64.105.35.85]:56301 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266730AbTATTo4>; Mon, 20 Jan 2003 14:44:56 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 20 Jan 2003 11:53:54 -0800
Message-Id: <200301201953.LAA15002@adam.yggdrasil.com>
To: brand@jupiter.cs.uni-dortmund.de
Subject: Re: Patch?: linux-2.5.59/sound/soundcore.c referenced non-existant errno variable
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2003, Horst von Brand wrote:

>"Adam J. Richter" <adam@yggdrasil.com> said:
>> 	To my knowledge, a goto in this case is not necessary for
>> avoiding code duplication.  If there are a small number of failable
>> steps that may need to be unwound, you could adopt the style of my patch
>> (which shortened the code slightly):
>> 
>>        if (step1() == ok) {
>> 		if (step2() == ok) {
>> 			if (strep3() == ok)
>> 				return OK;
>> 			undo_step2();
>> 		}
>> 		undo_step1();
>> 	}
>> 	return failure;

>The "undo_stepX()"'s pollute the CPU's cache,

	I believe my example should generate exactly the same machine
object code as what Petr was describing, that is, something like this,
which is longer and has more labels to remember or potentially a
mistake in jumping to the wrong label:

	if (step1() != ok)
		goto abort1;

	if (step2() != ok)
		goto abort2;

	if (step3() == ok)
		return OK;

	undo_step2();
abort2:
	undo_step1();
abort1:
	return failure;

	In both cases, the compiler is normally going to put all of
error handling code after all of the success code, so the only extra
instructions read into the cache will be from the tail end of the


>and (even much worse) the gentle reader's.

	Don't know what you mean here, given that the number of
steps is small.


>> 	If the nesting gets any deeper than this, then a more
>> understandable solution for readability than using goto would be to
>> define a separate inline routine.

>Can't be done (cleanly) in many cases due to function semantics in C,


	I said that sometimes using goto is topologically necessary.

	Your use of the term "(cleanly)" is apparently something
subjective about which we disagree.  To convert it to an objective
critereon would require cognitive research (for example, having dozens
of programmers try to debug code written one way or the other, under
carefully controlled conditions).


>polutes CPU cache as above,

	(Addressed above.)


>screws up or gives bad code due to compiler
>bugs.

	Can you elaborate on this?  "if()" obviously is a widely used
facility, so I assume you're talking about something more specific,
but I don't know what.  I'd be interested if you could point me to the
specific bug or bugs you are refererring to.


>Plus has the gentle reader who wants to check error handling chasing
>all over the place.

	But that is even more the case with gotos, which involves
remembering labels and noramlly has no indentation to show the
structure of the branches.

>> 	In general, I recommend using goto only when it is
>> topologically necessary to avoid code duplication or due to some
>> compiler quirk where you want to sqeeze a few more cycles out of code
>> in a critical path.  That way, the use of goto basically flags these
>> unusual cases for other programmers.

>IMVHO, any general criterion that is not strictly based on code
>understandability, possibly mitigated by a justified need of maximal speed,
>is flawed. This might come close, but won't cut it for me.

	Firstly, I think my recommendation happens to be "based on
code understandability, possibly mititgated by a justified need for
maximal speed".

	Secondly, at the risk of going off on a tangent, I also happen
to think your thesis is not well defined and also wrong in some cases.

	Your thesis uses the terms "strictly" and "flawed" without
defining them well.  If you were to replace those terms with a more
objective descriptions (e.g., "will likely cause more bugs to be
missed" if that is only what you mean) then it would be clearer
whether I (or any other reader) agrees or disagrees with your claim,
and exactly where.

	To the extent that I think we might agree on possible meanings
for terms like "flawed", I think your thesis is technically false
because it fails to consider that there may be other desired benefits.
I can think of numerous general criteria that are not "strictly based
on the need for understandability, possibly mititigated by speed."
For instance, deleting functionality can make code more understandable
and faster, and yet I would not say that every criteria of the form
"functionality X is should be provided for reason Y" is flawed.
Otherwise, perhaps you would want to run the following very
understandable and fast kernel:

		/* This is the entire kernel.  It is very understandable
		   and fast! */
		void linux_version_3_0(void) {
			for(;;)
				;
		}

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
