Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267402AbUG2BMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267402AbUG2BMS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 21:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267398AbUG2BMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 21:12:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:22691 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267399AbUG2BLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 21:11:25 -0400
Date: Wed, 28 Jul 2004 18:09:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: suparna@in.ibm.com, fastboot@osdl.org, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       jbarnes@engr.sgi.com
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Message-Id: <20040728180954.1f2baed9.akpm@osdl.org>
In-Reply-To: <m1d62f6351.fsf@ebiederm.dsl.xmission.com>
References: <16734.1090513167@ocs3.ocs.com.au>
	<20040725235705.57b804cc.akpm@osdl.org>
	<m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
	<200407280903.37860.jbarnes@engr.sgi.com>
	<25870000.1091042619@flay>
	<m14qnr7u7b.fsf@ebiederm.dsl.xmission.com>
	<20040728133337.06eb0fca.akpm@osdl.org>
	<1091044742.31698.3.camel@localhost.localdomain>
	<m1llh367s4.fsf@ebiederm.dsl.xmission.com>
	<20040728164457.732c2f1d.akpm@osdl.org>
	<m1d62f6351.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Shutdown methods will typically call into the slab allocator and the page
> > allocator to free stuff, and they are pretty common sources of oopses. 
> > Often with locks held.  You run an excellent change of deadlocking.
> 
> Hmm..  Last I looked shutdown methods typically don't exist at all.
> The shutdown methods are explicitly separated from the remove methods
> for exactly this reason.  It is a BUG for any shutdown method to
> free memory.  Their only function is to shutdown the hardware. 

OK.  But some (most) of them will sleep, too.  And we shouldn't sleep in a
dead kernel.

> > We really want to get into the new kernel ASAP and clean stuff up from
> > in there.
> 
> I agree.  However the gymnastics for doing that have not been worked out.
> The drivers cannot clean up stuff yet, nor do we have a good way to run
> in memory where DMA transfers on not ongoing.

Don't we?  The 16M of memory was allocated up-front at kexec load time[*],
so nobody will be pointing DMA hardware at it.  And the dump kernel won't
be pointing DMA hardware at the crashed kernel's pages.

> So for a first pass I think calling the shutdown methods make sense.

Well.  There aren't any.

> But the first pass is worth it (at least in the kexec tree) to sort out all
> of the interface issues and catch the low hanging fruit.

A significant proportion of kernel crashes happen from [soft]irq context,
from which we cannot call shutdown methods.  So we need to be able to bring
up the dump kernel without having run driver shutdown functions anwyay..

[*] At least, I _assume_ the 16MB will be prereserved,
    physically-contiguous and wholly within ZONE_NORMAL.  Is this wrong?

