Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273361AbRI0PfR>; Thu, 27 Sep 2001 11:35:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273372AbRI0PfG>; Thu, 27 Sep 2001 11:35:06 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:14099 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S273361AbRI0Pes>; Thu, 27 Sep 2001 11:34:48 -0400
Date: Thu, 27 Sep 2001 08:34:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Kiril Vidimce <vkire@pixar.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] exec-argsize-2.4.10-A3
In-Reply-To: <Pine.LNX.4.33.0109270859100.2745-200000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0109270829090.17030-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 27 Sep 2001, Ingo Molnar wrote:
>
> Comments?

I'd actually much rather see the argument size limit go away _completely_,
and keep the arguments in the original VM instead of copying them over one
page at a time etc.

One of th ereasons for the limit is simply that otherwise there is a
_nasty_ DoS-attack by causing lots of execve()'s to happen in parallel,
and deadlocking the system by having 100 execve's all of which have 1MB of
pinned argument pages.

Leaving the data in the original VM and populating a _new_ VM has many
advantages: if you have both VM's on the mm_list, you can automatically
let the page-out logic handle the DoS case for you, and the pages aren't
pinned any more (you'd keep just _one_ page pinned in the new VM: the page
that you're currently copying in to)

We can do that these days. Traditionally we couldn't, for various reasons
(we didn't have a mm list and we didn't have the notion of independent VM
address spaces when the code was written).

		Linus

