Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUGAXyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUGAXyQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 19:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266373AbUGAXyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 19:54:16 -0400
Received: from mail.shareable.org ([81.29.64.88]:20910 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266366AbUGAXyP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 19:54:15 -0400
Date: Fri, 2 Jul 2004 00:53:54 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Scott Wood <scott@timesys.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040701235354.GD8950@mail.shareable.org>
References: <20040630024434.GA25064@mail.shareable.org> <20040630091621.A8576@flint.arm.linux.org.uk> <20040630145942.GH29285@mail.shareable.org> <20040630192654.B21104@flint.arm.linux.org.uk> <20040630191428.GC31064@mail.shareable.org> <20040630202313.A1496@flint.arm.linux.org.uk> <20040630201546.GD31064@mail.shareable.org> <20040630235921.C1496@flint.arm.linux.org.uk> <20040701152728.GA20634@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701152728.GA20634@yoda.timesys>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Wood wrote:
> > However, plain ldr and str instructions will access the page, but
> > get_user/put_user doesn't use them, and copy_from_user/copy_to_user
> > are carefully crafted to ensure that we hit the necessary permission
> > checks for each page it touches on the first access.
> 
> What if CONFIG_PREEMPT is enabled, and you get preempted after that
> first access, and another thread unmaps the page before you're
> finished with it?

The code in uaccess.S:__arch_copy_{from,to}_user doesn't disable
pre-emption, and neither does its caller.

Pages can be unmapped just due to background paging.  I.e. it's a
normal occurrence, it doesn't require anything contrived.

So I think you're right: that looks like a bug.

The ARM uaccess code was written before CONFIG_PREEMPT was added, and
this couldn't happen then.  It could panic a kernel now.  I wonder why
it hasn't been noticed.  Maybe nobody turns on CONFIG_PREEMPT on ARM?

-- Jamie
