Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263088AbUFWWhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUFWWhX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 18:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUFWWdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 18:33:45 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:2769 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263041AbUFWWdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 18:33:14 -0400
Subject: Re: [Lhns-devel] Merging Nonlinear and Numa style memory hotplug
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <ygoto@us.fujitsu.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       Linux-Node-Hotplug <lhns-devel@lists.sourceforge.net>,
       linux-mm <linux-mm@kvack.org>,
       "BRADLEY CHRISTIANSEN [imap]" <bradc1@us.ibm.com>
In-Reply-To: <20040622114733.30A6.YGOTO@us.fujitsu.com>
References: <20040622114733.30A6.YGOTO@us.fujitsu.com>
Content-Type: text/plain
Message-Id: <1088029973.28102.269.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 23 Jun 2004 15:32:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thank you for merging nonlinear on top of your current
work.  It looks very promising.  

On Tue, 2004-06-22 at 12:00, Yasunori Goto wrote:
>   - Some of strucure's member are added to mem_section[] to 
>     unify between nonlinear and node style hotplug.

This quadruples the size of the mem_section[] array, and makes each
mem_section entry take up a whole cache line.  Are you sure all of these
structure members are needed?  Can they be allocated elsewhere, instead
of directly inside the translation tables, or otherwise derived?  Also,
why does the booked/free_count have to be kept here?  Can't that be
determined by simply looping through and looking at all the pages'
flags?

Also, can you provide a patch which is just your modifications to Dave's
original nonlinear patch?

Instead of remove_from_freelist(unsigned int section), I'd hope that we
could support a much more generic interface in the page allocator:
allocate by physical address.  remove_from_freelist() has some intimate
knowledge of the buddy allocator that I think is a bit complex.  

That also brings up a more important issue.  I see nonlinear as a
back-end for only the page_to_pfn() and pfn_to_page(), and that's all. 
There are no real exposures of the nonlinear section size or the
structures to any other part of the kernel because they're all wrapped
up in those functions.  It may be possible to keep the entire kernel
oblivious of nonlinear, but I think it's a worthy goal.  That's why I'd
like to see the buddy allocator modifications be limited to
currently-existing concepts like physical addresses.

Brad, do you have anything that you can post to demonstrate your
approach for doing allocation by address?

-- Dave

