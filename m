Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312446AbSCTLwA>; Wed, 20 Mar 2002 06:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312449AbSCTLvu>; Wed, 20 Mar 2002 06:51:50 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:45316
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S312446AbSCTLvf>; Wed, 20 Mar 2002 06:51:35 -0500
Date: Wed, 20 Mar 2002 03:51:20 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Dan Hopper <ku4nf@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Promise 20265 IDE chip gets detected in wrong order 2.4.x
In-Reply-To: <3C987200.4020505@evision-ventures.com>
Message-ID: <Pine.LNX.4.10.10203200333500.525-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Martin Dalecki wrote:

> Andre Hedrick wrote:
> > Hi Martin,
> > 
> > You kind of missed a few points and issues, so I would like to offer you
> > some help.
> 
> I don't think so. It is the order on the devices on the PCI bus
> which matters for the detection order, since linux is just going
> over the devices in the same order they are reported by the BIOS supplied
> PCI tables, which are most propably manipulated by the on board BIOS-es
> of the Fake-RAID controllers.

Unlikely, look at the classic ABIT case in the original BP6.  It has an
exclusive way of preventing the real HBA's from ever being used if it is
assumed to be a valid INT19 (virtual HBA).  This is present on the TYAN
251x series.  All of the OEM NB/SB manufacturers specify the ordering of
their devices.  It is the random board manufacturers who spoof the OS and
force the need to play hunt and peck for granting access to the primary
hwgroup pair.  Again, if Linux could support EDDS 2.0 or high much of
these issues would go away.

> > This is easily address by applying the exclusive rule of the seeking the
> > SouthBridge device.  Once this is found, one generally assumes this to be
> > the PCI_BASE_CLASS_BRIDGE + PCI_CLASS_BRIDGE_ISA or 601h.  It will
> > (should future unknown) have  a function number of 0 "zero".  Once the
> > location of the SB has been determined one seeks for function 1 "one".
> > Once SB + func 1 is found, tests for device class PCI_BASE_CLASS_STORAGE +
> > PCI_CLASS_STORAGE_IDE or 101h.
> 
> Yes this would actually make sense. However nowadays
> I would rather love to encourage everybody to just use partition
> labels for mount point discrimination instead of plain device
> names:

In theory maybe, in practice it fails (at the current time).
Real world has shown the act of updating to a kernel which is not approved
by the OEM distro general breaks on labels.  Now apply this to the upgrade
path between distro release which you preserve partition in the process.
Labels fail totally in that case, since they are not set or updated.

> Look for example:
> 
> LABEL=/                 /                       ext3    defaults        1 1
> LABEL=/boot             /boot                   ext3    defaults        1 2
> 
> Becouse there are some other occasions where the kernel will have
> to iterate over PCI devices (suspend/resume comes to mind) and where
> a different iteration order on behalf of the IDE subsystem may/could
> introduce subtile missinteractions.
> 
> Dan using disk labels would be the most convenient solutions to
> your problem anyway ;-).
> 
> However if I think about it again - I'm not at all sure whatever
> the root device can be recognized by a label? If not - the grock
> partitions code has to be extendid accordingly!

Yes please to ponder this again and hit it w/ LILO and see the fun.
However, GRUB may survive better, not sure about so I will ponder GRUB.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

> > Unless otherwise specifed this shall always be the INT13 device; however,
> > one does not exclude SCSI/RAID or any other device class having rights to
> > INT13 hooks.  Since linux does not support these type of BIOS services the
> > fore mentioned is the preferred ruleset.
> > 
> > This would have been applied to 2.5 but you are now free to do so
> > yourself.  As for all other booting devices under INT19 calls to load
> > option roms, which in the past have been considered valid, permit
> > ATA-HBA's to gain access to the priviledge hwgroup pair ide0/ide1.
> > 
> > This is all a design of detection ordering to override the nasty tricks
> > played by chipset venders attempting to do have their secondary host or
> > hba to be the preferred hardware to use.
> > 
> > The history of this problem is a result of HBA's coming to market before
> > system chipset.  Also people who have very good and useful systems who
> > want to boost their storage performance tend to drift to the HBA world.
> > Others who load the system up with every toy in the market place run out
> > of interrupts early (past w/ ISA physical slots), they find it useful and
> > practical to disable the legacy host to gain back an additional interrupt
> > but not loose the total storage device count before the addition of the
> > HBA.
> > 
> > Cheers,
> > 
> > Andre Hedrick
> > LAD Storage Consulting Group
> > 
> > On Wed, 20 Mar 2002, Martin Dalecki wrote:
> > 
> > 
> >>Dan Hopper wrote:
> >>
> >>>Andre Hedrick <andre@linux-ide.org> remarked:
> >>>
> >>>
> >>>>append="ide=reverse"
> >>>
> >>>
> >>>You're right, this works, too, and is a lot easier to remember than
> >>>the override I used before.  
> >>>
> >>>
> >>>
> >>>>Various Mainboard manufacturers do things to place the FAKE-RAID in front
> >>>>of the the legacy south bridge.  This is classic Windows spoofing.
> >>>>
> >>>>
> >>>>
> >>>>>PDC20265: IDE controller on PCI bus 00 dev 68
> >>>>>VP_IDE: IDE controller on PCI bus 00 dev 89
> >>>>
> >>>So, the I/O port assignments don't in fact properly determine the
> >>>assignment order?  I'm gathering from what you're saying that the
> >>>current behavior is related to PCI bus location?
> >>
> >>Precisely: The PCI bus detection order matters.
> 

