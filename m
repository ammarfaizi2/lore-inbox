Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWCVJ7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWCVJ7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWCVJ7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:59:23 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:17172 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751181AbWCVJ7W convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:59:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bXioZ5DTEnA406fSr1WgHLeWkYd9JDz813OxHWZ3KbsacP4WZ7maa7wDCenscVMQgsvKA/6w2JN7K+V1bv5N8+Un1DRv4DQ+FbSw2V3m8Wh25Aq5x2i79Z85pP8MxRA8Ll0Wi0/6x7Bx1JoTpFI48nzteyHpoJBlS4F90ZwbMUk=
Message-ID: <93564eb70603220159wd03a48du@mail.gmail.com>
Date: Wed, 22 Mar 2006 18:59:21 +0900
From: "Samuel Masham" <samuel.masham@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: libata/sata errors on ich[?]/maxtor
Cc: "Mauro Tassinari" <mtassinari@cmanet.it>, lkml@societasilluminati.org
In-Reply-To: <93564eb70603170635s4d3c8c3o@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA//gP36uv0hG9NQDAJogAp8KAAAAQAAAAoSG5sanwXkG4qxYkj76rcgEAAAAA@cmanet.it>
	 <93564eb70603162037g1856b7eey@mail.gmail.com>
	 <1142595294.28614.3.camel@localhost.localdomain>
	 <93564eb70603170635s4d3c8c3o@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Again All, Alan,

On 17/03/06, Samuel Masham <samuel.masham@gmail.com> wrote:
> Hi Alan,
>
> On 17/03/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > On Gwe, 2006-03-17 at 13:37 +0900, Samuel Masham wrote:
> > > As you can see from the printk's here this error continues and the for
> > > every access (write?) to the drive you just have to wait for a
> > > timeout.
> >
> > Eventually the drive will be offlined.
>
> really? I can test that easily enough if nothing else :)

When is it (should it) going to offline the drive? its been spitting
out these messages (about set per min?) for 4 hours at the moment with
no change bar the sector number increasing by 2 each time...

> > > ata1: command 0x35 timeout, stat 0xd1 host_stat 0x61
> > > ata1: translated ATA stat/err 0xd1/00 to SCSI SK/ASC/ASCQ 0xb/47/00
> > > ata1: status=0xd1 { Busy }
> > > SCSI disk error : host 0 channel 0 id 1 lun 0 return code = 8000002
> > > Current sd08:12: sense key Aborted Command
> > > Additional sense indicates Scsi parity error
> >
> > It thinks there is a communication (eg cable problem), at least that is
> > how it has mapped the error report. Not something I'd expect to see in
> > the SATA case on several machines so it could be some kind of setup
> > error or timing incompatibility in the driver.
>
> Well Its cheep enough to get another cable and test that.

Done. The new short cable showed no difference in behavior.

So left with the timing/setup error... Anyone with any ideas?

> > What is attached to that controller (SATA and PATA items)

as I said before there are two hardisks

> Ata Maxtor 6Y080M0  SCSI  sda 0
> Ata Maxtor 6V250F0   SCSI  sdb 0

(Remember the problem is ONLY with the second drive... and according
to others any in the 6Vxxx series shows this same issue?)

  ...and there is a cdrom drive attached via pata

(I think its on the same controller... the 6300ESB seems to do just
about everything...)

hdparm -I /dev/hda

/dev/hda:

ATAPI CD-ROM, with removable media
        Model Number:       SAMSUNG CD-ROM SN-124
        Serial Number:
        Firmware Revision:  N103
Standards:
        Likely used CD-ROM ATAPI-1
Configuration:
        DRQ response: 50us.
        Packet size: 12 bytes
Capabilities:
        LBA, IORDY(can be disabled)
        DMA: sdma0 sdma1 sdma2 mdma0 mdma1 mdma2 udma0 udma1 *udma2
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns

As Ian mentioned maxtor have release a new version of the drive
firmware ... but... The 6V250F0 drive that shows this lockup IS
running the latest drive firmware  which I discovered after a rather
long exchange with Maxtor...

I have had a bit of a look at the sata spec and would just like to
confirm that the drive is configured to disable the NCQ (as the Maxtor
support seemed to stress this point). From what i can see this is done
in the Device Configuration Overlay...

>From the spec

  4.8. Device Configuration Overlay
    4.8.1. Definition

WORD 8: Serial ATA command / feature sets supported
       This word enables configuration of command sets and feature sets.
       Bit 0 indicates whether native command queuing shall be
supported by the device. When
       set to one, the drive shall support native command queuing.
When cleared to zero, drive
       support for native command queuing shall be disabled ....

So anyone got any ideas how to read this?

Or anything else to check / try...

Samuel
