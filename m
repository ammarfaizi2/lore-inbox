Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289885AbSA2VJ4>; Tue, 29 Jan 2002 16:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289888AbSA2VJr>; Tue, 29 Jan 2002 16:09:47 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48139 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289885AbSA2VJe>; Tue, 29 Jan 2002 16:09:34 -0500
Date: Tue, 29 Jan 2002 13:08:12 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.44.0201291446460.25443-100000@waste.org>
Message-ID: <Pine.LNX.4.33.0201291302210.1283-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Oliver Xymoron wrote:
>
> fork:
>   detach page tables from parent

 - leave the option ot just mark them read-only on architectures that
   support it (ie x86, I think alpha does this too).

>   retain pointer to "backing page tables" in parent and child
>   update use count in page tables

You want to copy the top-level page table directory (with the "present
bit" disabled or something), not just retain a pointer to it. Otherwise
you just get really confused after two fork() calls, where you can have
multiple "backing page tables".

>   "prefault" tables for current stack and instruction pages in both parent
>     and child

Don't unconditionally prefault. There are many potentially useful things
that do _not_ want to do this, for example snapshot creation.

So the generic "do_fork()" thing should _not_ do prefaulting, although
"sys_fork()"  may well choose to do it.

			Linus

