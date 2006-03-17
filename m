Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWCQCQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWCQCQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 21:16:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWCQCQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 21:16:29 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:1674 "EHLO
	sj-iport-4.cisco.com") by vger.kernel.org with ESMTP
	id S1751449AbWCQCQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 21:16:28 -0500
X-IronPort-AV: i="4.03,103,1141632000"; 
   d="scan'208"; a="1785725739:sNHT34682296"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, hch@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: Remapping pages mapped to userspace
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
	<20060309163740.0b589ea4.akpm@osdl.org>
	<1142470579.6994.78.camel@localhost.localdomain>
	<ada3bhjuph2.fsf@cisco.com>
	<1142475069.6994.114.camel@localhost.localdomain>
	<adaslpjt8rg.fsf@cisco.com>
	<1142477579.6994.124.camel@localhost.localdomain>
	<20060315192813.71a5d31a.akpm@osdl.org>
	<1142485103.25297.13.camel@camp4.serpentine.com>
	<20060315213813.747b5967.akpm@osdl.org>
	<Pine.LNX.4.61.0603161332090.21570@goblin.wat.veritas.com>
	<adad5gmne20.fsf_-_@cisco.com>
	<1142553361.15045.19.camel@serpentine.pathscale.com>
	<adapsklnaby.fsf@cisco.com>
	<1142558909.23236.11.camel@localhost.localdomain>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 16 Mar 2006 18:16:26 -0800
In-Reply-To: <1142558909.23236.11.camel@localhost.localdomain> (Alan Cox's message of "Fri, 17 Mar 2006 01:28:28 +0000")
Message-ID: <adalkv9n7d1.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 Mar 2006 02:16:27.0513 (UTC) FILETIME=[CC07D690:01C64968]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > Oh yeah... but getting rid of the mapping so userspace gets a segfault
 > > might be a good idea too.  However, leaving the old PCI mapping there
 > > seems rather risky to me: I think it's entirely possible that accesses
 > > to that area after the device is gone could trigger machine checks or
 > > worse.
 > 
 > Not really. After all the hot remove can race an actual mmio cycle so
 > you can't close that window to nothing. In other words if it does make
 > the PCI bridge burp at you - well hotplug has to handle it.
 > 
 > That means on the positive side that all you need to do is refcount
 > properly and destroy the PCI device when you have finished with it. If a
 > mapping continues to exist then fine, because the device is still
 > logically there. If the device is logically there then the resources
 > have not been unmapped. If the resources have not been unmapped they are
 > not free for allocation to another device.

I'm not sure I'm following you.  Is it OK for a driver to return from
its pci_driver .remove method with userspace mappings to MMIO BARs
still hanging around?  I wouldn't think so.

Non-privileged userspace processes can get direct access to (a safe
subset of) PCI space for IB devices, and it seems unfriendly to force
all of those processes to be killed before an IB device can be removed.

The way I think about it is that one doesn't have to kill every
process with a connected socket to remove an ethernet device, and I'd
like the same to hold for IB devices.  The analogy doesn't really hold
at a technical level I know, but it still seems like the friendliest
interface.

Thanks,
  Roland
