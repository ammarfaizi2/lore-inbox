Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263280AbTEMHax (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 03:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTEMHax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 03:30:53 -0400
Received: from palrel12.hp.com ([156.153.255.237]:19371 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S263280AbTEMHav convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 03:30:51 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16064.41491.952068.159814@napali.hpl.hp.com>
Date: Tue, 13 May 2003 00:43:15 -0700
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: davidm@hpl.hp.com, Dave Jones <davej@codemonkey.org.uk>,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: Improved DRM support for cant_use_aperture platforms
In-Reply-To: <1052786080.10763.310.camel@thor>
References: <200305101009.h4AA9GZi012265@napali.hpl.hp.com>
	<1052653415.12338.159.camel@thor>
	<16062.37308.611438.5934@napali.hpl.hp.com>
	<20030511195543.GA15528@suse.de>
	<1052690133.10752.176.camel@thor>
	<16063.60859.712283.537570@napali.hpl.hp.com>
	<1052768911.10752.268.camel@thor>
	<16064.453.497373.127754@napali.hpl.hp.com>
	<1052774487.10750.294.camel@thor>
	<16064.5964.342357.501507@napali.hpl.hp.com>
	<1052786080.10763.310.camel@thor>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On 13 May 2003 02:34:41 +0200, Michel Dänzer <michel@daenzer.net> said:

  >> It should be possible to add vmap() and vunmap() to kernel/vmalloc.c
  >> on older kernels.  I think those are the only dependencies

  Michel> There are a couple more, like pte_offset_kernel(), pte_pfn(),
  Michel> pfn_to_page() and flush_tlb_kernel_range(). Getting this working with
  Michel> 2.4 seems like a lot of work and/or ugly. :\

Actually, it turns out I'm really not well positioned to do this,
because the ia64 agp patch for 2.4 looks very different from the 2.5
and your tree looks rather different from the DRM stuff that's in the
official Linux tree (correct me if I'm wrong here).

Anyhow, this should get you close to compiling (and working,
hopefully), modulo vmap/vunmap:

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
# define pte_offset_kernel(dir, address)	pte_offset(dir, address)
# define pte_pfn(pte)				(pte_page(pte) - mem_map)
# define flush_tlb_kernel_range(s,e)		flush_tlb_all()
#endif

The above definition of pte_pfn() is not truly platform-independent,
but I believe it works on all platforms that support AGP.  The problem
is that we can't just use page_address(), because the physical address
in the PTE may not be a valid memory address (it could be an I/O
address).

	--david
