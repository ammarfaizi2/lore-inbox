Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261958AbVBUMKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261958AbVBUMKl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 07:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261959AbVBUMKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 07:10:41 -0500
Received: from ns.suse.de ([195.135.220.2]:57236 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261958AbVBUMKP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 07:10:15 -0500
Date: Mon, 21 Feb 2005 13:10:11 +0100
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Paul Jackson <pj@sgi.com>, ak@muc.de,
       raybry@austin.rr.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview II
Message-ID: <20050221121010.GC17667@wotan.suse.de>
References: <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com> <20050217235437.GA31591@wotan.suse.de> <4215A992.80400@sgi.com> <20050218130232.GB13953@wotan.suse.de> <42168FF0.30700@sgi.com> <20050220214922.GA14486@wotan.suse.de> <20050220143023.3d64252b.pj@sgi.com> <20050220223510.GB14486@wotan.suse.de> <42199EE8.9090101@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42199EE8.9090101@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 02:42:16AM -0600, Ray Bryant wrote:
> All,
> 
> Just an update on the idea of migrating a process without suspending
> it.
> 
> The hard part of the problem here is to make sure that the page_migrate()
> system call sees all of the pages to migrate.  If the process that is
> being migrated can still allocate pages, then the page_migrate() call
> may miss some of the pages.

I would do an easy 95% solution:

When process has default process policy set temporarily a prefered policy
with the new node

[this won't work with multiple nodes though, so you have to decide on one
or stop the process if that is unacceptable] 

> 
> One way to solve this problem is to force the process to start allocating
> pages on the new nodes before calling page_migrate().  There are a couple
> of subcases:
> 
> (1)  For memory mapped files with a non-DEFAULT associated memory policy,
>      one can use mbind() to fixup the memory policy.  (This assumes the
>      Steve Longerbeam patches are applied, as I understand things).

I would just ignore them.  If user space wants it can handle it,
but it's probably not worth it.

> (1) could be handled as part of the page_migrate() system call --
> make one pass through the address space searching for mempolicy()
> data structures, and updating them as necessary.  Then make a second
> pass through and do the migrations.  Any new allocations will then
> be done under the new mempolicy, so they won't be missed.  But this
> still gets us into trouble if the old and new node lists are not
> disjoint.

I wouldn't bother fixing up VMA policies. 

> This doesn't handle anonymous memory or mapped files associated with
> the DEFAULT policy.  A way around that would be to add a target cpu_id

[...]

I would set temporarily a prefered policy as mentioned above.

That only handles a single node, but you solution is not better.

-Andi
