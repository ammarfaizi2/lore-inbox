Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265881AbRF2MxV>; Fri, 29 Jun 2001 08:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265977AbRF2MxL>; Fri, 29 Jun 2001 08:53:11 -0400
Received: from mail.bmlv.gv.at ([193.171.152.34]:32978 "EHLO mail.bmlv.gv.at")
	by vger.kernel.org with ESMTP id <S265899AbRF2Mw6>;
	Fri, 29 Jun 2001 08:52:58 -0400
Message-Id: <3.0.6.32.20010629145529.00922ae0@pop3.bmlv.gv.at>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Fri, 29 Jun 2001 14:55:29 +0200
To: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>
From: "Ph. Marek" <marek@bmlv.gv.at>
Subject: Re: Q: sparse file creation in existing data?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.A32.3.95.1010629135834.61212E-100000@werner.exp-math.
 uni-essen.de>
In-Reply-To: <3.0.6.32.20010629133915.0091e470@pop3.bmlv.gv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>For your specific problem I'd suggest the following approach:
>
>write a new filter prog, kind of a 'destructive cat' command.
>
>Open the file for read-modify (non destructive)
>Let it read some blocks (number controllable on commandline) from the
>beginning and pipe them to stdout. Then.. read in same amount (well;
>block aligned) from the end of file and copy it over the beginning,
>truncate the file accordingly. After some time reading and truncating
>will meet in the middle of the file, then you read the blocks back in
>on reverse (and truncate them after reading)
>
>It shouldn't be too difficult to write and result in a multipurpose
>commandline utility.
>
>It does some disk i/o but I don't think it will too bad due to disk
>buffers of the kernel and read-ahead. Theoretically, the kernel, buffers
>etc. could detect you are just moving file blocks to different places and
>does this in a 'zero-copy' fashion by just moving some inode entries
>around, but I doubt that it is soo smart.
>
>Drawback: If you have choosen the read block size too large (hmm.. you
>might want to read some data from beginning, some from the end, copy over
>beginning, then truncate, and only then pipe to stdout: this should
>eliminate this 'buffer/diskspace overrun')  of 'destructive cat' too big,
>or the archive is compressed and doesn't fit uncompressed, the backup was
>destructed. This is by far not as safe as any backup tool should be.
>
>A major advantage, however, is that this tool will run w/o a kernel patch,
>on any Unix on any filesystem, even those w/o holes (I think truncate
>works in general, maybe not samba?) 
I didn't even get this idea - it sound's very io-intensive. 
Of course, if you look at it from the right angle - you'd
- read the first halve,
- read the 2nd halve,
- and write the 2nd halve to the 1st,
- and then read the 1st again.

That's two times the amount of io.
If I assume using tar it's because of writing the data only one third more
io than necessary.

Hmmm, on second thought ... But I'd like it better to have a fcntl for
hole-making :-)
Maybe I'll implement this myself.


Thanks,

Phil


