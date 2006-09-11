Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWIKXI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWIKXI3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWIKXI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:08:29 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:28234 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S964897AbWIKXI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:08:28 -0400
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="340832951:sNHT32975860"
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jesse Barnes <jbarnes@virtuousgeek.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] MMIO accessors & barriers documentation
X-Message-Flag: Warning: May contain useful information
References: <1157947414.31071.386.camel@localhost.localdomain>
	<200609111139.35344.jbarnes@virtuousgeek.org>
	<1158011129.3879.69.camel@localhost.localdomain>
	<4505DB10.7080807@pobox.com>
	<1158015394.3879.82.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 11 Sep 2006 16:08:23 -0700
In-Reply-To: <1158015394.3879.82.camel@localhost.localdomain> (Benjamin Herrenschmidt's message of "Tue, 12 Sep 2006 08:56:34 +1000")
Message-ID: <adar6yi2e8o.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Sep 2006 23:08:26.0748 (UTC) FILETIME=[301CF3C0:01C6D5F7]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Benjamin> and rmb is heavy handed for a compiler barrier :) what
    Benjamin> you might need on some platforms is an rmb between the
    Benjamin> MMIO read of whatever status/index register and the
    Benjamin> following memory reads of descriptors, and you may want
    Benjamin> an rmb in case where it matters if the chip has been
    Benjamin> changing a value behind your back (which it generally
    Benjamin> doesn't) but that's pretty much it....

In drivers/infiniband/hw/mthca/mthca_eq.c, there is:

	while ((eqe = next_eqe_sw(eq))) {
		/*
		 * Make sure we read EQ entry contents after we've
		 * checked the ownership bit.
		 */
		rmb();

		switch (eqe->type) {

where next_eqe_sw() checks a "valid" bit of a 32-byte event queue
entry that is DMA-ed into memory by the device.  The device is careful
to write the valid bit (byte actually) last, but on PowerPC 970
without the rmb(), we actually saw the CPU reordering the read of
eqe->type (which is another field of the EQ entry written by the
device) so it happened before the entry was valid, but then executing
the check of the valid bit far enough into the future so that the
entry tested as valid.

This isn't that surprising: if you had two CPUs, with one CPU writing
into a queue and the other CPU polling the queue, you would obviously
need smp_rmb() on the CPU doing the reading.  But somehow it's not
quite as obvious when a device plays the role of one of the CPUs.

Of course there's no MMIO anywhere in sight here, so this isn't
directly applicable I guess.

 - R.
