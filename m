Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267560AbTBXVUO>; Mon, 24 Feb 2003 16:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267566AbTBXVUO>; Mon, 24 Feb 2003 16:20:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29571 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267560AbTBXVUM>; Mon, 24 Feb 2003 16:20:12 -0500
Date: Mon, 24 Feb 2003 16:33:35 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
In-Reply-To: <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.3.95.1030224162447.15114A-100000@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003, Linus Torvalds wrote:

> 
> On Mon, 24 Feb 2003, Richard B. Johnson wrote:
> > 
> > I think you must keep these warnings in! There are many bugs
> > that these uncover uncluding loops that don't terminate correctly
> > but seem to work for "most all" cases. These are the hard-to-find
> > bugs that hit you six months after release.
> 
> At least historically gcc has been so f*cking bad at the "unsigned vs 
> signed" warnings that they are totally useless.
> 
> Maybe things are better in gcc-3.3.
> 
> Maybe not.
> 
> 
> > size_t i;
> > 
> >    while((i = do_forever()) > 0)
> >           ;
> > 
> > ... do_forever() finally errors out and returns -1 stuck(forever).
> 
> Does gcc still warn about things like
> 
> 	#define COUNT (sizeof(array)/sizeof(element))
> 
> 	int i;
> 	for (i = 0; i < COUNT; i++)
> 		...
> 
> where COUNT is obviously unsigned (because sizeof is size_t and thus 
> unsigned)?
> 
> Gcc used to complain about things like that, which is a FUCKING DISASTER. 
> 
> Any compiler that complains about the above should be shot in the head, 
> and the warning should be killed.
> 
> 		Linus
>

Well yes. And it's correct. Variable `i' in the following code
should be a 'size_t'.
 
Script started on Mon Feb 24 16:23:19 2003
# cat xxx.c
#define ArraySize(a) (sizeof(a) / sizeof(a[0]))
int foo[12] = {0,};
int count()
{
    int i;
    for(i=0; i< ArraySize(foo); i++)
        ;
    return i;
}

# gcc -Wall -Wsign-compare -c -o xxx.o xxx.c
xxx.c: In function `count':
xxx.c:11: warning: comparison between signed and unsigned
# exit
exit
Script done on Mon Feb 24 16:23:50 2003

... and we all know that it's dumb to do:
    for(i=0; i< (int) ArraySize(foo); i++)
... just to placate a compiler. But the compiler did find what
could-have-been a real problem so the compiler is, indeed, correct.

Maybe what is needed is -Wsign-compare and -Wsign-strict, where
-Wsign-compare warns of obvious errors that could cause continuous
loops, etc., and -Wsign-strict acts like the current -Wsign-compare.
I agree that the current -Wsign-compare is way too strict for the
usual coding style where most int compares are "don't care" things
that are not worth casts.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


