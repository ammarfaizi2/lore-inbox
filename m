Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWEJGaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWEJGaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 02:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964836AbWEJGaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 02:30:15 -0400
Received: from ozlabs.org ([203.10.76.45]:63893 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964834AbWEJGaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 02:30:13 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17505.34919.750295.170941@cargo.ozlabs.ibm.com>
Date: Wed, 10 May 2006 16:29:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060510051649.GD1794@lixom.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510051649.GD1794@lixom.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson writes:

> Looks like alot of the text growth is from the added mfsprg3 instructions:

Yes, probably mostly from current.

> ... so, as the PACA gets deprecated, the bloat will go away again.

Yes.  I was hoping to get rid of the paca entirely, but that would
mean it would have to be in the RMA (so that the early exception entry
code can use it) which means that it won't be node-local any more.
I have a patch which allocates the per-cpu areas in the RMA but now
I'm rethinking it, since Ben H (at least) thinks the per-cpu area
really needs to be node-local.

Moving current to a per-cpu variable means that we need to allocate at
least the boot cpu's per-cpu area earlier than we do now, since it
seems that printk references current.  That makes it hard to make sure
the boot cpu's per-cpu area is node-local, unless we do something
tricky like reallocating it once the bootmem allocator is available.

> It would be interesting to see benchmarks of how much it improves
> things. I guess it doesn't really get interesting until after the paca
> gets removed though, due to the added mfsprg's.

I have moved current, smp_processor_id and a couple of other things to
per-cpu variables, and that results in the kernel text being about 8k
smaller than without any of these __thread patches.  Performance seems
to be very slightly better but it's hard to be sure that the change is
statistically significant, from the measurements I've done so far.

Paul.
