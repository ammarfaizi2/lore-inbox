Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbWGFDkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbWGFDkN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbWGFDkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:40:13 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7587
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965154AbWGFDkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:40:12 -0400
Date: Wed, 05 Jul 2006 20:40:36 -0700 (PDT)
Message-Id: <20060705.204036.104053108.davem@davemloft.net>
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [BUG sparc64] 2.6.16-git6 broke X11 on Ultra5 with ATI Mach64
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607031117.k63BHiDa007719@harpo.it.uu.se>
References: <200607031117.k63BHiDa007719@harpo.it.uu.se>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 3 Jul 2006 13:17:44 +0200 (MEST)

> I.e., X did a simple PROT_READ|PROT_WRITE MAP_SHARED mmap() of
> something PCI-related, presumably the ATI card. The protection
> bits passed into io_remap_pfn_range() are 0x80...0788, while
> pg_iobits are 0x80...0f8a. Current kernels obey the prot bits,
> which, if I read things correctly, means that _PAGE_W_4U and
> _PAGE_MODIFIED_4U don't get set any more.
> 
> I guess something else in the kernel should have set those
> bits before they got to io_remap_pfn_range()?

The problem is with X, it should not be doing a MAP_SHARED
mmap() of the framebuffer device.  It should be using
MAP_PRIVATE instead.

The kernel is trying to provide copy-on-write semantics for
the mapping, which doesn't make any sense for device registers.
That's why the kernel isn't setting the writable or modified
bits in the protection bitmask.

Please fix the X server :)
