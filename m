Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbTKLVJI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 16:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbTKLVJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 16:09:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:16354 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261613AbTKLVJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 16:09:06 -0500
Date: Wed, 12 Nov 2003 13:09:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Erik Jacobson <erikj@efs.americas.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: available memory imbalance on large NUMA systems
Message-Id: <20031112130924.39c91a16.akpm@osdl.org>
In-Reply-To: <Pine.SGI.4.53.0311120916130.160127@efs.americas.sgi.com>
References: <Pine.SGI.4.53.0311120916130.160127@efs.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Jacobson <erikj@efs.americas.sgi.com> wrote:
>
> As a side point, some of the hash tables allocated during startup get very
> large on large-memory systems (systems with a terrabyte of memory for example).
> Someone may wish to consider implementing a cap on the size of some of these
> tables. 

The patch seems a reasonable way of implementing it, but I think your above
comment lies at the heart of the issue: those tables are just too darn big.

Both the pagecache hash table and the buffer_head hash tables were removed
from 2.6 (but I suspect the structures which replaced them are all still
crammed into the zeroeth node?).  That leaves the dentry, inode and TCP
hash tables.  These need stern examination and benchmarking to decide
whether we really are appropriately sizing them on large machines.

If we can get away with just making these sanely sized then the remaining
issue is the node-round-robining of pagecache allocations.  I don't have an
opinion on the desirability of this for NUMA machines in general.
