Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133035AbRAVVJl>; Mon, 22 Jan 2001 16:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133051AbRAVVJb>; Mon, 22 Jan 2001 16:09:31 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:26163 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S133035AbRAVVJX>; Mon, 22 Jan 2001 16:09:23 -0500
Message-Id: <4.3.2.7.2.20010122130852.00b92a80@mail.fluent-access.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 22 Jan 2001 13:09:07 -0800
To: linux-kernel@vger.kernel.org
From: Stephen Satchell <satch@fluent-access.com>
Subject: RE: [OT?] Coding Style
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:04 AM 1/22/01 -0500, you wrote:
>WRONG!!!
>
>Not documenting your code is not a sign of good coding, but rather shows
>arrogance, laziness and contempt for "those who would dare tamper with your
>code after you've written it".  Document and comment your code thoroughly.
>Do it as you go along.  I was also taught to comment nearly every line - as
>part of the coding style used by a large, international company I worked for
>several years ago.  It brings the logic of the programmer into focus and
>makes code maintenance a whole lot easier.  It also helps one to remember
>the logic of your own code when you revisit it a year or more hence.

Oh, those who refuse to study history are doomed to repeat it.

The COBOL language was created specifically to reduce the amount of 
commenting necessary in a program, because the English-like sentence 
structure could be read and understood by humans.  The FORTRAN language was 
created so that math types could "talk" in a language more familiar to 
them, letting the computer take care of the details about how to perform 
the specified task step-by-step.

One goal of language designers is to REMOVE the need for comments.  With a 
good fourth-generation or fifth-generation language, the need for comments 
diminishes to a detailed description of the data sets and any highly 
unusual operations or transforms on the data.

I've even gone so far as to "invent" my own languages, and the parsers to 
go with them, to reduce the need to comment by making the code easy for 
humans to read.  Not only are such systems easier to debug (with good 
language design) but are highly maintainable and usually not all that 
difficult to extend when necessary.

Remember, the line-by-line commenting requirement was mandatory in 
assembler programming, because the nature of assembler made you outline 
each step by tiring step.  When I worked for Rockwell, I was granted a 
partial wavier when I showed them my assembler-language commenting 
style:  pseudo-code at the top of each block of assembler code.  Blindly 
applying the rule to second-generation and later languages is just sloppy 
management, usually by people who don't understand coding.  (And yes, that 
includes some professors of computer science I have known.)

Comments do NOT make code maintenance easier.  Too many comments obscure 
what is really going on.  Linus' style actually increases the 
maintainability of the code, because if the code doesn't accurately show 
how it implements the goal specified in the block comment, the coder hasn't 
done his/her job.

Want to improve the maintainability of C code?  Consider the following:

1)  Keep functional parts small.  If the code won't fit in a hundred lines 
or so of code, then you haven't factored the problem well 
enough.  Functional parts != functions.  A program with thousands of 
well-encapsulated function parts strung together into a single function is 
easier to maintain than a "well-factored" program with its parts spread all 
over hell.  Diagnostic programmers have learned the hard way that factoring 
a program can make it difficult to ensure test coverage and even more 
difficult to determine if a part of the code is buggy or whether it found a 
hardware error that it was looking for.  This is why diagnostics tend to be 
rather long affairs with very few functions.

In my ANSI C code, you will see the following a lot:

#define DO /*syntactic sugar */

     DO {
        </* first functional part, with owned variables */
     }

     DO {
         </* next functional part, with its owned variables */
     }

and so forth.  The "DO" is visual syntactic sugar so that the sub-blocks 
have the same appearance as other blocks, such as if, while, and for.  An 
added bonus to this particular style element is that compilers can more 
easily detect problems if you forget to initialize the local variables, or 
define variables you end up not using.  This has saved me hours of tedious 
debugging of my own code.  From the maintenance standpoint, it means that 
the definition of local variables are near all usages of it, so you don't 
have to continuously page up or split-screen to see the definition (and 
initialization) of "foobar_at_will".

