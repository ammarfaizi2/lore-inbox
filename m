Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTFKEBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 00:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264083AbTFKEBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 00:01:42 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:1437 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264080AbTFKEBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 00:01:41 -0400
Date: Tue, 10 Jun 2003 21:16:07 -0700
From: Andrew Morton <akpm@digeo.com>
To: Simon Fowler <simon@himi.org>
Cc: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.70-bk radeonfb oops on boot.
Message-Id: <20030610211607.2bb55b41.akpm@digeo.com>
In-Reply-To: <20030611035525.GB2852@himi.org>
References: <20030610061654.GB25390@himi.org>
	<20030610130204.GC27768@himi.org>
	<20030610141440.26fad221.akpm@digeo.com>
	<20030611021926.GA2241@himi.org>
	<20030610201641.220a4927.akpm@digeo.com>
	<20030611035525.GB2852@himi.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2003 04:15:23.0075 (UTC) FILETIME=[13F0B130:01C32FD0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Fowler <simon@himi.org> wrote:
>
> > > > 
> > > > It might be worth reverting this chunk, see if that fixes it:
> > > > 
> > > > --- b/drivers/char/mem.c        Thu Jun  5 23:36:40 2003
> > > > +++ b/drivers/char/mem.c        Sun Jun  8 05:02:24 2003
> > > > @@ -716 +716 @@
> > > > -__initcall(chr_dev_init);
> > > > +subsys_initcall(chr_dev_init);
> > > > 
> > > And we have a winner . . . Reverting this hunk fixes the oops.
> > > 
> > 
> > So it's another initcall problem in the PCI layer.
> > 
> > pci_enable_device_bars() is needing things which are not yet set up.  A lot
> > of the PCI initialisation is at subsys_initcall() as well, and you got
> > unlucky with link order.
> > 
> > I expect the below patch will fix this as well.  Could you please put the
> > above change back to normal and see if this one fixes it?
> > 
> I applied this to a clean 2.5.70-bk14 tree, and it failed to boot -
> I've copied the output after switching to the framebuffer:
> 
> --------------------------------------------------
> onsole: switching to colour frame buffer device 160x48
> pty: 256 Unix98 ptys configured.
> block request queues:
>   4/128 requests per read queue
>   4/128 requests per write queue
>   Enter congestion at 15
>   Exit congestion at 17
> PCI: Cannot allocate resource region 0 of device 00:14.0
> PCI: Cannot allocate resource region 2 of device 00:14.0
> --------------------------------------------------
> 
> 00:14.0 is the Radeon.

Thanks for testing.

All the initcall ordering of chardevs versus pci, pci versus pci and who
knows what else is all bollixed up.

Unfortunately I do not have the bandwidth to work on this.

