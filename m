Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263343AbRFAD3I>; Thu, 31 May 2001 23:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263340AbRFAD27>; Thu, 31 May 2001 23:28:59 -0400
Received: from idiom.com ([216.240.32.1]:5907 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S263338AbRFAD2x>;
	Thu, 31 May 2001 23:28:53 -0400
Message-ID: <3B170ADC.5FAE88E5@namesys.com>
Date: Thu, 31 May 2001 20:24:12 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Andreas Dilger <adilger@turbolinux.com>,
        "Peter J. Braam" <braam@mountainviewdata.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: [reiserfs-list] Re: Why side-effects on open(2) are evil. (was Re: 
 [RFD w/info-PATCH]device arguments from lookup)
In-Reply-To: <200105222010.f4MKAWZk011755@webber.adilger.int> <0105242307570P.06233@starship> <3B0D8465.B1A13674@namesys.com> <0105251256300U.06233@starship>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> Graciously accepted.  Coming up with something sensible in a mere 6
> months would be a minor miracle. ;-)
> 
> - what happens if the user forgets to close the transaction?

then the user has branched into his own version, or at least that would be my
take on it.  Another possible method is to expire transactions by persons who
lack permission to keep them open indefinitely.  I suppose one could expire them
to abort, or expire them to commit, both being valid under some circumstances.  


> 
>    I plan to set a checkpoint there (because the transaction got
>    too big) and log the fact that it's open.
> 
> - issues of lock/transaction duration
> 
>    Once again relying on checkpoints, when the transaction gets
>    uncomfortably big for cache, set a checkpoint.  I haven't thought
>    about locks
> 
> - transaction batching
> 
>    1) Explicit transaction batch close 2) Cache gets past a certain
>    fullness.  In both cases, no new transactions are allowed to start
>    and as soon as all current ones are closed we close the batch.re6;
> 
> - of levels of isolation
> - concurrent transactions modifying global fs metadata
>    and some but not all of those concurrent transactions receiving a
>    rollback
> 
>    First I was going to write 'huh?' here, then I realized you're
>    talking about real database ops, not just filesystem ops.  I had
>    in mind something more modest: transactions are 'mv', 'read/write'
>    (if the 'atomic read/write' is set), other filesystem operations I've
>    forgotten, and anything the user puts between open_xact and
>    close_xact.  You are raising the ante a little ;-)
> 
>    In my case (Tux2) I could do an efficient rollback to the beginning
>   of the batch (phase), then I would have had to have kept an
>    in-memory log of the transactions for selective replay.  With a
>    journal log you can obviously do the same thing, but perhaps more
>    efficiently if your journal design supports undo/redo.
> 
>    The above is a pure flight of fancy, we won't be seeing anything
>    so fancy as an API across filesystems.

It is just a matter of time, and we will.  I think that the major release AFTER
2.6 will see it.  First we have to get a prototype done in time for 2.6....

> 
> - permissions relating to keeping transactions open.
>    We can see this one in the light of a simple filesystem
>    transaction: what happens if we are in the middle of a mv and
>    someone changes the permissions?  Go with the starting or
>    ending permissions?
> 
> Well, the database side of this is really interesting, but to get
> something generic across filesystems, the scope pretty well has to be
> limited to journal-type transactions, don't you think?

don't know what a journal-type transaction is and how it differs from a database
transaction.

> 
> --
> Daniel
