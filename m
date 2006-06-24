Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932586AbWFXLUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932586AbWFXLUe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 07:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWFXLUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 07:20:34 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:5837 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1752214AbWFXLUd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 07:20:33 -0400
Date: Sat, 24 Jun 2006 07:19:54 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       linux-scsi@vger.kernel.org, ebiederm@xmission.com, mike.miller@hp.com
Subject: Re: [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Message-ID: <20060624111954.GA7313@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060623210121.GA18384@in.ibm.com> <20060623210424.GB18384@in.ibm.com> <20060623235553.2892f21a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623235553.2892f21a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 11:55:53PM -0700, Andrew Morton wrote:
> On Fri, 23 Jun 2006 17:04:24 -0400
> Vivek Goyal <vgoyal@in.ibm.com> wrote:
> 
> > 
> > o cciss driver initialization fails and hits BUG() if underlying device
> >   was active during the driver initialization. Device might be active
> >   if previous kernel crashed and this kernel is booting after that using
> >   kdump.
> > 
> >
> > ...
> >
> > o If crash_boot parameter is set, then ignore the completed command messages
> >   sent by device which have not been issued in the context of this kernel.
> > 
> > Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
> > ---
> > 
> >  linux-2.6.17-1M-vivek/drivers/block/cciss.c |    7 +++++++
> >  1 files changed, 7 insertions(+)
> > 
> > diff -puN drivers/block/cciss.c~cciss-initialization-issue-over-kdump-fix drivers/block/cciss.c
> > --- linux-2.6.17-1M/drivers/block/cciss.c~cciss-initialization-issue-over-kdump-fix	2006-06-23 14:04:55.000000000 -0400
> > +++ linux-2.6.17-1M-vivek/drivers/block/cciss.c	2006-06-23 14:08:12.000000000 -0400
> > @@ -1976,6 +1976,13 @@ static int add_sendcmd_reject(__u8 cmd, 
> >  			ctlr, complete);
> >  		/* not much we can do. */
> >  #ifdef CONFIG_CISS_SCSI_TAPE
> > +		/* We might get notification of completion of commands
> > +		 * which we never issued in this kernel if this boot is
> > +		 * taking place after previous kernel's crash. Simply
> > +		 * ignore the commands in this case.
> > +		 */
> > +		if (crash_boot)
> > +			return 0;
> >  		return 1;
> 
> Looks like this is working around a driver problem rather than fixing it
> properly ;)

That's true. Its more of a working around the problem. I think in all
such cases we should soft reset the device so that device drops the messages
issued from the context of previous kernel and starts afresh.

But looks like not all the devices provide software reset facility
(Or I can't find it out from the source code or limited documentation
available). Mike, can I soft reset this device?

I am facing similar problem in megaraid driver as well where detailed
technical documentation is not available and I can't find a way to
soft reset the device.

Or is there a generic way to handle these situations? Fixing them driver
by driver is a long painful process. 

Thanks
Vivek
