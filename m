Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbVK2NZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVK2NZP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 08:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbVK2NZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 08:25:15 -0500
Received: from nproxy.gmail.com ([64.233.182.194]:22223 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751354AbVK2NZO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 08:25:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QTFI76rAkZfr8l9W3Em09z8oQPX9aairniyD9SnbJI0irj0Ye46PZ0jt8+kcFgHSKCo3LGy60CwW6ws0KFVvV6HVCVPq57OYjery46VK1oHz9De3wWD4ATDtJSLVFayFUC0xCrUpYQnGIUGSL5LZR7dZtaH7ZuqmHzb24+9EPBk=
Message-ID: <121a28810511290525m1bdf12e0n@mail.gmail.com>
Date: Tue, 29 Nov 2005 14:25:12 +0100
From: Grzegorz Nosek <grzegorz.nosek@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] race condition in procfs
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org
In-Reply-To: <121a28810511290038h37067fecx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <121a28810511282317j47a90f6t@mail.gmail.com>
	 <20051129000916.6306da8b.akpm@osdl.org>
	 <121a28810511290038h37067fecx@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Do you know what the race is?
>
> Apparently it's a race between deleting a process and accessing its
> /proc/pid entries. It came out in pidof while it was accessing
> /proc/pid/stat (fs/proc/array.c:do_task_stat crashed on first
> instruction - it was an inline function accessing task->state,
> get_task_state IIRC). oops (with vserver history data - I'm using a
> patch mentioned below) is attached.
>
> >
> > How does one reproduce it?
>
> I managed to reproduce it (although not reliably) during high CPU load
> and I/O (parallel kernel compiles) on SMP systems with the vserver
> patch (http://linux-vserver.org, the exact patch is
> http://vserver.13thfloor.at/Experimental/patch-2.6.14.2-vs2.1.0-rc8.diff),
> but the vserver maintainer pointed out that it probably is a mainline
> issue. We're not using 2.6 systems too much except for the vserver
> test beds so I cannot tell if it happens on vanilla kernels.
>
> >
> > > The following micro-patch seems to fix it.
> >
> > It might be right, or it might be a workaround..
> >
>
> I'm not a kernel guru so it's just my proposal. Can it break anything?
> An alternative _might_ be somewhat coarser task_struct locking
> (do_task_stat grabs a spinlock but then it's already too late).
> However, if no "right" solution appears, I'll keep using my two-liner
> because it seems to help, at least in my setup.
>

Oh well, I got another oops in the very same place with the patch
applied. So now I surrounded the check with
read_[un]lock(&tasklist_lock) and added a check to do_task_stat (both
now have a printk). If it builds, boots and doesn't crash, I'll post
the patch.

Best regards,
 Grzegorz Nosek
