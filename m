Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbTD3XuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbTD3XuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:50:03 -0400
Received: from [12.47.58.20] ([12.47.58.20]:3703 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262563AbTD3XuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:50:03 -0400
Date: Wed, 30 Apr 2003 16:59:14 -0700
From: Andrew Morton <akpm@digeo.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: ricklind@us.ibm.com, solt@dns.toxicfilms.tv, linux-kernel@vger.kernel.org,
       frankeh@us.ibm.com
Subject: Re: must-fix list for 2.6.0
Message-Id: <20030430165914.2facc464.akpm@digeo.com>
In-Reply-To: <20030430234746.GW10374@parcelfarce.linux.theplanet.co.uk>
References: <20030430121105.454daee1.akpm@digeo.com>
	<200304302311.h3UNB2H27134@owlet.beaverton.ibm.com>
	<20030430162108.09dbd019.akpm@digeo.com>
	<20030430234746.GW10374@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 May 2003 00:02:17.0403 (UTC) FILETIME=[EDA348B0:01C30F74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> On Wed, Apr 30, 2003 at 04:21:08PM -0700, Andrew Morton wrote:
> > menu if there was a kernel build happening at the same time.  That is just
> > utterly broken, so if we're going to leave the sched.c code as-is then we
> > *require* that all applications be updated to not spin on sched_yield.
> 
> Excuse me, but WTF do they spin on the sched_yield() in the first place?
> _That_ sounds like utterly broken...

I think it's happening down inside the old linuxthreads library.  No idea
who, what, where or why.

There are quite a few places in the kernel which do it, too.  Usually when
waiting for memory to come free.  These are being gradually removed, in
favour of blk_congestion_wait() calls.

That leaves behind the very performance-critical sched_yield() in ext3
transaction batching.  That was designed to allow other processes to join a
transaction before the calling one closes the transaction.  With the new
yield() it was causing horrid starvation and was lamely replaced with a
schedule().  It needs to be resurrected for real, but I'm not sure how. 
Probably just a sleep(0.01).

