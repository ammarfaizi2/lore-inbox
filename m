Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317312AbSFREd7>; Tue, 18 Jun 2002 00:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317310AbSFREd6>; Tue, 18 Jun 2002 00:33:58 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:14343 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S317309AbSFREd4>;
	Tue, 18 Jun 2002 00:33:56 -0400
Message-ID: <3D0EB7D0.FDB66BAA@torque.net>
Date: Tue, 18 Jun 2002 00:32:16 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>
CC: Kurt Garloff <kurt@garloff.de>,
       Linux SCSI list <linux-scsi@vger.kernel.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: /proc/scsi/map
References: <20020615133606.GC11016@gum01m.etpnet.phys.tue.nl> <20020617180818.C30391@redhat.com> <20020617230648.GA3448@gum01m.etpnet.phys.tue.nl> <20020617224046.A6590@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:
> 
> On Tue, Jun 18, 2002 at 01:06:48AM +0200, Kurt Garloff wrote:
> > Hi Doug,
> >
> > On Mon, Jun 17, 2002 at 06:08:18PM -0400, Doug Ledford wrote:
> > > On Sat, Jun 15, 2002 at 03:36:06PM +0200, Kurt Garloff wrote:
> > > > Life would be easier if the scsi subsystem would just report which SCSI
> > > > device (uniquely identified by the controller,bus,target,unit tuple) belongs
> > > > to which high-level device. The information is available in the kernel.
> > >
> > > Umm, this patently fails to meet the criteria you posted of "stable device
> > > name".  Adding a controller to a system is just as likely to blow this
> > > naming scheme to hell as it is to blow the traditional linux /dev/sd?
> > > scheme.  IOW, even though the /proc/scsi/map file looks nice and usefull,
> > > it fails to solve the very problem you are trying to solve.
> >
> > In case you just add controllers, you just need to make sure you get them the
> > same numbers again. A solution for this exists already:
> > * For a kernel where SCSI low-level drivers are loaded as modules,
> >   you just need to keep the order constant
> > * For compiled in SCSI drivers, use scsihosts=
> 
> No, this is not true.  If you add a new controller (for some new disks in
> a new external enclosure or whatever), and that controller uses the same
> driver as other controller(s) in your system, then you have no guarantee
> of order.  For example, adding a 4th aic7xxx controller to your system
> might or might not place the new controller at the end of the list
> depending on PCI scan order, etc.  There simply is *no* guarantee here of
> any consistent naming, so don't bother trying to claim there is.

It only been two days and it seems appropriate to refer
to Martin Petersen's summation of persistent naming issues again:
http://marc.theaimsgroup.com/?l=linux-scsi&m=101840990116069&w=2


As for "scsihosts" its current syntax is:
 scsihosts=aic7xxx:sym53c8xx::aic7xxx

This could be extended to
  scsihosts=aic7xxx[pci=00:0c.0]:sym53c8xx::aic7xxx
and if "pci=" was assumed to be the default then this
would have the same effect as:
  scsihosts=[00:0c.0]:sym53c8xx::aic7xxx
assuming there was a aic7xxx controlled HBA at that PCI slot.

No consistent persistence here, just a little more precision.

> Now don't get me wrong, I'm not saying the patch isn't usefull, but the
> patch doesn't provide *any* guarantee of consistent device naming and so
> using that as a reason to put the patch into the mainstream kernel is
> utter crap.  Go ahead and make your case for why it should be in the
> kernel, but don't use reasons that aren't correct.
> 
> > But actually, the patch is not meant to be the holy grail of persistent
> > device naming. But it enables userspace tools to collect information
> > * reliably
> >   (fails so far due to possible open() failures with unknown
> >    relation to the corresponding sg device (which could be opened))
> 
> This can be done without your patch (the mapping from /dev/sg to /dev/sd?
> or /dev/st? or /dev/scd? or whatever is not impossible from user space
> without your patch, it just requires a user space tool to open the files
> and start comparing host/bus/id/lun combinations from dev file to dev
> file).
> 
> > * without too much trouble
> 
> This part is true enough, it is easier to read the map file than to
> program the information retrieval I mentioned above.

You can say that again. Joerg Schilling is still some way
from getting it right in cdrecord, SANE still has problems
in this area (and I rewrote the scsi scanning code). Kurt
and I have a fair amount of experience in this particular 
area. There are lots of gotchas ...


Kurt's implementation is worthy of note as well. When I have
pondered this problem I just wanted to poke each sg kdev_t into
the corresponding Scsi_Device. People objected that this was
a layering violation. Kurt has added a new upper level callback
find_kdev() which is cleaner. Based on this new callback we
could add a new mid level ioctl that yielded the principal
(k)dev_t (i.e. sd, st or sr) and the generic one. That would
make life easier for cdrecord and cdparanoia (and sg_utils). 
As for SANE, by looking at /proc/scsi/map it could only analyse 
sg devices that where "printer" or "processor" device types.

Doug Gilbert

