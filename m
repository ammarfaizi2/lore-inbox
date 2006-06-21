Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWFUDtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWFUDtt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 23:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWFUDts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 23:49:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46751 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750754AbWFUDtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 23:49:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Roland Dreier <rdreier@cisco.com>
Cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-acpi@vger.kernel.org>, <linux-pci@atrey.karlin.mff.cuni.cz>,
       <discuss@x86-64.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>, Andi Kleen <ak@suse.de>,
       "Natalie Protasevich" <Natalie.Protasevich@UNISYS.com>,
       "Len Brown" <len.brown@intel.com>,
       "Kimball Murray" <kimball.murray@gmail.com>,
       Brice Goglin <brice@myri.com>, Greg Lindahl <greg.lindahl@qlogic.com>,
       Dave Olson <olson@unixfolk.com>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Grant Grundler <iod00d@hp.com>,
       "bibo,mao" <bibo.mao@intel.com>, Rajesh Shah <rajesh.shah@intel.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Shaohua Li <shaohua.li@intel.com>,
       Matthew Wilcox <matthew@wil.cx>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Ashok Raj <ashok.raj@intel.com>, Randy Dunlap <rdunlap@xenotime.net>,
       Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 8/25] msi: Simplify the msi irq limit policy.
References: <m1ac87ea8s.fsf@ebiederm.dsl.xmission.com>
	<11508425183073-git-send-email-ebiederm@xmission.com>
	<11508425191381-git-send-email-ebiederm@xmission.com>
	<11508425192220-git-send-email-ebiederm@xmission.com>
	<11508425191063-git-send-email-ebiederm@xmission.com>
	<1150842520235-git-send-email-ebiederm@xmission.com>
	<11508425201406-git-send-email-ebiederm@xmission.com>
	<1150842520775-git-send-email-ebiederm@xmission.com>
	<11508425213394-git-send-email-ebiederm@xmission.com>
	<adak67bmdj5.fsf@cisco.com>
Date: Tue, 20 Jun 2006 21:48:41 -0600
In-Reply-To: <adak67bmdj5.fsf@cisco.com> (Roland Dreier's message of "Tue, 20
	Jun 2006 19:46:22 -0700")
Message-ID: <m1ac879nja.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier <rdreier@cisco.com> writes:

>  > Only the s2io driver even takes advantage of this feature
>  > all other drivers have a fixed number of irqs they need and
>  > bail if they can't get them.
>
> My todo list for the mthca (InfiniBand HCA) driver includes adding
> support for more event queues.  When I do that, I'll likely want to
> try to get something on the order of number_of_cpus plus two or three
> MSI-X vectors, and fall back to a lower number of vectors if that
> allocation fails.

Allowing drivers that can take advantage of large numbers of
irqs is part of this patch.  To be clear the method still supports
allocate a bunch of irqs and then falling back.

We have to kinds of drivers.  Those that allocate a lot of irqs and
allocate fewer if they can't get them, and those just allocate a
couple and fail if they can't get them. 

The policy I deleted tries to be fair, and give all drivers the
same number of irqs.  What I left us with is a simple first
come first serve policy.

To do better you need an accurate count and you need to separate
out the various kinds of drivers, and you need a shortage of
irqs.

Currently x86_64 hardware supports up to 244*NR_CPUS irqs.  I
don't expect we will exceed that limit any time soon even with
a first come first serve policy.  

The worst case I can think of with your proposed irq allocation
policy in the mthca driver is a 128 cpu machine with 128 IB cards
in it.  That would just barely fail with every driver allocating
3 IRQs per cpu, and it could be trivially fixed by putting in
dual core cpus :)

So when we exceed the limit on the number of IRQs we actually
have then it probably makes sense to see if a policy more
aggressive than first come first serve makes sense.  But until
then it is a waste of time and we should be concentrating
our efforts on making more IRQs usable.

Eric
