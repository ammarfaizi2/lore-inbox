Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129028AbRBGJdT>; Wed, 7 Feb 2001 04:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129031AbRBGJdK>; Wed, 7 Feb 2001 04:33:10 -0500
Received: from ivanova.coker.com.au ([203.36.46.209]:24074 "HELO
	ivanova.coker.com.au") by vger.kernel.org with SMTP
	id <S129028AbRBGJdF> convert rfc822-to-8bit; Wed, 7 Feb 2001 04:33:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: linux-kernel@vger.kernel.org
Subject: sync in strange state in 2.4.1
Date: Wed, 7 Feb 2001 10:31:24 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <0102071031241I.08100@lyta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Athlon 800 running 2.4.1 with two IDE hard drives, hda and hdc.

hda has the OS on it, hdc is currently blank and unused.

Today I had a bad sector error on hdc so I decided to wipe it properly with 
the following:
for n in /dev/hdc? ; do cat /dev/zero > $n ; done

When running this I ran top in another session and noticed the cat process 
taking 30% CPU time, this is what I expected as the version of cat on that 
system uses 1K buffers (4K buffers require half the CPU time according to my 
last tests of the issue).

Then I decided to run sync, I expected it to sync all buffers in memory (most 
of the 256M of RAM in the machine should have been write-back cache buffers 
by that time so it should take less than 10 seconds, the drive is a 
reasonably fast ATA66 drive - see 
http://www.coker.com.au/~russell/hardware/46g.png for a graph of the drive's 
performance characteristics).  Instead sync appears to want to keep going 
until there are no buffers left (IE when all 46G of data have been written).  
Is it supposed to be this way?
I can imagine situations where sync could run for weeks/months/years without 
completing!

Then I looked at the top output and it reported that sync was in state "RW" 
and using >60% CPU (not in state "D" as I expected).  Non-kernel processes 
that are not in state "D" are supposed to be killable, so I tried giving it a 
"kill -9" which had no affect.  So the process seems to be state "D" after 
all.

This raises the following questions:
Is this operation considered correct behaviour of 2.4.1 kernels?  Or have I 
discovered a bug?

Is this a new feature for 2.4.x that processes that are in a disk IO state 
will report CPU usage and not report as being in state "D"?  If so how do I 
recognise such processes?

Is it a known bug that sync can run virtually forever?

-- 
http://www.coker.com.au/bonnie++/     Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/       Postal SMTP/POP benchmark
http://www.coker.com.au/projects.html Projects I am working on
http://www.coker.com.au/~russell/     My home page
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
