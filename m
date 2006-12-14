Return-Path: <linux-kernel-owner+w=401wt.eu-S1751887AbWLNAog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWLNAog (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWLNAog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:44:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:39461 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751887AbWLNAog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:44:36 -0500
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 19:44:35 EST
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,165,1165219200"; 
   d="scan'208"; a="26737144:sNHT17433432"
Date: Wed, 13 Dec 2006 16:08:12 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Greg KH <gregkh@suse.de>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, Arjan <arjan@linux.intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kref refcnt and false positives
Message-ID: <20061213160812.A13177@unix-os.sc.intel.com>
References: <20061213153408.A13049@unix-os.sc.intel.com> <20061214001246.GA10056@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061214001246.GA10056@suse.de>; from gregkh@suse.de on Wed, Dec 13, 2006 at 04:12:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2006 at 04:12:46PM -0800, Greg KH wrote:
> On Wed, Dec 13, 2006 at 03:34:08PM -0800, Venkatesh Pallipadi wrote:
> > 
> > With WARN_ON addition to kobject_init()
> > [ http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19/2.6.19-mm1/dont-use/broken-out/gregkh-driver-kobject-warn.patch ]
> > 
> > I started seeing following WARNING on CPU offline followed by online on my
> > x86_64 system.
> > 
> > WARNING at lib/kobject.c:172 kobject_init()
> > 
> > This is a false positive as mce.c is unregistering/registering sysfs
> > interfaces cleanly on hotplug.
> 
> The warning above tends to look like this is not true.
> 
> > kref_put() and conditional decrement of refcnt seems to be the root cause
> > for this and the patch below resolves the issue for me.
> 
> Why?
> 
> Are you properly initializing your kref to null before you register it
> with the driver core?  Or is it a static object?
> 

Yes. arch/x86_64/kernel/mce.c is calling sysdev_register and sysdev_unregister
for cpu hot_add and hot_remove respectively.

The problem is that due to the perf optimization, refcnt remains at 1
even after unregister (as it never gets decremented to 0 in kref_put()).

So, when we try to register next time for same sysdev (The object is percpu,
so previously set refcnt will remain 1), init sees that refcnt is already 1
and print out the WARNing.


> > Original comment seemed to indicate that this conditional thing was
> > performance related. Is it really? If not, we should consider the below patch.
> 
> Yes, it's a performance gain and I don't see how this patch would change
> the above warning.
> 

In that case, I think we should change the WARN_ON in question to check for > 1.

Thanks,
Venki
