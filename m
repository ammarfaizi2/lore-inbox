Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWGKNXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWGKNXT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 09:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWGKNXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 09:23:18 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:47847 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751071AbWGKNXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 09:23:18 -0400
Date: Tue, 11 Jul 2006 21:45:48 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/8] FDPIC: Add coredump capability for the ELF-FDPIC binfmt [try #4]
Message-ID: <20060711174548.GA131@oleg>
References: <20060710024657.GA255@oleg> <10872.1152538291@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10872.1152538291@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, David Howells wrote:
>
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> > Do you see any reason for tasklist_lock here (and in elf_core_dump) ?
> >
> > do_each_thread() is rcu-safe, and all tasks which use this ->mm must
> > sleep in wait_for_completion(&mm->core_done) at this point.
>
> Hmmm... do_each_thread() does not call rcu_read_lock/unlock(), but you may
> well be right.

Yes, we can't just kill tasklist_lock, we should replace it with rcu_read_lock.

>                 What about kernel threads running on another CPU with
> active_mm set to this mm (assuming I'm remembering correctly how that works)?
> I'm not sure they'd be a problem, though.

Those threads have ->mm == NULL, this loop will not count them. But I think
tasklist_lock can't make any difference for this issue. I am not sure I
understand your concern, it is ok to use this ->mm (current uses it), and
a kernel thread incremented ->mm_count.

Oleg.

