Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264641AbUFXSql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbUFXSql (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 14:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264660AbUFXSqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 14:46:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:25805 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264641AbUFXSqW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 14:46:22 -0400
Date: Thu, 24 Jun 2004 11:44:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jack Steiner <steiner@sgi.com>
Cc: davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Reduce TLB flushing during process migration
Message-Id: <20040624114449.47fe2f67.akpm@osdl.org>
In-Reply-To: <20040624125544.GA15742@sgi.com>
References: <20040623143844.GA15670@sgi.com>
	<20040623143318.07932255.akpm@osdl.org>
	<20040624125544.GA15742@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jack Steiner <steiner@sgi.com> wrote:
>
> On Wed, Jun 23, 2004 at 02:33:18PM -0700, Andrew Morton wrote:
> > Jack Steiner <steiner@sgi.com> wrote:
> > >
> > > This patch adds a platform specific hook to allow an arch-specific
> > > function to be called after an explicit migration.
> > 
> > OK by me.  David, could you please merge this up?
> > 
> > Jack, please prepare an update for Documentation/cachetlb.txt.
> 
> 
> ...
> +7) void tlb_migrate_finish(struct mm_struct *mm)
> +
> +	This interface is called at the end of an explicit
> +	process migration. This interface provides a hook 
> +	to allow a platform to update TLB or context-specific 
> +	information for the address space.
> +
> +	The ia64 sn2 platform is one example of a platform
> +	that uses this interface.

Ok...  But the code is still calling flush_tlb_mm() from within
set_cpus_allowed() on non-ia64 platforms, which I believe is unnecessary.

And it's calling it with a null pointer for kernel threads, which oopses on
i386.  We went over this weeks ago.

Shouldn't asm-generic.h be doing

	#define tlb_migrate_finish(mm)	do {} while (0)

?
 
