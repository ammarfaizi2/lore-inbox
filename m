Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135817AbREBUaG>; Wed, 2 May 2001 16:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135892AbREBU3s>; Wed, 2 May 2001 16:29:48 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:32988 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135213AbREBU3f>; Wed, 2 May 2001 16:29:35 -0400
Message-ID: <3AF06E94.15399CDF@redhat.com>
Date: Wed, 02 May 2001 16:31:16 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Anderson <mike.anderson@us.ibm.com>
CC: Eric.Ayers@intec-telecom-systems.com,
        James Bottomley <James.Bottomley@steeleye.com>,
        "Roets, Chris" <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi
In-Reply-To: <200105011445.KAA01117@localhost.localdomain><3AEEDFFC.409D8271@redhat.com> <15086.60620.745722.345084@gargle.gargle.HOWL> <3AF025AE.511064F3@redhat.com> <20010502102037.A19349@us.ibm.com> <3AF048FA.1B5EA399@redhat.com> <20010502115501.A19473@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Anderson wrote:
> 
> Doug,
> 
> I guess I worded my question poorly. My question was around multi-path
> devices in combination with SCSI-2 reserve vs SCSI-3 persistent reserve which
> has not always been easy, but is more difficult is you use a name space that
> can slip or can have multiple entries for the same physical device you want
> to reserve.

The software is independant on each machine, so it is entirely possible that
the same disk will be in two different name spaces one two different machines
and everything work just fine.  For example, maybe it's /dev/sdc on machine A
and /dev/sdf on machine B.  That's fine, you simply tell the software on
machine A to grab /dev/sdc and tell the software on machine B to grab /dev/sdf
and all will work properly.  Now, as to mixing SCSI-2 and SCSI-3 Persistent
Reservations on the same drive, not a chance.  The software will automatically
use the best alternative available, so it won't fall back to SCSI-2 LUN
reservations with SCSI-3 Persistent Reservations available (and if you force
it to do so, then you have no one to blame but yourself ;-)

> But here is a second try.
> 
> If this is a failover cluster then node A will need to reserve all disks in
> shareable space using sg or only a subset if node A has sync'd his sd name
> space with the other node and they both wish to do work in disjoint pools of
> disks.
> 
> In the scenario of grabbing all the disks. If sda and sdb are the same device
> than I can only reserve one of them and ensure IO only goes down through the
> one I reserver-ed otherwise I could get a reservation conflict.

Correct, if you hold a reservation on a device for which you have multiple
paths, you have to use the correct path.

> This goes
> along with your previous patch on supporting multi-path at "md" and translating this into the proper device to reserve.

The md multipath driver doesn't currently allow the proper ioctls for us to do
reservations at the md level.  We could only do them by going in and doing
reservations on /dev/sg entries behind the back of the md layer, which would
be risky at best.

> I guess it is up to the caller of
> your service to handle this case correct??

For now, yes.  And the best method to do so is to configure your failover
software to know that a device is a multipath device, only attempt to reserve
or mount one path, and fail back on the second path if the first path goes
away by issuing a bus reset on the secondary path, then reserving the
secondary path, then mounting the secondary path.  However, as you will have
lost data due to the failed writes on the primary path, I think this is of
dubious value.  Right now, as I see it, multipath and failover simply don't
mix well.  There is more work needed to make it work well.

> If this not any clearer than my last mail I will just wait to see the code
> :-).
> 
> Thanks,
> 
> -Mike
> 
> Doug Ledford [dledford@redhat.com] wrote:
> >
> >
> >
> > To:   Mike Anderson <mike.anderson@us.ibm.com>
> > cc:   Eric.Ayers@intec-telecom-systems.com, James Bottomley
> >       <James.Bottomley@steeleye.com>, "Roets, Chris"
> >       <Chris.Roets@compaq.com>, linux-kernel@vger.kernel.org,
> >       linux-scsi@vger.kernel.org
> >
> >
> >
> >
> >
> > Mike Anderson wrote:
> > >
> > > Doug,
> > >
> > > A question on clarification.
> > >
> > > Is the configuration you are testing have both FC adapters going to the
> > same
> > > port of the storage device (mutli-path) or to different ports of the
> > storage
> > > device (mulit-port)?
> > >
> > > The reason I ask is that I thought if you are using SCSI-2 reserves that
> > the
> > > reserve was on a per initiator basis. How does one know which path has
> > the
> > > reserve?
> >
> > Reservations are global in nature in that a reservation with a device will
> > block access to that device from all other initiators, including across
> > different ports on multiport devices (or else they are broken and need a
> > firmware update).
> >
> > > On a side note. I thought the GFS project had up leveled there locking /
> > fencing
> > > into a API called a locking harness to support different kinds of fencing
> > > methods. Any thoughts if this capability could be plugged into this
> > service so
> > > that users could reduce recoding depending on which fencing support they
> > > selected.
> >
> > I wouldn't know about that.
> >
> > --
> >
> >  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
> >       Please check my web site for aic7xxx updates/answers before
> >                       e-mailing me about problems
> 
> --
> Michael Anderson
> mike.anderson@us.ibm.com
> 
> IBM Linux Technology Center - Storage IO
> Phone (503) 578-4466
> Tie Line: 775-4466

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
