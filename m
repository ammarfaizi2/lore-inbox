Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262225AbVAEDSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262225AbVAEDSu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 22:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVAEDSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 22:18:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59363 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262225AbVAEDSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 22:18:46 -0500
Message-ID: <41DB5CE9.6090505@sgi.com>
Date: Tue, 04 Jan 2005 21:20:09 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Hirokazu Takahashi <taka@valinux.co.jp>, Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, stevel@mvista.com,
       andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
References: <41DB35B8.1090803@sgi.com> <m1wtusd3y0.fsf@muc.de>
In-Reply-To: <m1wtusd3y0.fsf@muc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Ray Bryant <raybry@sgi.com> writes:
> 
> 
>>http://sr71.net/patches/2.6.10/2.6.10-mm1-mhp-test7/
>>
>>A number of us are interested in using the page migration patchset by itself:
>>
>>(1)  Myself, for a manual page migration project I am working on.  (This
>>      is for migrating jobs from one set of nodes to another under batch
>>      scheduler control).
>>(2)  Marcello, for his memory defragmentation work.
>>(3)  Of course, the memory hotplug project itself.
>>
>>(there are probably other "users" that I have not enumerated here).
> 
> 
> Could you coordinate that with Steve Longerbeam (cc'ed) ? 
> 
> He has a NUMA API extension ready to be merged into -mm* that also
> does kind of page migration when changing the policies of files.
> 
> -Andi
> 
> 
Yes, Steve's patch tries to move page cache pages that are found to be 
allocated in the "wrong" place.  (See remove_invalid_filemap_page() in his
patch of 11/02/2004 on lkml).  But if the page is found to be busy, the code
gives up, as near as I can tell.

If the page migration patch were merged, Steve could call 
migrate_onepage(page,node) to move the page to the correct node. even if it
is busy [hopefully his code can "wait" at that point, I haven't looked into it 
further to see if that is the case.]

[This is really the page migration patch plus a small patch of
mine that addss the node argument to migrate_onepage(), and that I hope will
get merged into the page migration patch shortly]

Other than that, I don't see a big intersection between the two patches.
Steve, do you see anything else where we need to coordinate?

On the other hand, there is some work to be done wrt memory policies
and page migration.  For the project I am working on, we need to be able
to move all of the pages used by a process on one set of nodes to another
set of nodes.  At some point during this process we will need to update
the memory policy for that process.  For Steve's patch, we will
similarly need to update the policy associated with files associated with
the process, I would think, elsewise new pages will get allocated on the
old set of nodes, which is something we don't want.  Sounds like some
new interfaces will have to be developed here.  Does that make sense
to you, Andi and Steve?

My personal preference would be to keep as much of this as possible
under user space control; that is, rather than having a big autonomous
system call that migrates pages and then updates policy information,
I'd prefer to split the work into several smaller system calls that
are issued by a user space program responsible for coordinating the
process migration as a series of steps, e. g.:

(1)  suspend the process via SIGSTOP
(2)  update the mempolicy information
(3)  migrate the process's pages
(4)  migrate the process to the new cpu via set_schedaffinity()
(5)  resume the process via SIGCONT

that way the user program actually implements the process memory
migration fuctionality rather than having it all done by the kernel.
Thid also lets the user (or sys admin) modify or add new steps to
the page migration to satisfy local requirements without having to
modify the kernel.
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
