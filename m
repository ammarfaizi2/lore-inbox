Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314485AbSDRXEB>; Thu, 18 Apr 2002 19:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314486AbSDRXEA>; Thu, 18 Apr 2002 19:04:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:60667 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314485AbSDRXD7>;
	Thu, 18 Apr 2002 19:03:59 -0400
Importance: Normal
Sensitivity: 
Subject: Re: Bio pool & scsi scatter gather pool usage
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFCF00F1A4.2665039D-ON85256B9F.006B755C@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Thu, 18 Apr 2002 17:58:16 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.9a |January 28, 2002) at
 04/18/2002 07:03:52 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andew Morton wrote:
> Mark Peloquin wrote:
> >
> >  ...
> > > Tell me why this won't work?
> >
> > This would require the BIO assembly code to make at least one
> > call to find the current permissible BIO size at offset xyzzy.
> > Depending on the actual IO size many foo_max_bytes calls may
> > be required. Envision the LVM or RAID case where physical
> > extents or chunks sizes can be as small as 8Kb I believe. For
> > a 64Kb IO, its conceivable that 9 calls to foo_max_bytes may
> > be required to package that IO into permissibly sized BIOs.

> True.  But probably the common case is not as bad as that, and
> these repeated calls are probably still cheaper than allocating
> and populating the redundant top-level BIO.

Perhaps, but calls are expensive. Repeated calls down stacked block
devices will add up. In only the most unusually cases will there
be a need to allocate more than one top-level BIO. So the savings
for most cases requiring splitting will just be a single BIO. The
other BIOs will still need to be allocated and populated, but it
would just happen outside the block devices. The savings of doing
repeated calls vs allocating a single BIO is not obvious to me.

> Also, the top-level code can be cache-friendly.  The bad way
> to write it would be to do:
>
> while (more to send) {
>  maxbytes = bio_max_bytes(block);
>  build_and_send_a_bio(block, maxbytes);
>  block += maxbytes / whatever;
> }

> That creates long code paths and L1 cache thrashing.  Kernel
> tends to do that rather a lot in the IO paths.

> The good way is:
>  int maxbytes[something];
>  int i = 0;
>  while (more_to_send) {
>   maxbytes[i] = bio_max_bytes(block);
>   block += maxbytes[i++] / whatever;
>  }
>  i = 0;
>  while (more_to_send) {
>   build_and_send_a_bio(block, maxbytes[i]);
>   block += maxbytes[i++] / whatever;
>  }

> if you get my drift.  This way the computational costs of
> the second and succeeding bio_max_bytes() calls are very
> small.

Yup.

> One thing which concerns me about the whole scheme at
> present is that the uncommon case (volume managers, RAID,
> etc) will end up penalising the common case - boring
> old ext2 on boring old IDE/SCSI.

Yes it would.

> Right now, BIO_MAX_SECTORS is only 64k, and IDE can
> take twice that.  I'm not sure what the largest
> request size is for SCSI - certainly 128k.

In 2.5.7, Jens allows the BIO vectors to hold upto 256
pages, so it would seem that larger than 64k IOs are
planned.

> Let's not create any designed-in limitations at this
> stage of the game.

Not really trying to create any limitations, just trying
to balance what I think could be a performance concern.

