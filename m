Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262605AbREOBvi>; Mon, 14 May 2001 21:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262603AbREOBv3>; Mon, 14 May 2001 21:51:29 -0400
Received: from adsl-64-109-89-110.chicago.il.ameritech.net ([64.109.89.110]:31828
	"EHLO jet.il.steeleye.com") by vger.kernel.org with ESMTP
	id <S262602AbREOBvT>; Mon, 14 May 2001 21:51:19 -0400
Message-Id: <200105150151.UAA08944@jet.il.steeleye.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Rasmus Andersen <rasmus@jaquet.dk>
cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [NEW SCSI DRIVER] for 53c700 chip and NCR_D700 card against 2.4.4 
In-Reply-To: Message from Rasmus Andersen <rasmus@jaquet.dk> 
   of "Mon, 14 May 2001 22:23:06 +0200." <20010514222306.B840@jaquet.dk> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Mon, 14 May 2001 20:51:08 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've implemented most of these as you suggest, with these exceptions:

> > +	default:
> > +		printk(KERN_INFO "scsi%d (%d:%d): Unexpected message %s: ",
> > +		       host->host_no, pun, lun,
> > +		       NCR_700_phase[(dsps & 0xf00) >> 8]);
> > +		print_msg(hostdata->msgin);
> > +		printk("\n");
>
> It would be nice with a KERN_XX before "\n" (yes, I recognize that
> print_msg does not do this :( )

The KERN_XX only go at the beginning of an output line (otherwise you see rather annoying <n> embedded in the log---the smc-mca driver has a hugely irritating example of this).  print_msg doesn't do a carriage return by itself, so these three prints are really only one line (and hence all done under the KERN_INFO).

The "OUTSTANDING TAGS.." message is another one of these---it prints a list of tags all on one line.


rasmus@jaquet.dk said:
> +                       if(request_irq(irq, NCR_700_intr, SA_SHIRQ, "NCR_D700",
> +host)) {
> +                               printk(KERN_ERR "NCR D700, channel %d: irq
> +problem, detatching\n", i);
> +                               NCR_700_release(host);
> +                               release_region(host->base, 64);
> +                               continue;
> +                       }
>
> You need to kfree(hostdata) here. I would also recommend putting
> a scsi_unregister into NCR_700_release since you need to balance
> the scsi_register done in NCR_700_detect.

Actually, I need to remove the release_region here (since it's done in NCR_700_release) and add a scsi_unregister.

There's no need to do a scsi_unregister in _release; scsi_unregister is only really used to tell the mid layer to relinquish a host after an error.  In _release, the mid layer is telling you that it has released the host and we need to clean up.

Thanks for the updates, I'll post another patch once I've got a few other people's suggestions rolled in.

James


