Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265523AbTCCPM7>; Mon, 3 Mar 2003 10:12:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbTCCPM6>; Mon, 3 Mar 2003 10:12:58 -0500
Received: from inmail.compaq.com ([161.114.1.205]:4879 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S265523AbTCCPMx>; Mon, 3 Mar 2003 10:12:53 -0500
Date: Mon, 3 Mar 2003 09:26:40 +0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: arjanv@redhat.com
Subject: Re: [PATCH] cciss: add passthrough ioctl 
Message-ID: <20030303032640.GA13102@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arjan van de Ven (arjanv@redhat.com) wrote:

> On Mon, 2003-03-03 at 05:38, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1058, 2003/03/02 20:38:36-08:00, akpm@digeo.com
> > 
> >  [PATCH] cciss: add passthrough ioctl
> >  
> >  Patch from Stephen Cameron <steve.cameron@hp.com>
> >  
> >  Add new big passthrough ioctl to allow large buffers.  Used by e.g.  onl ine
> >  array controller firmware flash utility.
> 
> WHY?
> 
> didn't 2.5 have a generic method of doing this instead of weird per
> driver ioctls ?
> 

Show me how.  There are devices that may talked to through the per 
driver passthrough interface which are not normally exposed to linux.  
E.g.  the driver presents the "logical drives" to linux.  I can imagine
that these may be talked to through some generic interface because these
devices are exposed to linux (though there is still a mapping from SCSI-3
addressing to scsi-2 addressing).

But, there are the physical drives which comprise those logical volumes
(e.g. the drives which make up a mirrored logical drive or a RAID5 set
etc.)  Those devices are not exposed to linux in any way.  The only way
to talk to them directly (for example to upgrade firmware on them) is
thourgh this interface,  Likewise for talking to the controller itself
(e.g. again to upgrade firmware for example.).

Also, we can connect external array controllers to the 
internal array controller HBA, and talk to those external 
controllers through this interface.  (for normal disk i/o
to those external controllers, nothing special is needed as
the logical drives on those controllers are magically presented
by the firmware in the HBA as just more logical volumes.)

Examples of applications which want to use this interface:

Online array configuration utiltiy.  Allows you to create new
logical drives (e.g. add new disks and actually use them, that
would be the main feature, but lots of others.  e.g.: online 
volume migraction  (turning a raid-0 logical drive into a raid1, 
or a raid 5, etc, while i/o continues.)

CIM agents, for monitoring health of physical drives, external
storage boxes, etc.

Updating firmware.

Now, you may ask the question, why the "Big" passthrough
ioctl in addition to the "regular" one that's already there.

Because, in order to flash the array controller firmware,
it's got to be done that way...

You then can ask the question why not remove the regular
passthrough ioctl than?

Because we don't want to break the apps that rely on it.

If that's not a good enough reason?  Well, it's not my
kernel, who am I to say?  Break what you will.

-- steve