2)  Reduce visual complexity where possible.  Instead of using nested 
if-then-else statements, consider unrolling the nested 
statement.  Example:  {if (a && c)...; if (b && c)...; instead of {if (c) 
{if (a)...; if(b)...;}

This doesn't have to affect performance.  For example, you can have rules 
such as:

      ruleset = (a ? 1 : 0) | (b ? 2 : 0) | (c ? 4 : 0);
      if (ruleset == 5) {
      ...
      }
      if (ruleset == 6) {
      ...
      }

This particular method can eliminate multiple expensive tests, and can 
guarantee that a, b, and c are evaluated exactly once during a cycle.  This 
can improve performance.  Using AND, OR, and XOR can further increase the 
power of the technique without a performance hit.  (For understandability, 
I recommend strongly a considered use of symbolic bitmasks, however.)

3)  Make creative use of a run-on if statement to improve error detection 
and recording.  One of my tricks is to code the following statement in 
application programs:

      if(   (err = "input file can't be opened", in = fopen(filename, 
"rb"), in == NULL)
        ||  (err = "output file can't be opened", out = fopen(oname, "wb"), 
out = NULL)
        ...
          )
       {
       /* report the error that occurred, using the char * variable "err" 
to indicate the exact error. */
       }

This means that I don't have to explicitly remember to code error routines 
for each and every function call, but the error detection coverage is much, 
much improved.  I used this technique in an IEEE-488 driver to detect 
errors in every step of the way, and it took LESS time to do it this way 
than to unroll the if statement because of the inherent tracing that the 
technique implements.

4)  The functional part should be contained in a reasonable number of 
lines.  Large while and for loops should call functions instead of having 
bloated bodies.  Large case statements should call functions instead of 
running on and on and on.

5)  For those statements that take compound statements (if, else, while, 
for, do while) the statement should ALWAYS be a compound 
statement.  Nothing introduces bugs faster than a tired programmer not 
realizing that he/she is inserting a statement in the target of one of 
these statements and thereby replacing the target with a new one.  This one 
issue has broken more patches in my experience than any other single item.

The argument that "this introduces a blizzard of unnecessary braces" is 
overweighed by the guarantee that the programming coming down the pike 
later won't accidentally remove a target line because s/he is too tired or 
rushed to recognize that s/he has to ADD BRACES (and in the case of a 
severely nested statement where to add braces) in order to turn a 
single-line target into a two-line target.  (Of course, some of you never 
make mistakes like that.  Fine.)

6)  When you have an "empty" statement as the compound statement, indicate 
it unambiguously.  I have yet to find a see compiler that doesn't handle 
the following construct correctly:

      while (wait_for_condition())
         {}

(or, more in keeping with Linus' style without adding an extra line, "while 
(wait_for_condition()) {}" )

The "{}" signal (familiar to those of you who are adept with xargs) 
indicates that nothing is being done, and does it far more readily than a 
single semicolon can ever signal.  If I could make just one change to the C 
language, I would REQUIRE that a non-empty statement or possibly empty 
compound statement be the only valid targets for if, else, do while, for, 
and while statements.

7)  Name space pollution is always a problem, although in these days of 
computer with gigabytes of RAM it's less of a problem than it used to 
be.  I started programming C when my main computer had 256K of RAM and the 
symbol table space for linking was limited.  I got in the habit of using 
structures to minimize the number of symbols I exposed. It also 
disambiguates local variables and parameters from file- and program-global 
variables.  This name-space management ensures that you don't accidentally 
redefine in an inner block a variable that you think is a global.  In very 
large programs, it also avoids name collisions between portions of the project.

Style has little to do with art.  Style has to do with minimizing mistakes, 
both now and down the road.  If you don't like what I do, then don't do 
what I do.  Do what minimizes mistakes for you.

And, Linus, I'm not recommending you adopt any of these suggestions -- you 
have your way and I have mine.  If you like any of these, though, feel free 
to take them for your own.  File off the serial numbers, and enjoy.

Stephen Satchell

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
