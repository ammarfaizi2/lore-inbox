Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUCUXWO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 18:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbUCUXWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 18:22:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:47305 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261378AbUCUXWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 18:22:13 -0500
Date: Sun, 21 Mar 2004 15:21:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Peter Osterlund <petero2@telia.com>
cc: Ben Fennema <bfennema@falcon.csc.calpoly.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Linux 2.6.5-rc1
In-Reply-To: <m2d675vmq9.fsf@p4.localdomain>
Message-ID: <Pine.LNX.4.58.0403211520050.1106@ppc970.osdl.org>
References: <Pine.LNX.4.58.0403152154070.19853@ppc970.osdl.org>
 <m2d675vmq9.fsf@p4.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Mar 2004, Peter Osterlund wrote:
> 
> For some reason I don't understand, this makes the UDF filesystem lock
> up when I write a bunch of mp3 files to a CDRW using the packet
> writing patch. Both "cp" and pdflush get stuck in __down. Reverting
> the semaphore changes as in the patch below makes the problem go away,
> but it's probably not the right solution to re-introduce lock_kernel()
> calls.

Looks correct. It looks like memory pressure while doign write() on the 
semaphore will try to writeback dirty inodes and data, and the kernel lock 
allowed that fine, but using the inode semaphore will just deadlock, since 
the write() already holds the semaphore.

I think the prealloc stuff could probably be protected by the inode 
spinlock instead, but for now your backout patch seems to be the same 
thing to do.

			Linus
