Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWBFOsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWBFOsu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWBFOsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:48:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:9618 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932136AbWBFOst (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:48:49 -0500
Message-ID: <43E762C0.6030300@In.ibm.com>
Date: Mon, 06 Feb 2006 20:22:48 +0530
From: Suzuki <suzuki@In.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
CC: akpm@osdl.org
Subject: [PATCH] Fix do_path_lookup() to add the check for error in link_path_walk()
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I encountered an oops with 2.6.16-rc1-git3 kernel ( SLES 10 B2 kernel ), 
while running racer tests. The problem was hit in audit_inode() with the 
following stack trace :

Jan 31 19:15:27 x236 klogd:Unable to handle kernel paging request at 
virtual address 6b6b6b8b
Jan 31 19:15:27 x236 klogd: CPU:    3
Jan 31 19:15:27 x236 klogd: EIP:    0060:[<c013ffbd>]    Tainted: G 
U VLI
Jan 31 19:15:27 x236 klogd: EFLAGS: 00010282   (2.6.16-rc1-git3-4-smp)
Jan 31 19:15:27 x236 klogd: EIP is at audit_inode+0x78/0xa9
Jan 31 19:15:27 x236 klogd: eax: d29da000   ebx: ccc23638   ecx: 0000001
edx: ccc23638
Jan 31 19:15:27 x236 klogd: esi: 6b6b6b6b   edi: d29da000   ebp: 0000001
esp: ce4d7ecc
Jan 31 19:15:27 x236 klogd: ds: 007b   es: 007b   ss: 0068
Jan 31 19:15:27 x236 klogd: Process ln (pid: 12674, threadinfo=ce4d6000 
task=e49df550)
Jan 31 19:15:27 x236 klogd: Call Trace:
Jan 31 19:15:27 x236 klogd:  [<c016a843>] do_path_lookup+0x225/0x22f
Jan 31 19:15:27 x236 klogd:  [<c016af42>] __user_walk_fd+0x29/0x3a
Jan 31 19:15:27 x236 klogd:  [<c0164e7e>] vfs_stat_fd+0x15/0x3c
Jan 31 19:15:27 x236 klogd:  [<c014ca1c>] __handle_mm_fault+0x439/0x7a0
Jan 31 19:15:27 x236 klogd:  [<c0164f32>] sys_stat64+0xf/0x23
Jan 31 19:15:27 x236 klogd:  [<c0106d26>] do_syscall_trace+0x123/0x169
Jan 31 19:15:27 x236 klogd:  [<c0103c09>] syscall_call+0x7/0xb

I found the root cause of the problem to be the lack of error-check in 
do_path_lookup() for the link_path_walk().

in do_path_lookup:


                 fput_light(file, fput_needed);
         }
         read_unlock(&current->fs->lock);
         current->total_link_count = 0;
         retval = link_path_walk(name, nd); <----- No check for retval !
out:
         if (unlikely(current->audit_context
                      && nd && nd->dentry && nd->dentry->d_inode))
                 audit_inode(name, nd->dentry->d_inode, flags);
out_fail:
         return retval;
}

If link_path_walk returns error, the inode may not be reliable. This 
causes the oops in audit_inode.

The bug is there in 2.6.16-rc2 also. I believe the problem in Bugme 
#5897 also has the same root cause, though it has different call path.

The patch attached below fixes the issue. I have tested it on 
2.6.16-rc1-git3 with racer tests and it works fine.

Thanks,

Suzuki K P
Linux Technology Centre
IBM Software Labs,


-------------------------------------------------------------------------------------------

Fixes do_path_lookup() to avoid accessing invalid dentry or inode when 
the link_path_walk() has failed. This should fix Bugme #5897.

Signed Off by: Suzuki K P <suzuki@in.ibm.com>

--- fs/namei.c  2006-02-06 06:10:53.000000000 -0800
+++ fs/namei.c~fix-do-path-lookup       2006-02-06 11:33:59.000000000 -0800
@@ -1122,6 +1122,8 @@ static int fastcall do_path_lookup(int d
         read_unlock(&current->fs->lock);
         current->total_link_count = 0;
         retval = link_path_walk(name, nd);
+       if(retval)
+               goto out_fail;
  out:
         if (unlikely(current->audit_context
                      && nd && nd->dentry && nd->dentry->d_inode))



