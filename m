Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130962AbRCFOKE>; Tue, 6 Mar 2001 09:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130964AbRCFOJy>; Tue, 6 Mar 2001 09:09:54 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:14730 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S130962AbRCFOJk>; Tue, 6 Mar 2001 09:09:40 -0500
Message-Id: <l0313030db6ca9bf216b9@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.21.0103060920320.5591-100000@imladris.rielhome.conectiva>
In-Reply-To: <l0313030ab6ca4912a397@[192.168.239.101]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 6 Mar 2001 14:08:27 +0000
To: Rik van Riel <riel@conectiva.com.br>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: scsi vs ide performance on fsync's
Cc: Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Jeremy Hansen <jeremy@xxedgexx.com>, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Pathological shutdown pattern:  assuming scatter-gather is not allowed (for
>> IDE), and a 20ms full-stroke seek, write sectors at alternately opposite
>> ends of the disk, working inwards until the buffer is full.  512-byte
>> sectors, 2MB of them, is 4000 writes * 20ms = around 80 seconds (not
>> including rotational delay, either).  Last time I checked, you'd need a
>> capacitor array the size of the entire computer case to store enough power
>> to allow the drive to do this after system shutdown, and I don't remember
>> seeing LiIon batteries strapped to the bottom of my HDs.  Admittedly, any
>> sane OS doesn't actually use that kind of write pattern on shutdown, but
>> the drive can't assume that.
>
>But since the drive has everything in cache, it can just write
>out both bunches of sectors in an order which minimises disk
>seek time ...
>
>(yes, the drives don't guarantee write ordering either, but that
>shouldn't come as a big surprise when they don't guarantee that
>data makes it to disk ;))

That would be true for SCSI devices - I understand the controllers and/or
drives support "scatter-gather" which allows a drive to optimise it's seek
pattern in the manner you describe.  However, I'm not sure whether an IDE
drive is allowed to do this.  I'm reasonably sure that I heard somewhere
that IDE drives have to complete transactions in the specified order as far
as the host is concerned - what I'm unsure of is whether this also applies
to mechanical head movement.

If not, then the drive could by all means optimise the access pattern
provided it acked the data or provided the results in the same order as the
instructions were given.  This would probably shorten the time for a new
pathological set (distributed evenly across the disk surface, but all on
the worst-possible angular offset compared to the previous) to (8ms seek
time + 5ms rotational delay) * 4000 writes ~= 52 seconds (compared with
around 120 seconds for the previous set with rotational delay factored in).
Great, so you only need half as big a power store to guarantee writing that
much data, but it's still too much.  Even with a 15000rpm drive and 5ms
seek times, it would still be too much.

The OS needs to know the physical act of writing data has finished before
it tells the m/board to cut the power - period.  Pathological data sets
included - they are the worst case which every engineer must take into
account.  Out of interest, does Linux guarantee this, in the light of what
we've uncovered?  If so, perhaps it could use the same technique to fix
fdatasync() and family...

--------------------------------------------------------------
from:     Jonathan "Chromatix" Morton
mail:     chromi@cyberspace.org  (not for attachments)
big-mail: chromatix@penguinpowered.com
uni-mail: j.d.morton@lancaster.ac.uk

The key to knowledge is not to rely on people to teach you it.

Get VNC Server for Macintosh from http://www.chromatix.uklinux.net/vnc/

-----BEGIN GEEK CODE BLOCK-----
Version 3.12
GCS$/E/S dpu(!) s:- a20 C+++ UL++ P L+++ E W+ N- o? K? w--- O-- M++$ V? PS
PE- Y+ PGP++ t- 5- X- R !tv b++ DI+++ D G e+ h+ r- y+
-----END GEEK CODE BLOCK-----


