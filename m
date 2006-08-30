Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWH3JZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWH3JZS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 05:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWH3JZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 05:25:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28383 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750779AbWH3JZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 05:25:16 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060829112030.a2a8c763.akpm@osdl.org> 
References: <20060829112030.a2a8c763.akpm@osdl.org>  <20060829175949.32281.21374.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, uclinux-dev@uclinux.org
Subject: Re: [PATCH 1/2] NOMMU: Set BDI capabilities for /dev/mem and /dev/kmem 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 30 Aug 2006 10:24:55 +0100
Message-ID: <22155.1156929895@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton <akpm@osdl.org> wrote:

> Perhaps one could make mem_bdi==NULL if !CONFIG_MMU, for a minor space
> saving.

The problem is that takes the #ifdef-avoidance scheme a step too far.  If we
do that, the kernel will crash.  Observe the following:

  Breakpoint 1, memory_open (inode=0xc0f7da04, filp=0xc09d8ba0) at fs.h:635
  635		return MINOR(inode->i_rdev);
  (gdb) n
  634	{
  (gdb) 
  904				filp->f_mapping->backing_dev_info = &mem_bdi;
  (gdb) i sym filp->f_mapping->backing_dev_info
  default_backing_dev_info in section .data

Note how the BDI pointer is already set to the default which we then override.
We either need to fill in mem_bdi correctly for MMU or only override the BDI
pointer if !MMU.

Of course, that doesn't touch on the matter of the compiler not letting you do
&NULL, though I assume you meant make &mem_bdi == NULL.

Also, the default BDI is incorrect for /dev/mem and /dev/kmem since it does
not permit shared mappings, so I think we need mem_bdi anyway, though I should
perhaps make it more general, so that it can apply to all mappable chardevs.

David
