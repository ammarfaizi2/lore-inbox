Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTKPKPk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 05:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTKPKPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 05:15:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24595 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262655AbTKPKPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 05:15:39 -0500
Date: Sun, 16 Nov 2003 10:15:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Bootmem broke ARM
Message-ID: <20031116101535.A592@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew & others,

2.6 contains a change to init_bootmem_core() which now sorts the nodes
according to their start pfn.  This change occurred in revision 1.20 of
bootmem.c.  Unfortunately, this active sorting broke ARM discontig memory
support.

With previous kernels, the nodes are added to the list in reverse order,
so architecture code knew we had to add the highest PFN first and the
lowest PFN node last.

However, we now sort the nodes using node_start_pfn, which, at this point,
will be uninitialised - the responsibility for initialising this field
is with the generic code - in free_area_init_node() which occurs well
after bootmem has been initialised.

The result of this change is that we now add nodes to the tail of the
pgdat list, which is the opposite way to 2.4.

This causes problems for ARM because we need to use bootmem to initialise
the kernels page tables, and we can only allocate these from node 0 - none
of the other nodes are mapped into memory at this point.

I, therefore, believe this change is bogus.  Can it be reverted please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
