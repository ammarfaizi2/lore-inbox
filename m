Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275326AbTHSDje (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 23:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275323AbTHSDjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 23:39:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:49080 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S275320AbTHSDja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 23:39:30 -0400
Message-ID: <32829.4.4.25.4.1061264369.squirrel@www.osdl.org>
Date: Mon, 18 Aug 2003 20:39:29 -0700 (PDT)
Subject: Re: Debug: sleeping function called from invalid context
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <akpm@osdl.org>
In-Reply-To: <20030818203513.393c4a48.akpm@osdl.org>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org>
        <20030815173246.GB9681@redhat.com>
        <20030815123053.2f81ec0a.rddunlap@osdl.org>
        <20030816070652.GG325@waste.org>
        <20030818140729.2e3b02f2.rddunlap@osdl.org>
        <20030819001316.GF22433@redhat.com>
        <20030818171545.5aa630a0.akpm@osdl.org>
        <32789.4.4.25.4.1061263463.squirrel@www.osdl.org>
        <20030818203513.393c4a48.akpm@osdl.org>
X-Priority: 3
Importance: Normal
Cc: <davej@redhat.com>, <mpm@selenic.com>, <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Randy.Dunlap" <rddunlap@osdl.org> wrote:
>>
>> Debug: sleeping function called with interrupts disabled at
>>  include/asm/uaccess.h:473
>
> OK, now my vague understanding of what's going on is that the app has chosen
> to disable local interupts (via iopl()) and has taken a vm86 trap.  I guess
> we'd see the same thing if the app performed some sleeping syscall while
> interrupts are disabled.
>
> If that is correct then it really is just a false positive.
>
> It could also point at a bug in the application; it is presumably disabling
> interrupts for some form of locking, atomicity or timing guarantee.  But it
> will not lock against other CPUs and the fact that it trapped into the
> kernel indicates tat it may not be getting the atomicity which it desires.

Call Trace:
 [<c0120d93>] __might_sleep+0x53/0x74
 [<c010d001>] save_v86_state+0x71/0x1f0
 [<c010dbd5>] handle_vm86_fault+0xc5/0xa90
 [<c019cac8>] ext3_file_write+0x28/0xc0
 [<c011cd96>] __change_page_attr+0x26/0x220
 [<c010b310>] do_general_protection+0x0/0x90
 [<c010a69d>] error_code+0x2d/0x40
 [<c0109657>] syscall_call+0x7/0xb

My (more) vague understanding is that X(?) got the kernel to
do_general_protection() somehow, but change_page_attr() does this:
	spin_lock_irqsave(&cpa_lock, flags);
in arch/i386/mm/pageattr.c (I'm on a UP box),
so irqs are disabled by the kernel and then we calls put_user()
with a spinlock held.

~Randy  [betting I understand it less than Andrew]



