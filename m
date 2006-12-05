Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968279AbWLEPMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968279AbWLEPMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 10:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968282AbWLEPMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 10:12:48 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1659 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S968279AbWLEPMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 10:12:47 -0500
Date: Tue, 5 Dec 2006 14:42:00 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] SLAB : use a multiply instead of a divide in obj_to_index()
Message-ID: <20061205144159.GB4388@ucw.cz>
References: <4564C28B.30604@redhat.com> <4573B8DE.20205@redhat.com> <20061203222816.aaef93a3.akpm@osdl.org> <200612041741.51846.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612041741.51846.dada1@cosmosbay.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> When some objects are allocated by one CPU but freed by another CPU we can 
> consume lot of cycles doing divides in obj_to_index().
> 
> (Typical load on a dual processor machine where network interrupts are handled 
> by one particular CPU (allocating skbufs), and the other CPU is running the 
> application (consuming and freeing skbufs))
> 
> Here on one production server (dual-core AMD Opteron 285), I noticed this 
> divide took 1.20 % of CPU_CLK_UNHALTED events in kernel. But Opteron are 
> quite modern cpus and the divide is much more expensive on oldest 
> architectures :
> 
> On a 200 MHz sparcv9 machine, the division takes 64 cycles instead of 1 cycle 
> for a multiply.
> 
> Doing some math, we can use a reciprocal multiplication instead of a divide.
> 
> If we want to compute V = (A / B)  (A and B being u32 quantities)
> we can instead use :
> 
> V = ((u64)A * RECIPROCAL(B)) >> 32 ;
> 
> where RECIPROCAL(B) is precalculated to ((1LL << 32) + (B - 1)) / B

Well, I guess it should be gcc doing this optimalization, not we by
hand. And I believe gcc *is* smart enough to do it in some cases...

							pavel

-- 
Thanks for all the (sleeping) penguins.
