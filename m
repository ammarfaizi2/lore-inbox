Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129789AbQLBGNh>; Sat, 2 Dec 2000 01:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129834AbQLBGN1>; Sat, 2 Dec 2000 01:13:27 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:686 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129789AbQLBGNR>;
	Sat, 2 Dec 2000 01:13:17 -0500
Date: Sat, 2 Dec 2000 00:42:49 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Steven Van Acker <deepstar@ulyssis.org>, linux-kernel@vger.kernel.org,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ext2 directory size bug (?)
In-Reply-To: <20001202183021.D412@metastasis.f00f.org>
Message-ID: <Pine.GSO.4.21.0012020034220.27040-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 2 Dec 2000, Chris Wedgwood wrote:

> On Sat, Dec 02, 2000 at 12:14:34AM -0500, Alexander Viro wrote:
> 
>     Not really. Anything that modifies directories holds both ->i_sem and
>     ->i_zombie, lookups hold ->i_sem and emptiness checks (i.e. victim in
>     rmdir and overwriting rename) hold ->i_zombie, readdir holds both.
> 
> what performance issues does this raise in the cast of a directory
> with _many_ files in it -- when we are renaming often involving that
> directory?
> 
> I ask this because certain MTAs do just that; and when you have
> 10,000 to 100,000 messages queued I immagine you might spend much of
> your time waiting for ->i_sem locks?

And where do you get contending processes? 'Cause it takes at least two
to get that...

When you have that size of message queues your best bet is to split them into
many directories, though - all FFS derivatives do linear searches, so locking
or not, you are going to lose.

>     Truncating is a piece of cake. Repacking is not a good idea,
>     though, since you are risking massive corruption in case of dirty
>     shutdown in the wrong moment.
>     
> ext2 directories seem somewhat susepctable to corruption on badly
> timed shutdowns anyhow; and I don't think there is any way to do
> atomic writes to them with most disk hardware is there?

It has to do with the lack of write ordering. Which can be fixed, but not
if you do many updates in one operation. However, even without the ordering
repacking increases the window of corruption. Big way.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
