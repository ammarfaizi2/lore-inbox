Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271722AbRHUPhb>; Tue, 21 Aug 2001 11:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271723AbRHUPhV>; Tue, 21 Aug 2001 11:37:21 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:53260 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S271722AbRHUPhN> convert rfc822-to-8bit; Tue, 21 Aug 2001 11:37:13 -0400
Date: Tue, 21 Aug 2001 17:34:36 +0200 (CEST)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Cliff Albert <cliff@oisec.net>, <linux-kernel@vger.kernel.org>
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo 
In-Reply-To: <200108210036.f7L0amY45964@aslan.scsiguy.com>
Message-ID: <20010821170410.W1490-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Justin,

The Linux SCSI device quirks table can be found in scsi_scan.c. :-)

It does not allow to limit tagged command queue depth, but only to disable
this feature using the BLIST_NOTQ flag. Adding an upper limit seems
feasible without too large a change. Low level drivers (SIMs) could then
access this information when called for select_queue_depth(), or the SCSI
layer could just lowered the value to this upper limit for each device.

And for the filling of such a new quirks table, you might just get the
data for the FreeBSD cam_xpt.c file you know very well. :-)

Historically, the tagged command queueing feature has been kind of
nightmare under Linux and low-level drivers that supported this feature
used to default to a safe value for the command queue depth.
The ncr53c8xx and sym53c8xx drivers defaulted and still default to 8
commands per LUN. This has been proven to work reasonnably even with well
known broken firmware. Some other drivers just defaulted to no tag.

Without some handling of appropriate quirks per device regarding tagged
command queue depth, it is not reasonnable, in my opinion, to default to
something larger that 8 commands per lun under current Linux.

My feeling, and somehow experience, is that not reusing tag numbers too
quickly prevents from triggerring races in broken firmwares. This has been
the reason I implemented a circular tag number allocation sheme in the
ncr53c8xx and sym53c8xx drivers and this seemed to have had the expected
effects.

Regards,
  Gérard.

PS1: By the way, I do agree with your analysis of the problem.
PS2: Thanks a lot for all your efforts for SCSI in free O/Ses.

On Mon, 20 Aug 2001, Justin T. Gibbs wrote:

> >> IIRC, the problem has to do with the state of the write cache in the drive.
> >> The cache will be in a different state after power-on as compared to
> >> after some amount of activity.
> >
> >Well i still suspect the broken firmware of the disk isn't the only cause of
> >these errors
>
> Perhaps.
>
> One thing to keep in mind however is that, although the messages may
> *look* the same, they very rarely are.  If you don't have verbose turned
> on, all transaction timeouts, regardless of the reason, look the same.
> It is only by analyzing the verbose output that a cause for a particular
> problem can be found.  In the case of your system, we always timeout
> with the bus idle with several pending transaction, we can always abort
> a transaction successfully (i.e. the bus is not dead, neither is the
> target), its just that some transactions never complete.  These are
> exactly the symptoms of the bogus FireBall ST firmware on your drive.
>
> Another thing to keep in mind...  The newer driver defaults to using
> tagged queing and attempts to issue the maximum number of concurrent
> transactions possible to each device.  The old driver, until fairly
> recently, defaulted to leaving tagged queuing disabled, and if enabled,
> only queued 8 transactions.  So, the new aic7xxx driver often places
> a much higher load on your SCSI setup than the old one did.  I think
> this has something to do with the large number of reports.
>
> This doesn't mean that there haven't been, or continue to be  bugs.
> After all this is software, but I am trying to do my best to make
> it work. 8-)
>
> --
> Justin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

