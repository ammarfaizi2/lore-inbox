Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288308AbSAHUoq>; Tue, 8 Jan 2002 15:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288302AbSAHUon>; Tue, 8 Jan 2002 15:44:43 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:41870
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288301AbSAHUo3>; Tue, 8 Jan 2002 15:44:29 -0500
Message-Id: <200201082029.g08KTAA28497@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        usenet2001-12@lina.inka.de, linux-kernel@vger.kernel.org
Subject: Re: Two hdds on one channel - why so slow?
Date: Tue, 8 Jan 2002 07:41:42 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200201041740.LAA07840@tomcat.admin.navo.hpc.mil>
In-Reply-To: <200201041740.LAA07840@tomcat.admin.navo.hpc.mil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 January 2002 12:40 pm, Jesse Pollard wrote:
> ---------  Received message begins Here  ---------
>
> > In article <200201041402.IAA80257@tomcat.admin.navo.hpc.mil> you wrote:
> > > In my experience, SCSI is not cost effective for systems with a single
> > > disk. As soon as you go to 4 or more disks, the throughput of SCSI
> > > takes over unless you are expanding a pre-existing workstation
> > > configuration.
> >
> > IDE Scales fine to 8 Channels (aka 8 Drives). Anything more than 8 Drives
> > on an HBA is insane anyway.
> >
> > I love the FC-to-IDE(8) Solution. You get Hardware Raid with 8 Channels,
> > each drive a didicated channel, thats much more reliable than usual 2 or
> > 3 channel SCSI Configurations.
> >
> > Do you realy run more than say 10 hard disk devices on a single SCSI Bus,
> > ever?
>
> Only place I've seen that (not sure it was true SCSI though) was on a
> Cray file server - each target (4) was itself a raid 5, with 5 transports.
> That would be total of 20 disks. The four targets were striped together in
> software to form a single filesystem. I think that was our first over 300GB
> filesystem (several years ago). Now we are using 1 TB to 5TB filesystems
> with nearly 5 million files each.

A couple years back I played with a 20-way SCSI software RAID, which was 
actually dual qlogic fiber channel, 10 drives per controller.  That was done 
for throughput reasons (attempting to capture uncompressed HDTV signals to 
disk, needed something like 160 megabytes per second, which of course 
required a 66 mhz 64 bit PCI bus...)  It broke the kernel in more than one 
place, by the way.  Long since fixed, I believe.  (Try it and see. :)

More recently I've played around a little with many-way IDE software RAID, 
which is much more fun.  The hard part is really getting enough power for all 
the drives (Ever seen an enormous tower case with three power supplies 
mounted in it, AND a lot of splitters?)  The goal was to see how cheaply we 
could get to 10 terabytes of storage, so we didn't really care about 
throughput there (the output of the cluster was the gigabit ethernet uplink 
on the switch, and the output of each node was a pair of bonded 100baseT 
ethernet adapters).  So we were willing to hanging two drives off each IDE 
controller (master and slave), which halved the throughput but that wasn't 
the bottleneck anyway.  (Dual 100baseT is 22 megabytes per second, a SINGLE 
modern IDE drive can swamp that.  And the raid could max out the PCI bus 
pretty easily with one drive per controller...)

You can cheaply get generic IDE expansion cards with at least 2 controllers 
on each card (4 drives per card), and you can get a board with onboard video, 
at least one onboard NIC (we had two onboard, that's why we did the bonding), 
two onboard IDE controllers, and 4 free PCI slots.  That's 4 drives onboard, 
16 through PCI, total of 20 drives.  (You need to tweak the linux kernel to 
allow that many IDE controllers.  PCI plug and pray is your friend here...)

The goal was to see how cheaply we could get to 10 terabytes of storage.  We 
didn't do the whole cluster, but I think we determined we only needed 4 or 5 
nodes to do it.  Then the dot-com crash hit and that company's business model 
changed, project got shelved...

But if you think about serving MPEG 4 video streams through simple TCP/IP 
(DVD quality's only about 150 kilobytes per second with mpeg 4, add in 5 megs 
of buffer at the client side and who cares about latency...) Really big IDE 
software RAID systems are quite nice. :)

Rob
