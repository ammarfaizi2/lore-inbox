Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310816AbSCWSlz>; Sat, 23 Mar 2002 13:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310835AbSCWSlq>; Sat, 23 Mar 2002 13:41:46 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:23568 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S310816AbSCWSl2>; Sat, 23 Mar 2002 13:41:28 -0500
Message-ID: <3C9CCBEB.D39465A6@zip.com.au>
Date: Sat, 23 Mar 2002 10:39:39 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: christophe =?iso-8859-1?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
In-Reply-To: <20020323161647.GA11471@ufies.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe barbé wrote:
> 
> Here is a small patch tested with 2.4.18 and 2.4.19-pre4.
> It was proposed by Andrew but not integrated in pre4.
> 
> The problem is when using the vortex driver and suspend/resuming the
> machine.

The patch looks fine to me.

This is a common bug in the Linux ethernet drivers.  Let's
review it:

- The module init function keeps a driver-wide `card_idx'
- Every time a new card is detected, card_idx is incremented
  and is associated with that card.
- The card instance's card_idx is used to index module options
  arrays.
- The global card_idx counter is never decremented.

So each time you hotplug a card, it gets the next index, and
eventually the index exceeds the size of the module options array
and the driver falls into its "oh, I've got more than eight
cards" mode.

The fix in this patch is to simply decrement card_idx in the
remove_one function.  Which somewhat assumes that cards are
removed and inserted in LIFO order, but that's true for
just one card :)

Same bug appears to be present in about eight divers - just
grep for card_idx.

I don't immediately see a simple and clean fix for this.
If we have, say,

	options 3c59x enable_wol=1,1,0,1,1,0,0,0

in modules.conf, and we really have eight NICS, and they're
being plugged and unplugged, how can we reliably associate
that option with the eight cards?  So the right option is
applied to each card eash time it's inserted?  Should the
option be associated with a card, or with a bus position?

Fun.

Anyway.  Let's apply the patch.

-
