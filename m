Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264530AbTLVVcF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 16:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264537AbTLVVcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 16:32:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:33770 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264530AbTLVVby (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 16:31:54 -0500
Date: Mon, 22 Dec 2003 13:31:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Dee <antitux@antitux.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: hmm..
In-Reply-To: <3FE74FD3.8040807@antitux.net>
Message-ID: <Pine.LNX.4.58.0312221316090.6868@home.osdl.org>
References: <3FE74FD3.8040807@antitux.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Dec 2003, John Dee wrote:
>
> I know you guys have already probably seen this.. figured I'd share with 
> the class, so the big kids can tear it apart.
> http://lwn.net/Articles/64052/

I spent half an hour tearing part of it apart for some journalists. No
guarantees for the full accuracy of this write-up, and in particular I
don't actually have "original UNIX" code to compare against, but the files
I checked (ctype.[ch]) definitely do not have any UNIX history to them.

The rest of the files are mostly errno.h/signal.h/ioctl.h (and they are 
apparently the 2.4.x versions, before we moved some common constants into 
"asm-generic/errno.h"), and while I haven't analyzed them, I know for a 
fact that

 - the original errno.h used different error numbers than "original UNIX"

   I know this because I cursed it later when it meant that doing things 
   like binary emulation wasn't as trivial - you had to translate the 
   error numbers.

 - same goes for "signal.h": while a lot of the standard signals are well 
   documented (ie "SIGKILL is 9"), historically we had lots of confusion 
   (ie I think "real UNIX" has SIGBUS at 10, while Linux didn't originally 
   have any SIGBUS at all, and later put it at 7 which was originally 
   SIGUNUSED.

So to me it looks like 

 - yes, Linux obviously has the same signal names and error number names 
   that UNIX has (so the files certainly have a lot of the same 
   identifiers)

 - but equally clearly they weren't copied from any "real UNIX". 

(Later, non-x86 architectures have tried harder to be binary-compatible 
with their "real UNIX" counter-parts, and as a result we have different 
errno header files for different architectures - and on non-x86 
architectures the numbers will usually match traditional UNIX).

For example, doing a "grep" for SIGBUS on the kernel shows that most
architectures still have SIGBUS at 7 (original Linux value), while alpha,
sparc, parisc and mips have it at 10 (to match "real UNIX").

What this tells me is that the original code never came from UNIX, but
some architectures later were made to use the same values as UNIX for
binary compatibility (I know this is true for alpha, for example: being
compatible with OSF/1 was one of my very early goals in that port).

In other words, I think we can totally _demolish_ the SCO claim that these 
65 files were somehow "copied". They clearly are not.

Which should come as no surprise to people. But I think it's nice to see 
just _how_ clearly we can show that SCO is - yet again - totally 
incorrect.

		Linus

----

For example, SCO lists the files "include/linux/ctype.h" and
"lib/ctype.h", and some trivial digging shows that those files are
actually there in the original 0.01 distribution of Linux (ie September of
1991). And I can state 

 - I wrote them (and looking at the original ones, I'm a bit ashamed: 
   the "toupper()" and "tolower()" macros are so horribly ugly that I 
   wouldn't admit to writing them if it wasn't because somebody else 
   claimed to have done so ;)

 - writing them is no more than five minutes of work (you can verify that 
   with any C programmer, so you don't have to take my word for it)

 - the details in them aren't even the same as in the BSD/UNIX files (the 
   approach is the same, but if you look at actual implementation details 
   you will notice that it's not just that my original "tolower/toupper"  
   were embarrassingly ugly, a number of other details differ too).

In short: for the files where I personally checked the history, I can
definitely say that those files are trivially written by me personally,
with no copying from any UNIX code _ever_.

So it's definitely not a question of "all derivative branches". It's a
question of the fact that I can show (and SCO should have been able to
see) that the list they show clearly shows original work, not "copied".


	Analysis of "lib/ctype.c" and "include/linux/ctype.h".


First, some background: the "ctype" name comes "character type", and the
whole point of "ctype.h" and "ctype.c" is to test what kind of character
we're dealing with. In other words, those files implement tests for doing
things like asking "is this character a digit" or "is this character an
uppercase letter" etc. So you can write thing like

	if (isdigit(c)) {
		.. we do something with the digit ..

and the ctype files implement that logic.

Those files exist (in very similar form) in the original Linux-0.01 
release under the names "lib/ctype.c" and "include/ctype.h". That kernel 
was released in September of 1991, and contains no code except for mine 
(and Lars Wirzenius, who co-wrote "kernel/vsprintf.c").

In fact, you can look at the files today and 12 years ago, and you can see 
clearly that they are largely the same: the modern files have been cleaned 
up and fix a number of really ugly things (tolower/toupper works 
properly), but they are clearly incremental improvement on the original 
one.

And the original one does NOT look like the unix source one. It has 
several similarities, but they are clearly due to:

 - the "ctype" interfaces are defined by the C standard library.

 - the C standard also specifies what kinds of names a system library 
   interface can use internally. In particular, the C standard specifies 
   that names that start with an underscore and a capital letter are 
   "internal" to the library. This is important, because it explains why
   both the Linux implementation _and_ the UNIX implementation used a
   particular naming scheme for the flags.

 - algorithmically, there aren't that many ways to test whether a 
   character is a number or not. That's _especially_ true in
   C, where a macro must not use it's argument more than once. So for 
   example, the "obvious" implementation of "isdigit()" (which tests for 
   whether a character is a digit or not) would be

	#define isdigit(x) ((x) >= '0' && (x) <= '9')

   but this is not actually allowed by the C standard (because 'x' is used 
   twice).

   This explains why both Linux and traditional UNIX use the "other" 
   obvious implementation: having an array that describes what each of the 
   possible 256 characters are, and testing the contents of that array
   (indexed by the character) instead. That way the macro argument is only 
   used once.

The above things basically explain the similarities. There simply aren't
that many ways to do a standard C "ctype" implementation, in other words.

Now, let's look at the _differences_ in Linux and traditional UNIX:

 - both Linux and traditional unix use a naming scheme of "underscore and 
   a capital letter" for the flag names. There are flags for "is upper 
   case" (_U) and "is lower case" (_L), and surprise surprise, both UNIX 
   and Linux use the same name. But think about it - if you wanted to use 
   a short flag name, and you were limited by the C standard naming, what 
   names _would_ you use? Maybe you'd select "U" for "Upper case" and "L" 
   for "Lower case"?

   Looking at the other flags, Linux uses "_D" for "Digit", while
   traditional UNIX instead uses "_N" for "Number". Both make sense, but 
   they are different. I personally think that the Linux naming makes more 
   sense (the function that tests for a digit is called "isdigit()", not
   "isnumber()"), but on the other hand I can certainly understand why 
   UNIX uses "_N" - the function that checs for whether a character is 
   "alphanumeric" is called "isalnum()", and that checks whether the 
   character is a upper case letter, a lower-case letter _or_ a digit (aka 
   "number").

   In short: there aren't that many ways you can choose the names, and 
   there is lots of overlap, but it's clearly not 100%.

 - The original Linux ctype.h/ctype.c file has obvious deficiencies, which 
   pretty much point to somebody new to C making mistakes (me) rather than 
   any old and respected source. For example, the "toupper()/tolower()"  
   macros are just totally broken, and nobody would write the "isascii()" 
   and "toascii()" the way they were written in that original Linux. And
   you can see that they got fixed later on in Linux development, even 
   though you can also see that the files otherwise didn't change.

   For example: remember how C macros must only use their argument once 
   (never mind why - you really don't care, so just take it on faith, for
   now). So let's say that you wanted to change an upper case character 
   into a lower case one, which is what "tolower()" does. Normal use is 
   just a fairly obvious

	newchar = tolower(oldchar);

   and the original Linux code does

	extern char _ctmp;
	#define tolower(c) (_ctmp=c,isupper(_ctmp)?_ctmp+('a'+'A'):_ctmp)

   which is not very pretty, but notice how we have a "temporary 
   character" _ctmp (remember that internal header names should start with
   an underscore and an upper case character - this is already slightly 
   broken in itself). That's there so that we can use the argument "c" 
   only once - to assign it to the new temporary - and then later on we 
   use that temporary several times.

   Now, the reason this is broken is 

    - it's not thread-safe (if two different threads try to do this at 
      once, they will stomp on each others temporary variable)

    - the argument (c) might be a complex expression, and as such it
      should really be parenthesized. The above gets several valid 
      (but unusual) expressions wrong.

Basically, the above is _exactly_ the kinds of mistakes a young programmer 
would make. It's classic.

And I bet it's _not_ what the UNIX code looked like, even in 1991. UNIX by
then was 20 years old, and I _think_ that it uses a simple table lookup
(which makes a lot more sense anyway and solves all problems). I'd be very
susprised if it had those kinds of "beginner mistakes" in it, but I don't 
actually have access to the code, so what do I know? (I can look up some 
BSD code on the web, it definitely does _not_ do anythign like the above).

The lack of proper parenthesis exists in other places of the original 
Linux ctype.h file too: isascii() and toascii() are similarly broken.

In other words: there are _lots_ of indications that the code was not 
copied, but was written from scratch. Bugs and all.

Oh, another detail: try searching the web (google is your friend) for 
"_ctmp". It's unique enough that you'll notice that all the returned hits 
are all Linux-related. No UNIX hits anywhere. Doing a google for

	_ctmp -linux

shows more Linux pages (that just don't happen to have "linux" in them),
except for one which is the L4 microkernel, and that one shows that they
used the Linux header file (it still says "_LINUX_CTYPE_H" in it).

So there is definitely a lot of proof that my ctype.h is original work.

