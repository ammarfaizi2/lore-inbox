Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261269AbVBVSkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVBVSkj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 13:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVBVSkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 13:40:39 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:33200 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261269AbVBVSk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 13:40:27 -0500
Message-ID: <421B7DC1.8070504@sgi.com>
Date: Tue, 22 Feb 2005 12:45:21 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Paul Jackson <pj@sgi.com>, ak@muc.de, raybry@austin.rr.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
 II
References: <20050217235437.GA31591@wotan.suse.de> <4215A992.80400@sgi.com> <20050218130232.GB13953@wotan.suse.de> <42168FF0.30700@sgi.com> <20050220214922.GA14486@wotan.suse.de> <20050220143023.3d64252b.pj@sgi.com> <20050220223510.GB14486@wotan.suse.de> <42199EE8.9090101@sgi.com> <20050221121010.GC17667@wotan.suse.de> <421AD3E6.8060307@sgi.com> <20050222180122.GO23433@wotan.suse.de>
In-Reply-To: <20050222180122.GO23433@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> 
> How about you add the va_start, va_end but only accept them 
> when pid is 0 (= current process). Otherwise enforce with EINVAL
> that they are both 0. This way you could map the
> shared object into the batch manager, migrate it there, then
> mark it somehow to not be migrated further, and then
> migrate the anonymous pages using migrate_pages(pid, ...) 
>

We'd have to use up a struct page flag (PG_MIGRATED?) to mark
the page as migrated to keep the call to migrate_pages() for
the anonymous pages from migrating the pages again.  Then we'd
have to have some way to clear PG_MIGRATED once all of the
migrate_pages() calls are complete (we can't have the anonymous
page migrate_pages() calls clear the flags, since the second
such call would find the flag clear and remigrate the pages
in the overlapping nodes case.)

How about ignoring the va_start and va_end values unless
either:

       pid == current->pid
   or  current->euid == 0 /* we're root */

I like the first check a bit better than checking for 0.  Are
there other system calls that follow that convention (e. g.
pid = 0 implies current?)

The second check lets a sufficiently responsible task manipulate
other tasks.  This task can choose to have the target tasks
suspended before it starts fussing with them.

> BTW it might be better to make va_end a size, just to be more
> symmetric with mlock,madvise,mmap et.al.
> 

Yes,.that's been pointed out to me before.  Let's make it so.

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
