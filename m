Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291970AbSB0VJn>; Wed, 27 Feb 2002 16:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292959AbSB0VJe>; Wed, 27 Feb 2002 16:09:34 -0500
Received: from unthought.net ([212.97.129.24]:2772 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S292848AbSB0VIO>;
	Wed, 27 Feb 2002 16:08:14 -0500
Date: Wed, 27 Feb 2002 22:08:12 +0100
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Artiom Morozov <artiom@phreaker.net>
Cc: linux-kernel@vger.kernel.org, Kiretchko Serguei <spk@csp.org.by>
Subject: Re: select() call corrupts stack
Message-ID: <20020227220812.F5725@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Artiom Morozov <artiom@phreaker.net>, linux-kernel@vger.kernel.org,
	Kiretchko Serguei <spk@csp.org.by>
In-Reply-To: <20020227214056.A6740@cyan.csp.org.by>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20020227214056.A6740@cyan.csp.org.by>; from artiom@phreaker.net on Wed, Feb 27, 2002 at 09:40:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 09:40:56PM +0200, Artiom Morozov wrote:
> Hello,
> 
> 	Here's a sample program. Try running it and open about 2k of 
> connections to port 5222 (you'll need ulimit -n 10000 or like that). It 
> will segfault. Simple asm like this
>    __asm__(
> 	"pushl %eax \n\t" 	"movl  0(%ebp), %eax \n\t"
> 	"cmp   $65535, %eax \n\t"
> 	"ja isok \n\t"
> 	"xor  %eax, %eax \n\t"
> 	"movl  %eax, 0(%eax) \n\t"	 
> 	"isok: \n\t"
> 	"popl  %eax \n\t"
>    );
> after each subroutine call will show you that after select() [ebp] have 
> weird value. While this is unlikely to be a security flaw, i think this 
> is a bug.
> 
> ps: it's okay for 1k of connections or so
> pps: kernel 2.4.17 on i686, gcc 3.0.3, glibc 2.2.3.

It's most likely not a kernel bug.  *Probably* not a glibc bug either.  Please
understand that *many* applications rely on select() working properly - finding
bugs in these basic system calls is rare (but not unheard of).

I'm going to send a long rant here - I really don't want to insult you, but I
cannot explain what I mean without giving some harsh comments. If you can't
handle that - stop reading now  :)

<rant>

First of all;  your code is ugly.  Sorry, but it is.  You cannot expect dirty
code to work,  and you *especially* cannot expect dirty *threaded* code to
work.

If you want to use C++, you should use it properly.  Like, not using void*
where real types would do.  And not using NULL. And not typecasting anonymous
structs. And not making deques of pointers. And, and, and...    If you cannot
do that,  then you should refrain from using C++, as you will avoid some
expensive mistakes by using a simpler and more primitive language, such as C.

Poor C++ is *a*lot* worse than poor C.  (The door swings both ways though)

May I recommend:  "The C++ Programming Language, 3rd edition", by a fellow
dane, Bjarne Stroustrup - and of course his other most excellent book "The
Design and Evolution of C++".   Read those two, and you will never write code
like the stuff you posted here again   :)

Furthermore, you abuse threads massively. You should read up on non-blocking
communication:  either just the man-pages, or using books like "UNIX Systems
Programming, for SVR5" or others..  

As someone (Alan I think) said:
  Threads are for people who cannot
  program state machines.

I would add:  "or people who need concurrent *computations* on multiple CPUs",
but that's obviously not what your application is trying to do.

</rant>

So my advice:
 *)  Start using C++, or stop using it.  There is no good compromise.
 *)  Read about non-blocking communication.
 *)  Run ElectricFence on code that has memory corruption

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
