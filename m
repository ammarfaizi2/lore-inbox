Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262799AbVAKPgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbVAKPgj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 10:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbVAKPgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 10:36:38 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19593 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262799AbVAKPg0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 10:36:26 -0500
Message-ID: <41E3F2DA.5030900@sgi.com>
Date: Tue, 11 Jan 2005 09:38:02 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Longerbeam <stevel@mvista.com>
CC: Andi Kleen <ak@muc.de>, Hirokazu Takahashi <taka@valinux.co.jp>,
       Dave Hansen <haveblue@us.ibm.com>,
       Marcello Tosatti <marcelo.tosatti@cyclades.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, andrew morton <akpm@osdl.org>
Subject: Re: page migration patchset
References: <41DB35B8.1090803@sgi.com> <m1wtusd3y0.fsf@muc.de> <41DB5CE9.6090505@sgi.com> <41DC34EF.7010507@mvista.com>
In-Reply-To: <41DC34EF.7010507@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi and Steve,

Steve Longerbeam wrote:
<snip>

>>
>> My personal preference would be to keep as much of this as possible
>> under user space control; that is, rather than having a big autonomous
>> system call that migrates pages and then updates policy information,
>> I'd prefer to split the work into several smaller system calls that
>> are issued by a user space program responsible for coordinating the
>> process migration as a series of steps, e. g.:
>>
>> (1)  suspend the process via SIGSTOP
>> (2)  update the mempolicy information
>> (3)  migrate the process's pages
>> (4)  migrate the process to the new cpu via set_schedaffinity()
>> (5)  resume the process via SIGCONT
>>
> 
> steps 2 and 3 can be accomplished by a call to mbind() and
> specifying MPOL_MF_MOVE. And since mbind() takes an
> address range, you could probably migrate pages and change
> the policies for all of the process' mappings in a single mbind()
> call.

OK, I just got around to looking into this suggestion.  Unfortunately,
it doesn't look as if this will do what I want.  I need to be able to
conserve the topology of the application when it is migrated (required
to give the application the same performance in its new location that
it got in its old location).  So, I need to be able to say "take the
pages on this node and move them to that node".  The sys_mbind() call
doesn't have the necessry arguments to do this.  I'm thinking of
something like:

migrate_process_pages(pid, numnodes, oldnodelist, newnodelist);

This would scan the address space of process pid, and each page that
is found on oldnodelist[i] would be moved to node newnodelist[i].

Pages that are found to be swapped out would be handled as follows:
Add the original node id to either the swap pte or the swp_entry_t.
Swap in will be modified to allocate the page on the same node it
came from.  Then, as part of migrate_process_pages, all that would
be done for swapped out pages would be to change the "original node"
field to point at the new node.

However, I could probably do both steps (2) and (3) as part of the
migrate_process_pages() call.

Does this all seem reasonable?

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
