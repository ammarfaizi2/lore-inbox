Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129423AbQLFApe>; Tue, 5 Dec 2000 19:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129458AbQLFApP>; Tue, 5 Dec 2000 19:45:15 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:65032 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129423AbQLFApL>; Tue, 5 Dec 2000 19:45:11 -0500
Date: Tue, 5 Dec 2000 16:13:51 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kai@thphy.uni-duesseldorf.de, Alan Cox <alan@redhat.com>
Subject: Re: That horrible hack from hell called A20
In-Reply-To: <3A2D7AA4.9E7D414F@transmeta.com>
Message-ID: <Pine.LNX.4.10.10012051558490.13428-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Dec 2000, H. Peter Anvin wrote:
>
> Okay, here is my latest attempt to find a way to toggle A20M# that
> genuinely works on all machines -- including Olivettis, IBM Aptivas,
> bizarre notebooks, yadda yadda.

I really think that the 0x92 accesses are still unsafe.

I will bet that the same way some manufacturers use the A20 output as a
GPIO, they might also use the keyboard _reset_ output as a GPIO. This
would explain why we have problems on getting back from resume.

So the "orb $2,%al ; andb $0xfe,%al" will potentially change both of
these. And I'd feel a hell of a lot more safe, if we avoided using 0x92
except when we find that we absolutely _have_ to. 

How about making the keyboard controller timeouts shorter, and moving all
the 0x92 games to after the keyboard controller games. That, I feel, would
be the safest approach: try the really old approach first (that people are
the least likely to use as GPIO - it's just too damn painful to go through
the keyboard controller, and the keyboard controller A20 logic is just too
well documented, so nobody would use it for anything else).

If the keyboard controller times out, or if A20 still doesn't seem to be
enabled, only _then_ would we do the 0x92 testing.

Btw, do we actually know of any machine that really needs the "and $0xfe"?
That register really makes me nervous.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
