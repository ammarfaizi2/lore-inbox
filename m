Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129777AbQLMUul>; Wed, 13 Dec 2000 15:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130113AbQLMUub>; Wed, 13 Dec 2000 15:50:31 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40464 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129777AbQLMUuQ>; Wed, 13 Dec 2000 15:50:16 -0500
Date: Wed, 13 Dec 2000 12:19:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mike Galbraith <mikeg@wen-online.de>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Signal 11 - the continuing saga
In-Reply-To: <Pine.LNX.4.10.10012131131090.19837-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10012131213160.802-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Dec 2000, Linus Torvalds wrote:
> 
> Hint: "ptep_mkdirty()".

In case you wonder why the bug was so insidious, what this caused was two
separate problems, both of them able to cause SIGSGV's. 

One: we didn't mark the page table entry dirty like we were supposed to.

Two: by making it writable, we also made the page shared, even if it
wasn't supposed to be shared (so when the next process wrote to the page,
if the swap page was shared with somebody else, the changes would show up
even in the process that _didn't_ write to it).

And "ptep_mkdirty()" is only used by swapoff, so nothing else would show
this. Which was why it hadn't been immediately obvious that anything was
broken.

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
