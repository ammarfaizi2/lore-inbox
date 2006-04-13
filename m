Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWDMHYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWDMHYD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 03:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbWDMHYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 03:24:01 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56458 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964816AbWDMHYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 03:24:01 -0400
Date: Thu, 13 Apr 2006 17:23:25 +1000
From: David Chinner <dgc@sgi.com>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com
Cc: jes@sgi.com, stern@rowland.harvard.edu, sekharan@us.ibm.com, akpm@osdl.org
Subject: notifier chain problem? (was Re: 2.6.17-rc1 did break XFS)
Message-ID: <20060413072325.GF2732@melbourne.sgi.com>
References: <20060413052145.GA31435@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060413052145.GA31435@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2006 at 07:21:45AM +0200, Herbert Poetzl wrote:
> 
> # grep XFS .config
> CONFIG_XFS_FS=y
> CONFIG_XFS_EXPORT=y
> CONFIG_XFS_QUOTA=y
> # CONFIG_XFS_SECURITY is not set
> # CONFIG_XFS_POSIX_ACL is not set
> # CONFIG_XFS_RT is not set
> 
> if you need more information, please let me know ...

I don't think this is an XFS bug....

> [   39.585041] BUG: unable to handle kernel paging request at virtual address 7856c380
> [   39.586688]  printing eip:
> [   39.587040] 78129430
> [   39.587354] *pde = 005bf027
> [   39.587709] *pte = 0056c000
> [   39.588201] Oops: 0000 [#1]
> [   39.588536] SMP DEBUG_PAGEALLOC
> [   39.589057] Modules linked in:
> [   39.589639] CPU:    0
> [   39.589670] EIP:    0060:[<78129430>]    Not tainted VLI
> [   39.589710] EFLAGS: 00000206   (2.6.17-rc1 #1) 
> [   39.591291] EIP is at notifier_chain_register+0x20/0x50
> [   39.591890] eax: 7856c378   ebx: 878db3f8   ecx: 00000000   edx: 784bf9bc
> [   39.592601] esi: 878db3f8   edi: 878e7c00   ebp: 878db800   esp: 878cad5c
> [   39.593399] ds: 007b   es: 007b   ss: 0068
> [   39.593896] Process mount (pid: 50, threadinfo=878ca000 task=87f7e570)
> [   39.594530] Stack: <0>784bf9a0 781295f4 784bf9bc 878db3f8 878db000 878db000 78136997 784bf9a0 
> [   39.595839]        878db3f8 782d43e6 878db3f8 00000404 878db000 87d1e6a0 878e7c00 782d1813 
> [   39.597002]        878db000 00000001 782e5eaf 00000424 00000001 878e7c00 87d1e6a0 782f2150 
> [   39.598164] Call Trace:
> [   39.598592]  <781295f4> blocking_notifier_chain_register+0x54/0x90   <78136997> register_cpu_notifier+0x17/0x20
> [   39.600024]  <782d43e6> xfs_icsb_init_counters+0x46/0xb0   <782d1813> xfs_mount_init+0x23/0x160

It looks like we landed on top of a a notifier call chain
implementation change in -rc1. However, this should not matter to
XFS because the interface to register_cpu_notifier() did not change
and XFS is completely abstracted away from the notifier chain
implementation. We do:

       mp->m_icsb_notifier.notifier_call = xfs_icsb_cpu_notify;
       mp->m_icsb_notifier.priority = 0;
       register_cpu_notifier(&mp->m_icsb_notifier);

and the mp structure is kzalloc()d almost immediately before this.  The definition
of m_icsb_notifier in the struct xfs_mount (mp) is:

	struct notifier_block   m_icsb_notifier; /* hotplug cpu notifier */

I can't see anything wrong with this, but maybe others can see a problem with
this.

Hence I suspect this is a bug in the new notifier call chain code. Adding a few
ppl involved in the notifier chain work to the cc list.

Cheers,

Dave.
-- 
Dave Chinner
R&D Software Enginner
SGI Australian Software Group
