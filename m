Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261442AbULBIdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbULBIdw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 03:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbULBIdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 03:33:52 -0500
Received: from smtp08.auna.com ([62.81.186.18]:30642 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S261442AbULBIds convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 03:33:48 -0500
Date: Thu, 02 Dec 2004 08:33:44 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: What if?
To: linux-kernel@vger.kernel.org
References: <41AE5BF8.3040100@gmail.com> <20041202044034.GA8602@thunk.org>
In-Reply-To: <20041202044034.GA8602@thunk.org> (from tytso@mit.edu on Thu
	Dec  2 05:40:34 2004)
X-Mailer: Balsa 2.2.6
Message-Id: <1101976424l.5095l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.12.02, Theodore Ts'o wrote:
> On Thu, Dec 02, 2004 at 05:34:08AM +0530, Imanpreet Singh Arora wrote:
> > 
> >    I realize most of the unhappiness lies with C++ compilers being 
> > slow. Also the fact that a lot of Hackers around here are a lot more 
> > familiar with C, rather than C++. However other than that what are the  
> > _implementation_  issues that you hackers might need to consider if it 
> > were to be implemented in C++. 
> 
> The suckitude of C++ compilers is only part of the issues.
> 
> > My question is regarding how will kernel 
> > deal with C++ doing too much behind the back, Calling constructors, 
> > templates exceptions and other. What are the possible issues of such an 
> > approach while writing device drivers?  What sort of modifications do 
> > you reckon might be needed if such a move were to be made?
> 
> The way the kernel will deal with C++ language being a complete
> disaster (where something as simple as "a = b + c + d +e" could
> involve a dozen or more memory allocations, implicit type conversions,
> and overloaded operators) is to not use it.  Think about the words of
> wisdom from the movie Wargames: "The only way to win is not to play
> the game".
> 

Don't ge silly. I have written C++ code to deal with SSE operations
on vectors, and there you really need to control the assembler produced,
and with the correct const and & on correct places the code is as
efficient as C. Or more. You can control everything. No more temporal
objects, no more copies, but still the type checking. I can send you,
for example, the code for a Vector class (no __asm in it),
and the assembler that g++ spits for a thing like a = b+c.
You would do not better in handcoded asm.

It is as all things, you need to know it deeply to use it well.
There are a ton of myths around C++.

For the kernel, you don't need exceptions nor iostreams, so don't use
the C++ runtime library.

Constructor/destuctor is needed, and also virtual single inheritance.
And those two things are already being done by hand with function
pointers inside structs in the kernel. The cost of (single and multiple)
inheritance in C++ is also just an indexed jump, the difference is that
in the pseudo object oriented things done in the kernel you have to
always initializa the funtions pointers, and C++ will do it for you.
How many bugs have you seen because somebody wrote a bad
.method = the wrong_func in an initializer ?

The kernel is full of things like
if (__builtin_constant_pointer(xxxx) and others to check if an argument
is constant and optimize some path, and in C++ you could write
class T {
	T& f();
	const T& f() const;
}
and the compiler will do it at compile time also.

In short, with C++ you can generate code as efficient as C or asm.
You just have to know how.

But C++ is not supported in the kernel. I can live with it.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.10-rc2-jam4 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #2


