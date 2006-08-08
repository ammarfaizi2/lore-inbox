Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbWHHP1I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbWHHP1I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 11:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWHHP1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 11:27:08 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:46560 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964950AbWHHP1G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 11:27:06 -0400
Subject: Re: [PATCH] sys_getppid oopses on debug kernel
From: Dave Hansen <haveblue@us.ibm.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <44D865FD.1040806@sw.ru>
References: <44D865FD.1040806@sw.ru>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 08:26:57 -0700
Message-Id: <1155050817.19249.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-08 at 14:22 +0400, Kirill Korotaev wrote:
> sys_getppid() optimization can access a freed memory.
> On kernels with DEBUG_SLAB turned ON, this results in
> Oops.
...
> +#else
> +	/*
> +	 * ->real_parent could be released before dereference and
> +	 * we accessed freed kernel memory, which faults with debugging on.
> +	 * Keep it simple and stupid.
> +	 */
> +	read_lock(&tasklist_lock);
> +	pid = current->group_leader->real_parent->tgid;
> +	read_unlock(&tasklist_lock);
> +#endif
>  	return pid;
>  }

Accessing freed memory is a bug, always, not just *only* when slab
debugging is on, right?  Doesn't this mean we could get junk, or that
the reader could potentially run off a bad pointer?

It seems that this patch only papers over the problem in the case when
it is observed, but doesn't really even fix the normal case.

Could we use a seqlock to determine when real_parent is in flux, and
re-read real_parent until we get a consistent one?  We could use in in
lieu of the existing for() loop.

-- Dave

