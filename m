Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285087AbRLFJtz>; Thu, 6 Dec 2001 04:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285074AbRLFJtp>; Thu, 6 Dec 2001 04:49:45 -0500
Received: from mail.science.uva.nl ([146.50.4.51]:13036 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S285078AbRLFJtb>; Thu, 6 Dec 2001 04:49:31 -0500
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Date: Thu, 6 Dec 2001 10:43:13 +0100 (CET)
From: Kamil Iskra <kamil@science.uva.nl>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Andrew Morton <akpm@zip.com.au>, Mark Hahn <hahn@physics.mcmaster.ca>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Problems with APM suspend and ext3
In-Reply-To: <20011205145901.A11105@redhat.com>
Message-ID: <Pine.LNX.4.33.0112061013190.10310-100000@krakow.science.uva.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Stephen C. Tweedie wrote:

> > Yup.  It seems that your BIOS is being asked to suspend all devices
> > while there is still disk IO being performed.  And it refuses to
> > suspend because the disk is still active.
> Yep.  I'd still like to know exactly what the circumstances around
> this are: just what are the constraints which apm requires us to
> observe for successful suspend?  I've never had a laptop fail to
> suspend due to this sort of problem with ext3, so it's obviously
> different from one apm implementation to the next.

I tried to perform some more experiments yesterday to get some insight,
but I didn't get much further than before.

Basically, the conclussions that I reached are that for a reasonably
reliable suspend, I either need the filesystem to be mounted as ext2, or I
need "noatime" option with ext3.  That's with 2.4.16 kernel BTW.  In
either of the two configurations I don't seem to need to play with "sync"
or such before attempting a suspend: it mostly "just works".

I also ran a fairly disk-intensive "find /usr" in another xterm and tried
to suspend with this process running.  With either of ext2 or
ext3+noatime, suspend attempts _sometimes_ succeed in this case, with a
rate of 30-50%, I think. That seems to be consistent with my past
experience with older Compaq Armada laptops, such as 15xx and 7xxx series.

Also, strangely enough, the success rate of suspends is higher if I invoke
"apm -s" from an xterm than when I do it from a virtual console.  I'm
talking about identical situations here, same processes running and all,
with one root session in an xterm and another on the console and just
switching between them with Alt+Fn.  I made so many tries and reboots that
I am quite certain that I'm not imagining this one.

With ext3 without noatime, suspend attempts occassionally succeed from
xterm, and practically never do from the virtual console.  Manually
invoking "sync" doesn't seem to help.

I've also played with the configuration of syslogd, putting a '-' in front
of all file/device fields so as to prevent a sync, and with hdparm,
turning off various optimisations such as 32-bit I/O, DMA and more.
These changes didn't seem to matter.

I'm always willing to try some patches or other ideas which would allow a
seemless work of ext3 on my laptop.  For the time being, I will probably
settle for ext3+noatime.  The latter is not a stupid thing anyway if you
ever want your harddisk to spin down.

Regards,

-- 
Kamil Iskra                 http://www.science.uva.nl/~kamil/
Section Computational Science, Faculty of Science, Universiteit van Amsterdam
kamil@science.uva.nl  tel. +31 20 525 75 35  fax. +31 20 525 74 90
Kruislaan 403  room F.202  1098 SJ Amsterdam  The Netherlands

