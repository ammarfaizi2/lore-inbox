Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964801AbWFXMJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964801AbWFXMJA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 08:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964800AbWFXMJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 08:09:00 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:44969 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964797AbWFXMI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 08:08:59 -0400
Date: Sat, 24 Jun 2006 08:08:36 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org,
       linux-scsi@vger.kernel.org, ebiederm@xmission.com, mike.miller@hp.com,
       Neela.Kolli@engenio.com
Subject: Re: [RFC] [PATCH 2/2] kdump: cciss driver initialization issue fix
Message-ID: <20060624120836.GB7313@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060623210121.GA18384@in.ibm.com> <20060623210424.GB18384@in.ibm.com> <20060623235553.2892f21a.akpm@osdl.org> <20060624111954.GA7313@in.ibm.com> <20060624043046.4e4985be.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060624043046.4e4985be.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 24, 2006 at 04:30:46AM -0700, Andrew Morton wrote:

[..]
> > > > 
> > > > diff -puN drivers/block/cciss.c~cciss-initialization-issue-over-kdump-fix drivers/block/cciss.c
> > > > --- linux-2.6.17-1M/drivers/block/cciss.c~cciss-initialization-issue-over-kdump-fix	2006-06-23 14:04:55.000000000 -0400
> > > > +++ linux-2.6.17-1M-vivek/drivers/block/cciss.c	2006-06-23 14:08:12.000000000 -0400
> > > > @@ -1976,6 +1976,13 @@ static int add_sendcmd_reject(__u8 cmd, 
> > > >  			ctlr, complete);
> > > >  		/* not much we can do. */
> > > >  #ifdef CONFIG_CISS_SCSI_TAPE
> > > > +		/* We might get notification of completion of commands
> > > > +		 * which we never issued in this kernel if this boot is
> > > > +		 * taking place after previous kernel's crash. Simply
> > > > +		 * ignore the commands in this case.
> > > > +		 */
> > > > +		if (crash_boot)
> > > > +			return 0;
> > > >  		return 1;
> > > 
> > > Looks like this is working around a driver problem rather than fixing it
> > > properly ;)
> > 
> > That's true. Its more of a working around the problem. I think in all
> > such cases we should soft reset the device so that device drops the messages
> > issued from the context of previous kernel and starts afresh.
> 
> Sounds good.
> 
> > But looks like not all the devices provide software reset facility
> > (Or I can't find it out from the source code or limited documentation
> > available). Mike, can I soft reset this device?
> > 
> > I am facing similar problem in megaraid driver as well where detailed
> > technical documentation is not available and I can't find a way to
> > soft reset the device.
> 
> Megaraid has a maintainer who has documents and hardware engineers.
> 

Well, maintainer mentioned that we do not export more documents more than
what is available on LSI site. That site contains product specification,
installation guides, user guides etc but not a technical document which
gives insight into the various registers and what a driver writer
can do with the device.

I have also sent mails regarding my problem to linux-scsi list as well
as to people working on megaraid but but no response. :-(


> > Or is there a generic way to handle these situations? Fixing them driver
> > by driver is a long painful process. 
> 
> Some generic way of whacking a PCI device via the standard PCI registers? 
> Not that I know of.

Somebody hinted that think of PCI bus reset. But I think PCI bus reset will
require firware/BIOS to export a hook to software to so initiate PCI bus
reset and I don't think many platforms do that. Infact I am not even aware
of one platform who does that.

Thanks
Vivek  
