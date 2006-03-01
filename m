Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750733AbWCAUEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733AbWCAUEy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 15:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbWCAUEy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 15:04:54 -0500
Received: from mx.pathscale.com ([64.160.42.68]:18658 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750733AbWCAUEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 15:04:54 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andi Kleen <ak@suse.de>
Cc: Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200603012049.32670.ak@suse.de>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <200603012027.55494.ak@suse.de>
	 <1141242206.2899.109.camel@localhost.localdomain>
	 <200603012049.32670.ak@suse.de>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 12:05:07 -0800
Message-Id: <1141243508.2899.126.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-2.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-01 at 20:49 +0100, Andi Kleen wrote:

> Relying on undocumented side effects of instructions as you're trying
> to do here is not very reliable and would likely cause breakage later.

I just quoted you the precise relevant semantics of sfence two messages
earlier, from the AMD64 optimisation guide.  Here's the same thing from
the EM64T optimisation guide.  See page 444 of the following PDF:

        ftp://download.intel.com/design/Pentium4/manuals/25366818.pdf

Here's the relevant quote:

        Writes may be delayed and combined in the write combining buffer
        (WC buffer) to reduce memory accesses. If the WC buffer is
        partially filled, the writes may be delayed until the next
        occurrence of a serializing event; such as, an SFENCE or MFENCE
        instruction, [...]
        
If you read section 10.3.1 of the same document (page 446), you'll see
that a CLFLUSH (as you suggested earlier) won't even work to get the WC
buffers to flush, because they're not part of the regular cache
hierarchy.

This section also makes it clear yet again that wmb() is absolutely not
sufficient to get program store order semantics in the presence of WC;
you *have* to use an explicit synchronising instruction of some kind.

This is pretty frustrating.  I'm quoting the manufacturer documentation
at you, and you're handwaving back at me with complete nonsense.

	<b

