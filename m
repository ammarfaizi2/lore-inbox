Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265373AbTFMMcv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 08:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbTFMMcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 08:32:51 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63704 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265373AbTFMMct
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 08:32:49 -0400
Date: Fri, 13 Jun 2003 18:18:54 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.70-bk16: nfs crash
Message-ID: <20030613124854.GB1204@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <Pine.LNX.4.44.0306120847540.2742-100000@home.transmeta.com> <Pine.LNX.4.44.0306120915190.2742-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306120915190.2742-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 09:18:11AM -0700, Linus Torvalds wrote:
> 
> 
[..]
> ---
> ===== include/linux/dcache.h 1.32 vs edited =====
> --- 1.32/include/linux/dcache.h	Tue Jun 10 14:56:43 2003
> +++ edited/include/linux/dcache.h	Thu Jun 12 09:12:27 2003
> @@ -174,8 +174,10 @@
>  
>  static inline void __d_drop(struct dentry *dentry)
>  {
> -	dentry->d_vfs_flags |= DCACHE_UNHASHED;
> -	hlist_del_rcu_init(&dentry->d_hash);
> +	if (!(dentry->d_vfs_flags & DCACHE_UNHASHED)) {
> +		dentry->d_vfs_flags |= DCACHE_UNHASHED;
> +		hlist_del_rcu(&dentry->d_hash);
> +	}
>  }

Looks like there is some problem in this. With this conditional
d_drop, umounting an NFS mount goes in a loop and oopses in dput()
This is on 2.5.70-bk17.

Unable to handle kernel paging request at virtual address 00100104
 printing eip:
c016f9b1
*pde = 00000000
Oops: 0002 [#1]
CPU:    3
EIP:    0060:[<c016f9b1>]    Not tainted
EFLAGS: 00010246
EIP is at dput+0x1f1/0x350
eax: 00100100   ebx: f72a8c80   ecx: f72a8c9c   edx: 00200200
esi: f64d2000   edi: f72a8c88   ebp: 00000000   esp: f64d3e8c
ds: 007b   es: 007b   ss: 0068
Process umount (pid: 926, threadinfo=f64d2000 task=f79d9900)
Stack: 00000010 c016007b 0000007b ffffffef f72a8c80 f6448380 f64481e0 c02fccca
       f72a8c80 f6448380 f72a8cf8 f72a8820 f72a8820 f6448860 c035f8e0 c02fd1c0
       f72a8820 f78775e0 f7fde560 f74971d9 00000005 10ee271a 00000010 00000000
Call Trace:
 [<c016007b>] bd_claim+0x2b/0xa0
 [<c02fccca>] rpc_depopulate+0x16a/0x190
 [<c02fd1c0>] rpc_rmdir+0x60/0xa0
 [<c02f2a4d>] rpcauth_destroy+0xd/0x60
 [<c02ec45d>] rpc_destroy_client+0x4d/0x70
 [<c01b6427>] nfs_put_super+0x17/0x40
 [<c015e03f>] generic_shutdown_super+0xbf/0x200
 [<c015eec0>] kill_anon_super+0x10/0x80
 [<c01b8811>] nfs_kill_super+0x11/0x20
 [<c015dcf9>] deactivate_super+0xa9/0x140
 [<c0175d08>] __mntput+0x18/0x30
 [<c0165e79>] path_release+0x29/0x30
 [<c0176641>] sys_umount+0x81/0x90
 [<c015710f>] sys_close+0x9f/0x100
 [<c017665c>] sys_oldumount+0xc/0x10
 [<c0109477>] syscall_call+0x7/0xb


Removing the DCACHE_UNHASHED check makes it work again. Needs more
investigation. 


-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
