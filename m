Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbTEQEB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 00:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbTEQEB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 00:01:26 -0400
Received: from marcie.netcarrier.net ([216.178.72.21]:57348 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id S261196AbTEQEBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 00:01:24 -0400
Message-ID: <3EC5B70E.F7284909@compuserve.com>
Date: Sat, 17 May 2003 00:14:06 -0400
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.5.69 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: dmo@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: DAC960 breakage, 2.5 bk current
References: <3EC5AD4A.B6C18A1C@compuserve.com> <20030516204920.25b8e951.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> 
> Kevin Brosius <cobra@compuserve.com> wrote:
> >
> > kernel NULL pointer deref - virt 00000019
> >  Oops: 0000 [#1]
> >  CPU: 0
> >  EIP: 0060:[<c02774d3>]  Not tainted
> >  EFLAGS: 00010286
> >  EIP is at DAC960_ioctl+0x33/0x190
> >
> >  Process swapper (pid: 1, ...)
> >
> >  Call Trace:
> >  ] blkdev_ioctl+0xa5/0x466
> >  ] ioctl_by_dev+0x41/0x50
> 
> You tricking me.  That's "ioctl_by_bdev".  It passes in a null file*, and
> we have to handle it.

Yes, sorry.  Missed a letter in that typing.

> 
> Does this fix?

Yes, works great!  No further panic.  Thank you.

> 
> diff -puN drivers/block/DAC960.c~DAC960-oops-fix drivers/block/DAC960.c
> --- 25/drivers/block/DAC960.c~DAC960-oops-fix   2003-05-16 20:44:52.000000000 -0700
> +++ 25-akpm/drivers/block/DAC960.c      2003-05-16 20:45:16.000000000 -0700
> @@ -102,7 +102,7 @@ static int DAC960_ioctl(struct inode *in
>         int drive_nr = (int)disk->private_data;
>         struct hd_geometry g, *loc = (struct hd_geometry *)arg;
> 
> -       if (file->f_flags & O_NONBLOCK)
> +       if (file && file->f_flags & O_NONBLOCK)
>                 return DAC960_UserIOCTL(inode, file, cmd, arg);
> 
>         if (cmd != HDIO_GETGEO || !loc)
> 
> _

-- 
Kevin
