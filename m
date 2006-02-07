Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965080AbWBGNiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbWBGNiU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 08:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbWBGNiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 08:38:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61511 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965080AbWBGNiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 08:38:19 -0500
Date: Tue, 7 Feb 2006 14:40:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Matt Keenan <matt.keenan@btinternet.com>
Cc: Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: CD writing - related question
Message-ID: <20060207134040.GK4210@suse.de>
References: <43DEA195.1080609@tmr.com> <20060202203503.GH4215@suse.de> <43E866D2.4050103@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E866D2.4050103@btinternet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07 2006, Matt Keenan wrote:
> Jens Axboe wrote:
> 
> >On Mon, Jan 30 2006, Bill Davidsen wrote:
> > 
> >
> >>Please take this as a question to elicit information, not an invitation 
> >>for argument.
> >>
> >>In Linux currently:
> >>SCSI - liiks like SCSI
> >>USB - looks like SCSI
> >>Firewaire - looks like SCSI
> >>SATA - looks like SCSI
> >>   
> >>
> >
> >SATA will _not_ look like SCSI in the future.
> >
> > 
> >
> >>Compact flash and similar - looks like SCSI
> >>   
> >>
> >
> >? CF adapters are usually IDE, so looks like ATA.
> >
> > 
> >
> >>ATAPI - looks different unless ide-scsi used
> >>   
> >>
> >
> >But it's all besides the point, it doesn't matter what the device
> >special file looks like (if it's SCSI or not). What matters is that you
> >talk to the device the same way - and that way is currently SG_IO.
> >
> >That a device hangs off the SCSI stack because that is the way the
> >author wrote eg usb-storage is irrelevant. What matters is that you open
> >the device in question and use SG_IO to talk to it.
> >
> >Talking about the SCSI stack and ide-scsi completely misses the point.
> >
> > 
> >
> Jens,
> 
> Is there a document that clearly lists how these components (SCSI, 
> SG_IO, ATA/PI etc et al) connect together and what protocol / transports 
> they use? I suspect the problem with all these current arguments is that 
> very few people understand how this all works / connects. I think alot 
> of people equate kconfig options with how the stuff works under the hood 
> (even though a number of these config options are badly named to say the 
> least).

The main transport mechanism in the block layer is the request queue.
This is where we place work-to-do for block devices, and where they
retrieve it. There is a defined API for the kernel to queue work on the
queue, and like wise for the block device driver to pull work off the
queue (and process it, etc). So that is really the transport we use in
the end to send commands to a drive. Some of these commands are "Linux"
commands, things like "read or write sectors foo at location bar" which
typically originate from the file system. But you can also transport
other command types on that queue, such as "SCSI" commands - note that
the SCSI here has _nothing_ to do with how you happen to have things
wired inside the computer. The actual device may be ATAPI, USB,
firewire, etc. They typically have the actual _command set_ in command -
eg if you want to read something from the drive, you would send for
instance a READ_10 with the command data block filled out according to
the command specification. Again, not related to the transport! They
just share the same command definitions. How you actually send out that
"SCSI" command is a low level driver detail that we know nothing about,
nor do we care.

Given the fact that they all basically share the same command set, Linux
defines a request type called REQ_BLOCK_PC. That enables us to send
these commands directly to a given block device, just using the request
queue we use for file system requests as well. This is what gives us the
power to use SG_IO on any device type, not just SCSI devices (here
meaning devices that may or may not be SCSI transport, but at least are
managed by the SCSI stack).

So, really, how devices are connected and what the transport looks like
has very little relevance and you don't need to know that fact. You just
need to know how to open a device, then you can talk to it.

-- 
Jens Axboe

