Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285092AbRLQLpU>; Mon, 17 Dec 2001 06:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285096AbRLQLpL>; Mon, 17 Dec 2001 06:45:11 -0500
Received: from mailgw2a.lmco.com ([192.91.147.7]:57866 "EHLO mailgw2a.lmco.com")
	by vger.kernel.org with ESMTP id <S285092AbRLQLo5>;
	Mon, 17 Dec 2001 06:44:57 -0500
Content-return: allowed
Date: Mon, 17 Dec 2001 06:43:49 -0500
From: "Needham, Douglas" <douglas.needham@lmco.com>
Subject: RE: kernel performance issues 2.4.7 -> 2.4.17-pre8
To: "'Andre Hedrick'" <andre@linux-ide.org>
Cc: "'Andrew Morton'" <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Message-id: <1B7FCD9C07D3D4118FC500508BDF42E80457DFBA@emss09m02.ems.lmco.com>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre, 

	Thanks to your note I began looking at my IDE driver to determine
which one I was using. My hardware uses the VIA chipset, and it was not
compiled into my kernels. Once I compiled in the support for VIA I began
seeing the performance go back up.

Thanks for the help from everyone. 


Doug 


-----Original Message-----
From: Andre Hedrick [mailto:andre@linux-ide.org]
Sent: Friday, December 14, 2001 2:25 PM
To: Needham, Douglas
Cc: 'Andrew Morton'; linux-kernel@vger.kernel.org
Subject: RE: kernel performance issues 2.4.7 -> 2.4.17-pre8



Douglas,

What is really needed is for a correct packetized ACB to be adopted.
Second is if you would allow the driver to correctly tune the hardware,
you could see things like this:

Device: Maxtor 5T020H2 Serial Number: T2J0HC0C
LBA 0 DMA Read Test                      = 68.67 MB/Sec (3.64 Seconds)
Outer Diameter Sequential DMA Read Test  = 36.68 MB/Sec (6.82 Seconds)
Inner Diameter Sequential DMA Read Test  = 21.37 MB/Sec (11.70 Seconds)
LBA 1 DMA Write Test                     = 65.68 MB/Sec (3.81 Seconds)
Outer Diameter Sequential DMA Write Test = 36.91 MB/Sec (6.77 Seconds)
Inner Diameter Sequential DMA Write Test = 21.45 MB/Sec (11.66 Seconds)


Wrote 19073 Meg / 39062400 blockse 0 Meg / 0 blocks
Device length: 20000000000 Bytes / 19073 Meg / 18 Gig
Total Diameter Sequential Pattern Write Test = 30.29 MB/Sec (629.67 Seconds)
Read 19073Meg (39062400 blocks)
Device length: 19999948800 Bytes / 19073 Meg / 18 Gig
Total Diameter Sequential Pattern Read Test  = 23.50 MB/Sec (811.75 Seconds)
Device passed CLEAN!

Maybe this kind of data-transport integrity checking means something to
you, but I have found that most do not care about making this a standard
for storage development.

Next "hdparm -X66 -d1 -u1 -m16 -c3 /dev/hda" is silly.

Driver will setup and time correctly -X66 -d1 -m16 -c0 -u0.
Unless you have an old ATA1/2 drive "-c3" is meaningless.
-c describes the data_io register

drive->no_io_32bit = id->dword_io ? 1 : 0;

Just maybe if I could put some consistance in the driver ..

static ide_startstop_t drive_cmd_intr (ide_drive_t *drive)
{
<snip>
                drive->io_32bit = 0;
                ide_input_data(drive, &args[4], args[3] * SECTOR_WORDS);
                drive->io_32bit = io_32bit;
<snip>
}

Which is an pio-out-data of one sector == read_intr of one sector, we just
might get a more stable platform.

I was hoping to be some what quiet, but now it looks like the good old
grenade launch is going to be needed -- and this is not productive -- just
informative because people grind their heals in deeper and refuse to allow
corrections.

Maybe you should try the preferred driver of mine that one day may be
adopted.

Regards,

Andre Hedrick
CEO/President, LAD Storage Consulting Group
Linux ATA Development
Linux Disk Certification Project


On Fri, 14 Dec 2001, Needham, Douglas wrote:

> Thanks for the feed back. 
> Here are my latest results re-running the same tests with the following
> enhancements. 
> I also added .17-rc1.
> 
> I did two things :
> the first was :
> 
> 	echo 70 64 64 256 30000 3000 80 0 0 > /proc/sys/vm/bdflush
> the second was : 
> 	hdparm -X66 -d1 -u1 -m16 -c3 /dev/hda
> 	following the document at :
> http://linux.oreillynet.com/lpt/a//linux/2000/06/29/hdparm.html
> 
> I did see some performance gains, but
> 
> My new questions are : 
> 	Do we(people running Linux) need to do more work on tuning the
> hardware in the current kernels? 
> 
> >Note: before running the hdparm test on hda1, you should mount a 4k
> blocksize
> >filesystem onto hda1. 
>       Where could I find more info on how to do this? Wouldn't changing
the
> blocksize of my file system kill my existing data? Or do I just need to
> create some filesystem on the device that has a 4k blocksize? I hate to
ask
> a dumb question, but I had not heard of this being done before. 
> 
> Thanks, 
> 
> Doug 
> 
> 
> 
> 
> 
> -----Original Message-----
> From: Andrew Morton [mailto:akpm@zip.com.au]
> Sent: Thursday, December 13, 2001 2:50 PM
> To: Needham, Douglas
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: kernel performance issues 2.4.7 -> 2.4.17-pre8
> 
> 
> "Needham, Douglas" wrote:
> > 
> > ...
> >         Overall I discovered that the Red Hat modified kernel beat the
> stock
> > kernel hands down in throughput.  Both the base Red Hat 7.2 kernel and
the
> > 7.2 update kernel (2.4.7-9, 2.4.9-13 respectively) had far better
> throughput
> > than the .10, .15, .14, .16, and .17-pre8 kernels.
> > 
> 
> The 60% drop in bonnie throughput going from 2.4.9 to 2.4.10 indicates
that
> something strange has happened.  This hasn't been observed by others.
> 
> My suspicion would be that something is wrong with the IDE tuning in your
> builds of later kernels.  Please check this with `hdparm -t /dev/hda1' -
> make
> sure that these numbers are consistent across kernel versions before you
> even start.
> 
> Note: before running the hdparm test on hda1, you should mount a 4k
> blocksize
> filesystem onto hda1.  This changes the softblocksize for the device from
1k
> to 4k and, for some devices, speeds up access to the block device by
> a factor of thirty.  This is some bizarro kooky brokenness which the
> 2.4.10 patch exposed and I'm still investigating...
> 
> For dbench, errr, just don't bother using it, unless you're using
> a large number of clients - 64 or more.  At lower client numbers,
> throughput is enormously dependent upon tiny changes in kernel
> behaviour.   Try this:
> 
> 	echo 70 64 64 256 30000 3000 80 0 0 > /proc/sys/vm/bdflush
> 
> and see the numbers go up greatly.
> 
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


