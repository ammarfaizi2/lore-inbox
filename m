Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbTESXXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263274AbTESXXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:23:31 -0400
Received: from air-2.osdl.org ([65.172.181.6]:9893 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263202AbTESXX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:23:29 -0400
Date: Mon, 19 May 2003 16:35:35 -0700
From: Dave Olien <dmo@osdl.org>
To: Kevin Brosius <cobra@compuserve.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: DAC960 breakage, 2.5 bk current
Message-ID: <20030519233535.GA26160@osdl.org>
References: <3EC5AD4A.B6C18A1C@compuserve.com> <20030516204920.25b8e951.akpm@digeo.com> <3EC5B70E.F7284909@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC5B70E.F7284909@compuserve.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I apologize for missing this before submitting that patch.
I'm working on a patch that eliminates this O_NONBLOCK nonsense entirely.
I'm away from work most of this week though. Back next week.

On Sat, May 17, 2003 at 12:14:06AM -0400, Kevin Brosius wrote:
> Andrew Morton wrote:
> > 
> > 
> > Kevin Brosius <cobra@compuserve.com> wrote:
> > >
> > > kernel NULL pointer deref - virt 00000019
> > >  Oops: 0000 [#1]
> > >  CPU: 0
> > >  EIP: 0060:[<c02774d3>]  Not tainted
> > >  EFLAGS: 00010286
> > >  EIP is at DAC960_ioctl+0x33/0x190
> > >
> > >  Process swapper (pid: 1, ...)
> > >
> > >  Call Trace:
> > >  ] blkdev_ioctl+0xa5/0x466
> > >  ] ioctl_by_dev+0x41/0x50
> > 
> > You tricking me.  That's "ioctl_by_bdev".  It passes in a null file*, and
> > we have to handle it.
> 
> Yes, sorry.  Missed a letter in that typing.
> 
> > 
> > Does this fix?
> 
> Yes, works great!  No further panic.  Thank you.
> 
> > 
> > diff -puN drivers/block/DAC960.c~DAC960-oops-fix drivers/block/DAC960.c
> > --- 25/drivers/block/DAC960.c~DAC960-oops-fix   2003-05-16 20:44:52.000000000 -0700
> > +++ 25-akpm/drivers/block/DAC960.c      2003-05-16 20:45:16.000000000 -0700
> > @@ -102,7 +102,7 @@ static int DAC960_ioctl(struct inode *in
> >         int drive_nr = (int)disk->private_data;
> >         struct hd_geometry g, *loc = (struct hd_geometry *)arg;
> > 
> > -       if (file->f_flags & O_NONBLOCK)
> > +       if (file && file->f_flags & O_NONBLOCK)
> >                 return DAC960_UserIOCTL(inode, file, cmd, arg);
> > 
> >         if (cmd != HDIO_GETGEO || !loc)
> > 
> > _
> 
> -- 
> Kevin
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
