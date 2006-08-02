Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWHBACh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWHBACh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 20:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWHBABy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 20:01:54 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:18361
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750786AbWHBABo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 20:01:44 -0400
Date: Tue, 01 Aug 2006 17:01:38 -0700 (PDT)
Message-Id: <20060801.170138.107248641.davem@davemloft.net>
To: zach.brown@oracle.com
Cc: johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org
Subject: Re: [take2 1/4] kevent: core files.
From: David Miller <davem@davemloft.net>
In-Reply-To: <44CFEA4B.3060200@oracle.com>
References: <11544248451203@2ka.mipt.ru>
	<44CFEA4B.3060200@oracle.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zach Brown <zach.brown@oracle.com>
Date: Tue, 01 Aug 2006 16:56:59 -0700

> Even if we only have one syscall with a cmd multiplexer (which I'm not
> thrilled with), we should at least make these arguments explicit in the
> system call.  It's weird to hide them in a struct.  We could also think
> about making them u32 or u64 so that we don't need compat wrappers, but
> maybe that's overkill.

I think making the userspace data structure not require any compat
handling is a must, thanks for pointing this out Zach.

> It'd be great if these struct members could get a prefix (ala: inode ->
> i_, socket -> sk_) so that it's less painful getting tags helpers to
> look up instances for us.  Asking for 'lock' is hilarious.

Agreed.

> Hmm.  I think the current preference is not to have a lock per bucket.

Yes, it loses badly, that's why we undid this in the routing cache
and just have a fixed sized array of locks which is hashed into.

For kevents, I think a single spinlock initially is fine and
if we hit performance problems on SMP we can fix it.  We should
not implement complexity we have no proof of needing yet :)

> > +#define KEVENT_MAX_REQUESTS		PAGE_SIZE/sizeof(struct kevent)
> 
> This is unused?

It is probably groundwork for the mmap() ring buffer... :)

