Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275156AbRJJJhM>; Wed, 10 Oct 2001 05:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275172AbRJJJhD>; Wed, 10 Oct 2001 05:37:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53254 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S275156AbRJJJhA>; Wed, 10 Oct 2001 05:37:00 -0400
Date: Wed, 10 Oct 2001 02:36:13 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <20011010182730.0077454b.rusty@rustcorp.com.au>
Message-ID: <Pine.LNX.4.33.0110100230170.1518-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Oct 2001, Rusty Russell wrote:
>
> If noone *holds* a reference, you can remove it "sometime later",
> where "sometime later" is (for example) after every CPU has scheduled.

Ehh.. One of those readers can hold on to the thing while waiting for
something else to happen.

Looking up a data structure and copying it to user space or similar is
_the_ most common operation for any lookup. You MUST NOT free it just
because we scheduled away. Scheduling points have zero meaning in real
life.

So you'll need a reference count to actually keep such a data structure
alive _over_ a schedule. Or all the readers need to copy the data too
before they actually start using it. At which point you've made your code
a _lot_ slower than the locking version.

Yeah, I can see that your data structure can be made to work by limiting
how you can use it ("you must never hold on to a entry over a schedule,
reference-counting is a no-no, and you have to stand on your left foot
when you look at it sideways").

		Linus


