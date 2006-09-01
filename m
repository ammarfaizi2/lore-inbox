Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750938AbWIATxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750938AbWIATxv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 15:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWIATxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 15:53:51 -0400
Received: from sj-iport-4.cisco.com ([171.68.10.86]:24355 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1750938AbWIATxu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 15:53:50 -0400
X-IronPort-AV: i="4.08,201,1154934000"; 
   d="scan'208"; a="1851727015:sNHT34895868"
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile error
X-Message-Flag: Warning: May contain useful information
References: <20060901015818.42767813.akpm@osdl.org>
	<20060901160023.GB18276@stusta.de>
	<20060901101340.962150cb.akpm@osdl.org> <adak64nij8f.fsf@cisco.com>
	<20060901112312.5ff0dd8d.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 01 Sep 2006 12:53:47 -0700
In-Reply-To: <20060901112312.5ff0dd8d.akpm@osdl.org> (Andrew Morton's message of "Fri, 1 Sep 2006 11:23:12 -0700")
Message-ID: <ada8xl3ics4.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2006 19:53:49.0061 (UTC) FILETIME=[5789D350:01C6CE00]
Authentication-Results: sj-dkim-8.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> My understanding is that __raw_writeq() is like writeq()
    Roland> except not strongly ordered and without the byte-swap on
    Roland> big-endian architectures.  The __raw_writeX() variants are
    Roland> convenient to avoid having to write inefficient code like
    Roland> writel(swab32(foo), ...) when talking to a PCI device that
    Roland> wants big-endian data.  Without the raw variant, you end
    Roland> up with a double swap on big-endian architectures.

Oh, I left one other thing out: writeq() and __raw_writeq() shold be
atomic in the sense that no other transactions should be able to get
onto the IO bus in the middle -- so implementing writeq() as two
writel()s in a row is not allowed

    Andrew> OK.  Can we please stop hacking around this in drivers and

    Andrew> a) work out what it's supposed to do

    Andrew> b) document that (Documentation/DocBook/deviceiobook.tmpl
    Andrew> or code comment or whatever)

    Andrew> c) tell arch maintainers?

Yes, I agree that's a good plan, especially the documentation part.
However I would argue that what's in drivers/infiniband/hw/mthca/mthca_doorbell.h 
is legitimate: the driver uses __raw_writeq() when it exists and uses
two __raw_writel()s properly serialized with a device-specific lock to
get exactly the atomicity it needs on 32-bit archs.

It's an open question what drivers that don't actually need atomicity
but just want a convenient way to write 64 bits at time should do.

 - R.
