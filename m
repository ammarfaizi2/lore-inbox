Return-Path: <linux-kernel-owner+w=401wt.eu-S1161028AbXAHW5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161028AbXAHW5S (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161035AbXAHW5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:57:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:4007 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161028AbXAHW5R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:57:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=POtCK5ffq0/GIhMHSOWzLtW8c77FY+puQnTBX/LPUM4Oe5ALeTEZ/65ujZ6ogHsKOkYZGvhr9eH70wPvesL/NQnHL2MSmf6mmHhG9NzLOhTGDSK1oST/N02nn+NhPCGQsXLh9IOiQlzvKp50OBy36lFCHMHkA8CeE1J6lk1ikTg=
Date: Mon, 8 Jan 2007 22:55:07 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Sumit Narayan <talk2sumit@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] sleeping function called from invalid context at kernel/sched.c
Message-ID: <20070108225506.GE15292@slug>
References: <1458d9610701081327sb9de173qc5b7d99558ed22ae@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1458d9610701081327sb9de173qc5b7d99558ed22ae@mail.gmail.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 04:27:32PM -0500, Sumit Narayan wrote:
> Hi,
> 
> I am trying to do file write operations in a thread (filewrite())
> initiated from a jprobe (fs_vfs_write()) set on kernel function
> (vfs_write()). Although the write operation succeed, I get this on my
> log:
> 
> BUG: sleeping function called from invalid context at kernel/sched.c:3678
> in_atomic():0, irqs_disabled():1
> [<c011a65b>] __might_sleep+0xa5/0xab
> [<c0343a00>] wait_for_completion+0x1a/0xc9
> [<c0118480>] __wake_up+0x32/0x43
> [<c012b33a>] __queue_work+0x42/0x4f
> [<c012e0f7>] kthread_create+0x9b/0xd3
> [<c012e00a>] keventd_create_kthread+0x0/0x52
> [<f8a560d4>] filewrite+0x0/0xaf [fsTrace]
> [<c03464b9>] do_page_fault+0x31f/0x5c5
> [<f8a561da>] fs_vfs_write+0x57/0x9e [fsTrace]
> [<f8a560d4>] filewrite+0x0/0xaf [fsTrace]
> [<c015f396>] sys_write+0x41/0x67
> [<c01034d1>] sysenter_past_esp+0x56/0x79
> =======================
kprobe disables interrupts, and you're not supposed to sleep with
interrupts disabled. But you call keventd_create_kthread which sleeps,
and that issues this message.

Regards,
Frederik
