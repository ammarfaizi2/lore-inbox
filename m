Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315540AbSFJRV0>; Mon, 10 Jun 2002 13:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315544AbSFJRV0>; Mon, 10 Jun 2002 13:21:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56849 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315540AbSFJRVZ>; Mon, 10 Jun 2002 13:21:25 -0400
Date: Mon, 10 Jun 2002 10:21:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
cc: Andreas Dilger <adilger@clusterfs.com>, Dan Aloni <da-x@gmx.net>,
        Lightweight patch manager <patch@luckynet.dynu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 - list.h cleanup
In-Reply-To: <Pine.GSO.4.05.10206101904480.17299-100000@mausmaki.cosy.sbg.ac.at>
Message-ID: <Pine.LNX.4.44.0206101011440.30535-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Jun 2002, Thomas 'Dent' Mirlacher wrote:
>
> On Mon, 10 Jun 2002, Linus Torvalds wrote:
>
> --snip/snip
> > But in the end, maintainership matters. I personally don't want the
> > typedef culture to get the upper hand, but I don't mind a few of them, and
> > people who maintain their own code usually get the last word.
>
> to sum it up:
>
> using the "struct mystruct" is _recommended_, but not a must.

Well, it's more than just "struct xx". It's really typedefs in general.

For example, some people like to do things like

	typedef unsigned int counter_t;

and then use "counter_t" all over the place. I think that's not just ugly,
but stupid and counter-productive. It makes it much harder to do things
like "printk()" portably, for example ("should I use %u, %l or just %d?"),
and generally adds no value. It only _hides_ information, like whether the
type is signed or not.

There is nothing wrong with just using something like "unsigned long"
directly, even if it is a few characters longer than you might like. And
if you care about the number of bits, use "u32" or something. Don't make
up useless types that have no added advantage.

We actually have real _problems_ due to this in the kernel, where people
use "off_t", and it's not easily printk'able across different
architectures (we used to have this same problem with size_t). We should
have just used "unsigned long" inside the kernel, and be done with it (and
"unsigned long long" for loff_t).

We should also have some format for printing out "u32/u64" etc, but that's
another issue and has the problem that gcc won't understand them, so
adding new formats is _hard_ from a maintenance standpoint.

			Linus

PS. And never _ever_ make the "pointerness" part of the type. People who
write

	typedef struct urb_struct * urbp_t;

(or whatever the name was) should just be shot. I was _soo_ happy to see
that crap get excised from the kernel USB drivers.

