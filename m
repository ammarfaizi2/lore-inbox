Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130902AbRCFDbK>; Mon, 5 Mar 2001 22:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130903AbRCFDbB>; Mon, 5 Mar 2001 22:31:01 -0500
Received: from zooty.lancs.ac.uk ([148.88.16.231]:7910 "EHLO zooty.lancs.ac.uk")
	by vger.kernel.org with ESMTP id <S130902AbRCFDaw>;
	Mon, 5 Mar 2001 22:30:52 -0500
Message-Id: <l03130307b6ca031531fc@[192.168.239.101]>
In-Reply-To: <Pine.LNX.4.10.10103051819530.8391-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33L2.0103052108590.32449-100000@srv2.ecropolis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 6 Mar 2001 03:30:00 +0000
To: Linus Torvalds <torvalds@transmeta.com>,
        Jeremy Hansen <jeremy@xxedgexx.com>
From: Jonathan Morton <chromi@cyberspace.org>
Subject: Re: scsi vs ide performance on fsync's
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've run the test on my own system and noted something interesting about
the results:

When the write() call extended the file (rather than just overwriting a
section of a file already long enough), the performance drop was seen, and
it was slower on SCSI than IDE - this is independent of whether IDE had
hardware write-caching on or off.  Where the file already existed, from an
immediately-prior run of the same benchmark, both SCSI and IDE sped up to
the same, relatively fast speed.

These runs are for the following code, writing 2000 blocks of 4096 bytes each:

    fd = open("tst.txt", O_WRONLY | O_CREAT, 0644);
    for (k = 0; k < NUM_BLKS; ++k) {
        write(fd, buff + (k * BLK_SIZE), BLK_SIZE);
        fdatasync(fd);
    }
    close(fd);

IDE: Seagate Barracuda 7200rpm UDMA/66
first run:			1.98 elapsed
second and further runs:	0.50 elapsed

SCSI: IBM UltraStar 10000 rpm Ultra/160
first run:			23.57 elapsed
second and further runs:	0.55 elapsed

If the test file is removed between runs, all show the longer timings.

HOWEVER if I modify the benchmark to use 2000 blocks of *20* bytes each,
the timings change.

IDE: Seagate Barracuda 7200rpm UDMA/66
first run:			1.46 elapsed
second and further runs:	1.45 elapsed

SCSI: IBM UltraStar 10000 rpm Ultra/160
first run:			18.30 elapsed
second and further runs:	11.88 elapsed

Notice that the time for the second run of the SCSI drive is almost exactly
one-fifth of a minute, and remember that 2000 rotations / 10000 rpm = 1/5
minute.  IOW, the SCSI drive is performing *correctly* on the second run of
the benchmark.  The poorer performance on the first run *could* be
attributed to writing metadata interleaved with the data writes.  The
better performance on the second run of the first benchmark can easily be
attributed to the fact that the drive does not need to wait an entire
revolution before writing the next block of a file, if that block arrives
quickly enough (this is a Duron, so it darn well arrives quickly).

It's pretty clear that the IDE drive(r) is *not* waiting for the physical
write to take place before returning control to the user program, whereas
the SCSI drive(r) is.  Both devices appear to be performing the write
immediately, however (judging from the device activity lights).  Whether
this is the correct behaviour or not, I leave up to you kernel hackers...

IMHO, if an application needs performance, it shouldn't be syncing disks
after every write.  Syncing means, in my book, "wait for the data to be
committed to physical media" - note the *wait* involved there - so syncing
should only be used where data integrity in the event of a system failure
has a much higher importance than performance.

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


