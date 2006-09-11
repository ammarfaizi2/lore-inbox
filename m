Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbWIKXTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWIKXTd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWIKXT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:19:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:9909 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965117AbWIKXTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:19:20 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jesse Barnes <jbarnes@virtuousgeek.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <adar6yi2e8o.fsf@cisco.com>
References: <1157947414.31071.386.camel@localhost.localdomain>
	 <200609111139.35344.jbarnes@virtuousgeek.org>
	 <1158011129.3879.69.camel@localhost.localdomain>
	 <4505DB10.7080807@pobox.com>
	 <1158015394.3879.82.camel@localhost.localdomain>
	 <adar6yi2e8o.fsf@cisco.com>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 09:18:51 +1000
Message-Id: <1158016731.15465.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> where next_eqe_sw() checks a "valid" bit of a 32-byte event queue
> entry that is DMA-ed into memory by the device.  The device is careful
> to write the valid bit (byte actually) last, but on PowerPC 970
> without the rmb(), we actually saw the CPU reordering the read of
> eqe->type (which is another field of the EQ entry written by the
> device) so it happened before the entry was valid, but then executing
> the check of the valid bit far enough into the future so that the
> entry tested as valid.

Yes, the CPU can perfectly load it before the previous load, indeed. I'm
sure that wouldn't be powerpc specific. In this case, it would be a
speculative load (since there is a data dependency, thus you would think
it's ok, but it's not on CPUs that do speculative execution).

> This isn't that surprising: if you had two CPUs, with one CPU writing
> into a queue and the other CPU polling the queue, you would obviously
> need smp_rmb() on the CPU doing the reading.  But somehow it's not
> quite as obvious when a device plays the role of one of the CPUs.
> 
> Of course there's no MMIO anywhere in sight here, so this isn't
> directly applicable I guess.

It's a "normal" case memory barrier in this case. Same as for SMP. Yup. 

Ben.


