Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264925AbTCEKcA>; Wed, 5 Mar 2003 05:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbTCEKcA>; Wed, 5 Mar 2003 05:32:00 -0500
Received: from packet.digeo.com ([12.110.80.53]:33466 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264925AbTCEKb7>;
	Wed, 5 Mar 2003 05:31:59 -0500
Date: Wed, 5 Mar 2003 02:42:54 -0800
From: Andrew Morton <akpm@digeo.com>
To: suparna@in.ibm.com
Cc: bcrl@redhat.com, linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/2] Retry based aio read - filesystem read changes
Message-Id: <20030305024254.7f154afc.akpm@digeo.com>
In-Reply-To: <20030305150026.B1627@in.ibm.com>
References: <20030305144754.A1600@in.ibm.com>
	<20030305150026.B1627@in.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Mar 2003 10:42:16.0401 (UTC) FILETIME=[E3ADA410:01C2E303]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
> +extern int FASTCALL(aio_wait_on_page_bit(struct page *page, int bit_nr));
> +static inline int aio_wait_on_page_locked(struct page *page)

Oh boy.

There are soooo many more places where we can block:

- write() -> down(&inode->i_sem)

- read()/write() -> read indirect block -> wait_on_buffer()

- read()/write() -> read bitmap block -> wait_on_buffer()

- write() -> allocate block -> mark_buffer_dirty() ->
	balance_dirty_pages() -> writer throttling

- write() -> allocate block -> journal_get_write_access()

- read()/write() -> update_a/b/ctime() -> journal_get_write_access()

- ditto for other journalling filesystems

- read()/write() -> anything -> get_request_wait()
  (This one can be avoided by polling the backing_dev_info congestion
   flags)

- read()/write() -> page allocator -> blk_congestion_wait()

- write() -> balance_dirty_pages() -> writer throttling

- probably others.

Now, I assume that what you're looking for here is an 80% solution, but it
seems that a lot more changes will be needed to get even that far.

And given that a single kernel thread per spindle can easily keep that
spindle saturated all the time, one does wonder "why try to do it this way at
all"?
