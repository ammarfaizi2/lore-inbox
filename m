Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVEQQ4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVEQQ4T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 12:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbVEQQ4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 12:56:18 -0400
Received: from fire.osdl.org ([65.172.181.4]:34744 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261825AbVEQQzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 12:55:51 -0400
Date: Tue, 17 May 2005 09:55:28 -0700
From: Chris Wright <chrisw@osdl.org>
To: Linux Audit Discussion <linux-audit@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc4-mm2 - sleeping function called from invalid context at mm/slab.c:2502
Message-ID: <20050517165528.GB27549@shell0.pdx.osdl.net>
References: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505171624.j4HGOQwo017312@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Valdis.Kletnieks@vt.edu (Valdis.Kletnieks@vt.edu) wrote:
> It threw 5 of them in short succession.  Different entry points into
> avc_has_perm(). Here's the tracebacks:

I'm guessing this is from my change to use single skb for audit buffer
instead of a temp buffer.

> [4295584.974000] Debug: sleeping function called from invalid context at mm/slab.c:2502
> [4295584.974000] in_atomic():1, irqs_disabled():0

This is gfp_any() flag that's used here, which I think is the problem.

> [4295584.974000]  [<c01035a8>] dump_stack+0x15/0x17
> [4295584.974000]  [<c013ba6d>] kmem_cache_alloc+0x1e/0x6a
> [4295584.974000]  [<c02de4fa>] skb_clone+0x14/0x183
> [4295584.974000]  [<c02ef64a>] netlink_unicast+0x7d/0x171

Here and up we are in netlink code which does netlink_trim to reduce the
skb data size before queing to socket.  This does skb_clone with
gfp_any() flag.  We aren't in softirq, so we get GFP_KERNEL flag set
even though in_atomic() is true (spin_lock held I'm assuming).

> [4295584.974000]  [<c0130947>] audit_log_end_fast+0xf5/0x188
> [4295584.974000]  [<c01c3c56>] avc_audit+0x94d/0x958
> [4295584.974000]  [<c01c3ffb>] avc_has_perm+0x3b/0x48
> [4295584.974000]  [<c01c8022>] selinux_socket_unix_stream_connect+0x6f/0xa8
> [4295584.974000]  [<c032b740>] unix_stream_connect+0x228/0x482
> [4295584.974000]  [<c02dbab6>] sys_connect+0x6a/0x81
> [4295584.974000]  [<c02dc23b>] sys_socketcall+0x6f/0x166
> [4295584.974000]  [<c01026cf>] sysenter_past_esp+0x54/0x75
