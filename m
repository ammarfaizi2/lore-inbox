Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751512AbVKBFcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbVKBFcM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbVKBFcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:32:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40347 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751510AbVKBFcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:32:11 -0500
Date: Wed, 2 Nov 2005 15:31:43 +1100
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: hch@lst.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH consolidate sys_ptrace
Message-Id: <20051102153143.5005a87b.akpm@osdl.org>
In-Reply-To: <10611.1130845074@warthog.cambridge.redhat.com>
References: <20051101051221.GA26017@lst.de>
	<20051101050900.GA25793@lst.de>
	<10611.1130845074@warthog.cambridge.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > > The sys_ptrace boilerplate code (everything outside the big switch
> > > statement for the arch-specific requests) is shared by most
> > > architectures.  This patch moves it to kernel/ptrace.c and leaves the
> > > arch-specific code as arch_ptrace.
> 
> Looks okay to me. I do have a concern about all the extra indirections we're
> acquiring by this mad rush to centralise everything. It's going to slow things
> down and consume more stack space. Is there any way we can:
> 
>  (1) Make a sys_ptrace() *jump* to arch_ptrace() instead of calling it, thus
>      obviating the extra return step.
> 
>  (2) Drop the use of lock_kernel().

If we can remove the lock_kernel() and move the final put_task_struct()
into each arch_ptrace() then we can end sys_ptrace() with

	return arch_ptrace(....);

and with luck, gcc will convert it into a tailcall for us.

It's probably not the first place to start doing such optimisation tho.

