Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314634AbSFQQLO>; Mon, 17 Jun 2002 12:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314690AbSFQQLN>; Mon, 17 Jun 2002 12:11:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:7069 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314634AbSFQQLM>;
	Mon, 17 Jun 2002 12:11:12 -0400
Date: Mon, 17 Jun 2002 09:09:58 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Oliver Neukum <oliver@neukum.name>, David Brownell <david-b@pacbell.net>,
       Andries.Brouwer@cwi.nl, garloff@suse.de, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, sancho@dauskardt.de,
       linux-usb-devel@lists.sourceforge.net,
       linux1394-devel@lists.sourceforge.net, dougg@torque.net
Subject: Re: [linux-usb-devel] Re: /proc/scsi/map
Message-ID: <20020617090958.A19843@eng2.beaverton.ibm.com>
References: <oliver@neukum.name> <200206171454.g5HEsu802593@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200206171454.g5HEsu802593@localhost.localdomain>; from James.Bottomley@SteelEye.com on Mon, Jun 17, 2002 at 09:54:56AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 09:54:56AM -0500, James Bottomley wrote:
> 
> But, in SCSI, you can't.  Just for a simple device showing up as a SCSI disc 
> (that's a real SCSI disc, attached say by parallel connectors), there are 
> several potential ways to get a unique ID.  No one way works for all such 
> disks, that is the nub of the problem.

I agree it would be nice to get the ID via user space, but it is not that
hard to get the ID, and trying the various SCSI INQUIRY pages that supply 
the ID is not complicated. Putting ID code (including hotplug hooks) into
user space is probably more complex. I would also like the ID at scan time
for multi-path use so we don't have to allocate extraneous Scsi_Devices,
and later coalesce them.

Mike Sullivan's driverfs patch for SCSI (without any device naming) includes
code to look up an ID, and store the ID in driverfs; he was working on
a patch for 2.5.21.

FYI the various SCSI ID pages and such are described in the SCSI primaray
command for example the following:

ftp://ftp.t10.org/t10/drafts/spc3/spc3r07.pdf

Near page 316 (section 8.6) are descriptions for INQUIRY VPD page 0x80
and 0x83.

> but the only piece that has disc specific logic is sd.  The lld is specific to 
> the host adapter card (not shown), not the real device, so it is not the right 
> element to probe for an ID.

Any SCSI device can return an ID (i.e. INQUIRY VPD page 0x80 or 0x83),
so the logic need not be in sd. I don't know how removable media should
be handled (not a SCSI device being added/removed from the system), for
tape this is probably not an issue.

> 
> Here, the usb-storage driver does know about the real device (and already has 
> a huge exception table), so it has enough knowledge to probe for an identifier.

> 
> The thing I think is a bad idea is having to code the logic to look up a 
> unique identifier (plus all the exceptions) in sd.  But for the pure SCSI 
> stack, there's nowhere else to place it.  Even if you get usb-storage to 
> supply an API for providing the id, it will be one of the few llds that can 
> retrieve this, so it will become just another exception sd has to cope with.
> 
> James

usb-storage could emulate VPD page 0x83 to return the GID, and that could
then be used by the mid-layer or a user level program to extract an ID.

-- Patrick Mansfield
