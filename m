Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271888AbRH1TdS>; Tue, 28 Aug 2001 15:33:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271890AbRH1TdI>; Tue, 28 Aug 2001 15:33:08 -0400
Received: from web10901.mail.yahoo.com ([216.136.131.37]:18451 "HELO
	web10901.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271888AbRH1TdA>; Tue, 28 Aug 2001 15:33:00 -0400
Message-ID: <20010828193317.96277.qmail@web10901.mail.yahoo.com>
Date: Tue, 28 Aug 2001 12:33:17 -0700 (PDT)
From: Brad Chapman <kakadu_croc@yahoo.com>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
To: linux-kernel@vger.kernel.org
In-Reply-To: <200108281746.f7SHk1O27199@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Everyone,

	From reading this thread, I believe I have come up with several reasons,
IMHO, why the old min()/max() macros were not usable:

	- They did not take into account non-typesafe comparisons
	- They were too generic
	- Some versions, IIRC, relied on typeof()
	- They did not take into account signed/unsigned conversions

	I have also discovered one problem with the new three-arg min()/max()
macro: it forces both arguments to be the same, thus preventing signed/unsigned
comparisons.

	Thus, I have a humble idea: add another type argument!

	Below is a coding example (just an example!):

	#define min(ta, a, tb, b)	((ta)(a) < (tb)(b) ? (a) : (b))
	#define max(ta, a, tb, b)	((ta)(a) > (tb)(b) ? (a) : (b))

	.....
	long int number[] = { 878593, 786831 };
	short int num[] = { 878, 786 };

	.....
	long_min = min(long int, num[0], long int, number[0]);
	short_min = min(short int, num[0], short int, number[0]);

	long_max = max(long int, num[1], long int, number[1]);
	short_max = max(short int, num[1], short int, number[1]);

	Thus, people can now cast different number types up or down, depending
on what they need, and properly compare their sizes. The new argument also makes
comparisons between signed/unsigned more flexible, because now you can cast
in both directions - get a signed minimum and an unsigned minimum.

	This is an RFC. Flames, anyone? Honestly, this was one of those
"lightbulb" ideas. If people object, I don't mind......

Brad

P.S: /me also wonders if I will need firehoses in my e-mail client ;)
	
> On 28 Aug 2001, Andreas Schwab wrote:
> 
> > Roman Zippel <zippel@linux-m68k.org> writes:
> > 
> > |> Hi,
> > |> 
> > |> Linus Torvalds wrote:
> > [...]
> > |> > You just fixed the "re-use arguments" bug - which is a bug, but doesn't
> > |> > address the fact that most of the min/max bugs are due to the programmer
> > |> > _indending_ a unsigned compare because he didn't even think about the
> > |> > type.
> 
> 
> #if 0
> If the comparison was made unsigned, cast to the largest natural
> value on the target, while keeping the types and sizes of the
> input variables the same, this macro does about what 99.9999999 percent
> of what everybody wants:
> #endif
> 
> #include <stdio.h>
> 
> #define min(a,b) ((size_t)(a) < (size_t)(b) ? (a) : (b))
> 
> int main()
> {
>     printf("%d\n", min(1,2));
>     printf("%d\n", min(-1,2));
>     printf("%d\n", min(0xffffffff,3));
>     printf("%d\n", min(0x8000,4));
>     printf("%d\n", min(0x7fff,5));
>     printf("%d\n", min(0x80000000,6));
>     printf("%d\n", min(0x7fffffff,7));
> 
>     printf("%ld\n", min(1L,2L));
>     printf("%ld\n", min(-1L,2L));
>     printf("%ld\n", min(0xffffffff,3L));
>     printf("%ld\n", min(0x8000,4L));
>     printf("%ld\n", min(0x7fff,5L));
>     printf("%ld\n", min(0x80000000,6L));
>     printf("%ld\n", min(0x7fffffff,7L));
> 
>     printf("%lu\n", min(1L,2LU));
>     printf("%lu\n", min(-1L,2LU));
>     printf("%lu\n", min(0xffffffff,3LU));
>     printf("%lu\n", min(0x8000,4LU));
>     printf("%lu\n", min(0x7fff,5LU));
>     printf("%lu\n", min(0x80000000,6LU));
>     printf("%lu\n", min(0x7fffffff,7LU));
> 
>     printf("%d\n", min(-1, -2));
>     printf("%d\n", min(-1, 0));
>     printf("%p\n", min((void *)0x80000000, (void *)0x7fffffff));
>     return 0;
> }
> 
> 
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).
> 
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


=====
Brad Chapman

Permanent e-mail: kakadu_croc@yahoo.com
Current e-mail: kakadu@adelphia.net
Alternate e-mail: kakadu@netscape.net

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
