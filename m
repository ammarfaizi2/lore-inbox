Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbUC2Gsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 01:48:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUC2Gsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 01:48:40 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:51709 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262711AbUC2Gsh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 01:48:37 -0500
Date: Mon, 29 Mar 2004 12:23:09 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: BUG: Problem with your patches for sysfs from 2 weeks ago
Message-ID: <20040329065309.GA4531@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <Pine.LNX.4.44L0.0403271705250.32373-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0403271705250.32373-100000@netrider.rowland.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2004 at 05:25:07PM -0500, Alan Stern wrote:
> Maneesh:
> 
> I've been tracing a problem with sysfs that starting showing up just
> recently, and it seems likely to have originated with your patches from a
> couple of weeks ago.  I can't tell exactly what's wrong or fix it because
> I don't understand the filesystem layer well enough.
> 
> The problem I found (there may be others) shows up when trying to delete a 
> nonexistent symlink -- presumably trying to delete a nonexistent file 
> would have a similar result.  The code in sysfs_hash_and_remove() does a 
> lookup on the nonexistent name and sysfs_get_dentry() returns a 
> newly-allocated dentry.  Creating the new entry increments the parent 
> directory's d_count, of course.  But at the end of the routine, when 
> dput() is called for the new dentry, the parent's d_count does _not_ get 
> decremented.  The new dentry is placed on the dentry_unused list and the 
> parent is left with an anomalously large d_count.  This doesn't ever seem 
> to get resolved, and when the directory's kobject is deleted the reference 
> you added doesn't get dropped.
> 

I see the problem here. Probably same will happen even if a non-existent 
regular file is deleted. Negative dentry and the ref. taken on the parent
should go away eventually when there is a memory pressure. But the situation
here needs immediate removal of the negative dentry.

This could be solved partially if sysfs_hash_and_remove() handles negative 
dentries as well by unhashing them before calling dput(). 

Partially because sysfs_hash_and_remove() is called only if some kernel 
level code (drivers) issues sysfs_remove_file() or sysfs_create_file(). 
But if a user just goes to the corresponding directory and does rm 
for a non-existent file, I guess we will have the same situation. This needs
some solution.

The patch (sysfs-pin-kobject.patch) I did was required for oops 
(Use after free) situations like this

=============================================================================
Unable to handle kernel paging request at virtual address db368dc0
 printing eip:
c01f8690
*pde = 5a5a5a5a
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c01f8690>]    Not tainted
EFLAGS: 00010282
EIP is at kobject_get+0x10/0x50
eax: db368da8   ebx: db368da8   ecx: 00000001   edx: d6d0ff68
esi: db69ee88   edi: db69ee88   ebp: d7ed3f0c   esp: d7ed3ef8
ds: 007b   es: 007b   ss: 0068
Process cat (pid: 30394, threadinfo=d7ed2000 task=d63dc9b0)
Stack: c014a447 d6d0ff68 c1fb9aec 00000001 d6d0ff68 d7ed3f30 c019f500 db368da8
       d7ed3f30 c016601b d6d0ff68 d6d0ff68 db69ee88 c1fa9c44 d7ed3f50 c01640ec
       db69ee88 d6d0ff68 ffffffe9 00008000 00008000 d975e000 d7ed3f9c c0163fa6
Call Trace:
 [<c014a447>] kmem_cache_alloc+0x107/0x240
 [<c019f500>] check_perm+0x20/0x190
 [<c016601b>] get_empty_filp+0x7b/0x110
 [<c01640ec>] dentry_open+0x13c/0x1f0
 [<c0163fa6>] filp_open+0x66/0x70
 [<c0164545>] sys_open+0x55/0x90
 [<c010b651>] sysenter_past_esp+0x52/0x71
                                                                                
Code: 8b 43 18 85 c0 74 0d f0 ff 43 18 89 d8 8b 5d fc 89 ec 5d c3


-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
