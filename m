Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266748AbUGLHhJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266748AbUGLHhJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 03:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266751AbUGLHhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 03:37:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:26814 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266748AbUGLHfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 03:35:36 -0400
Date: Mon, 12 Jul 2004 00:34:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Instrumenting high latency
Message-Id: <20040712003418.02997a12.akpm@osdl.org>
In-Reply-To: <cone.1089613755.742689.28499.502@pc.kolivas.org>
References: <cone.1089613755.742689.28499.502@pc.kolivas.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> He hacked 
>  together this simple patch which times periods according to the preempt 
>  count.

OK, small problem.  We have code which does, effectively,

	if (need_resched()) {
		drop_the_lock();
		schedule();
		grab_the_lock();
	}

so if need_resched() stays false then this will hold the lock for a long
time and bogus reports are generated:

46ms non-preemptible critical section violated 1 ms preempt threshold starting at exit_mmap+0x26/0x188 and ending at exit_mmap+0x154/0x188

To fix that you need to generate high scheduling pressure so that
need_resched() is frequently true.  On all CPUs.  Modify realfeel to pin
itself to each CPU, or something like that.

This rather decreases the patch's usefulness.

The way I normally do this stuff is with

	http://www.zip.com.au/~akpm/linux/patches/stuff/rtc-debug.patch

and `amlat', from http://www.zip.com.au/~akpm/linux/amlat.tar.gz


It _might_ be sufficient to redefine need_resched() to just return 1 all
the time.  If that causes the kernel to livelock then we need to fix that
up anyway.
