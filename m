Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130230AbQKYX3C>; Sat, 25 Nov 2000 18:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131884AbQKYX2x>; Sat, 25 Nov 2000 18:28:53 -0500
Received: from red.csi.cam.ac.uk ([131.111.8.70]:26509 "EHLO red.csi.cam.ac.uk")
        by vger.kernel.org with ESMTP id <S130230AbQKYX2q>;
        Sat, 25 Nov 2000 18:28:46 -0500
From: James A Sutherland <jas88@cam.ac.uk>
To: Andries Brouwer <aeb@veritas.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] removal of "static foo = 0"
Date: Sat, 25 Nov 2000 22:53:00 +0000
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20001125211939.A6883@veritas.com> <200011252211.eAPMBIo21200@gondor.apana.org.au> <20001125234624.A7049@veritas.com>
In-Reply-To: <20001125234624.A7049@veritas.com>
MIME-Version: 1.0
Message-Id: <0011252259430A.11866@dax.joh.cam.ac.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2000, Andries Brouwer wrote:
> On Sun, Nov 26, 2000 at 09:11:18AM +1100, Herbert Xu wrote:
> 
> > No information is lost.
> 
> Do I explain things so badly? Let me try again.
> The difference between
> 
>   static int a;
> 
> and
> 
>   static int a = 0;
> 
> is the " = 0". The compiler may well generate the same code,

It does not. That's the whole point: the (functionally redundant) =0 wastes
another sizeof(int) bytes in the kernel image.

> but I am not talking about the compiler. I am talking about
> the programmer. This " = 0" means (to me, the programmer)
> that the correctness of my program depends on this initialization.

If you want to document your code like this, put it in a comment. That's what
they are there for. Or, if coding a function which explicitly relies on a
variable being 0, have that function set the variable to zero.

> Its absense means (to me) that it does not matter what initial
> value the variable has.

Which is silly. The variable is explicitly defined to be zero anyway, whether
you put this in your code or not.

> This is a useful distinction. It means that if the program
> 
>   static int a;
> 
>   int main() {
> 	  /* do something */
>   }
> 
> is used as part of a larger program, I can just rename main
> and get
> 
>   static int a;
> 
>   int do_something() {
> 	  ...
>   }
> 
> But if the program
> 
>   static int a = 0;
> 
>   int main() {
> 	  /* do something */
>   }
> 
> is used as part of a larger program, it has to become
> 
>   static int a;
> 
>   int do_something() {
> 	  a = 0;
> 	  ...
>   }

Just put:

static int a; /* must be set to zero in foobar() */

> You see that I, in my own code, follow a certain convention
> where presence or absence of assignments means something
> about the code.

Unfortunately, this handy documentation shortcut of yours bloats the kernel
unnecessarily.

> If now you change "static int a = 0;"
> into "static int a;" and justify that by saying that it
> generates the same code,

It does NOT generate the same code - that's the point. It generates smaller but
functionally equivalent code. The first version zeroes a TWICE, in effect; this
is completely unnecessary, and just bloats the kernel.

> then I am unhappy, because now
> if I turn main() into do_something() I either get a buggy
> program, or otherwise I have to read the source of main()
> again to see which variables need initialisation.

Oh no! You mean you might actually have to look at the code you're changing?!
This is hardly a valid reason for bloating the kernel! If you put the "this
variable must be zero when foo() is called" in a comment, rather than as a C
statement, it is equally clear to you - but avoids bloating the kernel.

> In a program source there is information for the compiler
> and information for the future me. Removing the " = 0"
> is like removing comments. For the compiler the information
> remains the same. For the programmer something is lost.

So put that comment in a real comment, rather than a redundant statement!


James.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
