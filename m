Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135899AbRAHSLh>; Mon, 8 Jan 2001 13:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136033AbRAHSL1>; Mon, 8 Jan 2001 13:11:27 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:39692 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136192AbRAHSLM>; Mon, 8 Jan 2001 13:11:12 -0500
Date: Mon, 8 Jan 2001 10:10:53 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: "Sergey E. Volkov" <sve@raiden.bancorp.ru>, linux-kernel@vger.kernel.org,
        Christoph Rohland <cr@sap.com>
Subject: Re: VM subsystem bug in 2.4.0 ?
In-Reply-To: <Pine.LNX.4.21.0101081550590.21675-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.10.10101081003410.3750-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jan 2001, Rik van Riel wrote:
> 
> We need a check in deactivate_page() to prevent the kernel
> from moving pages from locked shared memory segments to the
> inactive_dirty list.
> 
> Christoph?  Linus?

The only solution I see is something like a "active_immobile" list, and
add entries to that list whenever "writepage()" returns 1 - instead of
just moving them to the active list.

Seems to be a simple enough change. The main worry would be getting the
pages _off_ such a list: anything that unlocks a shared memory segment
(can you even do that? If the only way to unlock is to remove, we have no
problems) would have to have a special function to move all pages from the
immobile list back to the active list (and then they'd get moved back if
they were for another segment that is still locked).

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
