Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbWBHEk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbWBHEk6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 23:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965202AbWBHEk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 23:40:58 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:20314 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965200AbWBHEk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 23:40:57 -0500
Date: Wed, 8 Feb 2006 05:40:41 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, Richard Henderson <rth@twiddle.net>,
       Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Andrew Morton <akpm@osdl.org>, dada1@cosmosbay.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>, James.Bottomley@steeleye.com,
       Ingo Molnar <mingo@elte.hu>, axboe@suse.de, anton@samba.org,
       wli@holomorphy.com, ak@muc.de
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
Message-ID: <20060208044041.GA9357@osiris.boeblingen.de.ibm.com>
References: <200602051959.k15JxoHK001630@hera.kernel.org> <20060207151541.GA32139@osiris.boeblingen.de.ibm.com> <43E8CA10.5070501@cosmosbay.com> <Pine.LNX.4.64.0602070833590.3854@g5.osdl.org> <20060207093458.176ac271.akpm@osdl.org> <Pine.LNX.4.64.0602070946190.3854@g5.osdl.org> <20060207183018.GA29056@in.ibm.com> <Pine.LNX.4.64.0602071036050.3854@g5.osdl.org> <20060207185355.GC5771@in.ibm.com> <Pine.LNX.4.64.0602071107200.3854@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602071107200.3854@g5.osdl.org>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I am looking at 2.6.16-rc1 and I don't see cpu_possible_map
> > being set in setup_smp()
> 
> You're right, my bad.  I looked at setup_smp() and how it walked through 
> every CPU in the firmware, but it doesn't actually ever set the possible 
> map, it fills in just hwrpb_cpu_present_mask (which is then then only used 
> _later_ to set cpu_possible_map for some silly reason).
> 
> As far as I can tell, "hwrpb_cpu_present_mask" is just wrong, and the code 
> _should_ be using cpu_possible_map.

We still have this one in init/main.c:

        /* Sets up cpus_possible() */
        smp_prepare_cpus(max_cpus);

That is actually why s390 is doing this in smp_prepare_cpus. We also use the
passed value of max_cpus to set the number of bits in cpu_possible_map
accordingly. This isn't possible anymore if this should be done in setup_arch.

So it looks like we have to switch to setup_arch and set NR_CPUS bits in
cpu_possible_map on s390.

Heiko
