Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267518AbRGZP1e>; Thu, 26 Jul 2001 11:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbRGZP1Z>; Thu, 26 Jul 2001 11:27:25 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4614 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267518AbRGZP1I>; Thu, 26 Jul 2001 11:27:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ext3-2.4-0.9.4
Date: Thu, 26 Jul 2001 17:31:55 +0200
X-Mailer: KMail [version 1.2]
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <20010726151749.M17244@emma1.emma.line.org> <E15PlYr-0003mr-00@the-village.bc.nu> <20010726163223.Q17244@emma1.emma.line.org>
In-Reply-To: <20010726163223.Q17244@emma1.emma.line.org>
MIME-Version: 1.0
Message-Id: <0107261731550N.00907@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thursday 26 July 2001 16:32, Matthias Andree wrote:
> On Thu, 26 Jul 2001, Alan Cox wrote:
> > Rik is right. It isnt just about premature notification - its about
> > atomicity. At the point you are notified the data has been queued
> > for disk I/O. Even on traditional BSD ufs with synchronous metadata
> > you still had points where a crash left the rename partially
> > complete and nothing but a log or an atomic update system is going
> > to fix that.
>
> No. Atomic update systems and logs can by no means fix premature
> acknowledgements:
>
> Proof:
>
> Assume the OS has a phase tree kind of thing or log that requires
> just a single-block write for an atomic rename.
>
> Assume an MTA calls rename(), and the OS by whatever means notifies
> it of completion, but actually, the data is only queued, not written.
>
> Assume The MTA receives the acknowledgement (e. g. rename call
> returned), sends a "250 mail action complete" packet across the
> network.
>
> Assume the machine sends the network packed, but not the queued disk
> block and then crashes.
>
> --> The single block is lost, the rename operation is lost, but the
> operation had been acknowledged. Consequence: the mail is lost. q. e.
> d.
>
> All this boils down to:
>
> 1. The OS _MUST_ know when a write operation has been physically
> committed to non-volatile storage.

We're working on that, see the "[PATCH] 64 bit scsi read/write" thread 
on linux-fsdevel.  About half of it is devoted to investigating the 
detailed semantics of physical write completion.

> 2. The OS _MUST_ _NOT_ acknowledge the (assumedly synchronous
> operation) any earlier. (This may well include switching off drive
> write buffering.)

Yes, for now that's how you have to do it.

> If the OS cannot fulfill these two basic requirements, I can save all
> the log or FS atomicity efforts because they don't get me anywhere.
>
> The problem is not that the operation can fail, the problem IS
> premature acknowledgement. Even with atomic updates, as shown above.

Right now the interface for determining that the operation has actually 
completed is "sync".  Yes, that sucks but with journalling or atomic 
commit it's not nearly as expensive as you might think.  My early flush 
patch does nearly the equivalent of sync, 10 times a second and it 
actually improves performance (it does not attempt to do this under 
high load of course).

We *should* have something like sys_sync_dev(majorminor) or 
sys_sync_fs(mountpoint) (whatever that would look like).  For 
phase-tree the semantics are that the call doesn't return until the 
metaroot of the then-current "branching" tree is known to be safely on 
disk.  (Side note: it's ok to allow subsequent updates on the same 
filesystem to procede while an outstanding sync_dev is waiting for 
confirmation from the block layer, because these don't affect the 
filesystem state the sync_fs is waiting on.)

As I understand it, Ext2 allows much the same semantics.  While we do 
need to do something about exposing a more elegant interface, with Ext3 
you should be ok with +S and a "sync" just before you report to the 
world that the mail transaction is complete.  Ext3 does *not* leave a 
lot of dirty blocks hanging around in normal operation, so sync is not 
nearly as slow as it is with good old Ext2.

> Note, of course there is no premature acknowledgement for the
> Linux-default asynchronous directory update. There IS for -o sync or
> chattr +S -- and that's what MTAs to to guarantee data integrity, and
> that's why I'm still suggesting dirsync or something to remedy the
> negative data write performance of full-sync.
>
> If the OS tell me "write completed" when it means "I queued your data
> for writing", it is BROKEN.
>
> That's my point.
>
> And since the common POSIX OS lacks a dedicated notification feature
> for e. g. rename, MTAs have no other choice than to rely on "has
> completed when the syscall returns".
>
> BTW, my Linux rename(2) man page doesn't document EIO condition,
> FreeBSD 4.3-STABLE and SUS v2 do.

Sounds like a man page bug.

--
Daniel
