Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbSKNQJ7>; Thu, 14 Nov 2002 11:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264946AbSKNQJ7>; Thu, 14 Nov 2002 11:09:59 -0500
Received: from dialin-83194.ewetel.net ([212.6.83.194]:36620 "EHLO
	florz.dyndns.org") by vger.kernel.org with ESMTP id <S264945AbSKNQJ6>;
	Thu, 14 Nov 2002 11:09:58 -0500
Date: Thu, 14 Nov 2002 17:16:50 +0100
From: Florian Zumbiehl <florz@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Wrong size calculation in __ioremap(), various platforms
Message-ID: <20021114161649.GA831@florz.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

in arch/*/mm/ioremap.c, __ioremap() of several platforms there seems to
be a minor mistake in the calculation of the page-aligned mapping size:

void * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
{
	void * addr;
	struct vm_struct * area;
	unsigned long offset, last_addr;

	/* Don't allow wraparound or zero size */
	last_addr = phys_addr + size - 1;
	if (!size || last_addr < phys_addr)
		return NULL;

	/* ... code which doesn't change last_addr ... */

	size = PAGE_ALIGN(last_addr) - phys_addr;

	/* ... */
}

For this calculation to work, PAGE_ALIGN(last_addr) would have to be
the address immediately after the last address to be mapped - if
last_addr is the first address of a page however, PAGE_ALIGN() of course
"returns" it unchanged.

So, the correct version IMO should look like this:

	size = PAGE_ALIGN(last_addr + 1) - phys_addr;

(2.5.47?/)i386 even seems to be affected twice - bt_ioremap() contains the
same piece of code.

In the hope not to have overlooked something,

Florian
