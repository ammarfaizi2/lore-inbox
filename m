Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUGGB3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUGGB3V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 21:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264815AbUGGB3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 21:29:21 -0400
Received: from hera.cwi.nl ([192.16.191.8]:18922 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264808AbUGGB3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 21:29:16 -0400
Date: Wed, 7 Jul 2004 03:28:56 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andries Brouwer <aebr@win.tue.nl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring HDIO_GETGEO semantics)
Message-ID: <20040707012856.GA1481@apps.cwi.nl>
References: <20040706015620.GA12659@apps.cwi.nl> <Pine.LNX.4.21.0407061811090.4511-100000@mlf.linux.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0407061811090.4511-100000@mlf.linux.rulez.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2004 at 08:56:22PM +0200, Szakacsits Szabolcs wrote:

> > You say that other utilities are affected. Maybe, yes. So let us look
> > at them. In the time spent writing all these letters we probably could
> > have fixed a few.
> 
> Sorry, off-topic. This thread is not about patching utilities. Please keep
> the subject.

Pity. There are still a few days. Soon I'll be in Korea and Russia and
elsewhere, and before you know it it'll be September again. This week
there are a few days to do some Linux-related work.

Since you stressed so loudly that stuff was broken, I would have liked
to learn precisely what, and to fix, if possible.  Maybe it was not important.


> What would happen if it returns 0?

There is no serious suggestion to do so. It is 2.6 and interfaces are stable.
Also, this much maligned output still contains some information.
Making it 0 would have been a good signal around 2.5.6.


> You mentioned a RAID that needs the 2.6 geometry.

No, you misunderstood. It is just that the blanket statement
"geometry plays no role in Linux" is only true "roughly speaking",
but there are details. One such detail is that certain Promise firmware
expects a RAID superblock on the first sector of the last track of
the last full cylinder, IIRC. Where is that? That is known only
when a geometry has been defined.
(There was a discussion, forgot the details, see e.g.
http://www.uwsg.iu.edu/hypermail/linux/kernel/0307.2/0917.html )
See also the code in 2.4 pdcraid.c.

So, both you and I were telling Bartlomiej: "No, we are not talking about
the ide driver", as indeed we were not, but there may still be some
relevance even for drivers/ide.


> Why does it make the kernel buggier?
> Please detail.


There is a tension between correctness and convenience.

If an installer sees a partition with swap signature, then that is swap space,
isn't it? No need to ask the user. Only, it was my FreeBSD partition that
earlier had been swap space. Bye bye.

Everywhere where magic numbers are involved, where there is "recognition",
there are bugs. Low probability bugs. If a user knows the system, when
it is clear what is happening, then recognition is convenient, and in the
rare cases that something is misrecognized the problem is easily solved.

But when systems get more complicated, many layers of software, and on all
levels there is "recognition", then completely mysterious bugs will happen
with very low probability.

The conclusion is that a good system must be absolutely correct on the low levels.
No guessing. Of course heuristics also occur on low levels, but there
the function must be to improve efficiency. The punishment for guessing wrong
may be to spend a few milliseconds more, but not to get the wrong answer.

The Linux kernel started as a plaything but is getting complicated.
Long ago is was completely reasonable to guess what type partition table
and what type rootfilesystem the user had. There were only a few possibilities,
mostly easily recognized. But the number of possibilities grows, and the number
of users grows so that even unlikely things really occur. We got rootfstype=.
Also the "reread partition table" must not guess but get the type specified.

So, that was the general talk that you do not want to hear.

One of the many places where we guess is for the return values of HDIO_GETGEO.
What did it return? The precise description would fill several pages, but
the CMOS was inspected (only on i386, only for the first two disks),
the partition table was inspected (depending on the phase of the moon,
the IDE or SCSI driver used), switch settings on cards, as far as these
were readable, the IDENTIFY report from the disk, arbitrary numbers
like 15, 16, 63, 255 were invented, special cases for disk managers ...

How does a monster like that arise? Wart upon wart. Well, we guess, and
usually right, but not always, then invent a correction to guess a bit
better in some special situations, then ...
And times change, and likely guesses become less likely, and changes are made ...

At some point in time the monster must be eliminated.

Fortunately, the kernel does not need the result of this guesswork any longer.
Suppose the kernel exports all information it has to user space
without extracting guesses, and leaves the guessing to user space.
Then the kernel is 100% correct and well-defined.
That is what we like.

And even better, user space can do more than the kernel did.
You see that already in the current parted. It looks not only at
the partition table, but also inside FAT and NTFS filesystems
to inspect them for geometry info.
Looks like it may become better than any combination of old parted
with some kernel ever was.

So that is my answer. Ugly code, obscure and buggy guesswork is
being eliminated from the kernel. Rejoice!

Now this happened first in 2.5.6 if I recall correctly, over two
years ago, and a few programs had to be adapted a little.
I think fdisk, cfdisk, sfdisk, probably also lilo, were adapted rather
quickly, but, as we discovered recently, parted took more time. Ach.

Only a rather small amount of geometry code was removed, roughly speaking
a single file, and a much larger cleanup will follow, I hope.
This means that it would not be especially difficult to go back.
There is no reason to do so.


Andries
