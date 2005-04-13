Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVDMTKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVDMTKc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 15:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVDMTKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 15:10:32 -0400
Received: from webmail.topspin.com ([12.162.17.3]:49171 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261214AbVDMTJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 15:09:38 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andrew Morton <akpm@osdl.org>, libor@topspin.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
X-Message-Flag: Warning: May contain useful information
References: <200544159.Ahk9l0puXy39U6u6@topspin.com>
	<20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com>
	<20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com>
	<20050411180107.GF26127@kalmia.hozed.org> <52oeclyyw3.fsf@topspin.com>
	<20050411171347.7e05859f.akpm@osdl.org> <521x9gyhe7.fsf@topspin.com>
	<20050412182357.GA24047@mellanox.co.il>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 13 Apr 2005 11:28:03 -0700
In-Reply-To: <20050412182357.GA24047@mellanox.co.il> (Michael S. Tsirkin's
 message of "Tue, 12 Apr 2005 21:23:57 +0300")
Message-ID: <52sm1upm4s.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Apr 2005 18:28:03.0688 (UTC) FILETIME=[87A2B680:01C54056]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I'm by no means an expert on this, but Libor and I looked at
rmap.c a little more, and there is code:

	if ((vma->vm_flags & (VM_LOCKED|VM_RESERVED)) ||
			ptep_clear_flush_young(vma, address, pte)) {
		ret = SWAP_FAIL;
		goto out_unmap;
	}

before the check

	if (PageSwapCache(page) &&
	    page_count(page) != page_mapcount(page) + 2) {
		ret = SWAP_FAIL;
		goto out_unmap;
	}

If userspace allocates some memory but doesn't touch it aside from
passing the address in to the kernel, which does get_user_pages(), the
PTE will be young in that first test, right?  Does that mean that
the userspace mapping will be cleared and userspace will get a
different physical page if it faults that address back in?

 - R.


