Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262982AbTC1Nyl>; Fri, 28 Mar 2003 08:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262981AbTC1Nyl>; Fri, 28 Mar 2003 08:54:41 -0500
Received: from CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com ([24.114.72.97]:63497
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id <S262978AbTC1Nyj>; Fri, 28 Mar 2003 08:54:39 -0500
Subject: Re: hdparm and removable IDE?
From: Jeremy Jackson <jerj@coplanar.net>
To: Ron House <house@usq.edu.au>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E83BFC8.70901@usq.edu.au>
References: <Pine.LNX.3.96.1030326130640.8110B-100000@gatekeeper.tmr.com>
	 <3E83BFC8.70901@usq.edu.au>
Content-Type: text/plain
Organization: 
Message-Id: <1048860279.1615.13.camel@contact.skynet.coplanar.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Mar 2003 09:04:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-03-27 at 22:21, Ron House wrote:
> Bill Davidsen wrote:
> > On 26 Mar 2003, Alan Cox wrote:
> > 
> > 
> >>IDE hotswap at drive level is not supported by Linux. It might work ok. 

It might be better to say not supported fully, or support not complete. 
Most chipsets and their linux drivers have the ability to tristate-off
the IDE bus, making it work safely on the electrical level.  Switching
off the power to the drive has to be provided by the swap bay in
question.  I can get that for $17 CDN.  But...

> >>Providing you shut the drive down fully and flush the cache before you
> >>unregister/unplug and replug before registering the new interface
> > 
This is another piece of the puzzle.  The kernel buffer-cache can be
flushed by a simple sync command.  I've only seen the IDE write cache
flushed by the kernel on shutdown.  So the code is kinda there, but
needs to have a command to initiate it like sync does for the kernel.
Unfinished...
> > 
> > There was a bunch of discussion of this, possibly on this list, and I
> > believe that the whole cable has to be unregistered or some such. I've
> > done it with only one drive on a cable, and it seemed to work. On the
> > other hand I was only playing.

Yes, the whole cable.  You don't put more than one IDE device on one
cable, do you?  IDE TCQ may help performance in those cases (how will
IDE bus to disconnect/*reconnect*?) But hot swap will always affect both
cables.
> 
> Thanks Bill, I have read everything I can find in the archives, but am 
> still confused as to what exactly is going on. My current understanding is:
> 
> On boot, Linux examines the ide drive for physical parameters. Then, 
> mounting causes filesystem details to be loaded.

See below...
> 
> Now clearly, unmounting should undo mounting (or does the kernel keep 
> something even here in memory for 'efficiency?). So is hdparm -U enough 
> to undo the loading of physical parameters, and will hdparm -R reload them?
> 
> > I've seen some note regarding using ide-floppy for the whole drive instead
> > of the media, but I have never had the urge to try that.
> > 
> > WARNING: removable and hot swapable bays are not the same, had a client
> > prove that to herself the hard way.
> 
> This device is claimed to be 'hot-swappable'. It has circuitry on board, 
> which I presume does the necessary isolation and power down as claimed 
> in the blurb.
> 
> As an aside, I am puzzled by statements that Linux `doesn't support' 
> this. As far as I can see (and I acknowledge my relative ignorance, 
> which is why I have appealed for help here), whatever is done at boot 
> time can be done again later if conditions change, and it should be just 
> a matter of my ascertaining exactly what must be done to achieve this. 
> Or have I missed something very important (highly possible!)?

What can be done at boot... correct.  However, the BIOS does part of the
BOOT init, the linux kerenel IDE driver does some more.  So changing the
drive without rebooting through BIOS can be a problem.  The PIO modes
are the issue here.  Perhaps a script can do hdparm -X somehow, but
nobody is certain if it will be reliable, because who knows what the
bios does.  With LinuxBIOS there is hope though.

IMHO the ide driver is a real mess.  statically allocated structures,
because the kernel command line parameters have to be read early because
they're so wierd, no wonder the hdparm -U / -R stuff is busted.  It
should take the PCI ID of the interface, not the io ports.  Fixing this
is on my hit list, in about a month.

Regards,

Jeremy
-- 
Jeremy Jackson <jerj@coplanar.net>

