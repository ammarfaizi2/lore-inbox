Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271587AbRIGH0w>; Fri, 7 Sep 2001 03:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271577AbRIGH0m>; Fri, 7 Sep 2001 03:26:42 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:12812 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S271568AbRIGH0g>;
	Fri, 7 Sep 2001 03:26:36 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200109070726.f877QeQ27567@oboe.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <m2y9nrn7p0.fsf@sympatico.ca> from "Bill Pringlemeir" at "Sep 6,
 2001 08:52:27 pm"
To: "Bill Pringlemeir" <bpringle@sympatico.ca>
Date: Fri, 7 Sep 2001 09:26:40 +0200 (MET DST)
Cc: ptb@it.uc3m.es, "Patrick J. LoPresti" <patl@cag.lcs.mit.edu>,
        linux-kernel@vger.kernel.org
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Bill Pringlemeir wrote:"
>   > // possible implemetation with type sanity checks - alter to taste
>   > #define MIN(x,y) ({\
>   >    const typeof(x) _x = ~(typeof(x))0; \
>   >    const typeof(y) _y = ~(typeof(y))0; \
>   >    void MIN_BUG(); \
>   >    if (sizeof(_x) != sizeof(_y)) \
>   >      MIN_BUG(); \
>   >    if ((_x > 0 && _y < 0) || (_x < 0 && _y > 0)) \
>   >      MIN_BUG(); \
>   >    __MIN(x,y); \
>   >  })
> 
> min/max.  I just went through 1800 LKML emails and I am not quite
> clear what happened.  I have put my code that I posted earlier at the

The final version evoked a compile-time error instead of BUG(), and
also was more careful about the kind of zero it compares with! Linus
okayed it in principle and "real life" tests showed that it works
and catches what it's supposed to catch. For me it turned up one
kernel report (in tun.c) and three more in the xfs patches. The
trial covered about a quarter of the kernel.

Some people spotted that the error case can probably be reduced to
large signed versus small unsigned, both of size at least int.

> end of this email.  This was the result of someone's `fanciful comment'
> `what if gcc could handle "if(strcmp(typeof(a),typeof(b))!=0)"'.
> 
> So here is the important part.  The code Peter has introduced a cast
> in the lines "const typeof(x) _x = ~(typeof(x))0;" etc.  I think that
> the approach of declaring a variable of the type and initializing to
> zero and then comparing "x - 1" _might_ be better.

I don't know. I intended only to turn the sign bit on. I'm not sure how
1's complement arithmetic works, so I don't know if it works for 1's
complement arithmetic.

> The version of min() at the end calls the following an error, were
> Peter's does not [after removing the sizeof() restriction].
> 
>  unsigned char Cx = 1; unsigned int Ix = 1; unsigned long  Lx = 1;
>  Ix = min(Cx,Ix); Lx = min(Cx,Lx); 
> 
> Here the unsigned char is being promoted to int as discussed before.
> I think that this is `more faithful' as what we are try to achieve is

When someone states what the problem is exactly, and what portion
of it they want to test for, then the test can be modified to suit.
I intended to show that the test can be performed and a two
arg min thereby retained.

> to check the sign that will be used in the min comparison; almost
> like applying a proper warned signed selectively to the min/max
> macros.
> 
> Otherwise, I think we have independently came up with the same thing
> and the `error' throwing can of course be changed to whatever.

Probably!

Peter
