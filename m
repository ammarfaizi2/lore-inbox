Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbTAJLHe>; Fri, 10 Jan 2003 06:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbTAJLHb>; Fri, 10 Jan 2003 06:07:31 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:11281
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S264908AbTAJLH1>; Fri, 10 Jan 2003 06:07:27 -0500
Date: Fri, 10 Jan 2003 03:14:05 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: fverscheure@wanadoo.fr,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Problem in IDE Disks cache handling in kernel 2.4.XX
In-Reply-To: <1042198670.28469.45.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.10.10301100256240.31168-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Jan 2003, Alan Cox wrote:

> On Fri, 2003-01-10 at 09:54, Francis Verscheure wrote:
> > In fact for ATA/ATAPI 5 cfs_enable_2  has no meaning.  The fields to test are 
> > write cache bits in command_set_1 and cfs_enable_1.
> > And in both cases the FLUSH CACHE command ALWAYS EXISTS !
> > The test of cfs_enable_2 must only be used for ATA/ATAPI 6 drives to use 
> > FLUSH CACHE or FLUSH CACHE EXT in case of 48 bit addressing mode.
> 
> Thanks for the report. I need to go reread the spec before I can
> definitively comemnt on this.

I had started to work out a ruleset from ATA-3 forward based on the
capablities supported/enabled/supported_enabled ...

But it it is not clear how to even hand 2 or 3 bits in word 93, I have
little hope with out huge amounts of help to classify a rule set for at
least 48-bits of supported against another 48-bits of enabled, traversing
ATA-3,4,5,6,7 major releases, and about 15 minor revisions.

> > And it seems to me that when an IDE drive has a cache enabled wcache must be 
> > initialized to say so ? Or you have to do a STANDY or SLEEP before APM 
> > suspend or power off to be sure that the cache has been written to the disk.
> 
> Technically - no. In the real world its a very very good idea

They default wcache enabled.

bdflush,sync,spin,flushcache,check_error,(OMG's),STANDY/SLEEP

OMG:

The drive does random and automatic flush caches, if an error happens it
does not report. *sigh*  When APM hits it with a flush and pray the error
is from this flush, but it does not matter ... the kernel does not have
the paths to deal this issue ... so bye bye data!  Now it if the current
flush is not the owner of the error OMFG is suggested.

OMFG:

Since there is not a mechanism to assist the drive, and the drive can not
help it self ... you can expect a device lockup and fatal operations.

Stuff people really do not want to know.

> > I had a look at patch 2.4.21pre3 and the code looks the same.
> > 
> > And by the way how are powered off the IDE drives ?
> > Because a FLUSH CACHE or STANDY or SLEEP is MANDATORY before powering off the 
> > drive with cache enabled or you will enjoy lost data
> 
> IDE disagrees with itself over this but when we get a controlled power
> off we do this. The same ATA5/ATA6 problem may well be present there
> too. I will review both

Not true, the firmware knows to commit the data to platter.
If it was true you would be screaming long ago.

> Any specific opinion Andre ?

A dirty trick used to date is to pop the STANDY or SLEEP, and depend on
the drive to deal with the double dirty flush error.  If the FLUSH CACHE
was not valid, the drive would spin back up from STANDY, but not from
SLEEP, this could be a problem.  However SLEEP issued by the driver only
happens at shutdown unless it has been changed.  In the shutdown process,
each partition unmount was flushed and also once extra when the usage
count was set to zero.  Worst case was 2 flush min.

So it is a pig in a poke ...

Cheers,

Andre Hedrick
LAD Storage Consulting Group

