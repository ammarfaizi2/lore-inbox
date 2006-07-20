Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWGTRWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWGTRWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 13:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbWGTRWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 13:22:35 -0400
Received: from [212.70.39.252] ([212.70.39.252]:14340 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750785AbWGTRWe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 13:22:34 -0400
From: Al Boldi <a1426z@gawab.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] x86: Don't randomize stack unless current->personality permits it
Date: Thu, 20 Jul 2006 20:23:13 +0300
User-Agent: KMail/1.5
Cc: Paulo Marques <pmarques@grupopie.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Frank van Maarseveen <frankvm@frankvm.com>
References: <200607191305_MC3-1-C56F-6E4F@compuserve.com>
In-Reply-To: <200607191305_MC3-1-C56F-6E4F@compuserve.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200607202023.13901.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <200607180821.45346.a1426z@gawab.com>
>
> On Tue, 18 Jul 2006 08:21:45 +0300. Al Boldi wrote:
> > Going one step further,
> > with #define arch_stack_align(x) (x)
> > all blips/hits/weirdness are gone
> >
> > Which means that either arch_stack_align isn't necessary at all, or
> > randomization isn't working as intended.
> >
> > Can somebody prove me wrong here?
>
> Your program seems highly sensitive to any changes,

Extremely sensitive.  You may have noticed the strange repetitions in main 
instead of a for loop.  It's like that for a reason:  compile semantics.

> e.g. with the
> following code, results with and without the commented lines are
> different.  (I changed i to 5555555 because my cpu is slower than
> yours and changed main() to call it 10 times.)  This on an AMD
> Turion64 1.6GHz running an i386 kernel with stock arch_stack_align()
> and randomize_va_space == 1.
>
> void fn()
> {
>         double x = 0.0, y = 0.0;
>         long i = 5555555;
> //      static int printed = 0;
> //
> //      if (!printed) {
> //              printed++;
> //              printf("&x = %p, &y = %p\n", &x, &y);
> //      }
>
>         elapsed(1);
>         while (i--)
>                 fn2(&x,&y);
>         printf("%4lu ", elapsed(0));
> }
>
> $ ./tst.ex
> &x = 0xbfb32d90, &y = 0xbfb32d98
>   10    6   10   10    6   10    7   10   10   10   10   10   10   10   10
>   10   10   10   10   10 msec $ ./tst.ex
>    7   10    6    6    6    6   10   10    6    6    6   10   10    6    6
>    6    6   10    6    6 msec

So what happens when this is renamed/ sh -c'd/ randomize off'd/ while'd/ 
compiled w/ -Os?  Keep in mind, we want to surface a kernel problem, not a 
compiler problem, even though the compiler may have a problem.

Do you get the same kind of weirdness?

Mind you, only i686+ show this problem, i3/4/586 seem ok.  Don't know about AMD.

> BTW when compiled with gcc 4.1.1 using -O3 it just prints all zeros,
> so I had to use 3.3.3.

With your changes on:

stock kernel, gcc.322 -O3 doesn't show a slowdown.

stock kernel, randomize_va_space=0, gcc.322 -Os tstExec.c, while :; do ./a.out; done
&x = 0xbffff874, &y = 0xbffff86c   28   28   28   27   27   27   27   30   28   27 msec
&x = 0xbffff874, &y = 0xbffff86c   27   27   27   27   27   29   27   27   27   28 msec
&x = 0xbffff874, &y = 0xbffff86c   27   27   27   27   29   27   28   28   27   27 msec
&x = 0xbffff874, &y = 0xbffff86c   28   27   27   29   27   27   27   28   27   27 msec
&x = 0xbffff874, &y = 0xbffff86c   27   30   27   28   27   27   27   27   27   27 msec
&x = 0xbffff874, &y = 0xbffff86c   27   29   27   27   28   27   27   27   29   27 msec

stock kernel, randomize_va_space=1, gcc.322 -Os tstExec.c, while :; do ./a.out; done
&x = 0xbfe2e614, &y = 0xbfe2e60c   29   28   27   29   27   27   27   28   27   28 msec
&x = 0xbfd6a104, &y = 0xbfd6a0fc   55   56   56   55   57   59   55   56   55   55 msec
&x = 0xbf91d454, &y = 0xbf91d44c   27   27   27   28   27   28   27   29   27   27 msec
&x = 0xbf941e84, &y = 0xbf941e7c   55   56   56   56   56   56   57   59   55   55 msec
&x = 0xbfa75834, &y = 0xbfa7582c   28   27   27   27   27   27   27   27   27   27 msec
&x = 0xbfb58634, &y = 0xbfb5862c   27   30   27   28   27   27   27   27   28   27 msec

stock kernel, randomize_va_space=0, gcc.322 -Os tstExec.c, while :; do ./a.out; done
  28   28   28   29   27   27   27   28   27   27 msec
  27   27   27   27   29   28   27   27   27   27 msec
  27   29   28   29   27   28   28   27   27   27 msec
  27   31   27   28   27   27   27   27   27   29 msec
  28   27   28   27   27   27   27   27   29   27 msec
  27   28   29   29   29   27   29   27   27   27 msec

stock kernel, randomize_va_space=1, gcc.322 -Os tstExec.c, while :; do ./a.out; done
  55   54   54   55   55   56   56   56   58   54 msec
  55   55   56   56   56   56   57   56   55   55 msec
  27   27   28   27   27   27   28   27   28   27 msec
  30   28   27   27   27   28   27   27   27   28 msec
  27   27   27   28   27   27   28   30   28   27 msec
  55   55   55   56   55   56   55   58   57   55 msec
  55   55   56   55   56   58   56   55   55   55 msec

Can you confirm these numbers?

Thanks for your input!

--
Al

