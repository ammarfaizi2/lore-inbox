Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbTEFEuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbTEFEuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:50:13 -0400
Received: from [12.47.58.20] ([12.47.58.20]:37388 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262367AbTEFEsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:48:41 -0400
Date: Mon, 5 May 2003 22:02:50 -0700
From: Andrew Morton <akpm@digeo.com>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-Id: <20030505220250.213417f6.akpm@digeo.com>
In-Reply-To: <20030505.204002.08338116.davem@redhat.com>
References: <1052187119.983.5.camel@rth.ninka.net>
	<20030506040856.8B3712C36E@lists.samba.org>
	<20030505.204002.08338116.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 05:01:05.0101 (UTC) FILETIME=[7F71A7D0:01C3138C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> I think you should BUG() if a module calls kmalloc_percpu() outside
> of mod->init(), this is actually implementable.
> 
> Andrew's example with some module doing kmalloc_percpu() inside
> of fops->open() is just rediculious.

crap.  Modules deal with per-device and per-mount objects.  If a module
cannot use kmalloc_per_cpu on behalf of the primary object which it manages
then the facility is simply not useful to modules.

The static DEFINE_PER_CPU allocation works OK in core kernel because core
kernel does _not_ use per-instance objects.  But modules do.

A case in point, which Rusty has twice mentioned, is the three per-mount
fuzzy counters in the ext2 superblock.  And lo, ext2 cannot use the code in
this patch, because people want to scale to 4000 mounts.

In those very rare cases where a module wants allocation to be performed at
module_init()-time (presumably global stats counters), they can use
DEFINE_PER_CPU, so we should just not export kmalloc_per_cpu() to modules at
all.


