Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSFVURU>; Sat, 22 Jun 2002 16:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316893AbSFVURS>; Sat, 22 Jun 2002 16:17:18 -0400
Received: from cubert.attheoffice.org ([216.62.240.170]:38098 "EHLO
	cubert.attheoffice.org") by vger.kernel.org with ESMTP
	id <S313190AbSFVURQ>; Sat, 22 Jun 2002 16:17:16 -0400
Subject: Re: [PATCH] /proc/scsi/map
From: Nick Bellinger <nickb@attheoffice.org>
To: Douglas Gilbert <dougg@torque.net>
Cc: Oliver Xymoron <oxymoron@waste.org>, Patrick Mochel <mochel@osdl.org>,
       sullivan <sullivan@austin.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, Kurt Garloff <garloff@suse.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Linux SCSI list <linux-scsi@vger.kernel.org>
In-Reply-To: <3D14D301.F2C8DBBE@torque.net>
References: <Pine.LNX.4.44.0206211616510.16808-100000@waste.org>
	<1024720721.6874.104.camel@subjeKt>  <3D14D301.F2C8DBBE@torque.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 22 Jun 2002 13:11:57 -0600
Message-Id: <1024773118.11690.158.camel@subjeKt>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-06-22 at 13:41, Douglas Gilbert wrote:
> > 
> > The interaction between iSCSI & driverfs does pose an interesting
> > problem:
> > 
> > On one hand I tend to lead toward the view of a physical device.
> > The reason being that there will never be a distinction as far as the
> > kernel is concerned (other than driverfs of course) that a SCSI upper
> > level driver (hopefully soon to be a personality driver) using a iSCSI
> > Initiator low-level driver is not really a physical host.
> > 
> > On the other hand there is the obvious fact that an iSCSI initiator
> > driver is not attached to a bus, and assuming /root/iSCSI.target/disk1
> > etc, is out of the question.  There is a real need for a solution to
> > handle virtual devices (as stated your previous message) that are not
> > assoicated with any physical connectors.
> > 
> > Not being too fimilar with driverfs,  what are the options with regard
> > to virtual devices as things currently stand without tainting the
> > elegant tree that is provides?
> 
> iSCSI introduces some other issues. The SCSI subsystem has
> a 4 byte target (port) identifier at the moment. However Annex A
> of the SAM-2 draft ( http://www.t10.org ) indicates that it should
> be 258 bytes for iSCSI (and 11 bytes for ieee1394). For iSCSI the
> target port identifier is a WWUI plus a 2 byte target portal group 
> tag. A WWUI looks like:
>   com.disk-vendor.diskarrays.sn.45678

Yikes, 4 bytes?  Is there any special considerations bumping up the to
the maximum for an iSCSI Initiator SCSI port name of 264 bytes?

> 
> Also the SCSI subsystem has tended to hide the the initiator's
> own identifier (this is usually id 7 on the SCSI parallel bus).
> For iSCSI it may be worthwhile to make the initiator port 
> identifier visible in driverfs.
> 

Agreed.

> There is also the case where you want a box to appear to
> the network as an iSCSI target. In this case once a iSCSI
> login is complete you might want to represent the initiator
> in the driverfs tree. For iSCSI, the initiator port identifier 
> is a WWUI plus a 6 byte "inititator session id" for a total
> of 262 bytes.
> 

Now this would be interesting,  although I am not sure how useful
this would be if the user cannot see the entire iSCSI network or if this
would not be better left to userspace.  But of course that is out of the
scope of driverfs.

> So the "target id" we put in driverfs could have one of
> these suggested formats:
>    <number>              - 0 to 1 for ATA
>    <number>              - 0 to 15 for SCSI parallel interface
>    <number>              - 24 bit number for fibre channel
>    <EUI 64+discovery_id> - ieee1394
>    <???>                 - usb (mass storage + scanner)
>    <WWUI> ":" <num>      - iSCSI   [something better than ":"?]
> 

What does the ":" <num> represent?  Would not each <WWUI> directory
contain the devices which are currently in use from that iSCSI target
node?  

> 
> We should also be moving towards 8 byte luns which in one
> descriptor format are a 4 level hierarchy (2 bytes at each
> level).

<nod>
> 
> Doug Gilbert
> 
Thanks,
		Nicholas Bellinger			

