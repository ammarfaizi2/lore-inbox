Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVJaUC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVJaUC6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbVJaUC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:02:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57007 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964799AbVJaUC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:02:57 -0500
Date: Mon, 31 Oct 2005 12:02:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: PATCH: EDAC - clean up atomic stuff
Message-Id: <20051031120254.4579dc9a.akpm@osdl.org>
In-Reply-To: <m1oe55abm4.fsf@ebiederm.dsl.xmission.com>
References: <1129902050.26367.50.camel@localhost.localdomain>
	<m164rhbnyk.fsf@ebiederm.dsl.xmission.com>
	<1130772628.9145.35.camel@localhost.localdomain>
	<m1oe55abm4.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) wrote:
>
> Ok.  If I recall correctly atomic kmaps have the rule that they are
>  per cpu, and you can't be interrupted when the map is taken, by
>  something else that will use the map.  But they are safe to use from
>  interrupt context.  As I recall the code needs to ensure that an
>  interrupt handler doesn't use the same buffer and that it isn't
>  preempted where another thread will use the buffer.  The preemption
>  angle is new since that piece of code was written.

Yes, a particular atomic kmap slot is simply a static, per-cpu scalar. 
It's just like

int foo[NR_CPUS];

	...
	foo(smp_processor_id());

and all the same rules apply.

The use of KM_BOUNCE_READ does appear to be incorrect.  bounce_copy_vec()
will use KM_BOUNCE_READ from interrupt context, so if the EDAC code is
interrupted by the block layer while it holds that kmap, it will find that
it's suddenly diddling with a different physical page.

So to use KM_BOUNCE_READ, the EDAC code nees to disable local interrupts,
or to use a different (or new) slot.

In what contexts is edac_mc_scrub_block() called?  If process context, then
KM_USER0 would suit.

Ah, edac_mc_scrub_block() is passing the pageframe address to
kunmap_atomic() - that's a common bug.  It needs to pass in the virtual
address which kmap_atomic() returned.

