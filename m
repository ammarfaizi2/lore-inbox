Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751984AbWCGLJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbWCGLJA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 06:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752140AbWCGLJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 06:09:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:60112 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751984AbWCGLI7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 06:08:59 -0500
Date: Tue, 7 Mar 2006 11:08:54 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, dsp@llnl.gov, arjan@infradead.org,
       linux-kernel@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060307110854.GN27946@ftp.linux.org.uk>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603061052.57188.dsp@llnl.gov> <20060306195348.GB8777@kroah.com> <200603061301.37923.dsp@llnl.gov> <20060306213203.GJ27946@ftp.linux.org.uk> <20060306215344.GB16825@kroah.com> <20060306222400.GK27946@ftp.linux.org.uk> <20060307024113.103bbf1c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307024113.103bbf1c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 02:41:13AM -0800, Andrew Morton wrote:
> Al Viro <viro@ftp.linux.org.uk> wrote:
> >
> > On Mon, Mar 06, 2006 at 01:53:44PM -0800, Greg KH wrote:
> >  > > 	rmmod your_turd </sys/spew/from/your_turd
> >  > > and there you go.  rmmod can _NOT_ wait for sysfs references to go away.
> >  > 
> >  > To be fair, the only part of the kernel that supports the above process,
> >  > is the network stack.  And they implemented a special kind of lock to
> >  > handle just this kind of thing.
> >  > 
> >  > That is not something that I want the rest of the kernel to have to use.
> >  > If your code blocks when doing the above thing, that's fine with me.
> > 
> >  One word: fail.  With -EBUSY.
> 
> It seems quite simple to make wait_for_zero_refcount() interruptible? 
> Something like...

That's something we need to do anyway, but here it's not a matter of removal
blocking on module refcount:

| Regarding the above problem with the kobject reference count, this
| was recently fixed in the -mm tree (see edac-kobject-sysfs-fixes.patch
| in 2.6.16-rc5-mm2).  The fix I implemented was to add a call to
| complete() in edac_memctrl_master_release() and then have the module
| cleanup code wait for the completion.  I think there were a few other
| instances of this type of problem that I also fixed in the
| above-mentioned patch.

and that is clearly broken.  Moreover, unlike having rmmod -w interruptible
(which is obviously a very good idea), here we would be in the middle of
cleanup sequence and it would be too late to back off if interrupted.
