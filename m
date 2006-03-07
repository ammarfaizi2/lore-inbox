Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWCGQsB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWCGQsB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 11:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbWCGQsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 11:48:01 -0500
Received: from smtp-3.llnl.gov ([128.115.41.83]:953 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S1751243AbWCGQsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 11:48:00 -0500
From: Dave Peterson <dsp@llnl.gov>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] EDAC: core EDAC support code
Date: Tue, 7 Mar 2006 08:47:44 -0800
User-Agent: KMail/1.5.3
Cc: Greg KH <greg@kroah.com>, Arjan van de Ven <arjan@infradead.org>,
       dthompson@lnxi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603061301.37923.dsp@llnl.gov> <20060306213203.GJ27946@ftp.linux.org.uk>
In-Reply-To: <20060306213203.GJ27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603070847.44417.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 March 2006 13:32, Al Viro wrote:
> On Mon, Mar 06, 2006 at 01:01:37PM -0800, Dave Peterson wrote:
> > Regarding the above problem with the kobject reference count, this
> > was recently fixed in the -mm tree (see edac-kobject-sysfs-fixes.patch
> > in 2.6.16-rc5-mm2).  The fix I implemented was to add a call to
> > complete() in edac_memctrl_master_release() and then have the module
> > cleanup code wait for the completion.  I think there were a few other
> > instances of this type of problem that I also fixed in the
> > above-mentioned patch.
>
> This is not a fix, this is a goddamn deadlock.
> 	rmmod your_turd </sys/spew/from/your_turd
> and there you go.  rmmod can _NOT_ wait for sysfs references to go away.

Ok, how does this sound:

    - Modify EDAC so it uses kmalloc() to create the kobject.
    - Eliminate edac_memctrl_master_release().  Instead, use kfree() as
      the release method for the kobject.  Here, it's important to use a
      function -outside- of EDAC as the release method since the core
      EDAC module may have been unloaded by the time the release method
      is called.
    - Make similar modifications to the other places in EDAC where
      kobjects are used.

At least this will keep the module unload operation from blocking
in the module cleanup function due to a nonzero kobject reference
count.  I'm going to be away from my keyboard for most of the rest of
today.  However, if there is general agreement that this is a
reasonable way to proceed, I'll make a patch that implements this
tomorrow.

Dave
