Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316573AbSIJBn5>; Mon, 9 Sep 2002 21:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318955AbSIJBn4>; Mon, 9 Sep 2002 21:43:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22536 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316573AbSIJBnz>; Mon, 9 Sep 2002 21:43:55 -0400
Date: Mon, 9 Sep 2002 18:48:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Greg KH <greg@kroah.com>, <linux-usb-devel@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <Pine.LNX.4.44.0209091832160.1714-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209091842400.1714-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Sep 2002, Linus Torvalds wrote:
> 
> On the whole, it's a lot better to just print out a message (and call
> traces are often very useful) and continue. That's not always possible, of
> course, and a lot of BUG() and BUG_ON() cases are perfectly valid simply
> because sometimes there isn't anything you can do except kill the machine
> and try to inform the user.

Note that from an implementation standpoint I suspect that a "trap and 
continue" thing can easily be pretty much exactly as the current BUG() 
with a flag somewhere, say in the "third byte" of the "ud2" instruction. 

That would also make it easy to dynamically change the behaviour (ie some 
people might want to explicitly make even the "warnings" fatal - a kernel 
version of -Werror), and the implementation should be trivial:

#define TRAP_INSTRUCTION( lethal )	\
	__asm__ __volatile__( "ud2\n"	\
			"\t.byte %0\n"	\
			"\t.word %c1\n" \
			"\t.long %c2\n" \
			: :"i" (lethal), "i" (__LINE__), "i" (__FILE__))

and then you have

	#define BUG()	TRAP_INSTRUCTION(1)
	#define WARN()	TRAP_INSTRUCTION(0)

or something like that (where the non-lethal version just increments eip
by 9 to jump over the extended ud2 and the information pointers).

		Linus

