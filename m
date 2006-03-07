Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbWCGRET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbWCGRET (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 12:04:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWCGRET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 12:04:19 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:2024 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751318AbWCGRES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 12:04:18 -0500
Date: Tue, 7 Mar 2006 09:04:01 -0800
From: Greg KH <greg@kroah.com>
To: Dave Peterson <dsp@llnl.gov>
Cc: Al Viro <viro@ftp.linux.org.uk>, Arjan van de Ven <arjan@infradead.org>,
       dthompson@lnxi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060307170401.GA6989@kroah.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603061301.37923.dsp@llnl.gov> <20060306213203.GJ27946@ftp.linux.org.uk> <200603070847.44417.dsp@llnl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603070847.44417.dsp@llnl.gov>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 08:47:44AM -0800, Dave Peterson wrote:
> On Monday 06 March 2006 13:32, Al Viro wrote:
> > On Mon, Mar 06, 2006 at 01:01:37PM -0800, Dave Peterson wrote:
> > > Regarding the above problem with the kobject reference count, this
> > > was recently fixed in the -mm tree (see edac-kobject-sysfs-fixes.patch
> > > in 2.6.16-rc5-mm2).  The fix I implemented was to add a call to
> > > complete() in edac_memctrl_master_release() and then have the module
> > > cleanup code wait for the completion.  I think there were a few other
> > > instances of this type of problem that I also fixed in the
> > > above-mentioned patch.
> >
> > This is not a fix, this is a goddamn deadlock.
> > 	rmmod your_turd </sys/spew/from/your_turd
> > and there you go.  rmmod can _NOT_ wait for sysfs references to go away.
> 
> Ok, how does this sound:
> 
>     - Modify EDAC so it uses kmalloc() to create the kobject.
>     - Eliminate edac_memctrl_master_release().  Instead, use kfree() as
>       the release method for the kobject.  Here, it's important to use a
>       function -outside- of EDAC as the release method since the core
>       EDAC module may have been unloaded by the time the release method
>       is called.

No, if this happens then you are using the kobject incorrectly.  How
could it be held if your module is unloaded?  Don't you have the module
reference counting logic correct?

>     - Make similar modifications to the other places in EDAC where
>       kobjects are used.

Yes.

> At least this will keep the module unload operation from blocking
> in the module cleanup function due to a nonzero kobject reference
> count.  I'm going to be away from my keyboard for most of the rest of
> today.  However, if there is general agreement that this is a
> reasonable way to proceed, I'll make a patch that implements this
> tomorrow.

It's a good start :)

thanks,

greg k-h
