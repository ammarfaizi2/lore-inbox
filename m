Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136317AbREGQvx>; Mon, 7 May 2001 12:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136314AbREGQvn>; Mon, 7 May 2001 12:51:43 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:24583 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136317AbREGQva>; Mon, 7 May 2001 12:51:30 -0400
Date: Mon, 7 May 2001 09:51:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Brian Gerst <bgerst@didntduck.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 page fault handler not interrupt safe
In-Reply-To: <E14wiWH-0003KR-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0105070942380.12733-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 May 2001, Alan Cox wrote:
> 
> I dont see that we will get a valid value in both cases.
> 
> 	get_user
> 		fault - set %cr2
> 					IRQ
> 					vmalloc
> 					fault
> 						set %cr2
> 						fixup runs
> 					end IRQ
> 		cr2 is corrupt

Wrong. "%cr2" is _not_ "corrupt". It has a well-defined value.

So what happens is

	get_user (or user-mode access)
		fault - set %cr2 to fault1
			irq
			vmalloc fault - set %cr2 to fault2
				fixup runs, iret
			irq runs, iret
		%cr2 is still %fault2
		vmalloc fault - nothing to do
		"false fixup" runs, iret
	get_user (or user-mode access)
		fault - set %cr2 to fault1
		... get the right behaviour now ...
		
> There are a whole set of races with the vmalloc fixups.

As far as I can tell, there are no races anywhere. Just silly bugs that
are hard to see.

		Linus

