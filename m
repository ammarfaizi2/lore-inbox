Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751837AbWHAT1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWHAT1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 15:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWHAT1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 15:27:14 -0400
Received: from khc.piap.pl ([195.187.100.11]:36277 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751837AbWHAT1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 15:27:13 -0400
To: David Masover <ninja@slaphack.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
References: <200607312314.37863.bernd-schubert@gmx.de>
	<200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>
	<20060801165234.9448cb6f.reiser4@blinkenlights.ch>
	<1154446189.15540.43.camel@localhost.localdomain>
	<44CF84F0.8080303@slaphack.com>
	<1154452770.15540.65.camel@localhost.localdomain>
	<44CF9217.6040609@slaphack.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 01 Aug 2006 21:27:10 +0200
In-Reply-To: <44CF9217.6040609@slaphack.com> (David Masover's message of "Tue, 01 Aug 2006 12:40:39 -0500")
Message-ID: <m3fyggz27l.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> writes:

>> RAID deals with the case where a device fails. RAID 1 with 2 disks
>> can
>> in theory detect an internal inconsistency but cannot fix it.
>
> Still, if it does that, that should be enough.  The scary part wasn't
> that there's an internal inconsistency, but that you wouldn't know.

RAID1 can do that in theory but it practice there is no verification,
so the other disk can perform another read simultaneously (thus
increasing performance).

Some high-end systems, maybe.

That would be hardly economical. Per-block checksums (like used by the
ZFS) are different story, they add only little additional load.

> And it can fix it if you can figure out which disk went.  Or give it 3
> disks and it should be entirely automatic -- admin gets paged, admin
> hotswaps in a new disk, done.

Yep, that could be done. Or with 2 disks with block checksums.
Actually, while I don't exactly buy their ads, I think ZFS employs
some useful ideas.

> And yet, if you can do that, I'd suspect you can, should, must do it
> at a lower level than the FS.  Again, FS robustness is good, but if
> the disk itself is going, what good is having your directory (mostly)
> intact if the files themselves have random corruptions?

With per-block checksum you will know. Of course, that's still not
end to end checksum.

> If you can't trust the disk, you need more than just an FS which can
> mostly survive hardware failure.  You also need the FS itself (or
> maybe the block layer) to support bad block relocation and all that
> good stuff, or you need your apps designed to do that job by
> themselves.

Drives have internal relocation mechanisms, I don't think the
filesystem needs to duplicate them (though it should try to work
with bad blocks - relocations are possible on write).

> It just doesn't make sense to me to do this at the FS level.  You
> mention TCP -- ok, but if TCP is doing its job, I shouldn't also need
> to implement checksums and other robustness at the protocol layer
> (http, ftp, ssh), should I?

Sure you have to, if you value your data.

> Similarly, the FS (and the apps) shouldn't have to know
> about hardware problems until it really can't do anything about it
> anymore, at which point the right thing to do is for the FS and apps
> to go "oh shit" and drop what they're doing, and the admin replaces
> hardware and restores from backup.  Or brings a backup server online,
> or...

I don't think so. Going read-only if the disk returns write error,
ok. But taking the fs offline? Why?

Continuous backups (or rather transaction logs) are possible but
who has them? Do you have them? Would you throw away several hours
of work just because some file (or, say, unused area) contained
unreadable block (which could probably be transient problem, and/or
could be corrected by write)?
-- 
Krzysztof Halasa
