Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266982AbUAXSJe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 13:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266983AbUAXSJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 13:09:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:53701 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266982AbUAXSJc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 13:09:32 -0500
Date: Sat, 24 Jan 2004 10:10:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove More Unneccessary CPU Notifiers
Message-Id: <20040124101039.296c34fd.akpm@osdl.org>
In-Reply-To: <20040124121909.93C8F2C222@lists.samba.org>
References: <20040124121909.93C8F2C222@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> Three more removed CPU notifiers extracted from the hotplug CPU patch.
> 
>  kernel/softirq.c: the tasklet cpu prepration callback is useless:
>  the vectors are already initialized to NULL.  Even with the hotplug
>  CPU patches, they're of little or no use.
> 
>  fs/buffer.c: once again, they are already initialized to zero.
> 
>  mm/page_alloc.c: once again, already initialized to zero.

But when hot-remove is implemented we will need to migrate a going-away
CPU's per-cpu data into a different CPU's storage area, will we not?

If so, some of these notifiers need to remain in place.

Or are you saying that we should just leave the per-cpu accounting in a
non-zero state when its CPU has gone away, and rely upon the stats
gathering code iterating across all cpu_possible cpus?

That's a bit lame in the case of __get_page_state() at least.  We've had
problems with excess CPU consumption in there at times and it would be good
to be able to change that function to iterate across all online CPUs, not
all possible ones.  We can do that if we have a notifier which spills the
numbers from the gone-away CPU into the local CPU's slot.


