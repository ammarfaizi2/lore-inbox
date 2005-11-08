Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVKHOwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVKHOwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 09:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVKHOwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 09:52:45 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:25363 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S964905AbVKHOwo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 09:52:44 -0500
Message-ID: <4370BB8B.9060705@shadowen.org>
Date: Tue, 08 Nov 2005 14:51:55 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Kravetz <kravetz@us.ibm.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] Memory Add Fixes for ppc64
References: <20051104231552.GA25545@w-mikek2.ibm.com> <20051104231800.GB25545@w-mikek2.ibm.com> <1131149070.29195.41.camel@gaston> <20051107204743.GC5821@w-mikek2.ibm.com>
In-Reply-To: <20051107204743.GC5821@w-mikek2.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz wrote:

> Just curious if we still want to boost MAX_ORDER like this with 64k
> pages?  Doesn't that make the MAX_ORDER block size 256MB in this case?
> Also, not quite sure what happens if memory size (a 16 MB multiple)
> does not align with a MAX_ORDER block size (a 256MB multiple in this
> case).  My 'guess' is that the page allocator would not use it as it
> would not fit within the buddy system.

The buddy system and the SPARSEMEM mem_map are separate really.  The key
limitation is the a MAX_ORDER chunk must fit within the SPARSEMEM block
size it cannot span two blocks.  This is because the algorithm by which
the buddy system finds buddies for a returning allocation assumes that
mem_map is contigious upto the maximum buddy size (MAX_ORDER); it
assumes it can use relative addressing to locate them.

The buddy system doesn't really care about the alignment of any of its
blocks.  The allocator is built empty and all existant pages are freed
back to it.  If there is a chunk of memory which can never coalesce back
to MAX_ORDER it will simply sit lower in the tree 'waiting' for these
non-existant buddies and will never merge.  It will still be usable.

-apw
