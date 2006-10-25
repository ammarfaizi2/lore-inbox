Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423098AbWJYHwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423098AbWJYHwF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 03:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423097AbWJYHwF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 03:52:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36826
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1423101AbWJYHwE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 03:52:04 -0400
Date: Wed, 25 Oct 2006 00:51:34 -0700 (PDT)
Message-Id: <20061025.005134.74748405.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 oops on shutdown
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061024.175751.07640578.davem@davemloft.net>
References: <20061024.175751.07640578.davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 24 Oct 2006 17:57:51 -0700 (PDT)

> I just started to see the following ext3 umount() oops on
> shutdown, it happens every shutdown, has anyone else seen
> it?
> 
> I'll start bisecting soon... this was on sparc64.
> 
> free_block()+0x50/0x190
> cache_flusharray()+0x74/0xa0
> kmem_cache_free()
> journal_destroy_revoke()
> journal_destroy()
> ext3_put_super()
> generic_shutdown_super()
> kill_block_super()
> deactivate_super()
> sys_umount()

Just as an FYI, I bisected it down to this commit:

commit 6b4b78fed47e7380dfe9280b154e8b9bfcd4c86c
Author: Matt Domsch <Matt_Domsch@dell.com>
Date:   Fri Sep 29 15:23:23 2006 -0500

    PCI: optionally sort device lists breadth-first

which makes no sense.  Effectively all this changeset does is add some
__init section code to the PCI layer which never gets executed on
non-i386.  And even on i386 it only runs if you give a special kernel
command line option.

So the only side effect of this code for sparc64, by checking the
System.map before/after this change, is to move the __init_end ahead
by 1 PAGE_SIZE.

It's probably some sparc64 issue, maybe even some error wrt.  freeing
up init memory.  I'll try to track it down.  I'm actually quite
curious what this bug is :-)
