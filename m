Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286478AbRLTXpC>; Thu, 20 Dec 2001 18:45:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286479AbRLTXow>; Thu, 20 Dec 2001 18:44:52 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:16565 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S286471AbRLTXok>; Thu, 20 Dec 2001 18:44:40 -0500
Date: Thu, 20 Dec 2001 16:44:35 -0700
Message-Id: <200112202344.fBKNiZ705811@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Andrew Morton <akpm@zip.com.au>
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-rc2 BUG at slab.c:1110
In-Reply-To: <3C2135D3.C5AE16A7@zip.com.au>
In-Reply-To: <15393.11001.446919.939724@argo.ozlabs.ibm.com>
	<3C2135D3.C5AE16A7@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
> Paul Mackerras wrote:
> > 
> > So, is this devfs's fault for not allowing devfs_unregister to be
> > called from interrupt context, or is it ide-cs's fault for calling
> > ide_unregister from interrupt context?
> > 
> 
> ide-cs, I'd say.

Definately. It's always been illegal to call into the devfs API from
interrupt context, and in fact given that devfs_register() always
called kmalloc() with GFP_KERNEL, it should have caught any interrupt
context callers of devfs.

It just happened that in the old devfs core, you could often get away
with a call to devfs_unregister(), since it didn't do any allocations.
However, doing so was unsafe due to races (no locking/irq disabling),
even on UP systems. So it was always a driver bug to do this.

> The way hotplug generally avoids this problem is via schedule_task()
> - that was why it was written in the first place, I think.
> 
> And given that we need to bump the event up to process context, we may
> as well do it at the earliest stage.  Looks like the fix it to kill
> off the timer altogether, replace it with a tqueue and ask keventd
> to run ide_release.

Sounds good to me. I look forward to seeing your patch in -rc3 :-)

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
