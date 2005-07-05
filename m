Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVGETxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVGETxH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 15:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVGETxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 15:53:07 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:16345
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261500AbVGETw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 15:52:56 -0400
Date: Tue, 05 Jul 2005 12:52:42 -0700 (PDT)
Message-Id: <20050705.125242.104033031.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Subject: empty_zero_page
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why does mm/filemap_xip.c make an explicit reference to
"empty_zero_page"?  That's bogus, and ZERO_PAGE() is how
generic code should get at this thing.

In fact, what the mm/filemap_xip.c code wants is the page
struct, not the address of the page itself, because it
does a virt_to_page() on empty_zero_page in every such
reference.

This causes build failures for XIP support on sparc64.

When moving mm/filemap_xip.c over to ZERO_PAGE(), we will
need to determine the virtual address at which the ZERO_PAGE()
will be mapped.  This shouldn't be difficult to determine,
and it's incredibly important to get this right, wrt. page
coloring concerns, particularly on MIPS which does make use
of the 'vaddr' argument to ZERO_PAGE().
