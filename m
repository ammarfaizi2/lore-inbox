Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266038AbUA1VNI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 16:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266091AbUA1VNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 16:13:08 -0500
Received: from palrel10.hp.com ([156.153.255.245]:15234 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S266038AbUA1VM6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 16:12:58 -0500
Date: Wed, 28 Jan 2004 13:14:05 -0800
From: Grant Grundler <iod00d@hp.com>
To: Andi Kleen <ak@suse.de>
Cc: ishii.hironobu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [RFC/PATCH, 1/4] readX_check() performance evaluation
Message-ID: <20040128211405.GG5722@cup.hp.com>
References: <00a201c3e541$c0e7d680$2987110a@lsd.css.fujitsu.com> <20040128172004.GB5494@cup.hp.com> <20040128184137.616b6425.ak@suse.de> <20040128190923.GA6333@cup.hp.com> <20040128201701.045670db.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128201701.045670db.ak@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 08:17:01PM +0100, Andi Kleen wrote:
> This would likely 
> improve the quality of linux drivers long term and make your
> job as maintainer of an "anal IO error" platform easier.

yup. The key drivers we deal with reached that point last year.
Drivers could always be better. But those issues have been discussed
and presented:
o LinuxTag 2002 keynote by Alan Cox, "Submitting new Kernel drivers"
	(http://gsyprf11.external.hp.com/porting_zx1/mgp/Code.mgp)
o OLS 2002 talk by Arjan van de Ven, "How not to write kernel drivers"
o OLS 2002 talk by Greg K-H, "Documentation/CodingStyle and Beyond"
o OLS 2002 talk by myself, "Porting Drivers to HP ZX1"

It helps to "enforce" driver quality through "anal IO Error containment"
but it's too late when it happens on a customer box.

> Just it should not be enabled by default in production kernels.
> And finding out where it works reliably will be some work.

agreed.

> There is no reason pci_map_single() has to panic on overflow. On x86-64
> it returns an unmapped address that is guaranteed to cause an bus abort
> for 128KB.

parisc and ia64 will also bus abort. And then HPMC/MCA respectively.
We could reserve a "safe page" and then hand that back I guess.
But that sounds like a very broken error containment strategy to me.
(ie outbound data will be garbage).

This really isn't an issue for HP ZX1/IA64 since most drivers (64-bit)
can bypass the IOMMU and directly address memory. parisc-linux still
isn't commercially interesting.

> And you have an macro to test for it (pci_dma_error()). 

I didn't know about pci_dma_error.
Google found two references: One is:
	http://www.x86-64.org/lists/discuss/msg03841.html

> I believe ppc64 has adopted it too. Of course most drivers don't 
> use it yet.

<search 2.6.2-rc2 source tree>
grundler <502>find -name '*.[chS]' | xargs fgrep pci_dma_error
./include/asm-x86_64/pci.h:#define pci_dma_error(x) ((x) ==
bad_dma_address)
grundler <503>

That explains why most drivers don't use it yet.
It's only supported on one arch.
Maybe propose this to linux-pci mailing list?

grant
