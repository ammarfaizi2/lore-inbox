Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030626AbWJCW0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030626AbWJCW0K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 18:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbWJCW0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 18:26:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030623AbWJCW0H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 18:26:07 -0400
Date: Tue, 3 Oct 2006 15:26:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zach Brown <zach.brown@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [PATCH take2 1/5] dio: centralize completion in dio_complete()
Message-Id: <20061003152603.3de68390.akpm@osdl.org>
In-Reply-To: <20061002232125.18827.52078.sendpatchset@tetsuo.zabbo.net>
References: <20061002232119.18827.96966.sendpatchset@tetsuo.zabbo.net>
	<20061002232125.18827.52078.sendpatchset@tetsuo.zabbo.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Oct 2006 16:21:25 -0700 (PDT)
Zach Brown <zach.brown@oracle.com> wrote:

> dio: centralize completion in dio_complete()
> 
> The mechanics which decide the result of a direct IO operation were duplicated
> in the sync and async paths.
> 
> The async path didn't check page_errors which can manifest as silently
> returning success when the final pointer in an operation faults and its
> matching file region is filled with zeros.
> 
> The sync path and async path differed in whether they passed errors to the
> caller's dio->end_io operation.  The async path was passing errors to it which
> trips an assertion in XFS, though it is apparently harmless.
> 
> This centralizes the completion phase of dio ops in one place.  AIO will now
> return EFAULT consistently and all paths fall back to the previously sync
> behaviour of passing the number of bytes 'transferred' to the dio->end_io
> callback, regardless of errors.
> 
> dio_await_completion() doesn't have to propogate EIO from non-uptodate
> bios now that it's being propogated through dio_complete() via dio->io_error.
> This lets it return void which simplifies its sole caller.
> 
> ...
>
> -static void dio_complete(struct dio *dio, loff_t offset, ssize_t bytes)
> +static int dio_complete(struct dio *dio, loff_t offset, int ret)
>  {
> +	ssize_t transferred = 0;
> +
> +	if (dio->result) {
> +		transferred = dio->result;
> +
> +		/* Check for short read case */
> +		if ((dio->rw == READ) && ((offset + transferred) > dio->i_size))
> +			transferred = dio->i_size - offset;

On 32-bit machines ssize_t is `int' and loff_t is `long long'.  I guess
`transferred' cannot overflow because you can't write >4G.  And I guess
`transferred' cannot go negative because you cannot write >=2G.  Can you
confirm that thinking?

