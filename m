Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbUCWViN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 16:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbUCWViN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 16:38:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:60379 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262859AbUCWViF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 16:38:05 -0500
Subject: Re: 2.6.5-rc1-mm2 and direct_read_under and wb
From: Daniel McNeil <daniel@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mason@suse.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "linux-aio@kvack.org" <linux-aio@kvack.org>
In-Reply-To: <20040323095953.72786ccc.akpm@osdl.org>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	 <20040317150909.7fd121bd.akpm@osdl.org>
	 <1079566076.4186.1959.camel@watt.suse.com>
	 <20040317155111.49d09a87.akpm@osdl.org>
	 <1079568387.4186.1964.camel@watt.suse.com>
	 <20040317161338.28b21c35.akpm@osdl.org>
	 <1079569870.4186.1967.camel@watt.suse.com>
	 <20040317163332.0385d665.akpm@osdl.org>
	 <1079572511.6930.5.camel@ibm-c.pdx.osdl.net>
	 <1079632431.6930.30.camel@ibm-c.pdx.osdl.net>
	 <1079635678.4185.2100.camel@watt.suse.com>
	 <1079637004.6930.42.camel@ibm-c.pdx.osdl.net>
	 <1079714990.6930.49.camel@ibm-c.pdx.osdl.net>
	 <1079715901.6930.52.camel@ibm-c.pdx.osdl.net>
	 <1079879799.11062.348.camel@watt.suse.com>
	 <1079979016.6930.62.camel@ibm-c.pdx.osdl.net>
	 <1079980512.11058.524.camel@watt.suse.com>
	 <1079981473.6930.71.camel@ibm-c.pdx.osdl.net>
	 <20040322151312.6b629736.akpm@osdl.org>
	 <1080003067.6930.78.camel@ibm-c.pdx.osdl.net>
	 <20040323012514.7670f622.akpm@osdl.org>
	 <1080061501.6930.84.camel@ibm-c.pdx.osdl.net>
	 <20040323095953.72786ccc.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1080077881.2410.18.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2004 13:38:01 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like every place wbc->nonblocking is set to 1, sync_mode
is set to WB_SYNC_NONE, but there are places where WB_SYNC_NONE is
used and nonblocking is NOT set: 
	balance_dirty_pages()
	try_to_unuse()

So your patch makes balance_dirty_pages() do the lock_buffer()
in __block_write_full_page() instead of skipping and redirtying
the page.

I just making sure I understand.
So, WB_SYNC_ALL and nonblocking=1 should never be used?

Daniel

On Tue, 2004-03-23 at 09:59, Andrew Morton wrote:
> Daniel McNeil <daniel@osdl.org> wrote:
> >
> > Andrew,
> > 
> > Just to confirm my tests ran overnight without errors.
> 
> good.
> 
> > So the !wbc->nonblocking lowers the cpu utilization.
> 
> yup.  It prevents balance_dirty_pages() callers from spinning over the same
> pages again and again.
> 
> > What does sync_mode=WB_SYNC_ALL and nonblocking=1 mean?
> 
> WB_SYNC_ALL means "we're performing this writeout for data-integrity
> purposes, as opposed to for a regular dirty memory flush".  The code paths
> for these two things are deep, and are almost identical, so we pass it up
> and down in a flag.
> 
> ->nonblocking means "try to avoid blocking on request queues or locked
> pages".  pdflush and kswapd set this because those processes must serve
> many queues and cannot accord to get stuck on any one queue.  But regular
> write() callers do not set ->nonblocking because we _want_ these guys to
> throttle.
> 
> It's only OK to let pdflush avoid blocking on the buffer because pdflush
> will take an explicit nap in background_writeout().  hm, but only if the
> queue is congested - we may still have a problem there.

