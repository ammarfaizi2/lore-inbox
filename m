Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932091AbWG1BN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWG1BN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 21:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751654AbWG1BN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 21:13:59 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:32934
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751276AbWG1BN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 21:13:58 -0400
Date: Thu, 27 Jul 2006 18:13:56 -0700 (PDT)
Message-Id: <20060727.181356.71087770.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060707.000524.112600047.davem@davemloft.net>
References: <200607060937.k669bZT3017256@harpo.it.uu.se>
	<20060707.000524.112600047.davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 07 Jul 2006 00:05:24 -0700 (PDT)

> I'll have to figure out how the writeable bits get lost
> in the call chain.

Actually, I digged further, things seem correct.

Initially we only set the SW-writable bit, and this is the right thing
to do for a MAP_SHARED writable mapping.

If the process actually tries to write to the mapping, the page fault
path will set the two bits that actually enable writes, namely the
HW-writable bit and the SW-dirty bit.

This occurs when pte_mkdirty() is called on the PTE during the
execution of mm/memory.c:handle_pte_fault(), right here:

	if (write_access) {
		if (!pte_write(entry))
			return do_wp_page(mm, vma, address,
					pte, pmd, ptl, entry);
		entry = pte_mkdirty(entry);
	}

pte_write() will return true, since the SW-writable bit is set.  So we
don't should not invoke do_wp_page(), and we'll just set the dirty bit
on the existing PTE.

For some reason that isn't happening properly, or something keeps
clearing the HW-writable bit on us.  Another possibility is that
one of these operations sets the cacheable bits, or clears the
side-effect bit, either of which would cause corruption or other
problems when accessing the ATI card through such a mapping.

I wonder why.... I'll try to run some experiments on my system to try
and get to the bottom of this.
