Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263420AbTIHRYe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 13:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTIHRYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 13:24:33 -0400
Received: from havoc.gtf.org ([63.247.75.124]:29907 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263420AbTIHRYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 13:24:30 -0400
Date: Mon, 8 Sep 2003 13:24:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Adrian Bunk <bunk@fs.tum.de>, Manfred Spraul <manfred@colorfullife.com>,
       linux-kernel@vger.kernel.org, peter_daum@t-online.de
Subject: Re: [2.4 patch] fix CONFIG_X86_L1_CACHE_SHIFT
Message-ID: <20030908172416.GA21226@gtf.org>
References: <3F5B96C3.1060706@colorfullife.com> <20030908142046.GA28062@fs.tum.de> <20030908170751.GB27097@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030908170751.GB27097@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 08, 2003 at 06:07:51PM +0100, Jamie Lokier wrote:
> Adrian Bunk wrote:
> > > Why requires? On x86, the cpu caches are fully coherent. A too small L1 
> > > cache shift results in false sharing on SMP, but it shouldn't cause the 
> > > described problems.
> > >...
> > 
> > Thanks for the correction, I falsely thought CONFIG_X86_L1_CACHE_SHIFT 
> > does something different than it does.
> 
> Were there any changes in the kernel to do with PCI MWI settings?

Yes; I've lost the specific context of the thread, but I have been
working on MWI/cacheline size issues along with IvanK for a while.

It's apparently the responsibility of the OS to fill in correct
PCI_CACHE_LINE_SIZE values, which in the case of generic kernels must be
filled in at runtime (pci_cache_line_size) not at compile-time
(SMP_CACHE_BYTES, etc.)

If you don't call pci_set_mwi() for a PCI device, which triggers the
cacheline size fixups and other checks, then using
Memory-Write-Invalidate (MWI) is definitely wrong.  Or on an older
kernel, without the latest MWI changes, you could wind up programming
cacheline size to a value smaller than your current processor (again,
due to generic kernels).

If a feature/device/whatever can be programmed with cacheline size at
runtime, that will always be the preference.  With a compile-time
constant for cacheline size, you are _guaranteed_ it will be wrong in
some case.

	Jeff



