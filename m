Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265576AbTFMXBz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 19:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265577AbTFMXBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 19:01:54 -0400
Received: from dp.samba.org ([66.70.73.150]:29142 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265576AbTFMXBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 19:01:50 -0400
Date: Sat, 14 Jun 2003 09:15:01 +1000
From: Anton Blanchard <anton@samba.org>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: David Gibson <dwg@au1.ibm.com>, linux-kernel@vger.kernel.org,
       Nancy Milliner <milliner@us.ibm.com>,
       Herman Dierks <hdierks@us.ibm.com>,
       Ricardo Gonzalez <ricardoz@us.ibm.com>
Subject: Re: e1000 performance hack for ppc64 (Power4)
Message-ID: <20030613231501.GC32097@krispykreme>
References: <C6F5CF431189FA4CBAEC9E7DD5441E010107D932@orsmsx402.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E010107D932@orsmsx402.jf.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> 2-byte alignment is bad for ppc64, so what is minimum alignment that is
> good?  (I hope it's not 2K!)  What could you do at a higher level to
> present properly aligned buffers to the driver?

Best case 128 bytes - ppc64 cacheline size. Worst case 512 bytes - our
pci-pci bridge likes to prefetch in 512 byte increments. From Herman's
data you can see this in action:

Linux sending one 1514 byte packet   (777 Mbits sec rate)

      Address     PCI command Bytes xfered
      420A8       MRM         344
      42200       MRM         512
      42400       MRM         512
      42600       MRL         128
      42680       MR           18

With the buffer 512 byte aligned this is completed in 3 transactions.
Yes the hardware could be more intelligent about these unaligned
transactions but we cant do much about that now.

We might be able to do the alignment at a higher level but its not
straightforward (see my previous mail).

> If I'm understanding the patch correctly, you're saying unaligned DMA +
> TCE lookup is more expensive than a data copy?  If we copy the data, we
> loss some of the benefits of TSO and Zerocopy and h/w checksum
> offloading!  What is more expensive, unaligned DMA or TCE?

Lets ignore TCE lookup overhead for the moment. As Herman pointed all
these DMAs should occur on the same page.

Anton
