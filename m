Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314221AbSDRCWL>; Wed, 17 Apr 2002 22:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314222AbSDRCWK>; Wed, 17 Apr 2002 22:22:10 -0400
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:43278
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S314221AbSDRCWI>; Wed, 17 Apr 2002 22:22:08 -0400
Message-Id: <5.1.0.14.2.20020417214559.00a7edf8@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 17 Apr 2002 22:16:36 -0400
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Adam Kropelin <akropel1@rochester.rr.com>
From: Stevie O <stevie@qrpff.net>
Subject: Re: 2.5.8-dj1 : arch/i386/kernel/smpboot.c error
Cc: Rick Stevens <rstevens@vitalstream.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1873390000.1019090061@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:34 PM 4/17/2002 -0700, Martin J. Bligh wrote:

>Personally, I think that's a really sick and twisted way for a compiler
>to work ... what the hell is the point of compiling something you know
>perfectly well you're going to dispose of 2 nanoseconds later?
>
>M.

<RANT>

Granted, I could make a rather similar argument for the reverse: What the hell is the point of giving something to the compiler if we know perfectly well that it would be optimized out anyway?

(Especially if the alternative, leaving it up to the compiler, generates totally insane code like '0 = f();')

When I downloaded and put together 2.5.7, I couldn't even build the kernel because I didn't compile NFS support in ("undefined ref to sys_nfsservctl"); I dread to think of the number of errors I'd see if the compiler's optimizer dropped out blatantly erroneous code because it happened to be surrounded by 'if (0 && other_func())' and optimized out on certain builds.

Because if:
        (void*) 0 = (void*) 0;

isn't blatantly erroneous (even if not evident at first hand), I don't know what is.

And if the fact that it decomposed into "0 = 0;" wasn't blatantly obvious, all the more reason for my next point:

----

Yes, I agree that as code becomes #ifdef-laden, it becomes hard to read -- at an exponential rate,
especially if it's poorly done:

#ifdef OPTION_X
        x 
#else
#ifdef OPTION_Y
        y
#else
        z
#endif
#endif
                =
#ifdef OPTION_X
        x_func(x,
#else
        yz_func(
#ifdef OPTION_Y
                y
#else
                z
#endif
                 ,
#endif
                  32);

Yes, I've seen beautiful code mauled by nested #if's and #ifdef's and such.

However... Which of the following is more obviously code geared towards a specific config option?

#ifdef CONFIG_OBSCURE
  if (obscure_variable == 0) {
        obscure_variable = init_obscure_variable_function();
  }
#endif

-or-

  if (obscure_variable == 0) {
        obscure_variable = init_obscure_variable_function();
  }


If I didn't know that 'obscure_variable' was #defined to 0 in 'obscure_header.h':

#ifdef CONFIG_OBSCURE
extern void* obscure_variable;
#else
#define obscure_variable ((void*)0)
#endif

I might wonder why my system never links in 'init_obscure_variable_function' despite the reference.

The preprocessor is a tool.  It's designed to help us.  Just because it's misused often doesn't mean we need to reject it in every situation.  (Just like guns, the preprocessor will let you shoot yourself in the foot! :P)


Okay, I'm out of breath for now.
</RANT>


--
Stevie-O

Real programmers write code like this:

const char *FlashPROMFunc;

...
 (((void)(*)(void*,void*,int,int))(FlashPROMFunc))(dst, src, count, 1);

[yes, I wrote that line of code once. yes, it was for production use. yes, it worked.]

