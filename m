Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135281AbRDRT7M>; Wed, 18 Apr 2001 15:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135277AbRDRT7C>; Wed, 18 Apr 2001 15:59:02 -0400
Received: from pop.gmx.net ([194.221.183.20]:16094 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S135276AbRDRT6y>;
	Wed, 18 Apr 2001 15:58:54 -0400
Message-ID: <3ADDF370.FAEF5117@gmx.at>
Date: Wed, 18 Apr 2001 22:05:04 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Paul Flinders <P.Flinders@ftel.co.uk>, linux-kernel@vger.kernel.org,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Help with Fasttrack/100 Raid on Linux
In-Reply-To: <Pine.LNX.4.10.10104171921300.23608-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> On Tue, 17 Apr 2001, Wilfried Weissmann wrote:
> 
> > Andre Hedrick wrote:
> > >
> > > Wilfried,
> > >
> > > Why a module?
> >
> > The idea behind that was that, if it is a seperate module, then it would be easier to maintain for
> > me. I am a guy that always needs the newest and greatest, so I expected that I would have to port my
> > stuff to newer kernels frequently. (I started the HPT-RAID0 alone without much knowledge about the
> > kernel.)
> >
> > > Why not have the detection and flags that hook the md driver for linux and
> > > use linux's software raid?
[snip]

>
> Hello Wilfried,

Hello Andre,

You completely confused me. Attemts to get an idea of what is going on
are inline.

> 
> The really easy thing to do is to come up with the personality rules you
> want to se and let me create the API.  I can make drives talk, listen,
> dance, spin, flip, etc.....
> 
> Raid 0 and Raid 1 are cakewalks, if you have the right tools.
> These will be around in 2.5.
> 
> All you need to do is tell me what you want the subsystem to do.
> When you want it done and the observer's view of the operations.
> 
> I can do things like threaded-parallel PRD building for DMA with the tap
> of a keystroke of two.  I can commit the purfect lie in storage and
> destroke a drive to the view of the OS and then do switch-buffer PRD
> building.  If you want it on 2,3,4,N drives I can do it with fast simple
> legal trick code.
> 
> During INIT process I can protect the drive in ways you have never
> considered.  I can access the whole drive even of the OS only knows only a
> portion of the real capacity.  And I do not need silly and foolosh means
> like "bread".  I tell it, "Hey dude, we are running under a lie.  Go sneak
> off to the head or tail of the drive and get me that raid-voodoo-bios-os
> communication transport layer, and do it ins DMA modes, NOW!"

"voodoo" would be the sector where the raid configuration is stored
then, right!? Maybe I did not understand you properly...

I am really trying to understand what you want to do. From what I have
seen this would go into kernel 2.5 first. For now there appears to be no
information or this-would-be-new-in-2.5 list available of new
development kernel so far, so I have to use my fantasy even more.
So you want to introduce a new layer between the MD driver and the ATA
HDs of IDE-RAIDs. This code would be placed in the ide-chipset driver.
Configuration happens at system startup after the chipset is in service.
There you read the config-sector (e.g. sector 9 on HPTs) of the disks
and datafill your configuration tables. Plus you start one (or more) MD
device with the according raid level(s). The MD then accesses your layer
instead of talking directly to the disk driver, and the requests are
mapped (buffer_head->rsector+10 with the HPTs) as the bios would do it.
But the raid is still handled by MD. So you can completely reuse the
raid code for all that.
Pardon me, but please tell me that I am wrong, because this sounds odd
to me! <:(

Talking about the API... These should be the basic steps that we need to
do (unordered, this is just brainstorming):

*) device_size_calculation() should use a callback of the raid level to
get the device size. Or the code should be completly moved over to the
<raid level>_run()'s.

*) Hide/unhide disks from the userland (this is just a cosmetic issue).

*) Shift sectors and shrink capacity of disks so that the existing raid
levels can access the disks according to the ata-raid layout.

*) Get the configuration sector from disk. Analyse the configuration and
setup disks and md-devices.

*) All raid pers. must be able to handle I/O that requests sectors from
more than only one disk.

*) Partitioned raid devices must be handled somehow.

> 
> I do not have the desire to do personality tables, but I can.
> 
> We will not need any new majors because there is plenty of space in the
> ones we have, and 128 minors/channel is enough to do anything.
> 
> If you want to do your module cool, but I promise you it will break in 2.5
> and you will not know for months what hit you.  I personally would like to
> avoid this issue of wreckin work.  Second, if you think changes to the
> driver made by you have a chance in hell to make the kernel, I am not
> allowed to fixed the driver today to address the needs and correct current
> issues and ones coming down the pipe.
> 
> With about 96% of all linux boxes in the world dependent on some form of
> ATA/ATAPI, Linus and Alan are very sensitive to even the sligthest change.

I would avoid to change anything there, but do a raid personality...
Well, we are back at our your solution vs. my raid personality
discussion again!

> 
> Cheers,
> 
> Andre Hedrick

bye,
Wilfried

> Linux ATA Development
> ASL Kernel Development
> -----------------------------------------------------------------------------
> ASL, Inc.                                     Toll free: 1-877-ASL-3535
> 1757 Houret Court                             Fax: 1-408-941-2071
> Milpitas, CA 95035                            Web: www.aslab.com

-- 
Wilfried Weissmann ( mailto:Wilfried.Weissmann@gmx.at )
Mobile: +43 676 9444465
