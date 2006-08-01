Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750899AbWHARkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750899AbWHARkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbWHARkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:40:45 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:64718 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S1750899AbWHARko
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:40:44 -0400
Message-ID: <44CF9217.6040609@slaphack.com>
Date: Tue, 01 Aug 2006 12:40:39 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Adrian Ulrich <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200607312314.37863.bernd-schubert@gmx.de>	 <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>	 <20060801165234.9448cb6f.reiser4@blinkenlights.ch>	 <1154446189.15540.43.camel@localhost.localdomain>	 <44CF84F0.8080303@slaphack.com> <1154452770.15540.65.camel@localhost.localdomain>
In-Reply-To: <1154452770.15540.65.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Ar Maw, 2006-08-01 am 11:44 -0500, ysgrifennodd David Masover:
>> Yikes.  Undetected.
>>
>> Wait, what?  Disks, at least, would be protected by RAID.  Are you 
>> telling me RAID won't detect such an error?
> 
> Yes.
> 
> RAID deals with the case where a device fails. RAID 1 with 2 disks can
> in theory detect an internal inconsistency but cannot fix it.

Still, if it does that, that should be enough.  The scary part wasn't 
that there's an internal inconsistency, but that you wouldn't know.

And it can fix it if you can figure out which disk went.  Or give it 3 
disks and it should be entirely automatic -- admin gets paged, admin 
hotswaps in a new disk, done.

>> we're OK with that, so long as our filesystems are robust enough.  If 
>> it's an _undetected_ error, doesn't that cause way more problems 
>> (impossible problems) than FS corruption?  Ok, your FS is fine -- but 
>> now your bank database shows $1k less on random accounts -- is that ok?
> 
> Not really no. Your bank is probably using a machine (hopefully using a
> machine) with ECC memory, ECC cache and the like. The UDMA and SATA
> storage subsystems use CRC checksums between the controller and the
> device. SCSI uses various similar systems - some older ones just use a
> parity bit so have only a 50/50 chance of noticing a bit error.
> 
> Similarly the media itself is recorded with a lot of FEC (forward error
> correction) so will spot most changes.
> 
> Unfortunately when you throw this lot together with astronomical amounts
> of data you get burned now and then, especially as most systems are not
> using ECC ram, do not have ECC on the CPU registers and may not even
> have ECC on the caches in the disks.

It seems like this is the place to fix it, not the software.  If the 
software can fix it easily, great.  But I'd much rather rely on the 
hardware looking after itself, because when hardware goes bad, all bets 
are off.

Specifically, it seems like you do mention lots of hardware solutions, 
that just aren't always used.  It seems like storage itself is getting 
cheap enough that it's time to step back a year or two in Moore's Law to 
get the reliability.

>>> The sort of changes this needs hit the block layer and ever fs.
>> Seems it would need to hit every application also...
> 
> Depending how far you propogate it. Someone people working with huge
> data sets already write and check user level CRC values for this reason
> (in fact bitkeeper does it for one example). It should be relatively
> cheap to get much of that benefit without doing application to
> application just as TCP gets most of its benefit without going app to
> app.

And yet, if you can do that, I'd suspect you can, should, must do it at 
a lower level than the FS.  Again, FS robustness is good, but if the 
disk itself is going, what good is having your directory (mostly) intact 
if the files themselves have random corruptions?

If you can't trust the disk, you need more than just an FS which can 
mostly survive hardware failure.  You also need the FS itself (or maybe 
the block layer) to support bad block relocation and all that good 
stuff, or you need your apps designed to do that job by themselves.

It just doesn't make sense to me to do this at the FS level.  You 
mention TCP -- ok, but if TCP is doing its job, I shouldn't also need to 
implement checksums and other robustness at the protocol layer (http, 
ftp, ssh), should I?  Because in this analogy, it looks like TCP is the 
"block layer" and a protocol is the "fs".

As I understand it, TCP only lets the protocol/application know when 
something's seriously FUBARed and it has to drop the connection. 
Similarly, the FS (and the apps) shouldn't have to know about hardware 
problems until it really can't do anything about it anymore, at which 
point the right thing to do is for the FS and apps to go "oh shit" and 
drop what they're doing, and the admin replaces hardware and restores 
from backup.  Or brings a backup server online, or...



I guess my main point was that _undetected_ problems are serious, but if 
you can detect them, and you have at least a bit of redundancy, you 
should be good.  For instance, if your RAID reports errors that it can't 
fix, you bring that server down and let the backup server run.
