Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263698AbREYKzs>; Fri, 25 May 2001 06:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263697AbREYKzj>; Fri, 25 May 2001 06:55:39 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:21256 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263692AbREYKzT>; Fri, 25 May 2001 06:55:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hans Reiser <reiser@namesys.com>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Date: Fri, 25 May 2001 12:56:30 +0200
X-Mailer: KMail [version 1.2]
Cc: Andreas Dilger <adilger@turbolinux.com>,
        "Peter J. Braam" <braam@mountainviewdata.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Edgar Toernig <froese@gmx.de>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Josh MacDonald <jmacd@CS.Berkeley.EDU>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
In-Reply-To: <200105222010.f4MKAWZk011755@webber.adilger.int> <0105242307570P.06233@starship> <3B0D8465.B1A13674@namesys.com>
In-Reply-To: <3B0D8465.B1A13674@namesys.com>
MIME-Version: 1.0
Message-Id: <0105251256300U.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 May 2001 00:00, Hans Reiser wrote:
> Daniel Phillips wrote:
> > I suppose I'm just reiterating the obvious, but we should
> > eventually have a generic filesystem transaction API at the VFS
> > level, once we have enough data points to know what the One True
> > API should be.
>
> Daniel, implementing transactions is not a trivial thing as you
> probably know. It requires that you resolve such issues as, what
> happens if the user forgets to close the transaction, issues of
> lock/transaction duration, of transaction batching, of levels of
> isolation, of concurrent transactions modifying global fs metadata
> and some but not all of those concurrent transactions receiving a
> rollback, and of permissions relating to keeping transactions open. 
> I would encourage you to participate in the reiser4 design discussion
> we will be having over the next 6 months, and give us your opinions. 
> Josh will be leading that design effort for the ReiserFS team.

Graciously accepted.  Coming up with something sensible in a mere 6 
months would be a minor miracle. ;-)

- what happens if the user forgets to close the transaction?

   I plan to set a checkpoint there (because the transaction got
   too big) and log the fact that it's open.

- issues of lock/transaction duration

   Once again relying on checkpoints, when the transaction gets
   uncomfortably big for cache, set a checkpoint.  I haven't thought
   about locks

- transaction batching

   1) Explicit transaction batch close 2) Cache gets past a certain     
   fullness.  In both cases, no new transactions are allowed to start
   and as soon as all current ones are closed we close the batch.

- of levels of isolation
- concurrent transactions modifying global fs metadata
   and some but not all of those concurrent transactions receiving a
   rollback

   First I was going to write 'huh?' here, then I realized you're       
   talking about real database ops, not just filesystem ops.  I had
   in mind something more modest: transactions are 'mv', 'read/write'
   (if the 'atomic read/write' is set), other filesystem operations I've
   forgotten, and anything the user puts between open_xact and          
   close_xact.  You are raising the ante a little ;-)

   In my case (Tux2) I could do an efficient rollback to the beginning
  of the batch (phase), then I would have had to have kept an           
   in-memory log of the transactions for selective replay.  With a      
   journal log you can obviously do the same thing, but perhaps more
   efficiently if your journal design supports undo/redo.

   The above is a pure flight of fancy, we won't be seeing anything
   so fancy as an API across filesystems.

- permissions relating to keeping transactions open. 
   We can see this one in the light of a simple filesystem              
   transaction: what happens if we are in the middle of a mv and        
   someone changes the permissions?  Go with the starting or
   ending permissions?

Well, the database side of this is really interesting, but to get 
something generic across filesystems, the scope pretty well has to be 
limited to journal-type transactions, don't you think?

--
Daniel
