Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262131AbVGZXJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbVGZXJB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 19:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVGZXGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 19:06:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64721 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262131AbVGZXFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 19:05:37 -0400
Date: Tue, 26 Jul 2005 16:07:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Memory pressure handling with iSCSI
Message-Id: <20050726160728.55245dae.akpm@osdl.org>
In-Reply-To: <1122418089.6433.62.camel@dyn9047017102.beaverton.ibm.com>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com>
	<20050726111110.6b9db241.akpm@osdl.org>
	<1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com>
	<20050726114824.136d3dad.akpm@osdl.org>
	<20050726121250.0ba7d744.akpm@osdl.org>
	<1122412301.6433.54.camel@dyn9047017102.beaverton.ibm.com>
	<20050726142410.4ff2e56a.akpm@osdl.org>
	<1122414300.6433.57.camel@dyn9047017102.beaverton.ibm.com>
	<20050726151003.6aa3aecb.akpm@osdl.org>
	<1122418089.6433.62.camel@dyn9047017102.beaverton.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> Here is the data with 5 ext2 filesystems. I also collected /proc/meminfo
> every 5 seconds. As you can see, we seem to dirty 6GB of data in 20
> seconds of starting the test. I am not sure if its bad, since we have
> lots of free memory..

It's bad.  The logic in balance_dirty_pages() should block those write()
callers as soon as we hit 40% dirty memory or whatever is in
/proc/sys/vm/dirty_ratio.  So something is horridly busted.

Can you try reducing the number of filesystems even further?

Either the underlying block driver is doing something most bizarre to the
VFS or something has gone wrong with the arithmetic in page-writeback.c. 
If total_pages or ratelimit_pages are totally wrong or if
get_dirty_limits() is returning junk then we'd be seeing something like
this.

It'll be something simple - if you have time, stick some printks in
balance_dirty_pages(), work out why it is not remaining in that `for' loop
until dirty memory has fallen below the 40%.

I'll take a shot at reproducing this on my 4G x86_64 box, but this is so
grossly wrong that I'm sure it would have been noted before now if it was
commonly happening (famous last words).
