Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132847AbRDPDa0>; Sun, 15 Apr 2001 23:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132848AbRDPDaR>; Sun, 15 Apr 2001 23:30:17 -0400
Received: from adsl-204-0-249-112.corp.se.verio.net ([204.0.249.112]:12015
	"EHLO tabby.cats-chateau.net") by vger.kernel.org with ESMTP
	id <S132847AbRDPD37>; Sun, 15 Apr 2001 23:29:59 -0400
From: Jesse Pollard <jesse@cats-chateau.net>
Reply-To: jesse@cats-chateau.net
To: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: fsck, raid reconstruction & bad bad 2.4.3
Date: Sun, 15 Apr 2001 21:51:52 -0500
X-Mailer: KMail [version 1.0.28]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <E14oxbX-0000oM-00@sites.inka.de> <01041521302600.15046@tabby> <p05100b09b7000a8c3bc9@[207.213.214.34]>
In-Reply-To: <p05100b09b7000a8c3bc9@[207.213.214.34]>
MIME-Version: 1.0
Message-Id: <01041522295701.15046@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Apr 2001, Jonathan Lundell wrote:
>At 9:23 PM -0500 2001-04-15, Jesse Pollard wrote:
>> >b) wait with fsck until rebuild is fixed
>>
>>Depends on your definition of "fixed". The most I can see to fix is
>>reduce the amount of continued update in favor of updating those blocks
>>being read (by fsck or anything else). This really ought to be a runtime
>>configuration option. If it is set to 0, then no automatic repair would
>>be done.
>
>The original post was referring to RAID 1; there's no repair necessary at
>the RAID level to give fsck the correct data. Seems to me the basic problem
>here is that the RAID re-sync is supposed to be throttling back to allow other
>activity to run, but that in the case of fsck the other activity is still
>slower by a large factor (compared to no RAID re-sync).

If I've got the numbering right;
	0 - concatenated stripes => no sync required
	1 - mirrored => resync required
		a: which drive has the correct info?
		b: having determined that, read the correct block,
		   it must now be written to the mirror.
	all others => resync required (rebuild possible bad block)

>Is this a pathological case because of the way fsck does business, or does
>the RAID re-sync affect any disk-bound process that severely?

My experience has been with hardware raid, and even then there has been
a 1-5% decrease in I/O during resync (not accurately measured - fsck took
longer, and then only when the channel is maxed out -- otherwise the 1-5% is
not visible; filesystem was 3 IRIX efs, spread across two raid luns).

fsck is particularly bad, since nearly every read instigates a write to
the mirror drive. Fsck can then modify the block and write it back, causing
two more writes; for a total of 3 writes for a read (worst case).

It does mean that when fsck finishes, MOST of the re-sync will be finished.
All of the metadata will be synced, and only file data blocks will remain.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: jesse@cats-chateau.net

Any opinions expressed are solely my own.
