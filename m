Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbTKJDBD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 22:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbTKJDBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 22:01:02 -0500
Received: from fw.osdl.org ([65.172.181.6]:49563 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262669AbTKJDBA (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 22:01:00 -0500
Date: Sun, 9 Nov 2003 19:04:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Burton Windle <bwindle@fint.org>
Cc: Linux-kernel@vger.kernel.org
Subject: Re: slab corruption in test9 (NFS related?)
Message-Id: <20031109190444.5d8d6645.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0311091815460.872@morpheus>
References: <Pine.LNX.4.58.0311091815460.872@morpheus>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burton Windle <bwindle@fint.org> wrote:
>
> Forwarding to LKML as per Neil Brown.
> 
> 
> ---------- Forwarded message ----------
> Date: Sun, 9 Nov 2003 17:21:47 -0500 (EST)
> From: Burton Windle <bwindle@fint.org>
> To: Trond Myklebust <trond.myklebust@fys.uio.no>, neilb@cse.unsw.edu.au
> Subject: nfsd caused slab corruption in test9
> 
> Hello. I'm not quite sure whom to send this to, so my appologizes if you
> aren't the right people.
> 
> Two linux boxes, both running Debian Testing, both x86 with 2.6.0-test9.
> The nfs client was running the nhfsstone stress test against an ext3 NFS
> exported share. After about an hour (I forgot it was running), the console on the
> server woke up and spit this out:
> 
> 
> Slab corruption: start=c9df6bcc, expend=c9df6c8b, problemat=c9df6bcc
> Last user: [<c017f87e>](d_callback+0x1e/0x40)
> Data: 6A**********************************************************************************************************************************************************************************************A5
> Next: 71 F0 2C .7E F8 17 C0 A5 C2 0F 17 00 00 00 00 08 00 00 00 3C 4B 24 1D 00 00 00 00 0A 00 00 00 slab error in check_poison_obj(): cache
> `dentry_cache': object was modified after freeing Call Trace:
>  [<c0143653>] check_poison_obj+0xf3/0x180
>  [<c0181d19>] d_alloc+0x19/0x360
>  [<c01457da>] kmem_cache_alloc+0x13a/0x180
>  [<c0181d19>] d_alloc+0x19/0x360
>  [<c0174a3e>] cached_lookup+0x5e/0x80
>  [<c0175ebb>] __lookup_hash+0x5b/0xa0
>  [<c0175f10>] lookup_hash+0x10/0x20
>  [<c0175f75>] lookup_one_len+0x55/0x80
>  [<c01e7d05>] nfsd_lookup+0xa5/0x5e0
>  [<c01f020b>] nfsd3_proc_lookup+0x8b/0x100
>  [<c01e5147>] nfsd_dispatch+0xc7/0x1a0
>  [<c0313a7f>] svc_process+0x49f/0x640
>  [<c01e4c47>] nfsd+0x307/0x740
>  [<c01e4940>] nfsd+0x0/0x740
>  [<c0107429>] kernel_thread_helper+0x5/0x1c
> 

Someone did a dput() of a freed dentry.  This is quite possibly an nfsd bug.

There's also http://bugme.osdl.org/show_bug.cgi?id=1497, in which someone
did a scribble on the buffer_head slab's metadata.   Could be unrelated.

There's a debug patch in -mm which should catch the rogue dput().  Perhaps
you could include it in your testing.  It is at

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm2/broken-out/atomic_dec-debug.patch

