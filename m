Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992702AbWJTSqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992702AbWJTSqp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 14:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992530AbWJTSqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 14:46:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41913 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S2992702AbWJTSqn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 14:46:43 -0400
Date: Fri, 20 Oct 2006 11:46:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Enforce "unsigned long flags;" when spinlocking
Message-Id: <20061020114640.9231b18f.akpm@osdl.org>
In-Reply-To: <20061020131544.GC17199@martell.zuzino.mipt.ru>
References: <20061020131544.GC17199@martell.zuzino.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2006 17:15:44 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Make it break or warn if you pass to spin_lock_irqsave() and friends
> something different from "unsigned long flags;". Suprisingly large amount of
> these was caught by recent commit c53421b18f205c5f97c604ae55c6a921f034b0f6 .
> 
> Idea is largely from FRV typechecking.
> 
> Note #1: checking with sparse is still needed, because a driver can save and
>          pass around flags or something. So far patch is very intrusive.
> Note #2: techically, we should break only if sizeof(flags) < sizeof(unsigned long),
>          but hey, there is opportunity to escalate. Thus !=
> Note #3: yes, would break every single buggy out-of-tree module.
> 

This is a pretty ugly-looking patch.

> 
> +		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
> +		typecheck(unsigned long, flags);			\
> ...
> +		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
> +		typecheck(unsigned long, flags);			\
> ...
> +		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
> +		typecheck(unsigned long, flags);			\
> ...
> +		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
> +		typecheck(unsigned long, flags);			\
> ...
> +		BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
> +		typecheck(unsigned long, flags);			\
> ...

starting to see a pattern here?

If we're going to do this then a helper macro build_check_irq_flags() would
help clean things up.  It will also allow us to centralise the
warning-vs-error policy decision.

I'm not sure that we need both, do we?  If it spits a warning then it'll
get fixed soon enough.
