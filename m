Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbTEFMOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTEFMOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:14:14 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:25400 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S262685AbTEFMON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:14:13 -0400
Date: Tue, 6 May 2003 13:28:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: Ingo Molnar <mingo@redhat.com>, Manfred Spraul <manfred@colorfullife.com>,
       <linux-kernel@vger.kernel.org>
Subject: initcall kmem_cache cpu 1 oops
Message-ID: <Pine.LNX.4.44.0305061319190.1821-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if it's right or wrong for initcalls to happen on cpus
other than 0.  But with CONFIG_NR_SIBLINGS_2 on 2*HT*P4 in 2.5.69-mm1
(I didn't try 2.5.68-mm, but 2.5.69 okay) I have sock_init run on cpu 0
setting sock_inode_cachep and its array[0], then later rtnetlink_init on
cpu 1, causing kmem_cache_alloc oops on NULL sock_inode_cachep->array[1]:
g_cpucache_up is still PARTIAL, cpucache_init is yet to be called.

Before 2.5.68-mm3 rtnetlink_init was invoked from within sock_init, but
it's now from a separate netlink_proto_init: so that's another source
of doubt.  For now I have CONFIG_NR_SIBLINGS_0 instead (from a vague
suspicion that CONFIG_SHARE_RUNQUEUE work might have caused unexpectedly
early switch from cpu 0 to 1), and that works around it for me: but I'm
not pointing any finger of blame, I don't know the axioms here at all.

Hugh

