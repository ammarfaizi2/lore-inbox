Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264066AbUEHUzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbUEHUzx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 16:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264153AbUEHUzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 16:55:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:45999 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264066AbUEHUzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 16:55:51 -0400
Date: Sat, 8 May 2004 13:55:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: torvalds@osdl.org, manfred@colorfullife.com, davej@redhat.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: Re: dentry bloat.
Message-Id: <20040508135512.15f2bfec.akpm@osdl.org>
In-Reply-To: <20040508204239.GB6383@in.ibm.com>
References: <20040506200027.GC26679@redhat.com>
	<20040506150944.126bb409.akpm@osdl.org>
	<409B1511.6010500@colorfullife.com>
	<20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
	<Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
	<20040508120148.1be96d66.akpm@osdl.org>
	<Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
	<Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org>
	<20040508204239.GB6383@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
> > And yes, removing d_movecount would be ok by then, as long as we re-test
> > the parent inside d_lock (we don't need to re-test "hash", since if we
> > tested the full name inside the lock, the hash had better match too ;)
> 
> There are couple of issues that need to be checked -
> 
> 1. Re-doing the parent comparison and full name under ->d_lock
> need to be benchmarked using dcachebench. That part of code
> is extrememly performance sensitive and I remember that the
> current d_movecount based solution was done after a lot of
> benchmarking of various alternatives.

There's a speed-space tradeoff here as well.  Making the dentry smaller
means that more can be cached, which reduces disk seeks.  On all
machines...

But yes, when I've finished mucking with this I'll be asking you to put it
all through your performance/correctness/stress tests please.

One thing which needs to be reviewed is the layout of the dentry, too.

> 2. We need to check if doing ->d_compare() under ->d_lock will
> result in locking hierarchy problems.

Yup, I checked that.  Is OK.  It's hard to see how a ->d_compare
implementation could care.  And ->d_compare is called under dcache_lock
in 2.4.

