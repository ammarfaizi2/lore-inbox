Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbWBTVXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWBTVXm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 16:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWBTVXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 16:23:41 -0500
Received: from ns1.suse.de ([195.135.220.2]:54216 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932341AbWBTVXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 16:23:38 -0500
To: Mishin Dmitry <dim@openvz.org>
Cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       rusty@rustcorp.com.au, akpm@osdl.org, devel@openvz.org
Subject: Re: [PATCH 1/2] iptables 32bit compat layer
References: <200602201110.39092.dim@openvz.org>
From: Andi Kleen <ak@suse.de>
Date: 20 Feb 2006 22:23:25 +0100
In-Reply-To: <200602201110.39092.dim@openvz.org>
Message-ID: <p73slqd4tde.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mishin Dmitry <dim@openvz.org> writes:

> Hello,
> 
> This patch set extends current iptables compatibility layer in order to get
> 32bit iptables to work on 64bit kernel. Current layer is insufficient 
> due to alignment checks both in kernel and user space tools.
> 
> This patch introduces base compatibility interface for other ip_tables modules

Nice. But some issues with the implementation


+#if defined(CONFIG_X86_64)
+#define is_current_32bits() (current_thread_info()->flags & _TIF_IA32)

This should be is_compat_task(). And we don't do such ifdefs
in generic code.  And what you actually need here is a 
is_compat_task_with_funny_u64_alignment() (better name sought)

So I would suggest you add macros for that to the ia64 and x86-64
asm/compat.hs and perhaps a ARCH_HAS_FUNNY_U64_ALIGNMENT #define in there.

+	ret = 0;
+	switch (convert) {
+		case COMPAT_TO_USER:
+			pt = (struct ipt_entry_target *)target;

etc. that looks ugly. why can't you just define different functions
for that?  We don't really need in kernel ioctl

+#ifdef CONFIG_COMPAT
+	down(&compat_ipt_mutex);
+#endif

Why does it need an own lock?

Overall the implementation looks very complicated. Are you sure
it wasn't possible to do this simpler?


-Andi
