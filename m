Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbTE3QHx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 12:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbTE3QHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 12:07:53 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:23724 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263775AbTE3QHv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 12:07:51 -0400
Date: Fri, 30 May 2003 09:21:11 -0700
From: Andrew Morton <akpm@digeo.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: jacobs@penguin.theopalgroup.com, linux-kernel@vger.kernel.org
Subject: Re: Ext3 meta-data performance
Message-Id: <20030530092111.5bdadf5c.akpm@digeo.com>
In-Reply-To: <3ED772F5.8060100@cyberone.com.au>
References: <Pine.LNX.4.44.0305290923330.11990-100000@penguin.theopalgroup.com>
	<3ED772F5.8060100@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 May 2003 16:21:11.0672 (UTC) FILETIME=[7BF83F80:01C326C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> >
>  >I have some more time to experiment, so please let me know if there is
>  >anything else you think I should try.
>  >
>  Andrew might be able to suggest some worthwhile tests, if nothing
>  else, try mounting your filesystems as ext2, so you can get a
>  baseline figure.

So the workload is a `cp -Rl' of a 500,000 file tree?

Vast amounts of metadata.  ext2 will fly through that.  Poor old ext3 has
to write everything twice, and has to keep on doing seek-intensive
checkpointing when the journal fills.

When we get Andreas's "dont bother reading empty inode blocks" speedup
going it will help both filesystems quite a bit.

Increasing the journal size _may_ help.  `tune2fs -J size=400', or `mke2fs
-j J size=400'.

The Orlov allocator will help this workload significantly, but you have to
give it time to settle in: it uses different decisions for the placement of
directories on disk.  If the source directory of the copy was created by a
2.4 filesystem then we won't get any of that benefit.


