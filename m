Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWIIGgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWIIGgL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 02:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWIIGgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 02:36:11 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:17892 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751139AbWIIGgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 02:36:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=NqxCifLjFcZnlV1a+HitIwLLroQ+AMis6IVGNAv4K/LQN/0OcO/UyAdMIMHHYJ2JB87pR6I8j/fqHCzSacWGXskS6IOepx5b1LBcLP96UoUZV7lSVqZJ2wGwxg+Z5HHavPUeG+i6+We1OLNy/Pgm/j663yKQ0ZO9iHaJNGbNso0=
Date: Sat, 9 Sep 2006 08:35:23 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, arjanv@infradead.org
Subject: lockdep warning in check_flags()
Message-ID: <20060909083523.GG1121@slug>
References: <20060908011317.6cb0495a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908011317.6cb0495a.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 01:13:17AM -0700, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm1/
> 
Lockdep issues the following warning:

[   16.835268] Freeing unused kernel memory: 260k freed
[   16.842715] Write protecting the kernel read-only data: 432k
[   17.796518] BUG: warning at kernel/lockdep.c:2359/check_flags()
[   17.804117]  [<c0104436>] dump_trace+0x1f3/0x22a
[   17.811514]  [<c0104493>] show_trace_log_lvl+0x26/0x3c
[   17.818984]  [<c0104b58>] show_trace+0x1b/0x1d
[   17.826397]  [<c0104c43>] dump_stack+0x24/0x26
[   17.833856]  [<c013775e>] check_flags+0x1e4/0x2b1
[   17.841400]  [<c013a9e2>] lock_acquire+0x21/0x7a
[   17.848977]  [<c0135a50>] down_write+0x50/0x69
[   17.856557]  [<c01640d4>] sys_brk+0x23/0xe7
[   17.864105]  [<c01031f6>] sysenter_past_esp+0x5f/0x99
[   17.871556]  [<b7faf410>] 0xb7faf410
[   17.878831]  =======================
[   17.885839] irq event stamp: 8318
[   17.892746] hardirqs last  enabled at (8317): [<c01032c8>] restore_nocheck+0x12/0x15
[   17.906778] hardirqs last disabled at (8318): [<c0103203>] sysenter_past_esp+0x6c/0x99
[   17.921481] softirqs last  enabled at (7128): [<c0123cd1>] __do_softirq+0xe9/0xfa
[   17.936962] softirqs last disabled at (7121): [<c0123d3e>] do_softirq+0x5c/0x60

I've replaced the DEBUG_LOCKS_WARN_ON by a BUG, and it appears that the
user space program calling sys_brk is hotplug.
This is 100% reproducible, it happens at (nearly) the same time, at each
boot.
The lspci, .config and dmesg are available at
http://fdeweerdt.free.fr/lockdep_warning
I'm going to try to bisect sysenter_past_esp by instering some
TRACE_IRQS_ON between the beginning of the routine and the actual syscall
to see when the irq enabling is missed.


Thanks,
Frederik
