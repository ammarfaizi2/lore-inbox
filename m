Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbTJUK7g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 06:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbTJUK7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 06:59:36 -0400
Received: from [65.172.181.6] ([65.172.181.6]:51086 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262886AbTJUK7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 06:59:34 -0400
Date: Tue, 21 Oct 2003 03:59:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] Avoid flushing AIO workqueue on cancel/exit
Message-Id: <20031021035900.18040eee.akpm@osdl.org>
In-Reply-To: <20031021102514.GA4217@in.ibm.com>
References: <20031021102514.GA4217@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> When streaming AIO requests are in progress on multiple
>  io context's, flushing the AIO workqueue on i/o cancellation
>  or process exit could potentially end up waiting for a 
>  long time as fresh requests from other active ioctx's keep 
>  getting queued up.

But flush_workqueue() will ignore any newly-added work requests:

 * This function will sample each workqueue's current insert_sequence number and
 * will sleep until the head sequence is greater than or equal to that.  This
 * means that we sleep until all works which were queued on entry have been
 * handled, but we are not livelocked by new incoming ones.

Now, flush_workqueue() is potentially inefficient on SMP because it flushes
each CPU's workqueue sequentially.  But we can fix that in
flush_workqueue() by converting it to a two-pass approach:

a) gather each CPU's insert_sequence number into a local array[NR_CPUS]

b) wait until each CPU's remove_sequence number exceeds the previously-gathered
   insert_sequence number.


