Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVBUH0q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVBUH0q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 02:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVBUH0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 02:26:46 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:49386 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261911AbVBUH01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 02:26:27 -0500
Message-ID: <42198DE5.2040703@sgi.com>
Date: Mon, 21 Feb 2005 01:29:41 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Paul Jackson <pj@sgi.com>, ak@muc.de, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
References: <20050215121404.GB25815@muc.de> <421241A2.8040407@sgi.com> <20050215214831.GC7345@wotan.suse.de> <4212C1A9.1050903@sgi.com> <20050217235437.GA31591@wotan.suse.de> <4215A992.80400@sgi.com> <20050218130232.GB13953@wotan.suse.de> <42168FF0.30700@sgi.com> <20050220214922.GA14486@wotan.suse.de> <20050220143023.3d64252b.pj@sgi.com> <20050220223510.GB14486@wotan.suse.de>
In-Reply-To: <20050220223510.GB14486@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>>Do you have any better way to suggest, Andi, for a batch manager to
>>relocate a job?  The typical scenario, as Ray explained it to me, is
> 
> 
> - Give the shared libraries and any other files a suitable policy
> (by mapping them and applying mbind) 
> 
> - Then execute migrate_pages() for the anonymous pages with a suitable
> old node -> new node mapping.
> 
> 
>>How would you recommend that the batch manager move that job to the
>>nodes that can run it?  The layout of allocated memory pages and tasks
>>for that job must be preserved in order to keep the same performance.
>>The migration method needs to scale to hundreds, or more, of nodes.
> 
> 
> You have to walk to full node mapping for each array, but
> even with hundreds of nodes that should not be that costly
> (in the worst case you could create a small hash table for it
> in the kernel, but I'm not sure it's worth it) 
> 
> -Andi
> -

I'm going to assume that there have been some "crossed emails" here.
I don't think that this is the interface that you and I have been
converging on.  As I understood it, we were converging on the following:

(1)  extended attributes will be used to mark files as non-migratable
(2)  the page_migrate() system call will be defined as:

          page_migrate(pid, count, old_nodes, new_nodes);

      and it will migrate all pages that are either anonymous or part
      of mapped files that are not marked non-migratable.
(3)  The mbind() system call with MPOL_MF_STRICT will be hooked up
      to the migration code so that it actually causes a migration.
      Processes can use this interface to migrate a portion of their own
      address space containing a mapped file.

This is different than your reply above, which seems to imply that:

(A)  Step 1 is to migrate mapped files using mbind().  I don't understand
      how to do this in general, because:
      (a)  I don't know how to make a non-racy list of the mapped files to
           migrate without assuming that the process to be migrated is stopped
and  (b)  If the mapped file is associated with the DEFAULT memory policy,
           and page placement was done by first touch, then it is not clear
           how to use mbind() to cause the pages to be migrated, and still
           end up with the identical topological placement of pages after
           the migration.
(B)  Step 2 is to use page_migrate() to migrate just the anonymous pages.
      I don't like the restriction of this to just anonymous pages.

Fundamentally, I don't see why (A) is much different from allowing one
process to manipulate the physical storage for another process.  It's
just stated in terms of mmap'd objects instead of pid's.  So I don't
see why that is fundamentally different from a page_migration() call
with va_start and va_end arguments.

So I'm going to assume that the agreement was really (1)-(3) above.

The only problem I see with that is the following:  Suppose that a user
wants to migrate a portion of their own address space that is composed
of (at last partly) anonymous pages or pages mapped to a file associated
with the DEFAULT memory policy, and we want the pages to be toplogically
allocated the same way after the migration as they were before the
migration?

The only way I know how to do the latter is with a system call of the form:

	page_migrate(pid, va_start, va_end, count, old_nodes, new_nodes);

where the permission model is that a pid can migrate any process that it
can send a signal to.  So a root pid can migrate any process, and a user
pid can migrate pages of any pid started by the user.
-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
