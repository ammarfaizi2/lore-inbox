Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUG1XpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUG1XpH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 19:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267351AbUG1Xmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 19:42:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:34255 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266531AbUG1Xlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 19:41:52 -0400
Date: Wed, 28 Jul 2004 16:44:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: alan@lxorguk.ukuu.org.uk, suparna@in.ibm.com, fastboot@osdl.org,
       mbligh@aracnet.com, jbarnes@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-Id: <20040728164457.732c2f1d.akpm@osdl.org>
In-Reply-To: <m1llh367s4.fsf@ebiederm.dsl.xmission.com>
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com>
	<25870000.1091042619@flay>
	<m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	<20040728133337.06eb0fca.akpm@osdl.org>
	<1091044742.31698.3.camel@localhost.localdomain>
	<m1llh367s4.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > On Mer, 2004-07-28 at 21:33, Andrew Morton wrote:
> > > We really don't want to be calling driver shutdown functions from a crashed
> > > kernel.
> > 
> > Then at the very least you need to disable bus mastering and have
> > specialist recovery functions for problematic devices. The bus
> > mastering one is essential otherwise bus masters will continue to
> > DMA random data into your new universe.
> > 
> > Other stuff like graphics cards and IDE may need care too.
> 
> Alan if we call anything the shutdown methods really are the thing
> to call.  Because they are exactly the specialty recovery functions for
> problematic devices.
> 
> Of course no matter what we do will this work 100% of the time because
> part of what we will be fighting is broken hardware.  However we should
> be able to get a mechanism that works most of the time.

Shutdown methods will typically call into the slab allocator and the page
allocator to free stuff, and they are pretty common sources of oopses. 
Often with locks held.  You run an excellent change of deadlocking.

Possibly one could add

#ifdef CONFIG_WHATEVER
	if (unlikely(oops_in_progress))
		return;
#endif

to the relevant entry points.

The shutdown routines may also call into sysfs/kobject/procfs release entry
points, and they're even more popular oops sites.

We really want to get into the new kernel ASAP and clean stuff up from
in there.
