Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUEWBCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUEWBCt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 21:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbUEWBCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 21:02:49 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30876 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262063AbUEWBCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 21:02:47 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
References: <20040522013636.61efef73.akpm@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 22 May 2004 19:01:23 -0600
In-Reply-To: <20040522013636.61efef73.akpm@osdl.org>
Message-ID: <m165aorm70.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm5/
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.6/2.6.6-mm5/
> 
> 
> add-i386-readq.patch
>   add i386 readq()/writeq()

> static inline u64 readq(void *addr)
> {
> 	return readl(addr) | (((u64)readl(addr + 4)) << 32);
> }
> 
> static inline void writeq(u64 v, void *addr)
> {
> 	u32 v32;
> 
> 	v32 = v;
> 	writel(v32, addr);
> 	v32 = v >> 32;
> 	writel(v32, addr + 4);
> }
> 
> #endif

The implementation is broken and it will break drivers that actually
expect writeq and readq to be 64bit reads and writes.

In particular an interrupt can come in during the middle of a read
or a write and widely separate the two different halves.

Unless the driver has a lock protecting access to the card already
this race could be nasty and quite difficult to debug.  And I have
looked and we do have some cases in the kernel that do not have
a lock protecting them.

I attempted to suggest some alternative implementations earlier
in the original thread that brought this up but it looks like
you missed that.

Eric
