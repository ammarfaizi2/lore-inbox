Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751072AbWDJJXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbWDJJXP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751082AbWDJJXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:23:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28880 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751072AbWDJJXN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:23:13 -0400
Date: Mon, 10 Apr 2006 01:22:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au, prasanna@in.ibm.com,
       davem@davemloft.net, mita@miraclelinux.com
Subject: Re: [patch 2/8] use hlist_move_head()
Message-Id: <20060410012220.53b374d2.akpm@osdl.org>
In-Reply-To: <20060330081729.880726000@localhost.localdomain>
References: <20060330081605.085383000@localhost.localdomain>
	<20060330081729.880726000@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita <mita@miraclelinux.com> wrote:
>
> This patch converts the combination of hlist_del(A) and hlist_add_head(A, B)
> to hlist_move_head(A, B).
> 
> ...
>
> --- 2.6-git.orig/fs/nfsd/nfscache.c
> +++ 2.6-git/fs/nfsd/nfscache.c
> @@ -113,8 +113,7 @@ lru_put_end(struct svc_cacherep *rp)
>  static void
>  hash_refile(struct svc_cacherep *rp)
>  {
> -	hlist_del_init(&rp->c_hash);
> -	hlist_add_head(&rp->c_hash, hash_list + REQHASH(rp->c_xid));
> +	hlist_move_head(&rp->c_hash, hash_list + REQHASH(rp->c_xid));
>  }

Just got an oops here.

BUG: unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
f8a06fde
*pde = 00000000
Oops: 0002 [#1]
SMP
last sysfs file: /devices/pci0000:00/0000:00:1f.3/i2c-0/0-0050/name
Modules linked in: usblp pcspkr nfsd exportfs lockd sunrpc parport_pc lp parport autofs video button battery ac
CPU:    0
EIP:    0060:[<f8a06fde>]    Not tainted VLI
EFLAGS: 00010246   (2.6.17-rc1-mm2 #88)
EIP is at hash_refile+0x20/0x3a [nfsd]
eax: 00000000   ebx: f7c07e1c   ecx: f77b3180   edx: 00000000
esi: 00000006   edi: f8a26d38   ebp: f73eff08   esp: f73eff04
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 2545, threadinfo=f73ef000 task=f7201000)
Stack: <0>f77b3180 f73eff3c f8a07146 f7c19a00 f7c19a40 00000002 00000008 00000003
       00000006 c6a1f621 00000000 f7c19a00 f7c19a00 f8a26d38 f73eff58 f89ff5b0
       f8a26b40 f05a7018 f7c19a64 f7c19a00 f8a26d38 f73effa8 f89a740f 00000075
Call Trace:
 <c0103379> show_stack_log_lvl+0x7d/0x99   <c01034fb> show_registers+0x127/0x182
 <c01036e6> die+0x11a/0x1ea   <c01121b6> do_page_fault+0x31c/0x607
 <c010304f> error_code+0x4f/0x54   <f8a07146> nfsd_cache_lookup+0x14e/0x2d2 [nfsd]
 <f89ff5b0> nfsd_dispatch+0x2a/0x1b2 [nfsd]   <f89a740f> svc_process+0x490/0x5f5 [sunrpc]
 <f89ff3e7> nfsd+0x174/0x313 [nfsd]   <c0100e8d> kernel_thread_helper+0x5/0xb
Code: ec a2 f8 89 0a 89 51 04 5b 5d c3 55 89 c1 8b 15 84 ec a2 f8 89 e5 53 0f b6 40 27 33 41 24 83 e0 3f 8d 1c 82 8b 51 04 8b 01 85 c0 <89> 02 74 03 89 50 04 8b 03 85 c0 89 01 74 03 89 48 04 89 0b 89
EIP: [<f8a06fde>] hash_refile+0x20/0x3a [nfsd] SS:ESP 0068:f73eff04


I don't think you've made an equivalent transformation here. 
hlist_del_init() won't call __hlist_del() if !n->pprev.

But if that was the problem, I'd have expected to see an access address of
0x00000004, not 0x00000000.  Perhaps n->next is NULL as well.

