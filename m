Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266134AbUBDAPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 19:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266234AbUBDAP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 19:15:29 -0500
Received: from grassmarket.ucs.ed.ac.uk ([129.215.166.64]:54718 "EHLO
	grassmarket.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id S266134AbUBDAP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 19:15:27 -0500
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Reply-To: s0348365@sms.ed.ac.uk
Organization: University of Edinburgh
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc3-mm1
Date: Wed, 4 Feb 2004 00:17:43 +0000
User-Agent: KMail/1.5.94
References: <20040202235817.5c3feaf3.akpm@osdl.org> <200402032347.36489.s0348365@sms.ed.ac.uk> <200402040100.40682.bzolnier@elka.pw.edu.pl>
In-Reply-To: <200402040100.40682.bzolnier@elka.pw.edu.pl>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200402040017.43787.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 February 2004 00:00, Bartlomiej Zolnierkiewicz wrote:
[snip]
> > > > UDMA(133) /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
> > > > hde: max request size: 128KiB
> > > >
> > > > 30 seconds later, I get something like:
> > > >
> > > > hde: lost interrupt
> > > > hde: lost interrupt
> > >
> > > It seems kernel hangs in ide-disk.c,
> > > idedisk_setup()->write_cache()->...
> > >
> > > > The kernel does not recover. Presumably it is a problem specific to
> > > > my PDC IDE controller.
> > >
> > > Do you run with Promise BIOS disabled?  If so please try booting kernel
> > > with "hde=autotune hdg=autotune" parameters.  If still no-go, try this
> > > patch:
> >
> > Neither suggestion changes the behaviour. I've got the BIOS enabled, but
> > in the past it's made no difference. I still see lost interrupts.
>
> Please try this debugging patch to see it hangs on
> idedisk_setup()->write_cache().
>
> --- linux/drivers/ide/ide-disk.c	2004-02-04 00:57:49.000000000 +0100
> +++ linux-2.6.2-rc3-bk3/drivers/ide/ide-disk.c	2004-02-04
> 00:58:58.571025744 +0100 @@ -1668,8 +1668,10 @@
>  #endif	/* CONFIG_IDEDISK_MULTI_MODE */
>  	}
>  	drive->no_io_32bit = id->dword_io ? 1 : 0;
> +	printk(KERN_INFO "%s: before write_cache()\n", drive->name);
>  	if (drive->id->cfs_enable_2 & 0x3000)
>  		write_cache(drive, (id->cfs_enable_2 & 0x3000));
> +	printk(KERN_INFO "%s: after write_cache()\n", drive->name);
>
>  #ifdef CONFIG_BLK_DEV_IDE_TCQ_DEFAULT
>  	if (drive->using_dma)

Tried the patch. I see both before and after messages for hda, but when hde is 
probed I see neither. Briefly looking at the IDE code, I see the max request 
size: printk comes before either of those lines, as as nothing else is 
printed after that line (see original bug report), I can only assume the 
problem is somewhere before the write_cache().

I applied the patch on top of your previous changes, as they seemed innocuous 
enough.

-- 
Cheers,
Alistair.

personal:   alistair()devzero!co!uk
university: s0348365()sms!ed!ac!uk
student:    CS/AI Undergraduate
contact:    7/10 Darroch Court,
            University of Edinburgh.
